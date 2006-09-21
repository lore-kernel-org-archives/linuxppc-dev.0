Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC0F667C26
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 23:27:31 +1000 (EST)
Date: Thu, 21 Sep 2006 08:37:07 -0500
From: Matt Porter <mporter@embeddedalley.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Message-ID: <20060921133707.GA29137@gate.crashing.org>
References: <17680.30367.157642.674242@cargo.ozlabs.ibm.com>
	<20060920012042.GA28489@mag.az.mvista.com>
	<1158721828.3043.13.camel@vader.jdub.homelinux.org>
	<A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>
	<1158787957.6002.307.camel@localhost.localdomain>
	<20060920215738.GC24809@mag.az.mvista.com>
	<C2AFCB31-CFC2-4B0E-ADAE-380A612D1053@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C2AFCB31-CFC2-4B0E-ADAE-380A612D1053@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 21, 2006 at 02:07:05AM +0200, Segher Boessenkool wrote:
> If you use a different name than "address", you're not bound to its
> semantics either.  And as those semantics have some problems, please
> do change-em.  How about:
> 
> The "reg-virtual-address" property contains the same regions as the
> "reg" property, in the same order; each entry is #address-cells from
> the root node 32-bit integers wide(*); the entry describes a
> contiguous area of virtual memory of the same size as the
> corresponding "reg" entry, mapping that area, or 0 if the area isn't
> mapped.
> 
> Any holes in this definition?

On PPC44x (and other PowerPC processors) the number of address cells
to represent a virtual address and a physical address differ due the
36-bits of physical address space. Regardless of the name of the
new property, it should be defined to allow a different number of
address cells to represent an address in virtual address space.
> 
> (*)  This isn't strictly correct, but OF doesn't describe the size of
> virtual addresses anywhere.  In practice, it's the same as the size
> of physical addresses always.  Oh, and the name "virtual" isn't correct
> in PowerPC-speak anyway, heh.

Actually, in practice, it's not always the same size as a physical
address. We have 36-bit physical addressing systems in the real world.

FWIW, I'd be happy with this property name or fw,address. When we
discussed this on IRC the thought was to conform to what already
existed for this purpose in the OF spec. Since the address prop sounds
like it will confuse some people I think it makes sense to add a
new property (might as well just throw out the spec :P).

-Matt
