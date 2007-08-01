Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0AB0DDDE30
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 01:44:32 +1000 (EST)
Date: Wed, 1 Aug 2007 16:51:40 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Message-ID: <20070801165140.3e176cd1@the-village.bc.nu>
In-Reply-To: <46B0972C.3020000@ru.mvista.com>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
	<46B0972C.3020000@ru.mvista.com>
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

On Wed, 01 Aug 2007 18:22:36 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Segher Boessenkool wrote:
> 
> >> setup-pci is for SFF8038i devices. It therefore knows that for  assigned
> >> resources they must be I/O. It also assumes that zero is not a  valid I/O
> >> port just like zero is not a valid IRQ. Stick a real IDE resource  at 
> >> zero and drivers/ide can't cope.
> 
> > But 0 _is_ a valid PCI I/O address.  Do we now have to start
> 
>     I wasn't in PCI 2.1 (later the corresponding passage have disppeared).

SFF controllers often use 0 to indicate a channel isn't configured and
present. Libata and old IDE both assume these semantics for an SFF
IDE device reporting address zero. It matches the hardware behaviour.

I would suggest you don't map one at I/O zero on your PCI.

Alan
