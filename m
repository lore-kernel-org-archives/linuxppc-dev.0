Message-ID: <3CC5477E.4955821A@imc-berlin.de>
Date: Tue, 23 Apr 2002 13:37:34 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Dan Malek <dan@embeddededge.com>
Subject: MPC8xx IDMA and console garbage
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I am trying to get DMA support for MPC8xx IDE. For now I use the IDMA
channel.
It is kind of working although it's not much more than a framework yet.

BUT:

My problem right now is this:

After activating the DMA (e.g. using hdparm -d1 /dev/hda) the output of
my serial console (connected to SMC1) gets garbaged when there is HDD
activity.

If I telnet into my machine and do e.g. a "fdisk -l /dev/hda" the output
of the serial console looks something like this

^PttyS: 80 input overrun(s)
 ^P^P^P^P^P^P^P^P^P^ ^PP ^ ^PP ^ ^PP ^P ^P^P^P^P^P^P ^P
^P^P^P^P^P^P^P^P^P^P^P^P^PttyS: 80 input overrun(s)

If I redirect console input into a file it contains 0x10 and 0x20 bytes.

So someone is flooding the serial port (SMC) with the two byte 0x10 and
0x20 !
(I might have seen 0x10 and 0xA0 as well.)

Any ideas?

Could there be a problem in using the internal ram area. Maybe my IDMA
is conflicting with anyother existing driver (SMC???) ?

Thanks,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
