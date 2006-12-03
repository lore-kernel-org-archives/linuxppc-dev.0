Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7AF3367B52
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 10:31:51 +1100 (EST)
Date: Sun, 3 Dec 2006 23:39:02 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pata_sl82c105 can not reserve IO region
Message-ID: <20061203233902.4550e39f@localhost.localdomain>
In-Reply-To: <1165011583.22108.17.camel@localhost.localdomain>
References: <20061130165202.GA23205@aepfle.de>
	<20061130171049.7b80a40c@localhost.localdomain>
	<20061130184748.GA24071@aepfle.de>
	<20061201183355.GA9701@aepfle.de> <45707CF8.3090106@ru.mvista.com>
	<1165010029.22108.10.camel@localhost.localdomain>
	<20061201221525.7a741062@localhost.localdomain>
	<1165011583.22108.17.camel@localhost.localdomain>
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

On Sat, 02 Dec 2006 09:19:43 +1100
> We don't have a choice but to trust the firmware on those machines. We
> can't assign things ourselves on most of them for various reasons (in
> many cases, the hypervisor won't let us).
> 
> So you suggest that I clear resource->flags in that case ?

That will do the trick yes.
 
> I think part of the problem is a firmware bug in that the firmware data
> actually decodes to BAR 5 is assigned to address 0 ... I suppose we can
> consider that address 0 is never valid on those machines and consider
> that as unassigned 

The core PCI code already "knows" that zero in a resource_start() is
unassigned
