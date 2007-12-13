Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 254C7DDF8F
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 07:37:47 +1100 (EST)
Subject: Re: [PATCH 19/20] [POWERPC] pci32: 4xx embedded platforms want to
	reassign all PCI resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071213130113.59342c40@weaponx>
References: <20071213073851.C321FDDFC9@ozlabs.org>
	<20071213130113.59342c40@weaponx>
Content-Type: text/plain
Date: Fri, 14 Dec 2007 07:37:23 +1100
Message-Id: <1197578243.15741.150.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This one is slightly broken in my opinion.  You've added
> the ppc_pci_flags to all of these platforms, which is fine for your
> intended goal.  But now all of these platforms _have_ to compile with
> PCI enabled or they'll break with:
> 
> arch/powerpc/platforms/built-in.o: In function `walnut_probe':
> walnut.c:(.init.text+0x9a): undefined reference to `ppc_pci_flags'
> walnut.c:(.init.text+0xa6): undefined reference to `ppc_pci_flags'
> make[1]: *** [.tmp_vmlinux1] Error 1
> 
> So to do it correctly we need to either select CONFIG_PCI for all of
> them, wrap the ppc_pci_flags assignment in #ifdef CONFIG_PCI, or move
> the ppc_pci_flags variable declaration into something that always gets
> compiled.

Hrm... PCI is user selectable ? Forgot about that ...

All those platforms have PCI slots, so we may as well select it in
Kconfig... I'd rather avoid #ifdef's

Ben.
