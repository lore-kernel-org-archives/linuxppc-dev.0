Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC81ADE244
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 07:41:04 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBDKf0I8008574
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 15:41:00 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBDKexCJ169104
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 13:40:59 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBDKewf5024423
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 13:40:59 -0700
Date: Thu, 13 Dec 2007 14:40:56 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 19/20] [POWERPC] pci32: 4xx embedded platforms want to
	reassign all PCI resources
Message-ID: <20071213144056.1a46b7a3@weaponx>
In-Reply-To: <1197578243.15741.150.camel@pasglop>
References: <20071213073851.C321FDDFC9@ozlabs.org>
	<20071213130113.59342c40@weaponx>
	<1197578243.15741.150.camel@pasglop>
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

On Fri, 14 Dec 2007 07:37:23 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > This one is slightly broken in my opinion.  You've added
> > the ppc_pci_flags to all of these platforms, which is fine for your
> > intended goal.  But now all of these platforms _have_ to compile with
> > PCI enabled or they'll break with:
> > 
> > arch/powerpc/platforms/built-in.o: In function `walnut_probe':
> > walnut.c:(.init.text+0x9a): undefined reference to `ppc_pci_flags'
> > walnut.c:(.init.text+0xa6): undefined reference to `ppc_pci_flags'
> > make[1]: *** [.tmp_vmlinux1] Error 1
> > 
> > So to do it correctly we need to either select CONFIG_PCI for all of
> > them, wrap the ppc_pci_flags assignment in #ifdef CONFIG_PCI, or move
> > the ppc_pci_flags variable declaration into something that always gets
> > compiled.
> 
> Hrm... PCI is user selectable ? Forgot about that ...
> 
> All those platforms have PCI slots, so we may as well select it in
> Kconfig... I'd rather avoid #ifdef's

What about people that don't have PCI on their boards, or don't really
care about it?

josh
