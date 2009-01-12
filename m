Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 4EB50DE127
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 10:39:06 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 13 Jan 2009 00:39:04 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20090112233904.221050@gmx.net>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Mon, 12 Jan 2009 16:12:18 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
> Betreff: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards

> The code in the kernel that retreives the interrupt that way is clearly
> marked as a fishy workaround for bogus firmwares :-)
"bogus" applies a little bit to the PCI init code of the A1 firmware. ;-)

> But I'm not going to reject things based on that, it will work for
> simple board using really only legacy interrupts like yours...
Thanks!

> > > For the flattened device tree, I think we've settled on the convention
> > > that every node with an IRQ connection should have both the
> > > interrupt-parent and interrupts properties.  (ie. don't rely on the
> > > parent node's interrupt-parent property.)
> > Even for ISA devices?
> 
> I disagree with Grant here. Especially in simple ISA cases like that,
> there's really no point in bloating the device-tree.
Okay, so I leave it as it is.

> > > Can this PCI device be probed?  Typically PCI devices don't get added
> > > to the flattened device tree because PCI is a probeable bus.
> > Yes, it can be probed. I thought it would be a good idea to include it,
> > because the IDE controller operates in legacy mode. I planned to specify
> > the two legacy interrupts in this node (as you can see), but the kernel
> > didn't like them.
> 
> Well, the kernel just didn't make use of them I'd say :-) But that can
> probably be fixed with the appropriate hacks. 
I think I throw away the IDE controller node for now, as libata just reads
the PCI register settings (progif) and I guess the IDE subsystem will do
the same in the future.

Gerhard

-- 
Sensationsangebot verlängert: GMX FreeDSL - Telefonanschluss + DSL 
für nur 16,37 Euro/mtl.!* http://dsl.gmx.de/?ac=OM.AD.PD003K1308T4569a
