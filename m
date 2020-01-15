Return-Path: <SRS0=ZwH7=3E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F67C33CB1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jan 2020 09:51:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2FD207FF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jan 2020 09:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2FD207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47yMzd257nzDqSC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jan 2020 20:51:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.167.196;
 helo=mail-oi1-f196.google.com; envelope-from=rjwysocki@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47yMxB5zvmzDqQT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2020 20:49:31 +1100 (AEDT)
Received: by mail-oi1-f196.google.com with SMTP id i1so14786187oie.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2020 01:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xlblpk3Q7AFTy8Enno95ZSx0IUH147BofZyxZsTxPpQ=;
 b=Qjsz7S8TC0kT17pOyv0/vU9dix0kBMQuABaRNs0c0UxGBkCa/BaAwqlV84c4Yl798H
 K2r2nC0MiiNjzZRFG6wcXOe/kT9JAQ/jWt6CQZMG5rdlIV98G9YnEI1srBKSusPArXHl
 xKeFZ19wSDjpD/g/iL2nDH+QaLNnF/fI/9a3ClIkhtYc/Mw4+UJ2sjSHFvI0tOokaoQX
 llZRxJFYqyj1YYEemSVVr9NgqAIpXG+Z6u35gqZK2WwIZgMPfhHsRAxe0GzQnZPIg8dl
 V/5/ndcK2DngYmJOAgudqLljzoy2K4otb9H3CnXbzeCTuaiTkImkOdPfw+b66RBDSkjl
 2IxQ==
X-Gm-Message-State: APjAAAWLwPbla1KNcugYaRW2r9f7a521kxPmdytyEgyoI0nPgsFwLrpv
 1wOkkv4an8Yx+3zgKgy8vFDwI3vNQRe+Fw5zr84=
X-Google-Smtp-Source: APXvYqzvsE9JWkTyA/qGCPe6FC5SfX/eWtD++abCAXNNUKmVhLTpM4TrHUCIWNo6kY2HmIQTdm2QXbcLDAmQBj9bi24=
X-Received: by 2002:aca:d6c8:: with SMTP id
 n191mr21412346oig.103.1579081768509; 
 Wed, 15 Jan 2020 01:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20200115063410.131692-1-hsinyi@chromium.org>
In-Reply-To: <20200115063410.131692-1-hsinyi@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Jan 2020 10:49:17 +0100
Message-ID: <CAJZ5v0jng1hpPzYUcPj96G9c8aqNYCwDqLHyQEVC9tD=F1dObw@mail.gmail.com>
Subject: Re: [PATCH v5] reboot: support offline CPUs before reboot
To: Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 sparclinux@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
 Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linux-s390@vger.kernel.org, linux-csky@vger.kernel.org,
 Aaro Koskinen <aaro.koskinen@nokia.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Linux PM <linux-pm@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 Stephen Boyd <swboyd@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Pavankumar Kondeti <pkondeti@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-parisc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@vger.kernel.org,
 James Morse <james.morse@arm.com>, Jiri Kosina <jkosina@suse.cz>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 15, 2020 at 7:35 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Currently system reboots uses architecture specific codes (smp_send_stop)
> to offline non reboot CPUs. Most architecture's implementation is looping
> through all non reboot online CPUs and call ipi function to each of them. Some
> architecture like arm64, arm, and x86... would set offline masks to cpu without
> really offline them. This causes some race condition and kernel warning comes
> out sometimes when system reboots.
>
> This patch adds a config ARCH_OFFLINE_CPUS_ON_REBOOT, which would offline cpus in
> migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
> checking online cpus would be an empty loop. If architecture don't enable this
> config, or some cpus somehow fails to offline, it would fallback to ipi
> function.
>
> Opt in this config for architectures that support CONFIG_HOTPLUG_CPU.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> Change from v4:
> * fix a few nits: naming, comments, remove Kconfig text...
>
> Change from v3:
> * Opt in config for architectures that support CONFIG_HOTPLUG_CPU
> * Merge function offline_secondary_cpus() and freeze_secondary_cpus()
>   with an additional flag.

This does not seem to be a very good idea, since
freeze_secondary_cpus() does much more than you need for reboot.

For reboot, you basically only need to do something like this AFAICS:

cpu_maps_update_begin();

for_each_online_cpu(i) {
        if (i != cpu)
                _cpu_down(i, 1, CPUHP_OFFLINE);
}
cpu_hotplug_disabled++;

cpu_maps_update_done();

And you may put this into a function defined outside of CONFIG_PM_SLEEP.

>
> Change from v2:
> * Add another config instead of configed by CONFIG_HOTPLUG_CPU

So why exactly is this new Kconfig option needed?

Everybody supporting CPU hotplug seems to opt in anyway.

[cut]

>
> -int freeze_secondary_cpus(int primary)
> +int freeze_secondary_cpus(int primary, bool reboot)
>  {
>         int cpu, error = 0;
>
> @@ -1237,11 +1237,13 @@ int freeze_secondary_cpus(int primary)
>                 if (cpu == primary)
>                         continue;
>
> -               if (pm_wakeup_pending()) {
> +#ifdef CONFIG_PM_SLEEP
> +               if (!reboot && pm_wakeup_pending()) {
>                         pr_info("Wakeup pending. Abort CPU freeze\n");
>                         error = -EBUSY;
>                         break;
>                 }
> +#endif

Please avoid using #ifdefs in function bodies.  This makes the code
hard to maintain in the long term.

>
>                 trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
>                 error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
> @@ -1250,7 +1252,9 @@ int freeze_secondary_cpus(int primary)
>                         cpumask_set_cpu(cpu, frozen_cpus);
>                 else {
>                         pr_err("Error taking CPU%d down: %d\n", cpu, error);
> -                       break;
> +                       /* When rebooting, offline as many CPUs as possible. */
> +                       if (!reboot)
> +                               break;
>                 }
>         }
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index c4d472b7f1b4..12f643b66e57 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -7,6 +7,7 @@
>
>  #define pr_fmt(fmt)    "reboot: " fmt
>
> +#include <linux/cpu.h>
>  #include <linux/ctype.h>
>  #include <linux/export.h>
>  #include <linux/kexec.h>
> @@ -220,7 +221,9 @@ void migrate_to_reboot_cpu(void)
>         /* The boot cpu is always logical cpu 0 */
>         int cpu = reboot_cpu;
>
> +#if !IS_ENABLED(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
>         cpu_hotplug_disable();
> +#endif

You can write this as

if (!IS_ENABLED(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT))
        cpu_hotplug_disable();

That's what IS_ENABLED() is there for.

>
>         /* Make certain the cpu I'm about to reboot on is online */
>         if (!cpu_online(cpu))
> @@ -231,6 +234,11 @@ void migrate_to_reboot_cpu(void)
>
>         /* Make certain I only run on the appropriate processor */
>         set_cpus_allowed_ptr(current, cpumask_of(cpu));
> +
> +#if IS_ENABLED(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
> +       /* Offline other cpus if possible */
> +       freeze_secondary_cpus(cpu, true);
> +#endif

The above comment applies here too.

>  }
>
>  /**
> --
