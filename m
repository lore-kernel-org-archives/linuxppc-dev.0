Return-Path: <linuxppc-dev+bounces-23948-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A75C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 16:56:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx1MG5sxMz3c8C;
	Fri, 10 Jul 2026 02:56:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783616186;
	cv=none; b=VtsuIeEQzMzf957lf2i2YVmkUlGDh8dzyzYKd1C1ad8cn1UT/tzAh2EpdkVdEySPoV+srPMBfK0k+5pXAJu5wfofLxl6+OOhM+snv9fWC/EHr+aNzwMAcFMz9V/vhIervh1hOwk5fbHAE/qAFJ3kS76nPE6sYXbGfwI7eyFTLipz47ocllVwLnRQpckkILpWd2En5IuELcz5wEpIosrKSAwnY53wqCKBPHu2dMXLjphCRJechqPfhTOb3OVff802oEFeiigrSmN9DKok3R7I0glnN+nlnBDIisCgBTc+JDxjrO8th0reOA3/J6J3G4SrbQ25iKx888My4Il5mxAnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783616186; c=relaxed/relaxed;
	bh=LxRJKp6D1ptC4y5YnQZ3DSiE42VBKKscZdC4o85YzcU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=fUHp2oiZUfItgT//1v1T/KfscSw9yqrXmIvHGIMbvjrXgMwnX8QF+JbcYe7jOiEco5T5dzIL2AlOZtLRnWQ7y2PjPgN53cZlmMKWYDlZt3DJggsHuMmPmqMnOTaalRZFF3CeA4fzRRaEGKwhrJLKiY9yJgDcerD4iDd2iTWNc3y3A8em+oK1vK1Hs/ME7ng7V3llh4ad9HnOGMgkRzw7o6mqzYwPQDGn/L6ujuhYdv/fsR7jWiBtA6U3U+7k9s/VxRkGKkjfTZZ/gH9ZR+7KqBwVHh+aL2PXXbLtaaBD8ySfhbxw5E9JzuzrhUP+kdyptPoHMTCF6B3zkpYkE02Uxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AZ6xM0Ne; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AZ6xM0Ne;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx1MF12Vwz3c2P
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 02:56:24 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so33181a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783616182; x=1784220982; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LxRJKp6D1ptC4y5YnQZ3DSiE42VBKKscZdC4o85YzcU=;
        b=AZ6xM0Nea4gHmk8DvB/HVy2Ss1G9A2ReG1MsKcY8xqqdRN8zBE1+elx8LN/JcjJtad
         bSDDJRMXN4RqjjCNb4bpB5xjVfFCcZUb+hZ+uOTZY50oJqH6b+SjsezJzdRnAIa8ASGE
         OM5D2SE37lUXJTD9y5vLf4ML6+J+tXzBTN2BzoXQJyoYOnIAoshveXZSLvpuQGZSger9
         ySpj20+9Qn5nQxFQ6F0Iw1CQTUC7+m/f4nGqLnrzBI91pKLxYeiFue13ca1Eku+62Tgt
         iug5vfLiKj7XJV9NmpNWK1Urcqyt8yBP80xSKw4yjy9hedtU4EyW+7PT0t31HPqk4Fse
         g6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783616182; x=1784220982;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LxRJKp6D1ptC4y5YnQZ3DSiE42VBKKscZdC4o85YzcU=;
        b=lI4YTtFK4KVFjLmKnsk7Y/8zdhuASMHflbnL7YGOHyVewO574ROImcIWjOhXIxuldy
         3y75k+VnMGIS4eGpJmcq3yH/ge6FGnfdLzviVBscV3EM4dBK5at+Hr9AsP8ky6Fvnq+D
         QbV8gf+O+HhozXmVFXMYKzAipTeeEdE6XGerKgWdFp62gCB0YVrRz0EKfTfsDcQLwx71
         h6Afg911VvXnwtvGVyuBvM2o6oB5wmD6eTL8zMrt1pZcFJBnh2xHo6Gv4FLiYqQ+xO3U
         KqKC4OUUiyKZOdBmdl8X8ayvqdgy9wHoWKSyyY5hEL7LALbVlGxGa8DAQreT0e1uifZa
         zN8g==
