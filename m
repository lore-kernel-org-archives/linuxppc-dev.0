Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533FAC0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 22:51:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6782087A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 22:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hsB/gPZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6782087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kVG23p0yzDr4C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 09:51:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hsB/gPZ2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="hsB/gPZ2";
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kMzH5VY3zDrS7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 05:08:24 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id u4-v6so2054838pfh.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 11:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QSKKc5HMlh7M5vL937dP++TT6tmkeJeSmcqt5MVCOtY=;
 b=hsB/gPZ2gEczir8iQUAn0e9pABW4rct9ZAh6E2jhg77MsVjPTMBQfPhvBJR1BZm+6m
 +OqpVPHEG2Hkn5wbNSXGiP7vXlYiyracqL7uFW25m8vWND53ljm5X4RERvGv6xZKL7xn
 jpFaHwDjmEMbTLwB1YIDBXfdvPbYN5rgtzT3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QSKKc5HMlh7M5vL937dP++TT6tmkeJeSmcqt5MVCOtY=;
 b=sS7XLM4ggJi7vkOTtGjalfOxuVhYT14BRtJXIR46PrKh8k/pvWDWeokfHCrJFs7Qf0
 upoY5NgAPfxlFwSdhul8tMXEwMyzoKJ7SYsy5Ss7g+7ySWG5jsaHEnoqbTc2+xnhbSHW
 H+Z8J7LHkktPEJCQ4M/gwm+BjoNSXB3W7ldwYLe9rKxlTlviZFL8nA69m4m0TM9T+HcS
 LmQvg1j7CHWdUM5phWpbsgxPoBfJoUo+7+wjujXjS36jQNc9icHJHWMPGXTOWH/dPDiV
 FvasNzZd2P8nw9PsIOpiPwjYfhGy5k0ko1eELUWLoOjLrlBEz4zpzD9iZ3UC2baMl2ej
 wAEg==
X-Gm-Message-State: AGRZ1gKaHHc/NcMh/tJQvt364lX5nsltY7lw0EgueujiooJ5BvunMVNq
 BcAAEi9oD7Q9POtiN6IMj1YWWA==
X-Google-Smtp-Source: AJdET5dGhnncRm9iSJg05kgJBJDzyYpBIEP2cpS8BQk0o1rd7rDmc4oUGhklGtHfFiVvNn75kQ9R1w==
X-Received: by 2002:a63:ea07:: with SMTP id
 c7-v6mr14041434pgi.361.1540836502105; 
 Mon, 29 Oct 2018 11:08:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:1:c8e0:70d7:4be7:a36])
 by smtp.gmail.com with ESMTPSA id u13-v6sm20537765pgp.18.2018.10.29.11.08.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Oct 2018 11:08:20 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <daniel.thompson@linaro.org>, tglx@linutronix.de,
 mingo@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 0/7] serial: Finish kgdb on qcom_geni;
 fix many lockdep splats w/ kgdb
Date: Mon, 29 Oct 2018 11:07:00 -0700
Message-Id: <20181029180707.207546-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Oct 2018 09:49:13 +1100
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
Cc: nm@ti.com, linux-mips@linux-mips.org, dalias@libc.org, vigneshr@ti.com,
 linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org, peterz@infradead.org,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 mhocko@suse.com, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org,
 jslaby@suse.com, marex@denx.de, sfr@canb.auug.org.au,
 ysato@users.sourceforge.jp, linux-hexagon@vger.kernel.org, x86@kernel.org,
 linux@armlinux.org.uk, tony@atomide.com, mingo@redhat.com, joel@jms.id.au,
 linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 jhogan@kernel.org, asierra@xes-inc.com, linux-snps-arc@lists.infradead.org,
 dan.carpenter@oracle.com, ying.huang@intel.com, Jisheng.Zhang@synaptics.com,
 riel@surriel.com, linux-arm-msm@vger.kernel.org, frederic@kernel.org,
 rolf.evers.fischer@aptiv.com, rppt@linux.vnet.ibm.com, bp@alien8.de,
 luto@kernel.org, andriy.shevchenko@linux.intel.com,
 linux-arm-kernel@lists.infradead.org, andrew@aj.id.au, vgupta@synopsys.com,
 Douglas Anderson <dianders@chromium.org>, ralf@linux-mips.org,
 rkuo@codeaurora.org, paul.burton@mips.com, jk@ozlabs.org, pombredanne@nexb.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 kstewart@linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I started out this series trying to make sysrq work over the serial
