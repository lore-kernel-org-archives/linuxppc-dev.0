Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 2F93867C9E
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 00:26:14 +1100 (EST)
Message-ID: <45742253.1000807@ru.mvista.com>
Date: Mon, 04 Dec 2006 16:27:47 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
References: <20061130165202.GA23205@aepfle.de>	<20061204123854.GA28159@aepfle.de>	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>	<4574197A.2020204@ru.mvista.com>	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
In-Reply-To: <20061204132124.4f7c50a9@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, Olaf Hering <olaf@aepfle.de>,
	linuxppc-dev@ozlabs.org
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

>>>>W82C105_IDE: inconsistent baseregs (BIOS) for port 0, skipping

>>>So that needs fixing too, then.

> Both PCI core and IDE interpret a zero length resource as unassigned.

   This is not about 0-length resource, this is about 0-address. Look at 
ide_hwif_confiure() in drivers/ide/setup-pci.c...

> That is probably better than clearing the flags in retrospect.

>>    I'd agree here, that check in the IDE code seems like being too x86 
>>specific. I'm having issues with it as well on MPC85xx/U-Boot...

> setup-pci is for SFF8038i devices. It therefore knows that for assigned
> resources they must be I/O. It also assumes that zero is not a valid I/O
> port just like zero is not a valid IRQ.

    You should know that the IRQ assumption is *not* true even for x86 since 
IRQ0 is and has always been a perfectly valid IRQ (used by PIT).

> Stick a real IDE resource at zero
 > and drivers/ide can't cope.

    Yeah, I've noticed. Unfortunately, a lot of PPC platforms (at least) are 
doing exactly this...

> Alan

WBR, Sergei
