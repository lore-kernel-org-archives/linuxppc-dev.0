From: Benjamin Herrenschmidt <bh40@calva.net>
To: Steven Hanley <sjh@wibble.net>,
        Linux PPC Dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: agpgart? or how to use dri?
Date: Thu, 1 Feb 2001 12:29:39 +0100
Message-Id: <19341227050123.16989@mailhost.mipsys.com>
In-Reply-To: <20010201184806.A5957@chiru.svana.org>
References: <20010201184806.A5957@chiru.svana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Trying to get the dri stuff to build (this is an X 4.02 tree checked out
>from the branch Gareth announced two days ago)
>
>The problem seems to be the kernel module. When I have agpgart enabled in
>the kernel the r128 kernel module builds, when I dont have apgart enabled
>only the tdfx module will build, this is doing a make in the
>xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/ directory in the
>X source
>
>The problem here of course is agpgart wont build on ppc
>
>in /usr/src/linux/drivers/char/agp/agpgart_be.c there is a flush_dcache
>function defined, and it is only defined for alpha, ia64 and i386.
>
>I dont know what the culprit is, but I assume thee dri stuff can be built
>without agpgart on ppc or some scuh, this kernel tree is the 2.4.1 bk
>rsynced about half an hour ago.
>
>Any hints on getting the dri kernel module to build to the extent that it
>can be insmod'd and used?
>

The current agpgart driver won't work on PPC, the Apple AGP host bridge
is not supported.

The new DRI support announced by Gareth is using the PCI GART which
doesn't need the AGP capabilities. Don't enable either AGP or DRI in your
kernel, and build the kernel r128 DRM module from XFree sources. You need
to use the CVS branch posted earlier by Gareth. I slightly hacked my own
to build since I lack the glide libs necessary for the 3dfx stuff to compile.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
