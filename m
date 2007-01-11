Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4BF6DDDE37
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 16:51:49 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0B5plpe028786
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 22:51:47 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0B5pjYv011150
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 23:51:46 -0600 (CST)
Subject: Re: [PATCH] powerpc: Remove bogus sanity check in pci -> OF node code
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
In-Reply-To: <1168493902.22458.399.camel@localhost.localdomain>
References: <1168493902.22458.399.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1168494765.6644.2.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 11 Jan 2007 13:52:45 +0800
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

On Thu, 2007-01-11 at 13:38, Benjamin Herrenschmidt wrote:
> The new implementation of pci_device_to_OF_node() on ppc32 has a bogus
> sanity check in it that can cause oopses at boot when no device node
> is
> present, and might hit correct cases with older/weird apple
> device-trees
> where they have the type "vci" for the chaos bridge.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Zang, please confirm that this fixes your problem. If it does, paulus,
> this should go in 2.6.20
It works for my problem. You remove them, so it is not necessary to test
whether it is NULL.
This issue blocks my two boards: MPC8548CDS and MPC8641HPCN. it should
go in 2.6.20.

> 
> 
> Index: linux-work/arch/powerpc/kernel/pci_32.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/kernel/pci_32.c        2007-01-11
> 16:30:09.000000000 +1100
> +++ linux-work/arch/powerpc/kernel/pci_32.c     2007-01-11
> 16:30:31.000000000 +1100
> @@ -775,11 +775,6 @@ static struct device_node *scan_OF_for_p
>         np = scan_OF_for_pci_dev(parent, bus->self->devfn);
>         of_node_put(parent);
>  
> -       /* sanity check */
> -       if (strcmp(np->type, "pci") != 0)
> -               printk(KERN_WARNING "pci: wrong type \"%s\" for bridge
> %s\n",
> -                      np->type, np->full_name);
> -
>         return np;
>  }
>  
> 
> 
