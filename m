Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LSpY5ccHzF1RT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 03:36:37 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w64HSxoL099762
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jul 2018 13:36:35 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k129w8x0x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jul 2018 13:36:35 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Wed, 4 Jul 2018 13:36:33 -0400
Date: Wed, 4 Jul 2018 14:36:29 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [v2 PATCH 2/2] powerpc: Enable CPU_FTR_ASYM_SMT for interleaved
 big-cores
References: <cover.1530609795.git.ego@linux.vnet.ibm.com>
 <573a559dff87da1d68a55bf6ada97b7697102909.1530609795.git.ego@linux.vnet.ibm.com>
 <20180703175346.GB6474@kermit-br-ibm-com.br.ibm.com>
 <20180704081505.GB1007@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180704081505.GB1007@in.ibm.com>
Message-Id: <20180704173629.GA21119@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 04, 2018 at 01:45:05PM +0530, Gautham R Shenoy wrote:
> Hi Murilo,
> 
> Thanks for the review.
> 
> On Tue, Jul 03, 2018 at 02:53:46PM -0300, Murilo Opsfelder Araujo wrote:
> [..snip..]
> 
> > > -        /* Initialize CPU <=> thread mapping/
> > > +	if (has_interleaved_big_core) {
> > > +		int key = __builtin_ctzl(CPU_FTR_ASYM_SMT);
> > > +
> > > +		cur_cpu_spec->cpu_features |= CPU_FTR_ASYM_SMT;
> > > +		static_branch_enable(&cpu_feature_keys[key]);
> > > +		pr_info("Detected interleaved big-cores\n");
> > > +	}
> > 
> > Shouldn't we use cpu_has_feature(CPU_FTR_ASYM_SMT) before setting
> > > it?
> 
> 
> Are you suggesting that we do the following?
> 
>     if (has_interleaved_big_core &&
>         !cpu_has_feature(CPU_FTR_ASYM_SMT)) {
> 	...
>     }
>     
> Currently CPU_FTR_ASYM_SMT is set at compile time for only POWER7
> where running the tasks on lower numbered threads give us the benefit
> of SMT thread folding. Interleaved big core is a feature introduced
> only on POWER9. Thus, we know that CPU_FTR_ASYM_SMT is not set in
> cpu_features at this point.

Since we're setting CPU_FTR_ASYM_SMT, it doesn't make sense to use
cpu_has_feature(CPU_FTR_ASYM_SMT).  I thought cpu_has_feature() held all
available features (not necessarily enabled) that we could check before
setting or enabling such feature.  I think I misread it.  Sorry.

> 
> > 
> > > +
> > > +	/* Initialize CPU <=> thread mapping/
> > >  	 *
> > >  	 * WARNING: We assume that the number of threads is the same for
> > >  	 * every CPU in the system. If that is not the case, then some code
> > > -- 
> > > 1.9.4
> > > 
> > 
> > -- 
> > Murilo
> 
> --
> Thanks and Regards
> gautham.
> 

-- 
Murilo
