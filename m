Date: Fri, 3 Mar 2000 11:07:48 +0100
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: FireWire + Apple PB G3: some success
Message-Id: <20000303110748.000701@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 3, 2000, Ryuichi Oikawa <roikawa@rr.iij4u.or.jp> wrote:

>BBTW, I'm new in the MOL source and I need some information/explanation.
>Today I tried to add RageLTPro OF properties to MOL oftree.nw,
>insert it into the pci device tree and mmu map full 16MB aperture
>in thw video driver(on PB G3). I could run the drawing engine within
>MacOS manually, but ATI's extension didn't seem to recognize the chip
>at all. I even tried to load & insert into the driver properties field
>the driver extracted from ATI Driver update file, but no success.
>I don't understand MOL interface mechanism yet(and unfortunately
>my macos complier, symantec c++ doesn't work on recent system).
>
>What is the correct way to accelerate MOL video?

I don't think we can use MacOS ATI accelerator. It's tightly coupled with
the ATI driver (which handles also allocation of fb memory for QuickTime,
YUV overlay, interrupts, etc..) and will certainly break as soon as we
switch MOL console out.

We have to write our own MacOS accelerator using Apple's QD accel APIs.
Unfortunately, those APIs are under NDA and a driver using them can not
be released in source code form. I do have those APIs and I will try to
write some kind of interface layer that sends some of QD commands to MOL
so we can build chip-specific accel modules, but this layer will have to
reside in a non-GPL'd MacOS extension, and I didn't have time to do it yet.

Another possibility is to patch, from a MacOS extension, some QD
functions are directly route them to the emulator instead of using Apple
acceleration hooks.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
