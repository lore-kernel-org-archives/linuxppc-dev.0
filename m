Date: Fri, 8 Dec 2000 12:47:22 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 66 Mhz bus clock for EST8260?
Message-ID: <Pine.GSO.4.21.0012081225350.24199-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is there any magic in getting the EST8260 board to work with a 66 Mhz bus
clock?  I haven't had good luck with a Linux or vxWorks image.

My board has a 200/166/66 rev A.1 chip.

I boot using a vxWorks bootrom.  I have made a few corrections to the
bootrom so the decrementer frequency is set correctly from the user
dip switches in addition to setting the core, cpm, and bus speeds.

The scenerio is as follows:

1.) Burn configuration word to change MODCK_H from 0x0001 to 0x0101
2.) Swap oscillators 33.0 -> 66.0 Mhz
3.) Set MODCK[1-3] switches to 0x111 (200/133/66)
4.) Mirror 3.) on user switches for vxWorks bootrom to read
5.) Hack head_8260.S to put immr in place for Linux
6.) Set linux board info in embed_config.c to 200/133/66/66
(core,cpm,bus,brg) making sure there is real space allocated for it
instead or whatever was in r3 when vxWorks booted us.
6.) Reboot.

vxWorks bootrom runs fine and downloads Linux or vxWorks.

Linux pannics just before giving me a shell prompt somewhere in tty init.

vxWorks appears to come up fine, but the muxDevBind fails for the Fast
Ethernet and thus no network communications.  Even though the bootrom
just downloaded us successfully over the same interface.

Has anyone had any luck with the 66 Mhz bus clock?

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
