Message-ID: <395998E0.65DD0D9B@wibble.net>
Date: Wed, 28 Jun 2000 16:19:12 +1000
From: Steven Hanley <sjh@wibble.net>
MIME-Version: 1.0
To: Rolf Liu <rolfl@sc23.sc.mcel.mot.com>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: problem with compressing the kernel
References: <03d601bfe0b3$e1f375a0$bf0102c8@sc.mcel.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Hi, everyone,
> The linux kernel is compressed into a zip file, which is done under linux
> using the utility
> named gzip.

and thus a gzip file not a zip file, but this is being picky

> now, I am doing such work under Windows NT. I  am wondering if
> there is
> a utility that can do the same job , compressing the linux kernel ,which
> still can be
> uncompressed at running time.

well my initial thought is why would you need this?

the answer is no.

you seem to be confused anyway, yes the kernel is compressed for x86
machiens (it is however not compressed for other architectures, my ppc
box uses a normal uncompresased vmlinux image.

however it is not just a compressed gzip file

using the file tool a gzip file will look like

[16:06:53] 23 sjhmmj sjh ~>file
/home/asd/sources/pmac/linux-pmac-2.2.15-pre14.tar.gz
/home/asd/sources/pmac/linux-pmac-2.2.15-pre14.tar.gz: gzip compressed
data, deflated, last modified: Mon Mar 27 01:27:14 2000, os: Unix

wheras a kernel image (for ppc) will look like

[17:18:53] 1 innuendo sjh ~>file /mac/System\ Folder/Linux\
Kernels/vmlinux-2.2.15pre14
/mac/System Folder/Linux Kernels/vmlinux-2.2.15pre14: ELF 32-bit MSB
executable, PowerPC or cisco 4500, version 1, statically linked, not
stripped

which is a plain all ordinary elf binary pretty much

the compressed kernels found on x86 boxes will look like
[15:56:34] 22 sjhmmj sjh ~>file /boot/devel
/boot/devel: Linux kernel x86 boot executable bzImage, version 2.2.16
(sjh@sjhmmj) #46 SMP Thu, RO-rootFS, root_dev=0x301, Normal VGA

it may seem you can just gzip an uncompressed vmlinux and get a vmlinuz
that will boot, except if you notice the devel image just there is not a
gzip file. There is some executable code added on the front of the image
so the x86 box will run it on boot up, some of this code uncompresses
the image.

So although gzip is available on windows (see prep.ai.mit.edu or the
cygwin site for more details (www.cygnus.com will have links)) it will
not help making a kernel image.

Now of course I wonder why you would need the ability as after all a
linux box is all you need to compile and make the image, or heck a
compatible gcc on any unix can in theory compile the kernel, the utility
to compress and uncompress the kernel is in the source tree so long as
you can compile the source tree it should work fine. gzip is not listed
as a requirement in kernel compiling in the file
/usr/src/linux/Documentation/Changes for this reason, if you can compile
the kernel on a machine it can create the compressed images if needed.

And of course remember you dont need otr use compressed images on ppc
machines.

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
