Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 21 Oct 2003 12:47:27 -0700
From: Ron Bianco <ronb@lcsaudio.com>
Subject: Kernel choices for 824x with ext3 FS
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Message-id: <000101c3980c$2811a3a0$4d00a8c0@warp-speed>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings,

I've been scouting out kernel alternatives for porting to our custom 8240 board.
We've been running a port of 2.3.16 for a few years now, but need to upgrade for
a couple of reasons.
I've been looking at Denx's 2.4.4 port, linuxppc 2.5, linux 2.4.22 and the
latest 2.6.0-test trees.

BTW, many thanks to Wolfgang Denk for making available the ELDK and his ( and
others ) embedded PPC specific work!

Unfortunately we can't use 2.4.4 as ext3 FS support is not present.
FYI, we may also have a need to use RTAI.

I am looking for some advice on which tree to use as a starting point for a new
embedded ppc port.
It is desirable to use the most up to date, yet robust for ppc, kernel possible
and this is somewhat awkward timing vis a vis the status of the 2.6.0 kernel.
But most pertinent ppc related patches seem to be included in 2.6.0 now along
with other enhancements, such as reduced latency, that are not present in
2.4.22.   So it is a bit of a quandary for me, and perhaps for others as well.

A short? hardware overview:
The board is a bare bones design used strictly for scsi ( symbios 53c895 ),
ethernet ( intel 82559 ), and interfaces to our custom backplane in a digital
audio matrix mixer.  The board's flash chip and boot sequence are controlled by
the system's main DSP board.
The backplane interface is via a 16k word dual port RAM and the firmware images
are transferred to SDRAM during startup thru it.
A rather unique situation and it is complicated by the fact that the board has
no UART.  In hindsight a very dumb omission, but this was worked around by
hacking a dummy serial port buffer scheme.
Anyway, it's been working well, and we've managed to cope with the rather large
linux 2.3.x interrupt latency variance in our custom device driver that handles
the backplane interface.   A driver improvement to use the 8240 DMA units helped
too, but there is still a 166 usec. interrupt and the driver can only cope with
getting behind up to 3 interrupts.
We used raw access to the scsi disks with a primitve 'FS' for audio storage and
had done some hacks to the driver set to enable auto switching quickly to a
backup drive if the active drive failed.  The system can be powered down at any
time, which precluded using a non-journalled FS.

But now we have new product specifications that requires the use of a journaling
FS and hardware RAID level 1, and I wish to take the opportunity to improve the
interrupt latency situation too.

Any comments appreciated.

regards, Ron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
