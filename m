Message-ID: <20030723011834.30711.qmail@web11005.mail.yahoo.com>
Date: Tue, 22 Jul 2003 18:18:34 -0700 (PDT)
From: Xupei Liang <tliang@yahoo.com>
Subject: Re: "alloc_area_pte: page already exists"
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030721201037.A16523@home.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Matt,

Thank you.

I am not using any io_block_map() call in the code.
However, there are might be other similar causes.
I am still working on it.

If you have more ideas, please let me know.

Regards,

Terry L.


--- Matt Porter <mporter@kernel.crashing.org> wrote:
>
> On Mon, Jul 21, 2003 at 07:01:49PM -0700, Xupei
> Liang wrote:
> >
> > Matt,
> >
> > It is a custom board with 256MB of memory.
>
> Ahh, ok.  So, what you've done is misconfigured a
> mapping in
> your custom board port.  It's reporting that you
> already have
> a pte allocated in the vmalloc area which must be
> untouched
> so the VM can allocate memory at runtime.
>
> Usually, this is the result of an errant
> io_block_map entry
> which overlaps the vmalloc area.  Examine the
> VMALLOC_START
> macro to see how the start of vmalloc space is
> calculated.
> In your case, (256MB of RAM) the start of vmalloc
> space will
> be at 0xd1000000 assuming a standard PAGE_OFFSET of
> 0xc0000000.
> If you've mapped something near that virtual address
> or somewhere
> close above that address then you need to move it.
> How much
> vmalloc space you need to reserve depends solely on
> your specific
> application.
>
> In most cases, it's smarter to never use
> io_block_map and to
> let ioremap() create mappings dynamically so this
> sort of thing
> doesn't happen. Most modern in-kernel ports try to
> not use
> io_block_map if at all possible.
>
> Regards,
> --
> Matt Porter
> mporter@kernel.crashing.org
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
