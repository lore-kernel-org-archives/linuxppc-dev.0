Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5D322B70E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 14:12:17 +1000 (EST)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F935DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 14:12:16 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5G4A5ic003750
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 14:10:05 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5G4CFXt987296
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 14:12:15 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5G4CFRJ009314
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 14:12:15 +1000
Subject: Re: [PATCH] Fix oprofile sampling of marked events on POWER7
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Maynard Johnson <maynardj@us.ibm.com>
In-Reply-To: <4A364F4A.6060300@us.ibm.com>
References: <49FB2EC5.4040400@us.ibm.com>  <4A364F4A.6060300@us.ibm.com>
Content-Type: text/plain
Date: Tue, 16 Jun 2009 14:12:14 +1000
Message-Id: <1245125534.12400.70.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-15 at 08:40 -0500, Maynard Johnson wrote:
> Looks like this posting got overlooked, so I'm re-posting the original patch.  Ben, can you please review?  BTW, Anton reported the problem that this patch fixes.

It was merged upstream after 2.6.30 -rc6, see commit e5fc948b...

Cheers,
Ben.

> Thanks.
> -Maynard
> 
> ==============================================================
> 
> 
> Description
> -----------
> Change ppc64 oprofile kernel driver to use the SLOT bits (MMCRA[37:39]only on 
> older processors where those bits are defined.
> 
> Background
> ----------
> The performance monitor unit of the 64-bit POWER processor family has the 
> ability to collect accurate instruction-level samples when profiling on marked 
> events (i.e., "PM_MRK_<event-name>").  In processors prior to POWER6, the MMCRA 
> register contained "slot information" that the oprofile kernel driver used to 
> adjust the value latched in the SIAR at the time of a PMU interrupt.  But as of 
> POWER6, these slot bits in MMCRA are no longer necessary for oprofile to use, 
> since the SIAR itself holds the accurate sampled instruction address.  With 
> POWER6, these MMCRA slot bits were zero'ed out by hardware so oprofile's use of 
> these slot bits was, in effect, a NOP.  But with POWER7, these bits are no 
> longer zero'ed out; however, they serve some other purpose rather than slot 
> information.  Thus, using these bits on POWER7 to adjust the SIAR value results 
> in samples being attributed to the wrong instructions.  The attached patch 
> changes the oprofile kernel driver to ignore these slot bits on all newer 
> processors starting with POWER6.
> 
> Thanks.
> -Maynard
> 
> Signed-off-by: Maynard Johnson <maynardj@us.ibm.com>
> 
> 
> 
> diff -paur linux/arch/powerpc/oprofile/op_model_power4.c linux-p7-oprofile-patch//arch/powerpc/oprofile/op_model_power4.c
> --- linux/arch/powerpc/oprofile/op_model_power4.c	2009-05-01 08:20:21.000000000 -0500
> +++ linux-p7-oprofile-patch//arch/powerpc/oprofile/op_model_power4.c	2009-05-01 08:20:05.000000000 -0500
> @@ -26,6 +26,7 @@
>  static unsigned long reset_value[OP_MAX_COUNTER];
> 
>  static int oprofile_running;
> +static int use_slot_nums;
> 
>  /* mmcr values are set in power4_reg_setup, used in power4_cpu_setup */
>  static u32 mmcr0_val;
> @@ -61,6 +62,12 @@ static int power4_reg_setup(struct op_co
>  	else
>  		mmcr0_val |= MMCR0_PROBLEM_DISABLE;
> 
> +	if (__is_processor(PV_POWER4) || __is_processor(PV_POWER4p) ||
> +	    __is_processor(PV_970) || __is_processor(PV_970FX) ||
> +	    __is_processor(PV_970MP) || __is_processor(PV_970GX) ||
> +	    __is_processor(PV_POWER5) || __is_processor(PV_POWER5p))
> +		use_slot_nums = 1;
> +
>  	return 0;
>  }
> 
> @@ -206,7 +213,7 @@ static unsigned long get_pc(struct pt_re
> 
>  	mmcra = mfspr(SPRN_MMCRA);
> 
> -	if (mmcra & MMCRA_SAMPLE_ENABLE) {
> +	if (use_slot_nums && (mmcra & MMCRA_SAMPLE_ENABLE)) {
>  		slot = ((mmcra & MMCRA_SLOT) >> MMCRA_SLOT_SHIFT);
>  		if (slot > 1)
>  			pc += 4 * (slot - 1);
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
