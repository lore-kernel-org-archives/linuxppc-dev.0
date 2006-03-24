Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 185F2679EB
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 08:49:03 +1100 (EST)
Subject: Re: pci_dlpar.c & probe mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Rose <johnrose@austin.ibm.com>
In-Reply-To: <1143217005.2567.12.camel@sinatra.austin.ibm.com>
References: <1143160576.4257.51.camel@localhost.localdomain>
	<1143217005.2567.12.camel@sinatra.austin.ibm.com>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 08:48:52 +1100
Message-Id: <1143236933.3710.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: External List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-03-24 at 10:16 -0600, John Rose wrote:
> > I noticed that pcibios_add_pci_devices() test the platform type to
> > decide wether to do a device-tree based probe or a direct PCI probe. Why
> > can't it use ppc_md.probe_mode() like the rest of the PCI code does ?
> 
> I can't see a good reason either! :)  I'll have a patch in two shakes of
> a lamb's tail.  
> 
> On a related note, I don't understand why devtree-based probe is only
> desirable for the LPAR case (on pSeries).  

I think it was dictated by a conservative approach .. it's necessary for
LPAR and we didn't want to change the behaviour on older machines...
besides, things like bare metal may not provide the PCI nodes in OF and
use the same code base.

> Also, do we anticipate future probe modes for new platforms or
> something?  Adding such logic to ppc_md seems like mucho infrastructure
> to answer a simple question (lpar or not).  For exmaple, _machine gets
> used all over the pmac code.

_machine is gone, see my last patch ... It's not only about lpar or
not .. on powermac, it's really a per-bus & per machine generation
decision wether to trust OF or not..

Ben.
