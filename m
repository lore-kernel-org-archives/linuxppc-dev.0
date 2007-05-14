Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id A87ADDDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 May 2007 10:51:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Fwd: [alsa-devel] embedded sound architecture question]
Date: Sun, 13 May 2007 17:50:58 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3CB059C2@ehost011-3.exch011.intermedia.net>
In-Reply-To: <1179069310.15907.11.camel@localhost>
References: <1179069310.15907.11.camel@localhost>
From: "Leonid" <Leonid@a-k-a.net>
To: =?iso-8859-1?Q?Joachim_F=F6rster?= <mls.JOFT@gmx.de>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ALSA middle layer is VERY sensitive to timing and it's extremely =
important how HW device behaves (I mean PCM part of driver, MIDI is =
quite simple). Recording ("capturing") poses even more problems than =
replaying.=20

Last but not least, different applications tend to deal differently with =
ALSA and one should have really good understanding of what's going on to =
configure everything properly.

I must admit that I'm not ALSA expert myself, but I was involved in =
writing ALSA Linux driver for some chip which didn't have one. During =
this process I realized that this is not a miracle nobody before =
bothered to write driver for that chip since it was rather laborious =
task. =20

You are in better situation - you kind of can create your HW yourself. =
If I were you, I would chose one of sound cards which have ALSA drivers =
implemented (the list can be found on ALSA site) and mimicked their =
behavior in your VHDL.

Thanks,

Leonid.

-----Original Message-----
From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org =
[mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf Of Joachim F=F6rster
Sent: Sunday, May 13, 2007 8:15 AM
To: linuxppc-embedded@ozlabs.org
Subject: [Fwd: [alsa-devel] embedded sound architecture question]

Hi,

I posted the following question/mail to the ALSA development mailing
list and somebody suggested posting it to the LKML, but I thought,
perhaps it is better to ask you, the Linux PPC embedded experts first,
since it is right about that topic.

It would be nice if somebody can say, if the described architecture
makes sense and will work or if it is a complete no-go.

-------- Forwarded Message --------
From: Joachim F=F6rster <mls.JOFT@gmx.de>
To: alsa-devel@alsa-project.org
Subject: [alsa-devel] embedded sound architecture question
Date: Wed, 09 May 2007 22:47:34 +0200

Hi ALSA devs,

I'm going to write an ALSA driver for a not yet existing AC97
controller, which is going to be "written" (VHDL), too (at the same
time). Platform/Board is a Xilinx ML403 with Virtex-4 FPGA, PowerPC 405
architecture, OPB/OCP bus, AC97 Codec LM4550.

Before presenting my question, I have to say, that I'm a beginner with
ALSA/Linux driver development.

My question is: Does the architecture described below make sense/is
reasonable with ALSA and Linux?

The problem is, that there is no DMA controller and implementing an OPB
master device which would be able to do DMA itself is not an option at
this time.
So our thoughts were: Integrate the "DMA ring buffer" (which is usually
somewhere in main memory/RAM) into the AC97 controller. Make ALSA access
this HW buffer as if it was in main memory. This way, the device (AC97
controller) has "direct access" to its buffer "memory" - this could be
called "fake DMA".
The AC97 controller would have tell us where it is while playing and
firing interrupts after one period, so that we don't write to values
which are in the current period, instead update the area where of the
past played periods etc. ... The buffer should be a "ring buffer",
right?

Mapping this "IO memory" into kernel space should be possible with
io_remap_page_range(), right?
I would have to implement the mmap() callback in my driver, to setup the
given VMA (with the above function), right?
So, ALSA library/applications will be able to use MMAP mode, which is
what we want to achieve?
[We don't want copy()/silence(). An intermediate buffer with
ack()/tasklet/workqueue + FIFO in HW would be an alternative.]

[snip]

Thanks for reading & your time,
 Joachim


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
