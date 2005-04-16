Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 58A2067B35
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Apr 2005 10:36:49 +1000 (EST)
Date: Fri, 15 Apr 2005 17:36:44 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050416003644.GA1086@gate.ebshome.net>
References: <c3d0340b05041517167c0cfa5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b05041517167c0cfa5c@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Question on fixup_bigphys_addr() in syslib/ibm44x_common.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Apr 15, 2005 at 05:16:32PM -0700, Shawn Jin wrote:
> Hi,
> 
> When looking into ppc440 support, I'm confused on the functionality of
> fixup_bigphys_addr() in syslib/ibm44x_common.c. It's called by
> ioremap() in arch/ppc/mm/pgtable.c. The prototype is as follows.
>      phys_addr_t fixup_bigphys_addr(phys_addr_t addr, phys_addr_t size)
> 
> Why do we need this fixup? ioremap() takes a physical address as an
> argument and maps the physical address space to virtual address space
> with the specified size. Since it's already a physical address, which
> is 36-bit address in the case of 440, why do we need to fix up the
> ERPN? I must be missing something here.

phys addr which is passed to ioremap doesn't always contain full 
36-bit address. The reason for this is that some generic Linux 
subsystems (e.g. PCI) for 32-bit archs assume that physical address is 
always 32-bit. To make such generic (not 440-specific) drivers work 
on 44x we need this hack.

IIRC there is an effort under way to fix this generic kernel 
limitation, so hopefully we will be able to get rid of this hack soon.

--
Eugene
