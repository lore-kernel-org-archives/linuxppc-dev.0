Return-Path: <SRS0=yMLg=3F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189B4C33CB2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 00:33:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845F9222C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 00:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845F9222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47ylXr3ZYyzDqR1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 11:33:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linutronix.de
 (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de;
 envelope-from=tglx@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linutronix.de
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.2 with cipher DHE-RSA-AES256-SHA256 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47ylVD4vVZzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2020 11:30:59 +1100 (AEDT)
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1irt3S-0004QP-Qv; Thu, 16 Jan 2020 01:30:35 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id B7BBB10121C; Thu, 16 Jan 2020 01:30:33 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5] reboot: support offline CPUs before reboot
In-Reply-To: <20200115063410.131692-1-hsinyi@chromium.org>
References: <20200115063410.131692-1-hsinyi@chromium.org>
Date: Thu, 16 Jan 2020 01:30:33 +0100
Message-ID: <8736cgxmxi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
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
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
 Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 linux-s390@vger.kernel.org, linux-csky@vger.kernel.org,
 Aaro Koskinen <aaro.koskinen@nokia.com>, Fenghua Yu <fenghua.yu@intel.com>,
 linux-pm@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 Stephen Boyd <swboyd@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Pavankumar Kondeti <pkondeti@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@vger.kernel.org,
 James Morse <james.morse@arm.com>, Jiri Kosina <jkosina@suse.cz>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hsin-Yi Wang <hsinyi@chromium.org> writes:

> Currently system reboots uses architecture specific codes (smp_send_stop)
> to offline non reboot CPUs. Most architecture's implementation is looping
> through all non reboot online CPUs and call ipi function to each of them. Some
> architecture like arm64, arm, and x86... would set offline masks to cpu without
> really offline them. This causes some race condition and kernel warning comes
> out sometimes when system reboots.

'some race condition and kernel warning' is pretty useless information.
Please describe exactly which kind of issues are caused by the current
mechanism. Especially the race conditions are the interesting part (the
warnings are just a consequence).

> This patch adds a config ARCH_OFFLINE_CPUS_ON_REBOOT, which would
> offline cpus in

Please read Documentation/process/submitting-patches.rst and search for
'This patch'.

> migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
> checking online cpus would be an empty loop.

This does not make any sense. The issues which you are trying to solve
are going to be still there when CONFIG_HOTPLUG_CPU is disabled.

> If architecture don't enable this config, or some cpus somehow fails
> to offline, it would fallback to ipi function.

This is really a half baken solution which keeps the various pointlessly
different pseudo reboot/kexec offlining implementations around. So with
this we have yet more code which only works depending on kernel
configuration and has the issue of potentially not being able to offline
a CPU. IOW this is going to fail completely in cases where a system is
in a state which prevents regular hotplug.

The existing pseudo-offline functions have timeouts and eventually a
fallback, e.g. the NMI fallback on x86. With this proposed regular
offline solution this will just get stuck w/o a chance to force
recovery.

While I like the idea and surely agree that the ideal solution is to
properly shutdown the CPUs on reboot, we need to take a step back and
look at the minimum requirements for a regular shutdown/reboot and at
the same time have a look at the requirements for emergency shutdown and
kexec/kcrash. Having proper information about the race conditions and
warnings you mentioned would be a good starting point.

> Opt in this config for architectures that support CONFIG_HOTPLUG_CPU.

This is not opt-in. You force that on all architectures which support
CONFIG_HOTPLUG_CPU. The way we do this normally is to provide the
infrastructure first and then have separate patches (one per
architecture) enabling this, which allows the architecture maintainers
to decide individually.

Thanks,

        tglx
