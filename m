Message-ID: <39D23018.92FA6256@mvista.com>
Date: Wed, 27 Sep 2000 13:36:24 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ruedi.Hofer@ascom.ch
CC: linuxppc-embedded@lists.linuxppc.org, vanbaren_gerald@si.com,
        kernel@linux01.hasler.ascom.ch
Subject: Re: VxWorks bootloader & PowerQUICC II, Booting the kernel
References: <0G1J00L5RU694U@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi.Hofer@ascom.ch wrote:

> I try to boot the Linux kernel on a SBC8260 evaluation board using
> the VxWorks bootloader.

Somewhere (and you can look through the archives as well as I can :-),
I posted a program that will hack a zImage so the VxWorks boot loader
will properly load and start it.....

> In order to be able to load the whole kernel at address 0x900000,
> I had to modify the ELF header of the zImage file. I basically changed
> the length and the start address.

There are a few more things, but that is the idea.


> 1. Why is the length in the ELF header wrong?

Well, it represents the code that we tack on the front of the
compressed kernel, not the contents of the image itself.  It is just
the result of the way we use the tools. "Wrong" depends upon your
point of view.  It works fine for some boards, including the Motorola
PPCBug boot roms.  However, the header doesn't really represent the
image.

> 2. Why is the start address set to 0x400000 and not to 0x900000?

Because the code is written to execute at 0x400000, but it must be
loaded somewhere above that.  The first thing the code does is discover
where it is loaded, move itself to the liked address, allocate some
memory for BSS and buffers, then starts working.  You can't load it
at the 0x400000 address because it allocates the BSS and buffers, the
will write over the attched zImage.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
