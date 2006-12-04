Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 78BB367C47
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 02:53:44 +1100 (EST)
Message-ID: <457444E3.7030706@ru.mvista.com>
Date: Mon, 04 Dec 2006 18:55:15 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
References: <20061130165202.GA23205@aepfle.de>	<20061204123854.GA28159@aepfle.de>	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>	<4574197A.2020204@ru.mvista.com>	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>	<45741DDE.4080509@ru.mvista.com>	<20061204132124.4f7c50a9@localhost.localdomain>	<45742253.1000807@ru.mvista.com>	<20061204142201.68d9621f@localhost.localdomain>	<457431FE.6040702@ru.mvista.com>	<20061204144411.246f3700@localhost.localdomain>
	<45744159.8040301@ru.mvista.com>
In-Reply-To: <45744159.8040301@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Olaf Hering <olaf@aepfle.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Sergei Shtylyov wrote:

>>>   When Linus remaps IRQ0 on x86, I'll follow that code as a testament. Until 
>>>this happens, I consider is just an opinion. Forcing every arch but x86 to 
>>>remap IRQ0 is an example of the double standards.

>>Yawn.. x86 does not expose IRQ 0 outside of arch specific code.

>     Can you believe, some non-x86 platofrms also don't -- for example, IRQ0 
> may be internal to SOC, not shareable or routable outside of it, BUT the SOC 
> device is driven by the standard driver (I'm minding 8250.c here). Yet we're 
> told that we should remap it, period...

>>>>The checks need pushing upwards and removing from their current place -
>>>>the pci layer should check the resource length, the isa pnp should I
>>>>believe check for zero address etc.

    Although, I'm getting the point -- PCI is likely to return 0 for 
unassigned the interrupt line register (this isn't always true though).  So, 
some mixup is possible in that regard.  Well, then we're unlucky, and indeed 
remapping IRQ0 has sense...

WBR, Sergei
