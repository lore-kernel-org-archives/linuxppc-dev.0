Message-ID: <3AF1A9CC.5966DC8B@mvista.com>
Date: Thu, 03 May 2001 11:56:12 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Steven Hein <ssh@sgi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: booting from cramfs in flash
References: <3AF1A6C9.9B0F05DF@sgi.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Hein wrote:
>
> My cramfs adventure continues.....
>
> Okay, so I have a cramfs filesystem image creaed created.
> Now, how do I tell the kernel to boot using that filesystem
> when the filesystem is an image in flash?
>
> Maybe I'm on the wrong path, but my previous setup used a compressed
> kernel and gzip'ed ext2 filesystem as an initial ramdisk, which
> also served as my permanent filesystem.   So I thought I should
> be able to just replace my old initrd with my new cramfs image,
> tell the kernel where it is (in flash), and it would go.

It turns out that cramfs is not supported for a root fs or initrd.
Basically, the kernel checks a hardcoded list of supported filesystems
and if the MAGIC number doesn't match it bails.  Midori has a patch to
add cramfs to this list.  I believe it is in thier kernel package.

>
> But, that's not the case for me so far. If I pass the address in
> flash of my cramfs image as the initrd_start
> and initrd_end (in R3/R4, the kernel craps out because it can't reuse
> the pages where I told it that the initrd lives).
>
> So,how do I make this connection?  Or, do I still need an ext2
> initrd like I used before?  If so, then how do I mount the CRAMFS
> filesystem that is an image sitting flash?
>

You can do that too.  Actually that is how we do it on the iPaq.  You
need to enable MTD, so your flash looks like a block device. then
'mount' can mount cramfs images.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