X-Forwarded-Encrypted: i=1; AHgh+Rpsh3vp7ruRrYwMVugSmnFMPv8Im82udXefhAjcGCCfvLnfg23Q/R/1vDxYcgETJEBA5+t6cN6+ZebWxPQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzKxGZwds1DU826UDszfSW4QPJJaHe1I0kcZhXrT4rE86KyHXjG
	XqVOvzfID7ZyXyzMpwdkEaYeIGLeMPygbOW+G8Sh6iFTjgfw8GHRs9Tu
X-Gm-Gg: AfdE7cmuaMyWuzQr6KsHDIsfwBSktMHsrUg1YPASvKs6ZBdS71fV+MCceExngG/Q4BY
	QFPoynCxfEYYB7TpG36o8G6iy46LjSF+hNHz8Nue8O149IbIAo0xP6BtS9iQ/AAnESrIE15+SBY
	MIzr8jDlNR0r9t11Kzl/Nn6L9Phlf0AZ3EMDr8Lys748OCQZsitoqcnTxnRfsEkxLQDW84qJtKH
	g9v9E5Jzhvm6U5HRtUIcKJUA5PaUjKJrDBm71hgrlZ/MCtOxo9xRo+LnTf+PEAFEr/h5XlUUjLy
	Lb37l09XbWri1YW0TtFfvaGe7PC1eKNj1wQaZJJtqRmzJ5MLrv4qgFelVopmj2GCML0Zo6Y/dau
	DFtbaCAMmBlEBcAVkPwsq0hMSduQHvQp1UDW1NWxaAFQxTVGpaAScFZ/nVqgtuq51HZT2u11ahd
	6OCHVB33qSgTE=
X-Received: by 2002:a05:6a21:512:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3c0bcfea433mr9860874637.21.1783616181907;
        Thu, 09 Jul 2026 09:56:21 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b658a99afsm32344548c88.0.2026.07.09.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:56:21 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, sourabhjain@linux.ibm.com, stable@vger.kernel.org, Mahesh Kumar G <mahe657@linux.ibm.com>
Subject: Re: [PATCH 1/1] powerpc/crash: stop watchdogs before booting kdump kernel
In-Reply-To: <20260603070217.483696-2-sourabhjain@linux.ibm.com>
Date: Thu, 09 Jul 2026 22:01:02 +0530
Message-ID: <4ii8w2ex.ritesh.list@gmail.com>
References: <20260603070217.483696-1-sourabhjain@linux.ibm.com> <20260603070217.483696-2-sourabhjain@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> On pseries LPAR systems, watchdog timers configured from userspace
> can remain active after a kernel panic. During panic triggered crash
> dump capture, the crashing kernel jumps directly to the kdump kernel
> without shutting down userspace services. As a result, active
> watchdogs are not stopped before entering the kdump kernel.
>
> If dump capture takes longer than the watchdog timeout, PHYP resets
> the LPAR before dump collection completes, resulting in dump capture
> failure.
>
> Fix this by issuing the H_WATCHDOG hcall on the crash shutdown path
> to stop all active watchdogs before booting the kdump kernel.
>

Nice catch!

> Fixes: 69472ffa6575 ("watchdog/pseries-wdt: initial support for H_WATCHDOG-based watchdog timers")
> Reported-by: Mahesh Kumar G <mahe657@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/kexec/crash.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index e6539f213b3d..5651523e3a70 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -28,6 +28,7 @@
>  #include <asm/interrupt.h>
>  #include <asm/kexec_ranges.h>
>  #include <asm/crashdump-ppc64.h>
> +#include <asm/hvcall.h>
>  

would be nice, if we could avoid papr specific header into common crash.c

