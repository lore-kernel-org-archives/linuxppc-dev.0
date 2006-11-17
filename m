Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1AFA767B61
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 03:57:08 +1100 (EST)
In-Reply-To: <1163781539.21518.27.camel@gentoo-jocke.transmode.se>
References: <1163781539.21518.27.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A4DE4C29-34A0-4C57-BA16-659F89DD0D6D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RTC , ds1307 I2C driver and NTP does not work.
Date: Fri, 17 Nov 2006 10:57:24 -0600
To: joakim.tjernlund@transmode.se
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 17, 2006, at 10:38 AM, Joakim Tjernlund wrote:

> I get this when I activathte NTP and ntp "sync" the time the I2C HW  
> clock.

You may be better off posting this to lkml and copy the i2c list (and  
rtc if one exists).  Since its more a driver issue than anything  
really ppc specific.  Clearly we are doing schedules() in mpc_xfer()  
and maybe we shouldn't be.

- kumar

> BUG: scheduling while atomic: swapper/0x00010000/0
> Call Trace:^M
> [C0245C80] [C000860C] show_stack+0x48/0x194 (unreliable)
> [C0245CB0] [C01BEFF4] schedule+0x5d4/0x618
> [C0245CF0] [C01BF9C8] schedule_timeout+0x70/0xd0
> [C0245D30] [C014416C] i2c_wait+0x164/0x1d8
> [C0245D80] [C0144490] mpc_xfer+0x2b0/0x3a8
> [C0245DD0] [C01423E8] i2c_transfer+0x58/0x7c
> [C0245DF0] [C0141124] ds1307_set_time+0x1bc/0x234
> [C0245E00] [C013F82C] rtc_set_time+0xb0/0xb8^M
> [C0245E20] [C000BFC4] set_rtc_class_time+0x34/0x58
> [C0245E40] [C000C8D0] timer_interrupt+0x5a0/0x5fc
> [C0245EE0] [C000F7B0] ret_from_except+0x0/0x14
> --- Exception: 901 at cpu_idle+0xc8/0xf0
>     LR = cpu_idle+0xec/0xf0
> [C0245FC0] [C000388C] rest_init+0x28/0x38
> [C0245FD0] [C01F36E0] start_kernel+0x1d8/0x228
> [C0245FF0] [00003438] 0x3438
>
> I have activated RTC CLASS and have this in my board file:
> #ifdef CONFIG_RTC_CLASS
> late_initcall(rtc_class_hookup);
> #endif
>
> kernel 2.6.19-rc5
>
>  Jocke
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
