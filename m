Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 8095EB70FE
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 02:20:47 +1000 (EST)
Received: by pvg16 with SMTP id 16so4602682pvg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Sep 2010 09:20:45 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 1 Sep 2010 10:19:25 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Jeremy Kerr <jeremy.kerr@canonical.com>, John Rigby <jcrigby@gmail.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	microblaze-uclinux@itee.uq.edu.au, Olof Johansson <olof@lixom.net>
Subject: Re: Request review of device tree documentation
Message-ID: <20100901161925.GG13421@angua.secretlab.ca>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<20100805044325.GC25458@yookeroo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100805044325.GC25458@yookeroo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 05, 2010 at 02:43:25PM +1000, David Gibson wrote:
> On Fri, Jun 11, 2010 at 04:59:46PM -0600, Grant Likely wrote:
> > I've been doing a bit of work on some introductory level documentation
> > of the flattened device tree.  I've got a rough copy up on the
> > devicetree.org wiki, and I could use some feedback.  If anyone has
> > some time to look at it, you can find it here:
> > 
> > http://devicetree.org/Device_Tree_Usage
> 
> Sorry I haven't replied sooner, I've been away, then sick and
> generally preoccupied.  Still here are some comments now.

Thanks David.  Reworked as per comments.  You can see the diff here:

http://www.devicetree.org/mediawiki/index.php?title=Device_Tree_Usage&diff=228&oldid=227

g.

> 
> How Addressing Works:
> 
>  * Small inconsistency you use "address1", "address2" then "unit-address3".
> 
>  * Perhaps re-emphasise that a parent's #*-cells properties govern the
>    children's reg properties, not its own, since this is a common
>    misunderstanding..
> 
> Non Memory Mapped Devices:
> 
>  * Your phrasing here suggests that non-memory-maped == zero
>    size-cells, which is not always true.
> 
> Ranges (Address Translation):
> 
>  * Third paragraph, first sentence is a grammatical dogs' breakfast,
> 
> How Interrupts Work:
> 
>  * Bogus paragraph break partway through first sentence.
> 
>  * At the end you say the second cell indicates the interrupt's
>    polarity, but you don't specify how this is encoded.  It might be
>    worth emphasising that while most interrupt specifiers do include
>    trigger and polarity type information, the encoding of it can and
>    does vary between interrupt controllers.
> 
> Advanced Sample Machine:
> 
>  * The unit address in the name shouldn't have a "0x" prefix
> 
> Advanced Interrupt Mapping:
> 
>  * Perhaps worth noting that while a PCI *card* will use INTA..INTD,
>    on-board PCI devices can, and frequently do, have interrupts wired
>    side-band to the PCI bus, directly to the main interrupt
>    controller.
> 
>  * In your example, you're muddying the waters of your previous usage
>    of interrupt-parent.  The PCI child nodes have the PCI top-level
>    node as their implicit interrupt parent, because its their first
>    ancestor with an interrupt-map, and we hit that before the
>    interrupt-parent property specified at the very top level.  This
>    means amongst other things that if there are PCI devices with
>    seperately wired interrupts, they must explicitly set
>    interrupt-parent to bypass the normal PCI interrupt mapping.
> 
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
