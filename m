Message-ID: <39EB6226.7FA81AA3@mvista.com>
Date: Mon, 16 Oct 2000 16:16:38 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Paolo Scaffardi <arsenio@tin.it>
CC: linuxppc-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: outb_p(0xc, 0x3f2) with _IO_BASE remapped!
References: <016f01c034ef$3cf52220$0a00010a@airvent.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paolo Scaffardi wrote:
>
> I discovered that my kernel hangs into 'drivers/block/ll_rw_blk.c', in
> function 'blk_dev_init', at the instruction outb_p(0xc, 0x3f2),

Hmmm...There should be an #ifdef around that to ensure it isn't done
on PowerPC platforms.  In later kernels, it is just #ifdef CONFIG_x86.
What kernel are you using?

> This is really a problem to me... i need to remap _IO_BASE to use
> m8xx_pcmcia!

Well, this is a specific example of a bunch of ranting I did recently
on the linuxppc-dev list about providing a much better I/O interface
(it was a PCI discussion, but would have fixed all of this too).
Unfortunately, for embedded systems it looks like we are just going
to have to hack code privately to get the configurations we need.
There are lots of mapping challenges because of implied address maps
that appear on workstations.  We will get there.....

> - may the pinguin b with u -

...and also with you...


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
