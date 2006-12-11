Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ACABA67DD1
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 03:58:46 +1100 (EST)
In-Reply-To: <2C6AF45B-CD26-449B-B12C-1A89D8537463@schihei.de>
References: <20061207172259.64168f8c@localhost>
	<89216897-DF66-4C4E-9436-BD7816424139@schihei.de>
	<1F172C93-90F5-48E5-88D7-4D0BC0E1841A@kernel.crashing.org>
	<200612111525.50044.arnd@arndb.de>
	<2C6AF45B-CD26-449B-B12C-1A89D8537463@schihei.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <06260804-0C3C-4A40-9E69-408E77973984@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Mon, 11 Dec 2006 17:58:36 +0100
To: Heiko J Schick <info@schihei.de>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Arnd Bergmann <arnd@arndb.de>, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> If I understood you comments an example OFDT node for IPMI could  
> look like the following:
>
> name = "ipmi"
> device_type = "ipmi"
> compatible = "ipmi-kcs"
>
> reg = XXXXXXX8 00000008
> reg-spacing = 4

Yeah.

> reg-size    = 1
> reg-shift   = 0

But without these two, they are the default.

> Is the "8" of the reg property correct?

Sure.  Alternatively, if your device really only claims
bus cycles targeting the 8-bit regs at xxx8 and xxxC, you
can say that in the "reg" property.  This doesn't change
the programming model in the least though.

> I'm still worried what happens when we have a BT or SMIC interface  
> an the registers sitting at XXXXXXX4, XXXXXXX6, XXXXXXXA. In this  
> case the reg-spacing property can't be used anymore. Can this  
> happen in reality?

I don't think it is allowed.  Either way, the generic Linux IPMI
code would need changing for this -- let's worry about it later
(if ever!)


Segher
