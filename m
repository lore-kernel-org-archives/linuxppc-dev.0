Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 75897DDEBF
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 May 2007 01:15:15 +1000 (EST)
Subject: [Fwd: [alsa-devel] embedded sound architecture question]
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 13 May 2007 17:15:10 +0200
Message-Id: <1179069310.15907.11.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I posted the following question/mail to the ALSA development mailing
list and somebody suggested posting it to the LKML, but I thought,
perhaps it is better to ask you, the Linux PPC embedded experts first,
since it is right about that topic.

It would be nice if somebody can say, if the described architecture
makes sense and will work or if it is a complete no-go.

-------- Forwarded Message --------
From: Joachim Förster <mls.JOFT@gmx.de>
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
