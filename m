Message-ID: <3932E59F.4A3F4936@embeddededge.com>
Date: Mon, 29 May 2000 17:48:15 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: "Brown, David (dbrown03)" <DBrown03@harris.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Questions about 8xxrom
References: <20000529022507.5F4463C9DF@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> > After all that, it still fails, while decompressing initrd.

I must have missed this.....what is the error?  Post the few lines
that show the actual/relocated debug messages for the zImage portions.

> I suspect Dan's comments last week explain that this doesn't currently work:

The word "currently" is quite correct.  It was never designed to
decompress directly from Flash.

> Dan, any chance you could clarify what would need to be done in order to
> decompress the initrd directly from flash?  We also want to do this
> eventually, and would like to avoid the wasted copy to RAM.

Nothing needs to be done.  The code in arch/ppc/mbxboot/misc.c will
allocate a RAM area and copy the initrd from Flash to RAM.  The address
and size of this is given to the kernel when it is started.

The functions for uncompressing and using initrd are part of the kernel
and common to all architectures.  It assumes the initrd is in RAM,
which is also common to all architectures.  I don't intend to change
this, and I don't see any real reason either.  The product dependent
boot will place a copy of initrd in RAM, which could be from a network,
CDROM, Floppy, Flash ROM, PCMCIA disk, etc.  The kernel isn't responsible
for placing it there, only for using it.  It is a common feature for
all systems, and thankfully someone made it real easy for us to use it.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
