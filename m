Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42L0F344PVzF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 00:09:39 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8QE5wPf114978
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 10:09:37 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mrbjp865n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 10:09:30 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Wed, 26 Sep 2018 15:09:29 +0100
Date: Wed, 26 Sep 2018 19:39:14 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] powerpc/64s: reimplement book3s idle code in C
References: <20180914015240.1506-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180914015240.1506-1-npiggin@gmail.com>
Message-Id: <20180926140914.GA2442@aks.ibm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2018 at 11:52:40AM +1000, Nicholas Piggin wrote:
> +
> +	/*
> +	 * On POWER9, SRR1 bits do not match exactly as expected.
> +	 * SRR1_WS_GPRLOSS (10b) can also result in SPR loss, so
> +	 * always test PSSCR if there is any state loss.
> +	 */
> +	if (likely((psscr & PSSCR_RL_MASK) < pnv_first_hv_loss_level)) {

Shouldn't we check PLS field to see if the cpu/core woke up from hv loss ?

Currently, a cpu requested stop4 (RL=4) and exited from a shallower state
(PLS=2), SPR's are unecessarily restored.

We can do something like : 

#define	PSSCR_PLS_SHIFT		60
if (likely((psscr & PSSCR_PLS) >> PSSCR_PLS_SHIFT) < pnv_first_hv_loss_level)
> +		if (sprs_saved)
> +			atomic_stop_thread_idle();
> +		goto out;
> +	}
> +
> +	/* HV state loss */
> +	BUG_ON(!sprs_saved);
> +
> +	atomic_lock_thread_idle();
> +
> +	if ((*state & ((1 << threads_per_core) - 1)) != 0)
> +		goto core_woken;
> +
> +	/* Per-core SPRs */
> +	mtspr(SPRN_PTCR,	sprs.ptcr);
> +	mtspr(SPRN_RPR,		sprs.rpr);
> +	mtspr(SPRN_TSCR,	sprs.tscr);
> +	mtspr(SPRN_LDBAR,	sprs.ldbar);
> +	mtspr(SPRN_AMOR,	sprs.amor);
> +
> +	if ((psscr & PSSCR_RL_MASK) >= pnv_first_tb_loss_level) {
> +		/* TB loss */
> +		if (opal_resync_timebase() != OPAL_SUCCESS)
> +			BUG();
> +	}