>  /*
>   * The primary CPU waits a while for all secondary CPUs to enter. This is to
> @@ -352,6 +353,28 @@ int crash_shutdown_unregister(crash_shutdown_t handler)
>  }
>  EXPORT_SYMBOL(crash_shutdown_unregister);
>  
> +/**
> + * stop_watchdogs - Stop active watchdogs before entering kdump kernel
> + * On pseries LPAR systems, watchdogs configured from userspace remain
> + * active after a kernel panic because userspace services are not shut
> + * down on the kdump crash path. If a watchdog expires while the kdump
> + * kernel is collecting the dump, PHYP resets the LPAR and dump capture
> + * fails
> + *
> + *   0x200UL : watchdog stop operation
> + *   -1      : watchdog number, disable all watchdogs
> + */
> +static void stop_watchdogs(void)
> +{
> +	if (firmware_has_feature(FW_FEATURE_LPAR)) {
> +		int rc;

ditto.
Also I guess this could be FW_FEATURE_WATCHDOG

> +
> +		rc = plpar_hcall_norets_notrace(H_WATCHDOG, 0x200UL, -1);

- 0x200 is hardcoded.
- -1 is hardcoded.
- I think it's return value is long.

> +		if (rc != H_SUCCESS && rc != H_NOOP)
> +			pr_warn("crash: failed to stop watchdogs\n");

Let's print rc as well.

> +	}
> +}
> +

Looking at the code, we already have a mechanism to register a crash
shutdown handler which anyways is getting called from
default_machine_crash_shutdown(). So, I think we could use this generic
crash handler register mechanism and keep the wdt specific calls within
pseries/setup.c file...

...How about something like this? 

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 50b26ed8432d..4e557694d724 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -59,6 +59,7 @@
 #include <asm/xics.h>
 #include <asm/xive.h>
 #include <asm/papr-sysparm.h>
+#include <asm/papr-watchdog.h>
 #include <asm/ppc-pci.h>
 #include <asm/i8259.h>
 #include <asm/udbg.h>
@@ -185,14 +186,42 @@ static void __init fwnmi_init(void)
 #endif
 }

<...>

+static void pseries_crash_stop_watchdogs(void)
+{
+       long rc;
+
+       rc = plpar_hcall_norets_notrace(H_WATCHDOG, PSERIES_WDTF_OP_STOP,
+                                       PSERIES_WDT_NUM_ALL);
+       if (rc != H_SUCCESS && rc != H_NOOP)
+               pr_warn("Could not stop watchdogs before kdump rc=%ld\n", rc);
+}
+
 /*
  * Affix a device for the first timer to the platform bus if
  * we have firmware support for the H_WATCHDOG hypercall.
  */
 static __init int pseries_wdt_init(void)
 {
-       if (firmware_has_feature(FW_FEATURE_WATCHDOG))
-               platform_device_register_simple("pseries-wdt", 0, NULL, 0);
+       if (!firmware_has_feature(FW_FEATURE_WATCHDOG))
+               return 0;
+
+       platform_device_register_simple("pseries-wdt", 0, NULL, 0);
+
+       if (crash_shutdown_register(pseries_crash_stop_watchdogs))
+               pr_warn("Could not register watchdog crash shutdown handler\n");
+
        return 0;
 }
 machine_subsys_initcall(pseries, pseries_wdt_init);


Note that I added papr-watchdog.h header file in above. I am guessing we
can move some definitions from drivers/watchdog/pseries-wdt.c to
arch/powerpc/include/asm/papr-watchdog.h in a separate patch before this
change.

I think you get the idea. Can you try this way and let me know if this works?

-ritesh

>  void default_machine_crash_shutdown(struct pt_regs *regs)
>  {
>  	volatile unsigned int i;
> @@ -360,6 +383,8 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
>  	if (TRAP(regs) == INTERRUPT_SYSTEM_RESET)
>  		is_via_system_reset = 1;
>  
> +	stop_watchdogs();
> +
>  	if (IS_ENABLED(CONFIG_SMP))
>  		crash_smp_send_stop();
>  	else
> -- 
> 2.52.0

