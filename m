Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v74dZ2p8yzDqHh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 21:47:46 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0OAhZ7d122405
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 05:47:44 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 285ee5e4v8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 05:47:43 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 24 Jan 2017 16:17:39 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 147B3E0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 16:18:50 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0OAkhGW31326420
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 16:16:43 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0OAlY0J027855
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 16:17:36 +0530
Date: Tue, 24 Jan 2017 16:17:34 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: BUILD_BUG_ON(!__builtin_constant_p(feature)) breaks bcc trace tool
References: <20170121120339.1c774b28@kryten>
 <87sho99fye.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87sho99fye.fsf@concordia.ellerman.id.au>
Message-Id: <20170124104734.GG3820@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/01/24 04:36PM, Michael Ellerman wrote:
> Anton Blanchard <anton@samba.org> writes:
> > We added:
> >
> > BUILD_BUG_ON(!__builtin_constant_p(feature)) 
> >
> > to cpu_has_feature() and mmu_has_feature() in order to catch usage
> > issues (such as cpu_has_feature(cpu_has_feature(X)). Unfortunately LLVM
> > isn't smart enough to resolve this, and it errors out.
> >
> > I work around it in my clang/LLVM builds of the kernel, but I have just
> > discovered that it causes a lot of issues for the bcc (eBPF) trace tool
> > (which uses LLVM).
> 
> I didn't understand that part, but Aneesh explained to me that it's
> because bcc pulls in the kernel-internal headers.
> 
> I guess as a quick fix we just have to #ifdef it, can you confirm this
> works?

This works and solves the issue for me. In the absence of a better 
approach, can you please push this for v4.10?

Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Thanks,
Naveen

> 
> 
> diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
> index b312b152461b..6e834caa3720 100644
> --- a/arch/powerpc/include/asm/cpu_has_feature.h
> +++ b/arch/powerpc/include/asm/cpu_has_feature.h
> @@ -23,7 +23,9 @@ static __always_inline bool cpu_has_feature(unsigned long feature)
>  {
>  	int i;
> 
> +#ifndef __clang__ /* clang can't cope with this */
>  	BUILD_BUG_ON(!__builtin_constant_p(feature));
> +#endif
> 
>  #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
>  	if (!static_key_initialized) {
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index a34c764ca8dd..233a7e8cc8e3 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -160,7 +160,9 @@ static __always_inline bool mmu_has_feature(unsigned long feature)
>  {
>  	int i;
> 
> +#ifndef __clang__ /* clang can't cope with this */
>  	BUILD_BUG_ON(!__builtin_constant_p(feature));
> +#endif
> 
>  #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
>  	if (!static_key_initialized) {
> 
> 
> cheers
> 
