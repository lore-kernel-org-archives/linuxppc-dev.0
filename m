Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBB1067BD2
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 00:17:33 +1100 (EST)
Date: Mon, 4 Dec 2006 13:21:24 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Message-ID: <20061204132124.4f7c50a9@localhost.localdomain>
In-Reply-To: <45741DDE.4080509@ru.mvista.com>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 04 Dec 2006 16:08:46 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> >> W82C105_IDE: inconsistent baseregs (BIOS) for port 0, skipping
> > So that needs fixing too, then.

Both PCI core and IDE interpret a zero length resource as unassigned.
That is probably better than clearing the flags in retrospect.

>     I'd agree here, that check in the IDE code seems like being too x86 
> specific. I'm having issues with it as well on MPC85xx/U-Boot...

setup-pci is for SFF8038i devices. It therefore knows that for assigned
resources they must be I/O. It also assumes that zero is not a valid I/O
port just like zero is not a valid IRQ. Stick a real IDE resource at zero
and drivers/ide can't cope. 

Alan
