Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 6296B2BF06
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Nov 2004 02:07:53 +1100 (EST)
Message-ID: <1100704405.419b6a95986a7@webmail.televes.com:443>
Date: Wed, 17 Nov 2004 16:13:25 +0100
From: alebas@televes.com
To: linuxppc-embedded@ozlabs.org, Ge@televes.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gerald.VanBaren@smiths-aerospace.com
Subject: low-boot configuration to MPC8260ADS family boards (Again)
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

My board is back, at last. Indeed, a new one has arrived. :-)
OK, finally I think HRCW for MPC8272ADS board for flash lowboot should
be 0x0E_74_B2_4A. But this is still not working. The board keeps reseting
all the time.

With the jumper JP9 set to config from flash, i have checked the contents of
flash when halted ...


8272>md 0
00000000 : 00000e0e 00000e0e 00007474 00007474  ..........tt..tt
00000010 : 0000b2b2 0000b2b2 00004a4a 00004a4a  ..........JJ..JJ
00000020 : 00000000 00000000 00000000 00000000  ................
00000030 : 00000000 00000000 00000000 00000000  ................
00000040 : 00000000 00000000 00000000 00000000  ................
00000050 : 00000000 00000000 00000000 00000000  ................
00000060 : 00000000 00000000 00000000 00000000  ................

So, this isn't what is supposed to be. Here HRCW will be load as 0x00000000
and the uboot code will also be corrupted with the same problem.

However, when I check flash contents with the jumper JP9 pointing to the
BCSR, flash begining is...

8272>md 0xff800000
ff800000 : 0e0e0e0e 0e0e0e0e 74747474 74747474  ........tttttttt
ff800010 : b2b2b2b2 b2b2b2b2 4a4a4a4a 4a4a4a4a  ........JJJJJJJJ
ff800020 : 00000000 00000000 00000000 00000000  ................
ff800030 : 00000000 00000000 00000000 00000000  ................
ff800040 : 00000000 00000000 00000000 00000000  ................
ff800050 : 00000000 00000000 00000000 00000000  ................


which is OK (and the same flash area than before).

So, why can I view only 16 bits from each 32 bits in flash? Any idea?
Must I change any other jumper?

Thanks,

Alex
