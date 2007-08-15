Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AF41DDDE48
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 02:17:04 +1000 (EST)
In-Reply-To: <5c9cd53b0708150659u2ba88a9as5055b42fb1e2be67@mail.gmail.com>
References: <5c9cd53b0708141321h62f0ddd1k3a57a37f52e93894@mail.gmail.com>
	<36201C92-F117-4273-9FA7-13665CF0C6DB@freescale.com>
	<5c9cd53b0708150659u2ba88a9as5055b42fb1e2be67@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FC996AA4-4C5F-4B36-A9E9-5F931D054F1C@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: System crash on boot_e500.S on 2.4Kernel
Date: Wed, 15 Aug 2007 11:17:08 -0500
To: mike zheng <mail4mz@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 15, 2007, at 8:59 AM, mike zheng wrote:

> I use BDI to debug these two instructions. And here are the output  
> of BDI just before the "rfi". The content of R6, R7 is different  
> from SRR0(SPR26) and SRR1(SPR27).

I see you have not printed the pc/nia once you stop.  Are you sure  
you're stopped where you think?  Please check this.

-B

>
> cds8548>res run
>
> - TARGET: processing user reset request
>
> - BDI asserts HRESET
>
> - Reset JTAG controller passed
>
> - JTAG exists check passed
>
> - IDCODE is 0x0003901D
>
> - SVR is 0x80390011
>
> - PVR is 0x80210010
>
> - CCSRBAR is 0x0_ff700000
>
> - BDI removes HRESET
>
> - TARGET: Target PVR is 0x80210010
>
> - TARGET: resetting target passed
>
> cds8548>halt
>
> Target CPU : MPC85xx (e500v2 rev.1)
>
> Target state : halted
>
> Debug entry cause : COP halt
>
> Current PC : 0xfff82560
>
> Current CR : 0x88000042
>
> Current MSR : 0x00021200
>
> Current LR : 0xfff8aa4c
>
> Current CCSRBAR : 0x0_e0000000
>
> cds8548>ci
>
> cds8548>bi 0x0000015c
>
> Breakpoint identification is 0
>
> cds8548>go
>
> - TARGET: stopped
>
> cds8548>rd
>
> GPR00: 00000000 0ffabd20 00000200 00000008
>
> GPR04: 00000000 00000001 00000020 00000160
>
> GPR08: 1f8b0808 00000148 0ffabace 0ffe08b0
>
> GPR12: 00000006 764deddb 10000300 007fff00
>
> GPR16: 00000001 ffffffff 007fff25 0ffff9d8
>
> GPR20: 007ffeb0 00000000 0fffaa3c 0ffae490
>
> GPR24: 00000000 00000003 02000040 007fff25
>
> GPR28: 007fff00 0ffab3b8 0fcd6000 007ffeb0
>
> CR : 24024022 MSR: 00021200
>
> cds8548>rdspr 26
>
> SPR 26 : 0xfff81300 - 519424
>
> cds8548>rdspr 27
>
> SPR 27 : 0x00001000 4096
>
> cds8548>
>
>
>
>
>
>
> On 8/14/07, Andy Fleming <afleming@freescale.com> wrote:
> On Aug 14, 2007, at 15:21, mike zheng wrote:
>
> >
> > Hi All,
> >
> > I am trying to bring up MPC8548 CDS board on 2.4 kernel. I have
> > problem in the head_e500.S. The "mtspr SRR0, r7; mtspr SRR1 r6"
> > does not work for me. The content of R7 and R6 are not moved to
> > SRR0 and SRR1.  I am using the tool-chain from Freescale for 2.6
> > kernel.
> >
> > Any idea on this issue?
>
> Just to check...how do you know it doesn't work?
>
> Andy
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
