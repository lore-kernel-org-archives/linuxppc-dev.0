Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A4951DDE46
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 09:36:30 +1000 (EST)
Subject: Re: [PATCH 1/3] Add a new member name to structure irq_host
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1185232974.13740.11.camel@concordia.ozlabs.ibm.com>
References: <11851892302391-git-send-email-g.chen@freescale.com>
	<11851892311178-git-send-email-g.chen@freescale.com>
	<1185228277.5439.141.camel@localhost.localdomain>
	<1185232974.13740.11.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 24 Jul 2007 09:36:11 +1000
Message-Id: <1185233771.5439.153.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Chen Gong <g.chen@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-24 at 09:22 +1000, Michael Ellerman wrote:
> On Tue, 2007-07-24 at 08:04 +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2007-07-23 at 19:13 +0800, Chen Gong wrote:
> > > This patch adds a new member 'name' for irq host's name to
> > > structure irq_host and modifies the definition of the
> > > function irq_alloc_host(). The assignment to the
> > > irq host's name is also added to irq_alloc_host().
> > 
> > I would instead prefer adding a irq_name callback to host, which would
> > return a per-irq name. In some cases, they could return the OF path to
> > the host for example.
> 
> The pity is, for the 75% [1] of irq_hosts that have a device_node, they
> will all have to implement the name callback, because they all store the
> of node differently.
> 
> Which makes me think (again) that we should have an optional device_node
> pointer in irq_host. I know you said you wanted the irq stuff to be OF
> agnostic, but the reality is most of the implementations do have an OF
> node. And all of the newer irq_host implementations do, with the
> exception of PS3 and celleb - which are special.

Won't work well in practice due to things like:

 - Cell iic -> one node per core, but one global host
 - xics -> one node per source controller (lots of them in the tree) but
one global host

Ben.
