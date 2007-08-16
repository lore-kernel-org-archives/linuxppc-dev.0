Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9AFCDDDE9D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 11:16:49 +1000 (EST)
In-Reply-To: <5c9cd53b0708151546y18714a46i785cdb5f23ef1536@mail.gmail.com>
References: <5c9cd53b0708141321h62f0ddd1k3a57a37f52e93894@mail.gmail.com>
	<36201C92-F117-4273-9FA7-13665CF0C6DB@freescale.com>
	<5c9cd53b0708150659u2ba88a9as5055b42fb1e2be67@mail.gmail.com>
	<FC996AA4-4C5F-4B36-A9E9-5F931D054F1C@freescale.com>
	<5c9cd53b0708151412v2f5feb74v9e0b49d114b83021@mail.gmail.com>
	<DF88391F-F3B9-4DDB-8A27-F610E931AFB7@freescale.com>
	<5c9cd53b0708151546y18714a46i785cdb5f23ef1536@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8513767D-F467-49EA-816B-48567E13F56D@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: System crash on boot_e500.S on 2.4Kernel
Date: Wed, 15 Aug 2007 20:16:44 -0500
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


On Aug 15, 2007, at 17:46, mike zheng wrote:

> Hi Andy,
>
> Here is BDI output of the register value after line 212. The value  
> of R6, R7 is 0x20, 0x160. However the value of SRR0(SPR26), SRR1 
> (SPR27) is 0xfff81300 and 0x00001000. Why are they different from  
> r7 and r6? We just did the mtspr, the value should be the same. The  
> rfi jump to 0xfff81300 is because of the value in SRR0.


Yes, it's very strange.  But it's also pretty much impossible for the  
mtspr to just fail like that.  A more likely scenario is that the BDI  
is getting bad information.  Could you take a look at your IVORs?   
I'm very curious to see if fff81300 is an interrupt vector.

Andy
