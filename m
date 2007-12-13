Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DBDB7DE078
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 06:01:58 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBDJ1sAc013924
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 14:01:54 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBDJ1lRB124510
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 12:01:48 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBDJ1gdi030836
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 12:01:43 -0700
Date: Thu, 13 Dec 2007 13:01:13 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 19/20] [POWERPC] pci32: 4xx embedded platforms want to
	reassign all PCI resources
Message-ID: <20071213130113.59342c40@weaponx>
In-Reply-To: <20071213073851.C321FDDFC9@ozlabs.org>
References: <20071213073851.C321FDDFC9@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 13 Dec 2007 18:38:46 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This makes 4xx embedded platforms re-assign all PCI resources as we
> pretty much never care about what the various firmwares have done on
> these, it's generally not compatible with the way the kernel will map
> the bridges.
> 
> We still need to also enable bus renumbering on some of them, but I
> will do that from a separate patch after I've fixed 4xx PCIe to handle
> all bus numbers.

This one is slightly broken in my opinion.  You've added
the ppc_pci_flags to all of these platforms, which is fine for your
intended goal.  But now all of these platforms _have_ to compile with
PCI enabled or they'll break with:

arch/powerpc/platforms/built-in.o: In function `walnut_probe':
walnut.c:(.init.text+0x9a): undefined reference to `ppc_pci_flags'
walnut.c:(.init.text+0xa6): undefined reference to `ppc_pci_flags'
make[1]: *** [.tmp_vmlinux1] Error 1

So to do it correctly we need to either select CONFIG_PCI for all of
them, wrap the ppc_pci_flags assignment in #ifdef CONFIG_PCI, or move
the ppc_pci_flags variable declaration into something that always gets
compiled.

josh
