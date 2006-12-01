Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 781B167DBC
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 08:54:10 +1100 (EST)
Subject: Re: pata_sl82c105 can not reserve IO region
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <45707CF8.3090106@ru.mvista.com>
References: <20061130165202.GA23205@aepfle.de>
	<20061130171049.7b80a40c@localhost.localdomain>
	<20061130184748.GA24071@aepfle.de> <20061201183355.GA9701@aepfle.de>
	<45707CF8.3090106@ru.mvista.com>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 08:53:49 +1100
Message-Id: <1165010029.22108.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, Olaf Hering <olaf@aepfle.de>,
	Alan <alan@lxorguk.ukuu.org.uk>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-12-01 at 22:05 +0300, Sergei Shtylyov wrote:
> Olaf Hering wrote:
> 
> >>The printk in pci_request_region has 'bar + 1', so 6 should be possible
> >>if i becomes 5.
> 
> > Does the IO region of the last bar look correct?

I think BAR 5 is unassigned by the firmware, though when OF does that,
it often means that an OF driver for that chip decided that the BAR
wasn't useful.

In fact, the driver doesn't actually use that BAR 5... Only 0 to 4
afaik.

I think the libata code shouldn't request the BARs it doesn't need or
that problem will hit us in other circumstances. It should only request
0 to 4 and let the drivers request 5 themselves if they need it.

Ben.
