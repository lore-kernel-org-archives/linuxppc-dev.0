Message-ID: <3AF1C388.57DEDDE0@routefree.com>
Date: Thu, 03 May 2001 13:46:00 -0700
From: David Blythe <blythe@routefree.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: booting from cramfs in flash
References: <3AF1A6C9.9B0F05DF@sgi.com> <3AF1A9CC.5966DC8B@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthew Locke wrote:

>
> It turns out that cramfs is not supported for a root fs or initrd.
> Basically, the kernel checks a hardcoded list of supported filesystems
> and if the MAGIC number doesn't match it bails.  Midori has a patch to
> add cramfs to this list.  I believe it is in thier kernel package.
>
> >
> > But, that's not the case for me so far. If I pass the address in
> > flash of my cramfs image as the initrd_start
> > and initrd_end (in R3/R4, the kernel craps out because it can't reuse
> > the pages where I told it that the initrd lives).
> >
> > So,how do I make this connection?  Or, do I still need an ext2
> > initrd like I used before?  If so, then how do I mount the CRAMFS
> > filesystem that is an image sitting flash?
> >
>
> You can do that too.  Actually that is how we do it on the iPaq.  You
> need to enable MTD, so your flash looks like a block device. then
> 'mount' can mount cramfs images.

that is what we did for our read-only file system.  so far we still use
a small ext2 ramdisk for the root file system because we have some
writable files and haven't been aggressive about eliminating it (the
gzip'd ext2 file system is also smaller than the equivalent cramfs
filesystem, which helps with space issues in the flash).  I had to make
some changes to the doc2001 driver to get it to work with the mtdblock
layer, but haven't forwarded the changes yet.
	david

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
