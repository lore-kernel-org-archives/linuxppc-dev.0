Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LDjg2zGLzF1SC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 18:31:35 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w648T13h105273
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jul 2018 04:31:32 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k0qrfq9c7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jul 2018 04:31:32 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 4 Jul 2018 02:31:31 -0600
Date: Wed, 4 Jul 2018 13:45:05 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/2] powerpc: Enable CPU_FTR_ASYM_SMT for interleaved
 big-cores
Reply-To: ego@linux.vnet.ibm.com
References: <cover.1530609795.git.ego@linux.vnet.ibm.com>
 <573a559dff87da1d68a55bf6ada97b7697102909.1530609795.git.ego@linux.vnet.ibm.com>
 <20180703175346.GB6474@kermit-br-ibm-com.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180703175346.GB6474@kermit-br-ibm-com.br.ibm.com>
Message-Id: <20180704081505.GB1007@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Murilo,

Thanks for the review.

On Tue, Jul 03, 2018 at 02:53:46PM -0300, Murilo Opsfelder Araujo wrote:
[..snip..]

> > -        /* Initialize CPU <=> thread mapping/
> > +	if (has_interleaved_big_core) {
> > +		int key = __builtin_ctzl(CPU_FTR_ASYM_SMT);
> > +
> > +		cur_cpu_spec->cpu_features |= CPU_FTR_ASYM_SMT;
> > +		static_branch_enable(&cpu_feature_keys[key]);
> > +		pr_info("Detected interleaved big-cores\n");
> > +	}
> 
> Shouldn't we use cpu_has_feature(CPU_FTR_ASYM_SMT) before setting
> > it?


Are you suggesting that we do the following?

    if (has_interleaved_big_core &&
        !cpu_has_feature(CPU_FTR_ASYM_SMT)) {
	...
    }
    
Currently CPU_FTR_ASYM_SMT is set at compile time for only POWER7
where running the tasks on lower numbered threads give us the benefit
of SMT thread folding. Interleaved big core is a feature introduced
only on POWER9. Thus, we know that CPU_FTR_ASYM_SMT is not set in
cpu_features at this point.

> 
> > +
> > +	/* Initialize CPU <=> thread mapping/
> >  	 *
> >  	 * WARNING: We assume that the number of threads is the same for
> >  	 * every CPU in the system. If that is not the case, then some code
> > -- 
> > 1.9.4
> > 
> 
> -- 
> Murilo

--
Thanks and Regards
gautham.
