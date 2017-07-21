Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDNXT2k2czDqsr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 18:02:17 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6L7xX1K135808
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 04:02:15 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2buaj3eeg7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 04:02:14 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Fri, 21 Jul 2017 18:02:12 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6L82AKn26345700
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 18:02:10 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6L822oT016493
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 18:02:02 +1000
Date: Fri, 21 Jul 2017 13:32:02 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: energy driver only print message when
 LPAR guest
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170720115900.455-1-npiggin@gmail.com>
 <87eftbgt0m.fsf@concordia.ellerman.id.au>
 <20170721111644.2a6a6610@roar.ozlabs.ibm.com>
 <20170721043526.GA12264@drishya.in.ibm.com>
 <87pocue1uk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <87pocue1uk.fsf@concordia.ellerman.id.au>
Message-Id: <20170721080202.GA20162@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2017-07-21 16:33:07]:

> Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> writes:
> > * Nicholas Piggin <npiggin@gmail.com> [2017-07-21 11:16:44]:
> >> diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
> >> index 164a13d3998a..35c891aabef0 100644
> >> --- a/arch/powerpc/platforms/pseries/pseries_energy.c
> >> +++ b/arch/powerpc/platforms/pseries/pseries_energy.c
> >> @@ -229,10 +229,9 @@ static int __init pseries_energy_init(void)
> >>  	int cpu, err;
> >>  	struct device *cpu_dev;
> >> 
> >> -	if (!firmware_has_feature(FW_FEATURE_BEST_ENERGY)) {
> >> -		printk(KERN_INFO "Hypercall H_BEST_ENERGY not supported\n");
> >> -		return 0;
> >> -	}
> >> +	if (!firmware_has_feature(FW_FEATURE_BEST_ENERGY))
> >> +		return 0; /* H_BEST_ENERGY hcall not supported */
> >> +
> >
> > The first patch (!firmware_has_feature(FW_FEATURE_LPAR)) would be
> > ideal, but we do not have this in KVM guest case also.
> 
> Yeah we do.
> 
> It should really be called FW_FEATURE_RUNNING_UNDER_PAPR_HYPERVISOR.
> 
> static int __init probe_fw_features(unsigned long node, const char *uname, int
> 				    depth, void *data)
> {
> 	....
> 	if (!strcmp(uname, "rtas") || !strcmp(uname, "rtas@0")) {
> 		prop = of_get_flat_dt_prop(node, "ibm,hypertas-functions", &len);
> 		if (prop) {
> 			powerpc_firmware_features |= FW_FEATURE_LPAR;
> 
> 
> Qemu initialises that property unconditionally in spapr_dt_rtas().

oops... I meant that FW_FEATURE_BEST_ENERGY is not found in KVM and we
will see the print needlessly.

If we have a check for phyp LPAR, then we can enable the print
"H_BEST_ENERGY hcall not supported"

Since the FW_FEATURE_LPAR is common for all PAPR guest (both pHyp and
KVM), I agree that deleting the print is the right thing to do since
we see it on both powernv and KVM where it is not supported and there
is no point reporting it.

--Vaidy
