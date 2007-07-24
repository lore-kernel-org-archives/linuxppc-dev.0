Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CFD7DDE46
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 19:36:59 +1000 (EST)
Subject: RE: [PATCH 1/3] Add a new member name to structure irq_host
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
In-Reply-To: <46B96294322F7D458F9648B60E15112C74CDC2@zch01exm26.fsl.freescale.net>
References: <11851892302391-git-send-email-g.chen@freescale.com>
	<11851892311178-git-send-email-g.chen@freescale.com>
	<1185228277.5439.141.camel@localhost.localdomain>
	<1185232974.13740.11.camel@concordia.ozlabs.ibm.com>
	<1185233771.5439.153.camel@localhost.localdomain>
	<995B09A8299C2C44B59866F6391D2635A69C88@zch01exm21.fsl.freescale.net>
	<1185251600.5439.204.camel@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C74CDC2@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Tue, 24 Jul 2007 19:36:42 +1000
Message-Id: <1185269802.5439.246.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Chen Gong-B11801 <G.Chen@freescale.com>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-24 at 17:25 +0800, Zhang Wei-r63237 wrote:
> Hi, Ben, 
> 
> Thanks! Please see my inline comments.
> 
> > 
> > Well, you would have to look at a cell blade or pSeries machine
> > device-tree, I don't have one at hand in DTS form... but basically,
> > those don't have a 1:1 relationship between hosts and nodes.
> 
> Is there any problem when the relationship between hosts and nodes is
> not 1:1?
> 
> The mapping method is defined in irq_alloc_host(). If there is only one
> host for many nodes,
> then these nodes will use the same mapping. Such as iic_host, the
> IRQ_HOST_MAP_LINEAR
> is used for its all nodes. We do _not_ care which node, we just care
> which virq is mapped from which host's hw irq.

Sure and it all works fine, I was replying to the suggestion of adding a
device_node pointer in there.

> > 
> > Anyway, I discussed with Michael today and it might be a good idea to
> > provide an optional device node field in the host struct that can be
> > used by the majority of the PICs that have one host == one node, that
> > would provide a good default for the name() function.
> > 
> 
> But we have some irq host which has not OF-node bound.

Sure, hence the word 'optional' which would provide a default name.

Ben.
