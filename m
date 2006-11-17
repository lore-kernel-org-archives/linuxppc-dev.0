Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 0DE0567B9F
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 03:39:03 +1100 (EST)
Subject: RTC , ds1307 I2C driver and NTP does not work.
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 17 Nov 2006 17:38:59 +0100
Message-Id: <1163781539.21518.27.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I get this when I activate NTP and ntp "sync" the time the I2C HW clock.



BUG: scheduling while atomic: swapper/0x00010000/0
Call Trace:^M
[C0245C80] [C000860C] show_stack+0x48/0x194 (unreliable)
[C0245CB0] [C01BEFF4] schedule+0x5d4/0x618
[C0245CF0] [C01BF9C8] schedule_timeout+0x70/0xd0
[C0245D30] [C014416C] i2c_wait+0x164/0x1d8
[C0245D80] [C0144490] mpc_xfer+0x2b0/0x3a8
[C0245DD0] [C01423E8] i2c_transfer+0x58/0x7c
[C0245DF0] [C0141124] ds1307_set_time+0x1bc/0x234
[C0245E00] [C013F82C] rtc_set_time+0xb0/0xb8^M
[C0245E20] [C000BFC4] set_rtc_class_time+0x34/0x58
[C0245E40] [C000C8D0] timer_interrupt+0x5a0/0x5fc
[C0245EE0] [C000F7B0] ret_from_except+0x0/0x14
--- Exception: 901 at cpu_idle+0xc8/0xf0
    LR = cpu_idle+0xec/0xf0
[C0245FC0] [C000388C] rest_init+0x28/0x38
[C0245FD0] [C01F36E0] start_kernel+0x1d8/0x228
[C0245FF0] [00003438] 0x3438

I have activated RTC CLASS and have this in my board file:
#ifdef CONFIG_RTC_CLASS
late_initcall(rtc_class_hookup);
#endif

kernel 2.6.19-rc5 

 Jocke
