Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from IE1EHSOBE002.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 708DADDEDB
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 14:27:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: device trees.
Date: Mon, 11 May 2009 21:27:28 -0700
In-Reply-To: <4A08E050.9000302@dlasys.net>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<20090511155232.A30671B6005D@mail89-va3.bigfish.com>
	<4A08593C.4010503@dlasys.net>
	<20090511183638.F07C01438054@mail184-wa4.bigfish.com>
	<4A08C599.2030100@dlasys.net>
	<20090512005554.EEE1019D009B@mail129-dub.bigfish.com>
	<4A08E050.9000302@dlasys.net>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>,
	<linuxppc-dev@ozlabs.org>
Message-ID: <20090512042733.8D4A21400054@mail184-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: David H. Lynch Jr. [mailto:dhlii@dlasys.net]
> Sent: Monday, May 11, 2009 7:35 PM
> To: Stephen Neuendorffer; linuxppc-dev@ozlabs.org
> Subject: Re: device trees.
> =

> Stephen Neuendorffer wrote:
> >
> >> Many of our systems are LX systems but currently we are not running
> >> Linux on them.
> >>
> >
> > Master SelectMap, I presume?  What FPGA family?
> > Does the FPGA have access to the CPLD after boot, other than through
the
> > configuration pins?
> >
> >
> One of the skills I have not had time to develop - because Pico has
> plenty of qualified firmware/hardware people and not enough OS people,
> is fluency with Xilinx tools.
> =

> FPGA Families - currently Spartan, virtex 4 and virtex 5.
> LX & FX, in all kinds of sizes. So that as an example our E14 (1st
> generation cardbus) comes in FX40's and FX60's and LX## .......
> =

> I am presuming that is what you mean.
> =

> Access to the hardware on the cards can be weird. As our cards are
often
> hosted, that means the firmware is often setup to allow host and
target
> access to hardware. In others only the host or only the target does.
> =

> What I know is that if I send a few magic values to the CPLD and then
> start reading the bit file out of flash, I will trigger the CPLD to
> reload the FPGA from the bitfile I selected.
> =

> =

> =

> =

> =

> > OK, so that means the boot monitor can open sector 2 of the flash
and
> > read info, right? (Or wherever else the bitstream is coming from.
> On powerup the CPLD boots from sector 2. IF it is rebooted by the host
> or target it can reboot from any flash sector.
> In the "normal" setup the target has indirect access to the entire NOR
> flash.
> =

> >   Can
> > the CPLD store one 32 bit int that the new bitstream can come back
and
> > read later?
> >
> Off the top of my head I do nto know, but if you are saying I need to
> find someway of preserving a 32bit value through rebooting the FPGA I
> can find a way to do it.
> =

> >
> >
> > OK, so the key question seems to be *when* the bitstream is
associated
> > with the
> > device tree.  If at bitstream generation time, you can prepend the
.dtb
> > to the bitstream.  As long as the dtb doesn't contain the magic
> > bitstream start code, you can go back and access it later.
> >
> You really mean prepend ? I was presuming that things would work
better
> if it was appended ?

Yes, actually prepend is simpler because you don't have to know the size
of the bitstream.
Everything before the SYNC code in the bitstream is ignored.

For instance, this is the start of a spartan 3ADSP bitstream:

00000000  00 09 0f f0 0f f0 0f f0  0f f0 00 00 01 61 00 0b
|.............a..|
00000010  73 79 73 74 65 6d 2e 6e  63 64 00 62 00 0e 33 73
|system.ncd.b..3s|
00000020  64 33 34 30 30 61 66 67  36 37 36 00 63 00 0b 32
|d3400afg676.c..2|
00000030  30 30 39 2f 20 35 2f 20  31 00 64 00 09 31 34 3a  |009/ 5/
1.d..14:|
00000040  34 38 3a 32 31 00 65 00  16 59 d4 ff ff ff ff ff
|48:21.e..Y......|
00000050  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
|................|
00000060  ff ff ff ff ff ff ff ff  ff ff ff aa 99 30 a1 00
|.............0..|

'FF FF AA 99' is the Spartan 3 DUMMY code/SYNC code combination,
everything before that
is discarded by the FPGA.

> Regardless, I have the means to know exactly what bit file is
currently
> loaded, and I can then look it up in the NOR Flash.

Yes, so as long as when the bitstream is loaded, it can figure out where
in the flash it was loaded *from* and then go back there and get the
dtb, then that should work.  This would make it difficult to do certain
things (like loading a useful bitstream from anywhere OTHER than flash),
but if you can make that restriction, then it should work.  I can think
of several ways of doing this, the simple of which is to have your
bootloader go to the CPLD after it has loaded to figure out where the
bitstream came from.

> I can glue the dtb and the bit file together in anyway that will make
> xilinx happy.

Fortunately, you don't have to keep Xilinx happy, only the FPGA.. :)

> If it is prepended the only case I care about is the power up
sequence,
> because that must start loading the bit file at sector 2.
> We do cope with the scenario where the sector 2 bit file is completely
> screwed up. The CPLD STARTS trying to load at sector 2, but it will
> continue to the end of flash until something actually loads. The dead
> card scenario is sector 2 is the start of a valid but non-functional
bit
> file.
> At that point you must load a bit image using JTAG and then write a
good
> bit file to flash.
> =

> Alright lets say I prepend. I am loosely familar with the magic start
> code. Does that need to be aligned in anyway ?

My understanding is that alignment does matter somewhat if you are using
SelectMap32, so if this is what you are doing, it's probably best to
preserve the existing alignment, padding the dtb to a number of words
divisible by 4.  If you're using serial configuration modes, or
selectmap8, then it doesn't matter.

> And just for the sake of argument lets say I append the dtb. Do I need
> some padding between the bitfile and the dtb to keep the
> FPGA from loading the dtb as firmware ? Is there a magic stop sequence
?
> Is the load terminated by the length of the bits.

The bitstream ends with a DESYNC code, followed by a pad of frame data.
After that, everything is ignored until the next SYNC code.  BTW, all of
this is documented in the various configuration user guides.

I'll add that if you are doing V4 and V5 only and don't care about S3,
then there is another mechanism which avoids 'knowing where you loaded
the bitstream from'.  This relies on the USR_ACCESS_VIRTEX4 and
USER_ACCESS_VIRTEX5 primitives to pass further configuration information
to the FPGA design from the configuration source.  You could use this to
append the dtb to the bitstream and to copy it into external memory
using a little bit of FPGA logic, and presumably, the processor.
However, this mechanism is not available on S3.

Steve

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
