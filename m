Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DC051DE024
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 04:51:33 +1000 (EST)
Message-ID: <471E42BF.5090509@freescale.com>
Date: Tue, 23 Oct 2007 13:51:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Barisa Kisku <barisa.kisku@gmail.com>
Subject: Re: Kernel function having physical address. how?
References: <80bb1bc60710230322t17fa517bt324031195abced24@mail.gmail.com>
In-Reply-To: <80bb1bc60710230322t17fa517bt324031195abced24@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Barisa Kisku wrote:
> I have  ported linux-2.6.20 in cutom board based on MPC860.Kernel
> with the KERNELBASE as default 0xc00000000. uImage is downloaded at
> some address and booted with "bootm" command.Kernel is uncompressed
> and  loaded at 0x00000000.All  the kernel function is now having
> physical address (e.g.  0x000020c8 instead of 0xc00020c8, which is
> given by compiler).I think this required, to run kernel before MMU is
>  on, but how  this change in assembled code happens.

There is no change in the code itself -- the kernel is merely careful to 
avoid (or fix up) data references before the MMU is turned on (which 
happens quite early).

> Does u-boot do
> this when uncompressing and loading the kernel.

No.

-Scott
