In-Reply-To: <Pine.LNX.4.60.0407271546570.7005@localhost.localdomain>
References: <Pine.LNX.4.60.0407271546570.7005@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <81B2FD02-E014-11D8-96F8-003065F9B7DC@embeddededge.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: more questions about 8xx microcode patches
Date: Tue, 27 Jul 2004 17:32:48 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 27, 2004, at 4:23 PM, Robert P. J. Day wrote:

> 1)
>   i recall that, while the manual lists the first controller above as
> USB, SCC1 is also a possibility for other 8xx processors, yes?

Yes.  On the 823/850 the SCC1 controller is dedicated to USB.

> 2)
>   given the size of the scc_enet structure in commproc.h, the whole
> reason to relocate SMC1 is to let ethernet on SCC3 spill over into the
> normally-reserved SMC1 memory.  i would assume the same situation
> would hold if you were trying to use SCC2 for ethernet -- you'd need
> to relocate SPI, right?

Yes.

>   speaking of I2C and SPI, what's the rationale for pretty much every
> single piece of information insisting that these two controllers are
> relocated as a pair?

There were (are?) various microcode patches that became available
as people needed the relocation.  In the end, I think there was only
one patch the relocated everything.

> 4)
>   the current micropatch.c file appears to limit one to applying a
> single patch.  the first patch (written to DPRAM address 0) appears to
> relocate both I2C/SPI (there's that linkage again).

Unless it has changed recently, all microcode patches have to be
loaded into location 0 of the DPRAM.  You can only load one patch
at a time, hence the need for a single patch to contain the relocation
of multiple devices.

> further down, there's a test for USE_SMC_PATCH (*clearly* not
> compatible with the first patch since they both write to DPRAM address
> 0) which represents the SMC/I2C/SPI patch.

Yep.

>   (actually, it reads
> "SMC2", which i assume is a typo.)

Nope, it's to relocate SMC2 so you could run Ethernet/ATM on SCC4.

>  i'm assuming that this patch
> relocates *all* of SMC1, I2C and SPI.

Don't assume anything.  There are lots of different patches.  Carefully
read all of the documentation with all of the patches to see what they
do, how they are supposed to be loaded, and they match the
CPM microcode ROM that is present in your processor.

>   in general, what patches should exist?

You will have to investigate.  At one time I knew of no less than six
different patches, for various relocation or feature additions.

>   should the USB SOF patch listed in micropatch.c be an option?
> despite the fact that, as some have pointed out, USB is kind of borked
> in the 850 Rev B board?

....and I have pointed out that when used properly it works just fine.
It's up to you.

>   it seems that creating a menu of 8xx microcode patches would be
> fairly easy:


Hahahahaha!!!!  You don't know how big of a hole you are digging :-)


>   1) collect the current patches, assign them symbolic names [*]
>   2) decide which are mutually exclusive and code that into Kconfig

As far as I know, they are all mutually exclusive, unless they have
been changed recently.

>   3) using the denx 2.4.25 tree as a model, put each patch into a
> 	separate source file and just include the appropriate file,
> 	making the appropriate changes to source files like
> 	cpm_uart_cpm1.c where necessary

I have not looked at what Wolfgang has done, but the patches
I have seen are all S-record files that were supposed to be downloaded
through a debugger.  In addition to writing the microcode to
the DPRAM, they also modified various parameter and control
registers in the CPM.  The point is, you just can't download
code, you also have to perform some initialization steps in
the drivers, which of course are usually different depending
upon the patch that is loaded.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