console on qcom_geni_serial, then fell into a rat's nest.

To solve the deadlock I faced when enabling sysrq I tried to borrow
code from '8250_port.c' which avoided grabbing the port lock in
console_write().  ...but since these days I try to run with lockdep on
all the time, I found it caused an annoying lockdep splat (which I
also reproduced on my rk3399 board).  ...so I instead changed my
qcom_geni_serial solution to borrow code from 'msm_serial.c'

I wasn't super happy with the solution in 'msm_serial.c' though.  I
don't like releasing the spinlock there.  Not only is it ugly but it
means we are unlocking / re-locking _all the time_ even though sysrq
characters are rare.  ...so I came up with what I think is a better
solution and then implemented it for qcom_geni_serial.

Since I had a good way to test 8250-based UARTs, I also fixed that
driver to use my new method.  When doing so, I ran into a missing
msm_serial.c at all, so I didn't switch that (or all other serial
drivers for that matter) to the new method.

After fixing all the above issues, I found the next lockdep splat in
kgdb and I think I've worked around it in a good-enough way, but I'm
much less confident about this.  Hopefully folks can take a look at
it.

In general, patches earlier in this series should be "less
controversial" and hopefully can land even if people don't like
patches later in the series.  ;-)

Looking back, this is pretty much two series squashed that could be
treated indepdently.  The first is a serial series and the second is a
kgdb series.

For all serial patches I'd expect them to go through the tty tree once
they've been reviewed.

If folks are OK w/ the 'smp' patch it probably should go in some core
kernel tree.  The kgdb patch won't work without it, though, so to land
that we'd need coordination between the folks landing that and the
folks landing the 'smp' patch.


Douglas Anderson (7):
  serial: qcom_geni_serial: Finish supporting sysrq
  serial: core: Allow processing sysrq at port unlock time
  serial: qcom_geni_serial: Process sysrq at port unlock time
  serial: core: Include console.h from serial_core.h
  serial: 8250: Process sysrq at port unlock time
  smp: Don't yell about IRQs disabled in kgdb_roundup_cpus()
  kgdb: Remove irq flags and local_irq_enable/disable from roundup

 arch/arc/kernel/kgdb.c                      |  4 +--
 arch/arm/kernel/kgdb.c                      |  4 +--
 arch/arm64/kernel/kgdb.c                    |  4 +--
 arch/hexagon/kernel/kgdb.c                  | 11 ++----
 arch/mips/kernel/kgdb.c                     |  4 +--
 arch/powerpc/kernel/kgdb.c                  |  2 +-
 arch/sh/kernel/kgdb.c                       |  4 +--
 arch/sparc/kernel/smp_64.c                  |  2 +-
 arch/x86/kernel/kgdb.c                      |  9 ++---
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  6 +++-
 drivers/tty/serial/8250/8250_fsl.c          |  6 +++-
 drivers/tty/serial/8250/8250_omap.c         |  6 +++-
 drivers/tty/serial/8250/8250_port.c         |  8 ++---
 drivers/tty/serial/qcom_geni_serial.c       | 10 ++++--
 include/linux/kgdb.h                        |  9 ++---
 include/linux/serial_core.h                 | 38 ++++++++++++++++++++-
 kernel/debug/debug_core.c                   |  2 +-
 kernel/smp.c                                |  4 ++-
 18 files changed, 80 insertions(+), 53 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog

