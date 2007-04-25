Return-Path: <miltonm@bga.com>
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20070424230708.GA10401@lixom.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <aa977cbe20f2d5698c5846df7de21eda@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] 64K page support for kexec
Date: Wed, 25 Apr 2007 00:48:56 -0500
To: Olof Johansson <olof@lixom.net>, Luke Browning <lukebr@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
>
> > > > + /*
> > > > +  * FIXME, this could be made more efficient by storing the type
> > > > +  * of hash algorithm in mmu_psize_defs[].  The code below 
> assumes
> > > > +  * the number of bits in the va representing the offset in the
> > > > +  * page is less than 23. This affects the hash algorithm that 
> is
> > > > +  * used. When 16G pages are supported, a new hash algorithm
> > > > +  * needs to be provided.  See POWER ISA Book III.
> > > > +  *
> > > > +  * The code below works for 16M, 64K, and 4K pages.
> > > > +  */
> > >
> > > A BUG_ON() when other sizes are hit could be a good idea?
> >
> > a BUG_ON if the B bit is set would be useful too. (that is 1T segment
> > HPTE).
>
> Yep.


NNNNOOOOO!!!!


Do NOT add any BUG() is this code!


Look at the context:

(1) We are tearing down *ALL* mappings.   That includes the
kernel linear mapping and the mapping of the kernel text.

(2) We are in real mode.   There is no way back to virtural
mode.  See (1).

(3) We hove put the new kernel in memory.  There is no data
that was not a part of the static data or bss sections.   There
are no per-cpu variables.  Nothing with vmalloc.   Nothing with
kmalloc.  Nothing with alloc_pages.

(4) If this is the panic kernel case, we are allready crashed
and trying to get into a new envrionment to dump memory.
Intentionally failing that is the last thing you want to do.

(5) This hook is only used by kexec_sequence, called by
machine_kexec.   At the beginning of that function there
is the comment "its too late to fail here."



Bottom line: Don't even think of causing any trap here, just
execute as best as you know how.   You dohn't have any way to
tell the user you failed anyways.


milton
