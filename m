Message-ID: <20030729062348.20980.qmail@web14601.mail.yahoo.com>
Date: Mon, 28 Jul 2003 23:23:48 -0700 (PDT)
From: Kalpesh Jasapara <kjasapara@yahoo.com>
Subject: Re: "alloc_area_pte: page already exists" 
To: tliang@yahoo.com
Cc: Matt Porter <mporter@kernel.crashing.org>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

>From the code it appears that iounmap() or vfree() of
any virtual address that maps physical address beyond
the 32 bit address space, especially in case of PPC
440 (where pte_t is defined as unsigned long long ),
free_area_pte() will return without completely
clearing out the pte.

If the pte has not completely been cleaned up (all 64
bits) during the iounmap(or vfree) is it possible that
pte_none() would complain and you see the messages ?

Matt, do you think it is a bug ?
the FIXME suggests that this needs to be cleaned up.

File: pgtable.h
<..snip..>
#else /* CONFIG_440 */
/* FIXME: Clean this up */
static inline unsigned long pte_update(pte_t *p,
unsigned long clr,
                                       unsigned long
set)
{
        unsigned long old, tmp, offset;

        __asm__ __volatile__("\
1:      li      %0,4\n\
        lwarx   %2,%0,%4\n\
        andc    %1,%2,%5\n\
        or      %1,%1,%6\n"
"       stwcx.  %1,%0,%4\n\
        bne-    1b"
        : "=&r" (offset), "=&r" (tmp), "=&r" (old),
"=m" (*p)
        : "r" (p), "r" (clr), "r" (set), "m" (*p)
        : "cc" );
        return old;
}
#endif /* CONFIG_440 */
<...snip...>

Regards,
-Kalpesh

>
> Matt,
>
> It is a custom board with 256MB of memory.

Ahh, ok. So, what you've done is misconfigured a
mapping in
your custom board port. It's reporting that you
already have
a pte allocated in the vmalloc area which must be
untouched
so the VM can allocate memory at runtime.

Usually, this is the result of an errant io_block_map
entry
which overlaps the vmalloc area. Examine the
VMALLOC_START
macro to see how the start of vmalloc space is
calculated.
In your case, (256MB of RAM) the start of vmalloc
space will
be at 0xd1000000 assuming a standard PAGE_OFFSET of
0xc0000000.
If you've mapped something near that virtual address
or somewhere
close above that address then you need to move it. How
much
vmalloc space you need to reserve depends solely on
your specific
application.

In most cases, it's smarter to never use io_block_map
and to
let ioremap() create mappings dynamically so this sort
of thing
doesn't happen. Most modern in-kernel ports try to not
use
io_block_map if at all possible.

Regards,
--
Matt Porter


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
