Return-Path: <Jogi95@web.de>
Received: from fmmailgate05.web.de (fmmailgate05.web.de [217.72.192.243])
	by ozlabs.org (Postfix) with ESMTP id BB850DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jan 2008 00:25:56 +1100 (EST)
Received: from web.de
	by fmmailgate05.web.de (Postfix) with SMTP id 6855D3BE5BE0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 14:25:54 +0100 (CET)
Date: Wed, 16 Jan 2008 14:25:53 +0100
Message-Id: <537566320@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: linuxppc-embedded@ozlabs.org
Subject: ml310 kernel2.6 booting problems
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I made an Ace file with my Kernel and load it with the Flash Card.
I made the Initial release CF image on the card and copied my ace file in an folder, from which I boot with the DIP-Switch.
If I used 
"console=ttyUL0 ,9600 root=/dev/xsysace/disc0/part2 rw "
in the Kernel config booting aborts like this:
----------------------------------------------------------------------------------------------------------------
....
[    5.715168] 000001c0: 00000000 00000000 00000000 00000000 ................
[    5.797484] 000001d0: 00000000 00000000 00000000 00000000 ................
[    5.879741] 000001e0: 00000000 00000000 00000000 00000000 ................
[    5.962057] 000001f0: 00000000 00000000 00000000 00000000 ................
[    6.044365] xsysace xsysace.0: capacity: 1000944 sectors
[    6.109986]  xsa:<7>xsysace xsysace.0: fsm_state=0, id_req_count=0
[    6.207902]  xsa1 xsa2
[    6.226842] Xilinx SystemACE device driver, major=254
[    6.281419] tun: Universal TUN/TAP device driver, 1.6
[    6.341706] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    6.419485] mice: PS/2 mouse device common for all mice
[    6.478716] TCP cubic registered
[    6.516974] NET: Registered protocol family 1
[    6.568940] NET: Registered protocol family 17
[    6.627483] VFS: Cannot open root device "xsysace/disc0/part2" or unknown-block(0,0)
[    6.714743] Please append a correct "root=" boot option; here are the available partitions:
[    6.814732] fe00     500472 xsa (driver?)
[    6.862193]   fe01      98248 xsa1
[    6.902974]   fe02     402192 xsa2
[    6.943603] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[    7.042832] Rebooting in 180 seconds..
------------------------------------------------------------------------------------------------------------------------------------

I tried to use this:
"console=ttyUL0 ,9600 root=fe02 rw" 
and with this, after making ace-file etc. I get:
-------------------------------------------------------------------------------------------------------
...
[    5.447429] 00000190: 00000000 00000000 00000000 00000000 ................
[    5.529734] 000001a0: 00000000 00000000 00000000 00000000 ................
[    5.612002] 000001b0: 00000000 00000000 00000000 00000000 ................
[    5.694288] 000001c0: 00000000 00000000 00000000 00000000 ................
[    5.776594] 000001d0: 00000000 00000000 00000000 00000000 ................
[    5.858861] 000001e0: 00000000 00000000 00000000 00000000 ................
[    5.941167] 000001f0: 00000000 00000000 00000000 00000000 ................
[    6.023453] xsysace xsysace.0: capacity: 1000944 sectors
[    6.090042]  xsa:<7>xsysace xsysace.0: fsm_state=0, id_req_count=0
[    6.186832]  xsa1 xsa2
[    6.205880] Xilinx SystemACE device driver, major=254
[    6.260331] tun: Universal TUN/TAP device driver, 1.6
[    6.320626] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    6.398443] mice: PS/2 mouse device common for all mice
[    6.457695] TCP cubic registered
[    6.495755] NET: Registered protocol family 1
[    6.547840] NET: Registered protocol family 17
[   12.726608] kjournald starting.  Commit interval 5 seconds
[   12.862678] EXT3 FS on xsa2, internal journal
[   12.899229] EXT3-fs: recovery complete.
[   12.982635] EXT3-fs: mounted filesystem with ordered data mode.
[   13.038505] VFS: Mounted root (ext3 filesystem).
[   13.094113] Freeing unused kernel memory: 96k init
[   13.159079] Warning: unable to open an initial console.
-------------------------------------------------------------------------------------------------

what is the Problem here?
What should I consider when I configure the kernel, what when building an rootfs?

Greetings
Joachim
_________________________________________________________________________
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten! 
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=021114
