Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id DA5A4688DA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 04:25:50 +1100 (EST)
Message-ID: <43A6ED1E.20506@anagramm.de>
Date: Mon, 19 Dec 2005 18:25:50 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>
References: <43A2E175.9050004@anagramm.de>
In-Reply-To: <43A2E175.9050004@anagramm.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel 2.6.15-rc5-latest doesn't work anymore on mpc8540ads
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello!

Here is a little update:

> I am just about to update my kernel from 2.6.13-rc7 which is working
> fine to linus' 2.6.15-rc5-latest git on my mpc8540ads flavored board.
> However, the kernel hangs pretty early after
> 
> openpic: exit

openpic_init() is called by mpc85xx_ads_init_IRQ in ppc/platforms/85xx

ppc_md.init_IRQ=mpc85xx_ads_init_IRQ in ppc/platforms/85xx

ppc_md.init_IRQ() is called from powerpc/kernel/irq.c

init_IRQ() is  called from init/main.c:start_kernel()

and that seems to work fine. So, it crashes silently somewhere
after that point. I try to build 2.6.15-rc6-latest with kgbd support,
not knowing if it's supposed to work on this platform.

Are there some open issues from the ppc->powerpc migration?

Thanks,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
