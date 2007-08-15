Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E57AADDEAB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 08:06:19 +1000 (EST)
In-Reply-To: <5c9cd53b0708151412v2f5feb74v9e0b49d114b83021@mail.gmail.com>
References: <5c9cd53b0708141321h62f0ddd1k3a57a37f52e93894@mail.gmail.com>
	<36201C92-F117-4273-9FA7-13665CF0C6DB@freescale.com>
	<5c9cd53b0708150659u2ba88a9as5055b42fb1e2be67@mail.gmail.com>
	<FC996AA4-4C5F-4B36-A9E9-5F931D054F1C@freescale.com>
	<5c9cd53b0708151412v2f5feb74v9e0b49d114b83021@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DF88391F-F3B9-4DDB-8A27-F610E931AFB7@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: System crash on boot_e500.S on 2.4Kernel
Date: Wed, 15 Aug 2007 17:06:15 -0500
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


On Aug 15, 2007, at 16:12, mike zheng wrote:

> Here is the PC value before the rfi:
>
> cds8458>halt
>            Target CPU:           : MPC85xx (e500v2 rev.1)
>            Target state            : halted
>            Debug entry cause  : instruction breakpoint
>            Current PC             : 0x0000015c
>            Current CR             : 0x24024022
>            Current MSR          : 0x00012100
>            Current LR              :0x00000148
>            Current CCSRBAR  :0x0_e000000
>
> After the rfi:
>
> #step timeout defected
> cds8458>halt
>            Target CPU:           : MPC85xx (e500v2 rev.1)
>            Target state            : halted
>            Debug entry cause  : COP halt
>            Current PC             : 0xfff81300
>            Current CR             : 0x24024022
>            Current MSR          : 0x00001000
>            Current LR              :0x00000148
>            Current CCSRBAR  :0x0_e000000

Ok, I'm sure your problem isn't that SRR0 isn't getting updated  
properly.  I suspect something is going wrong during the rfi.   
Possibly something in your TLBs.  However, what is happening is most  
likely that you have hit an exception, and SRR0 and SRR1 have been  
updated.  I'm a little confused by the addresses where you first  
invoke "halt".  It looks like you're in the middle of flash, which is  
an odd place in u-boot to be.

And if you look at your PC, it doesn't seem like you step.  It looks  
like something goes wrong with the debugging.  My suggestion is to  
check your TLB setup and your IVOR setup.  Find out if the IVORs are  
pointing at an exception at fff81300.

Andy
