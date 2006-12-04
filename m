Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 5936267BBD
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 02:38:49 +1100 (EST)
Message-ID: <45744159.8040301@ru.mvista.com>
Date: Mon, 04 Dec 2006 18:40:09 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
References: <20061130165202.GA23205@aepfle.de>	<20061204123854.GA28159@aepfle.de>	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>	<4574197A.2020204@ru.mvista.com>	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>	<45741DDE.4080509@ru.mvista.com>	<20061204132124.4f7c50a9@localhost.localdomain>	<45742253.1000807@ru.mvista.com>	<20061204142201.68d9621f@localhost.localdomain>	<457431FE.6040702@ru.mvista.com>
	<20061204144411.246f3700@localhost.localdomain>
In-Reply-To: <20061204144411.246f3700@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@ozlabs.org, greg@kroah.com,
	linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Alan wrote:

>>    When Linus remaps IRQ0 on x86, I'll follow that code as a testament. Until 
>>this happens, I consider is just an opinion. Forcing every arch but x86 to 
>>remap IRQ0 is an example of the double standards.

> Yawn.. x86 does not expose IRQ 0 outside of arch specific code.

    Can you believe, some non-x86 platofrms also don't -- for example, IRQ0 
may be internal to SOC, not shareable or routable outside of it, BUT the SOC 
device is driven by the standard driver (I'm minding 8250.c here). Yet we're 
told that we should remap it, period...

>>>The checks need pushing upwards and removing from their current place -
>>>the pci layer should check the resource length, the isa pnp should I
>>>believe check for zero address etc.

>>    So, it's OK to remove the base *address* check in ide_hwif_confiure() 
>>altogether?

> IFF you move all the other checks, verify their correctness and then get
> them tested for a while yes

    All other checks aren't hindering (at least me ATM).  What's probably 
worth doing is to check the result of ide_pci_check_iomem() some lines above 
the discussed check (it's ignored now).

WBR, Sergei
