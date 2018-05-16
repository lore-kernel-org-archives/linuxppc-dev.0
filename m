Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m2SJ6wrXzF13V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 15:05:20 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4G4xMp7071447
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 01:05:18 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j0bwevgau-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 01:05:18 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 16 May 2018 01:05:17 -0400
Date: Wed, 16 May 2018 10:35:08 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc: Enable ASYM_SMT on interleaved big-core
 systems
Reply-To: ego@linux.vnet.ibm.com
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
 <1526037444-22876-3-git-send-email-ego@linux.vnet.ibm.com>
 <1526268127.30369.21.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526268127.30369.21.camel@neuling.org>
Message-Id: <20180516050508.GB14826@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 14, 2018 at 01:22:07PM +1000, Michael Neuling wrote:
> On Fri, 2018-05-11 at 16:47 +0530, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > Each of the SMT4 cores forming a fused-core are more or less
> > independent units. Thus when multiple tasks are scheduled to run on
> > the fused core, we get the best performance when the tasks are spread
> > across the pair of SMT4 cores.
> > 
> > Since the threads in the pair of SMT4 cores of an interleaved big-core
> > are numbered {0,2,4,6} and {1,3,5,7} respectively, enable ASYM_SMT on
> > such interleaved big-cores that will bias the load-balancing of tasks
> > on smaller numbered threads, which will automatically result in
> > spreading the tasks uniformly across the associated pair of SMT4
> > cores.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/smp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 9ca7148..0153f01 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -1082,7 +1082,7 @@ static int powerpc_smt_flags(void)
> >  {
> >  	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
> >  
> > -	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
> > +	if (cpu_has_feature(CPU_FTR_ASYM_SMT) || has_interleaved_big_core) {
> 
> Shouldn't we just set CPU_FTR_ASYM_SMT and leave this code
unchanged?

Yes, that would have the same effect. I refrained from doing that
since I thought CPU_FTR_ASYM_SMT has the "lower numbered threads
expedite thread-folding" connotation from the POWER7 generation.

If it is ok to overload CPU_FTR_ASYM_SMT, we can do what you suggest
and have all the changes in setup-common.c

--
Thanks and Regards
gautham.
