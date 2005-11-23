Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95383687E0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 08:10:59 +1100 (EST)
Date: Wed, 23 Nov 2005 13:39:18 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20051123153918.GD5313@logos.cnet>
References: <437B2051.5030408@ru.mvista.com> <20051117135810.GB9753@logos.cnet>
	<437DE07E.6080005@ru.mvista.com>
	<20051118090845.GB12765@logos.cnet>
	<17283.54950.681390.749679@cargo.ozlabs.ibm.com>
	<20051123091107.GA3482@logos.cnet>
	<ACB2F36A-0A37-4EA1-9E4A-F773AD4E0D86@kernel.crashing.org>
	<20051123120033.GA3551@logos.cnet>
	<ddea89e58026c4f55f1a05af602cba60@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ddea89e58026c4f55f1a05af602cba60@embeddededge.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Dan,

On Wed, Nov 23, 2005 at 03:18:17PM -0500, Dan Malek wrote:
> 
> On Nov 23, 2005, at 7:00 AM, Marcelo Tosatti wrote:
> 
> >The files in arch/ppc/8xx_io/ (which is what I think you refer to as
> >candidates for drivers/), are:
> 
> I don't particularly like these macros, but I'm tired of fighting
> about it.  

We did not fight about it, did we??? I don't understand what you mean.

We need to agree on technical points. If you see a problem with the
macros, you need to teach us about them.

The requirement for in/out inline functions is to force the compiler
not to reorder instructions, but I suppose you are talking about the
clrbit/setbit macros? Or about both?

> If you follow the usage path, you will see it's only
> used in the CPM drivers, and I wish people would just use
> the data structure pointers to access these ports/bits with
> standard C code and then place any synchronization
> instructions properly.  

The in/out inline functions unify access to conf. registers.

Jeff Garzik gave me a list of reasons for using the inline macros
which is quite educational:

* Easier reviewing.  One cannot easily distinguish between writing to 
normal kernel virtual memory and "magic" memory that produces magicaly 
side effects such as initiating DMA of a net packet.

* Compiler safety.  As the code is written now, you have no guarantees 
that the compiler won't combine two stores to the same location, etc. 
Accessor macros are a convenient place to add compiler barriers or 
'volatile' notations that the MPC8xx code lacks.

* Maintainable.  foo_read[bwl] or foo_read{8,16,32} are preferred 
because that's the way other bus accessors look like -- yes even 
embedded SoC buses benefit from these code patterns.  You want your 
driver to look like other drivers as much as possible.
* Convenience.  The accessors can be a zero overhead memory read/write 
at a minimum.  But they can also be convenient places to use special 
memory read/write instructions that specify uncached memop, compiler 
barriers, memory barriers, etc.

And Paulus wrote some important points:

Generally on PowerPC you need to use at least the eieio instruction to
prevent reordering of the loads and stores to the device.  It's
possible that 8xx is sufficiently in-order that you get away without
putting in barrier instructions (eieio or sync), but it's not good
practice to omit them.

You can use accessors such as in_be32 and in_le32 in this situation,
when you have a kernel virtual address that is already mapped to the
device.


> There are some cases where you have to be quite careful about how you
> read and write some control registers, and I think this opens the
> possibility to just be sloppy and make mistakes since the read/write
> is hidden within the macro.

Here you're talking about the setbit/clrbit macros which combine 
read/write.

Its simply for the sake of readability, since the C text for 
"out_be32(xxx, in_be32(xxx) |& zzzz)" is quite large.

Do you think that the macro is a potential for introduction 
of mistakes?

We don't have any synchronization between read-modify-write 
operations to conf. registers now, can you mention the cases
where read and write need some sort of synchronization?

In any way, those can just not use the macros, right?

Sincerely, I don't care very much for setbit/clrbit macros,
I just think that they make the code easier to read.

> >Does anyone have hardware to test it? Dan?
> 
> Yes, I have hardware to test it.  I will do that one of these days.

OK ;)
