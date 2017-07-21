Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDHy85pZnzDqsr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 14:35:44 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6L4Xm6J028051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 00:35:42 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bu84mmutn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 00:35:42 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Fri, 21 Jul 2017 14:35:40 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6L4ZcwS29622514
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 14:35:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6L4ZUqY003431
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 14:35:30 +1000
Date: Fri, 21 Jul 2017 10:05:26 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: energy driver only print message when
 LPAR guest
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170720115900.455-1-npiggin@gmail.com>
 <87eftbgt0m.fsf@concordia.ellerman.id.au>
 <20170721111644.2a6a6610@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170721111644.2a6a6610@roar.ozlabs.ibm.com>
Message-Id: <20170721043526.GA12264@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Nicholas Piggin <npiggin@gmail.com> [2017-07-21 11:16:44]:

> On Thu, 20 Jul 2017 23:03:21 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Nicholas Piggin <npiggin@gmail.com> writes:
> > 
> > > This driver currently reports the H_BEST_ENERGY is unsupported even
> > > when booting in a non-LPAR environment (e.g., powernv). Prevent it.  
> > 
> > Just delete the printk(). Users don't know what that means, and
> > developers have other better ways to detect that the hcall is missing if
> > anyone cares.
> > 
> > cheers
> 
> powerpc/pseries: energy driver do not print failure message
> 
> This driver currently reports the H_BEST_ENERGY is unsupported (even
> when booting in a non-LPAR environment). This is not something the
> administrator can do much with, and not significant for debugging.
> 
> Remove it.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>


> ---
>  arch/powerpc/platforms/pseries/pseries_energy.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
> index 164a13d3998a..35c891aabef0 100644
> --- a/arch/powerpc/platforms/pseries/pseries_energy.c
> +++ b/arch/powerpc/platforms/pseries/pseries_energy.c
> @@ -229,10 +229,9 @@ static int __init pseries_energy_init(void)
>  	int cpu, err;
>  	struct device *cpu_dev;
> 
> -	if (!firmware_has_feature(FW_FEATURE_BEST_ENERGY)) {
> -		printk(KERN_INFO "Hypercall H_BEST_ENERGY not supported\n");
> -		return 0;
> -	}
> +	if (!firmware_has_feature(FW_FEATURE_BEST_ENERGY))
> +		return 0; /* H_BEST_ENERGY hcall not supported */
> +

The first patch (!firmware_has_feature(FW_FEATURE_LPAR)) would be
ideal, but we do not have this in KVM guest case also. Hence I take
mpe's suggestion.  Removing the print is fine.

--Vaidy
