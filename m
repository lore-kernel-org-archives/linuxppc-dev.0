Date: Mon, 8 May 2000 09:40:09 +0200 (CEST)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: Jerry Nguyen <jerry_nguyen_75@yahoo.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE on MPC821
In-Reply-To: <20000508041028.24425.qmail@web4604.mail.yahoo.com>
Message-ID: <Pine.BSF.4.21.0005080848280.58200-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, 7 May 2000, Jerry Nguyen wrote:

>
> Hi
>
> Sorry for the off-topic posting but I am stuck to this
> mail list. I am doing my thesis for my Master
> degree,which I want to build a IDE controller to work
> with MPC821. Can anyone tell me how difficult it is?
> or give advice where can I find related material, any
> example would be great. sorry for my humble english.

Since I have already embarrased myself over this subject
on this list before, I can just as well continue to do so.

On the hardware side this is not hard to do at all.
What you need to do is synthetisise a ISA bus out of
the MPC821 local bus. The IDE bus is just a buffered
version of the ISA bus. The disk itself appares in
its simplest form as just three IO registers. The
IDE controller is therefore nothing but buffers
and two address decoders.

Both the ISA and MPC8xx bus are asynchronous, but
where the ISA bus [aka. 80C286 local bus] is default run
and 16 bit little endian, the MPC8xx bus is default
wait 32 bit big endian _and_ bit reversed [meaning
D31 is LSB, as is A31.] Plus, the MPC8xx bus is a
tiny twiddle bit faster than the ISA bus, both in
fewer clock cycles per bus cycle and in pure
clock frequency. Also, the MPC8xx bus prefers,
though does not have to, bust data in four times
32 bit blocks. Plus, the MPC8xx does not support
IO space directly, only memory space.

An ATA66 interface OTOH can be more challenging.
Mostly because it is hacked together on top of a
shaky foundation. But not undoeable. But then we
face the IDMA problems. But these can be overcome
by performance scaling and FIFO buffering.

But if harddrive performance actually matters,
then place a SCSI bridge on PCI. I am only in
favor of Keep It Simple Stupid to the point
where make-do solutions start compromise
the stability and architecture of the
larger system at hand.

But I probabely have to do this interface myself.
You may mail me privately and we can come to some
arrangement.


--
  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.and.so.forth
  ******************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
