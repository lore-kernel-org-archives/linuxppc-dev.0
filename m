Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9t9k2KMRzDrCq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 16:07:22 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6H65vGT093521
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 02:07:19 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bqey2kfwq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 02:07:19 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Mon, 17 Jul 2017 16:07:16 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6H67Ec721299216
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 16:07:14 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6H675JK007581
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 16:07:05 +1000
Subject: Re: [linux-next][bisected 1c0eaf0f] Today's next kernel fails to
 boot on ppc bare-metal
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, sachinp
 <sachinp@linux.vnet.ibm.com>, benh@kernel.crashing.org, mikey@neuling.org
Date: Mon, 17 Jul 2017 11:37:06 +0530
In-Reply-To: <87mv8324p8.fsf@concordia.ellerman.id.au>
References: <1500025360.5335.37.camel@abdul.in.ibm.com>
 <87mv8324p8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1500271626.27017.3.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-17 at 12:10 +1000, Michael Ellerman wrote:
> Hi Abdul,
> 
> Thanks for the bug report.
> 
> Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> > Hi 
> >
> > Today's linux-next fails to boot on ppc bare-metal
> >
> > Test: Boot
> > Machine: Power 8 bare-metal
> > kernel: 4.12.0-next-20170713
> > gcc: version 4.8.5
> > config : Tul-NV-config attached.
> 
> [swearing redacted]
> 
> Does this help?

Yes, it fixes the boot issue. Thanks for the fix.

With below patch, I was able to successfully boot
4.13.0-rc1-next-20170717 kernel on ppc bare-metal

Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 9b87abb178f0..cad6b57ce494 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -78,7 +78,7 @@ void opal_configure_cores(void)
>  	 *  ie. Host hash  supports  hash guests
>  	 *      Host radix supports  hash/radix guests
>  	 */
> -	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +	if (early_cpu_has_feature(CPU_FTR_ARCH_300)) {
>  		reinit_flags |= OPAL_REINIT_CPUS_MMU_HASH;
>  		if (early_radix_enabled())
>  			reinit_flags |= OPAL_REINIT_CPUS_MMU_RADIX;
> 


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
