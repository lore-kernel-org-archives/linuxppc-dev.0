Message-ID: <3957D1CC.723FE4E6@netx4.com>
Date: Mon, 26 Jun 2000 17:57:32 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Jerry Van Baren <vanbaren_gerald@si.com>
CC: Kwansuk Kim <kskim@neowave.co.kr>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: omitted kernel sections
References: <Your message of "Mon, 26 Jun 2000 15:43:35 +0900." <NEBBKFENMLEDKDHMEHPJKEMECAAA.kskim@neowave.co.kr> <4.3.2.20000626080626.00b482e0@falcon.si.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jerry Van Baren wrote:

> Dan Malek has rejected the patch in the BitKeeper tree, although Jon
> and I disagree with him.

The purpose of the software contained in the boot directory and
the resulting zImage is to provide a minimal, generic environment
for all embedded systems.  The code in this directory it not
intended to replace a non-existant boot rom, but rather to collect
sufficient information about the board differences and provide that
to a kernel that should be generic for all 8xx processors.

The zImage in this directory is supposed to be the smallest compressed
image that will boot from a variety of production boot devices, such
as Flash rom, Compact/Flash cards, disks, or networks.

The ELF header on this image is an artifact of the tools used to
build this image.  All of the bits following this header comprise
a self-contained image.  Execute from the first location of this
image and it will relocate and uncompress the kernel, along with
any initial ram disk.  There are no symbols or any information
useful to a debugger in this image, so I fail to see why people
keep trying to use debuggers on this image.  If you want to use
a debugger, there is a fully-dressed ELF image called 'vmlinux'
in the top directory designed for this purpose.


> * It makes the image larger.
>  > Not really, its just some more elf headers that get stripped on loading.

Yes, really, because all of the BSS sections are expanded as
loadable sections using this technique.  People that have special
tools (and count flash rom bytes for all uses), couldn't load this
zImage when absolutely nothing else changed in the code.  It simply
grew in size and added no value to them.

>  > I disagree, we ran into the problem, developers before us ran into
> the problem, and it is coming up again.

Everybody wants something different in this directory and wants
different images to be produced.  If you want something different,
make this happen locally.  The purpose of using your changes in
the common source code is to generically benefit others, and
this doesn't do that.  It helps you and the few doing exactly what
you want, and breaks what people before you have been using for years.

In less time than you have spent complaining on this list, you could
have done as many before you.  Understand the format of this file
and write a conversion program to format this for your tools.  The
EST tools discussed right now have a binary loader option.  You can
use that without writing _anything_.  Should you write tools unique
to your environment, you will know that the file format here isn't
going to change, and your tools will remain useful for a very long
time.

>  > Not a big deal in my book given the benefits: a valid elf file that
> is loadable by commonly used tools.

As I said, a valid ELF file is produced, and it is in the upper
level directory.  Stop trying to use a special production purpose
bag of bits and use the other files more suitable for debugging.

> Dan said in a later message that he had put together a C program that
> rewrote the elf headers to make the file a loadable elf file, but I
> have not investigated his program.

I wrote a program that will hack the headers such that the stupid
VxWorks TFTP loader would load the zImage (like other properly
written loaders will do without any hacks).  I don't know if this
will help anyone else.  You can find it on
	ftp://ftp.embeddededge.com/pub/vxhack.c


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
