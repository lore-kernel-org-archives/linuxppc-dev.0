Message-ID: <638AA0336D7ED411928700D0B7B0D75BB323AC@mail2.aiinet.com>
From: "Gessner, Matt" <mattg@aiinet.com>
To: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Question about zvmlinux.embedded org.
Date: Mon, 3 Dec 2001 08:16:25 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all,

After running a plain old build on 2.4.15 with the ppc32 patches from
kernel.org,
this is how my zvmlinux.embedded image looks:

mattg@mattg-linux /home/mattg/wan-router/linux/arch/ppc/boot/images

Mon Dec 03 2001 8:13:14am {6} powerpc-linux-objdump -h zvmlinux.embedded

zvmlinux.embedded:     file format elf32-powerpc

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00004e84  00180000  00180000  00010000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .rodata       000005f0  00184e90  00184e90  00014e90  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .data         00000358  00186000  00186000  00016000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  3 .data.init    00000000  00187000  00187000  00017000  2**0
                  CONTENTS
  4 .bss          000031f0  00187000  00187000  00017000  2**2
                  ALLOC
  5 image         000828f5  00000000  00000000  00017000  2**0
                  CONTENTS, READONLY

Apologies if this isn't formatted nicely... I'm using (gasp) Outlook :(

Anyway, If you'll notice where .bss is being loaded, at 0x187000
and the location where image will be loaded (0x180000 - 0x10000 + 0x170000)
you'll notice that .bss overlaps image.

I did some searching on the archive, but couldn't find anything
definitive.  I'm surprised by this, and by the fact that this comes up
by default to be this way.

Can anyone shed light on what I need to do to make it so that clearing
.bss doesn't overwrite the top part of the vmlinux.gz embedded in the
file????

Also, can anyone explain why the default alignment isn't something
greater than 2**0 for the image?  I suppose it's not really, really
important,
but I expected it to be at least 2**2.

Thanks in advance.

Regards,

Matt Gessner

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
