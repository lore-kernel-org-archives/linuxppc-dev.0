From: okorpil@fh-landshut.de
Date: Wed, 7 Apr 2004 16:51:19 +0200 (CEST)
Reply-To: okorpil@fh-landshut.de
To: linuxppc-embedded@lists.linuxppc.org
Subject: MVME2100 patch
Message-ID: <Pine.LNX.4.58.0404071641050.16422@ppcproject1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.

Before I'm going into a prolonged Easter weekend, I've updated my patch
for the MVME2100.

Straightened out the interrupt configuration of the EPIC according to tips
from Tom Rini, commented a bit of stuff, cleaned up the patch itself, and
tested it. Boots up, works fine.

Tests for sanity of PCI/PMC cards and the VME-Bus stuff are planned for
the next weeks.

Get the patches at:
http://www.fh-landshut.de/~okorpil/mvme2100-linux-2.4.25.patch.bz2
http://www.fh-landshut.de/~okorpil/mvme2100-linux-2.4.25.patch.gz


My interrupt config without addon cards looks like this:

# cat /proc/interrupts
           CPU0
  2:          0   i8259     Edge      82c59 secondary cascade
  8:          0   i8259     Edge      rtc
 16:       1828   OpenPIC   Level     eth0
 25:        311   OpenPIC   Level     serial
BAD:          1

I still wonder why it maps RTC to IRQ8, because it should be at 27 in my
current config - 2nd line after serial.

Was wrong about IRQ stuff last time - I'm off course operation in serial
IRQ mode here, because there is a serial IRQ source (8259(attached to the
IRQO of the OpenPIC, giving me the 12 (16 in total, 4 unused) IRQs I care
about. But no cascade within that 16 lines, so no cascade hook.

I hope I got it right now.

Have a happy Easter, y'all.
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
