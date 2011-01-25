Return-Path: <diggskevin38@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB221B70F1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Jan 2011 10:54:11 +1100 (EST)
Received: by iwb12 with SMTP id 12so379091iwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Jan 2011 15:54:07 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 25 Jan 2011 17:54:07 -0600
Message-ID: <AANLkTikJ8V-gQv93HBDH3=4o51vY5xyxQojqEV7DqNj=@mail.gmail.com>
Subject: 750gx cpufreq induced kernel panic in 2.6.36
From: kevin diggs <diggskevin38@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The cpufreq driver I wrote for the 750gx causes a kernel panic in 2.6.36.

This is from a screen shot:

[c6035f30] [c001014c] timer_interrupt+0x13c/0x19c
[c6035f40] [c0013294] ret_from_except+0x0/0x14
--- Exception: 901 at 0x1000c694
    LR = 0x1000f3e4
Instruction dump:
4bffff48 38610008 4be7b2b1 4bffff9c 9421fff0 7c0802a6 bfc10xxx
90010014 7c0000a6 68008000 54008ffe <0f000000> 3d20c030 2f84xxxx
Kernel panic - not syncing: Fatal exception in interrupt
Call Trace:
[c6035bf0] [c00084e4] show_stack+0x3c/0x160 (unreliable)
[c6035c20] [c002cf44] panic+0xa4/0x1c8
[c6035c70] [c001085c] die+0x194/0x1a0
[c6035c90] [c0010aa8] _exception+0xfc/0x108
[c6035d80] [c0013248] ret_from_except_full+0x0/0x4c
--- Exception: 700 at cpufreq_notify_transition+0x20/0x128
    LR = cf750gx_pll_switch_cb+0x20/0xd0 [cf750gx]
[c6035e40] [c02e2280] 0xc02e2280 (unreliable)
[c6035e50] [ddc4b3dc] cf750gx_pll_switch_cb+0x20/0xd0 [cf750gx]
[c6035e60] [c004d7ac] notifier_call_chain+0x60/0xb0
[c6035e80] [ddc361c4] pllif_i_switch_PLLs+0xa0/0x140 [pll_if]
[c6035e90] [ddc365fc] pllif_i_timer_f+0x4c/0x6c [pll_if]
[c6035ea0] [c004bb24] __run_hrtimer+0x44/0xb8
[c6035eb0] [c004c1f8] hrtimer_interrupt+0x10c/0x388
[c6035f30] [c001014c] timer_interrupt+0x13c/0x19c
[c6035f40] [c0013294] ret_from_except+0x0/0x14
--- Exception: 901 at 0x1000c694
    LR = 0x1000f3e4
Rebooting in 180 seconds.._

What are exception 700 & 901?

The 0x1000c694 address looks fishy?

Thanks!

kevin
