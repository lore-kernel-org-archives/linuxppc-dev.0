Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 182B0DDE24
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 19:56:25 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0A8uNPi020294
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 01:56:23 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0A8uKSa008173
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 02:56:22 -0600 (CST)
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1168401489.22458.332.camel@localhost.localdomain>
References: <1165806548.7260.0.camel@localhost.localdomain>
	<1168398002.571.3.camel@localhost.localdomain>
	<1168399012.22458.328.camel@localhost.localdomain>
	<1168400086.700.12.camel@localhost.localdomain>
	<1168401489.22458.332.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1168419440.1704.16.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 10 Jan 2007 16:57:20 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-10 at 11:58, Benjamin Herrenschmidt wrote:
> > Stop here.
> 
> Probably the log is just the last console output you got from the
> early
> console before it switched to the main one. Do you use udbg on these
> boards for early boot messages ? If yes, have you tried the
> udbg-immortal option ? (Or just prevent udbg from unregistering).
> 
> Do you have access to a HW debugging tool maybe to trace what's going
> on ?
> 
> I have no idea what's wrong at this point, though it's likely to be a
> problem with your device-tree, I can't verify it without a bit more
> debug data. Have you tried adding some debug infos to the new
> implementation of pci_device_to_OF_node(), check how it's called and
> what it returns ? That might give you a clue about the problem.

Thanks for all your suggestions. I had thought you could point out where
was wrong :-). Now, I have to trace it myself. I do not have HW
debugging tools, I only have printk().

I catch the bug. In your patch:

+       /* not a root bus, we need to get our parent */
+       parent = scan_OF_for_pci_bus(bus->parent);
+       if (parent == NULL)
+               return NULL;
+
+       /* now iterate for children for a match */
+       np = scan_OF_for_pci_dev(parent, bus->self->devfn);
+       of_node_put(parent);
+
+       /* sanity check */
+       if (strcmp(np->type, "pci") != 0)
+               printk(KERN_WARNING "pci: wrong type \"%s\" for bridge %s\n",
+                      np->type, np->full_name);

I think you should judge np != NULL before using it.  If np == NULL,
np->type will cause memory access error. On CDS and some other Freescle
board, such as 8641HPCN, there is pci bridge, np = NULL , this will
cause error.
If you agree, you or I will provide a patch to fix it:-).
Thanks.
Roy 
