Message-ID: <20021220164821.77027.qmail@web41213.mail.yahoo.com>
Date: Fri, 20 Dec 2002 08:48:21 -0800 (PST)
From: Prakash kanthi <pkanthi@yahoo.com>
Subject: Re: After Uncompresseing Linux..., what's next
To: Gary Thomas <gary@chez-thomas.org>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1040402316.32282.6202.camel@hermes.chez-thomas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I do have xilinx tools and i am working with their V2P
product. I completely understands what you are said.
But the problem is, right after the uncompression and
cpy to 0x00000000, i loose total control because i
don't have any clue what is getting executed.

And also, i have my boot monitor code at 0x00000000,
before uncompress process overwrites it. I see that
some of that code is getting executed after jump to
0x0. I reason i am overwriting 0x0 is because, i only
have 8MB RAM.

thanks,
Prakash


--- Gary Thomas <gary@chez-thomas.org> wrote:
> On Fri, 2002-12-20 at 09:14, Prakash kanthi wrote:
> >
> > Folks,
> >
> > I just wanted to provide more info on my env. I
> have
> > PPC405 based board with no network support forcing
> me
> > to use zImage.initrd.elf.
> >
> > Can you suggest more on my problem described
> below? I
> > saw the memory values at 0x00000000 onwards after
> > uncompressing linux and they have changed. But
> when
> > the control jumps to 0x0, my board hangs. I see
> that
> > ESR is showing a value of 0x80000000, meaning
> either
> > illegal instruction or Machine Check.
> >
> > Can you tell what's going on? What happens next
> after
> > uncompressing? I am thinking it executes
> start_kernel
> > function which calls lock_kernel. Let me know if i
> am
> > wrong.
> >
>
> A *lot* happens, even before the first "printk"!
>
> At the point where the kernel is being started, all
> that
> has happened is the basic image has been loaded to
> low
> memory.  The kernel then needs to set up the memory
> management
> (to map things the way it wants to), then perform
> quite a
> lot of initialization, then start up the generic
> kernel
> which will then do things like initialize devices,
> etc.
>
> Since you just say you have a board (and don't name
> it),
> I assume that you are porting Linux yourself.  In
> this case,
> you'll either need some tools (like the BDI already
> mentioned)
> or a lot of patience.  You'll need to look at how
> the kernel
> is trying to do its work, at least to the point
> where you can
> get to the first "printk" (which comes during the
> memory 'find'
> sequence on the PPC in arch/ppc/mm/ppc_mmu.c).  Once
> you get
> this far, and printk is working, you can then move
> on and find
> out what else needs to be done.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
