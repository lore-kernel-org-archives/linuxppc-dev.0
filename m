Date: Tue, 24 Jul 2001 10:51:14 +0200
From: Sven Dickert <Sven.Dickert@planb.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: sound runs double speed on rs6k
Message-ID: <20010724105114.A17706@remote.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

  I try to set up a working kernel on the following machine:
IBM RS/6000 7020-001 also named 40P, seems to be compatible to
IBM PowerSeries 6015 also named PPS400. The machine is one-on-one
completely PreP as mentioned in
ftp://ftp.austin.ibm.com/pub/technology/spec/srp1_10?.ps.Z
I think the 40P was some sort of reference implentation of the
PreP standard. The machine boots 2.4.6. with some modifications:
http://www.remote.org/sven/ppc/40p.patch

  At the moment I'm working on sound support. I changed
-#define CAROLINA_IRQ_EDGE_MASK_HI   0xA4  /* IRQ's 8-15 [10,13,15] */
+#define CAROLINA_IRQ_EDGE_MASK_HI   0xA0  /* IRQ's 8-15 [10,13,15] */
in arch/ppc/kernel/prep_pci.c
I found this 'patch' at http://penguinppc.org/dev/prep/tp850.diff

  Now the system is not longer 'hanging' in userspace when I cat a .au file
to /dev/audio, instead sound is played at external speakers. But it is
played at _double_ speed. I've never listened to U2 as fast as
Michael Schuhmacher drives cars :)

  I can patch ad1848_set_speed in drivers/sound/ad1848.c to set
22050 instead of 44100 when speed of audio-device is choosen, but this
seems to be a poor hack, not solving the real problem.

  There is strange thing, that cat /proc/pci shows me a second device
at irq 10, same irq cs4231 uses.

  Have you any idea, knowledge about timers, bus speed or something that
I can change to get a slower sound?

Thank you for your attention, Sven

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
