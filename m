Return-Path: <absoluthunter@comcast.net>
Received: from rwcrmhc12.comcast.net (rwcrmhc13.comcast.net [204.127.198.39])
	by ozlabs.org (Postfix) with ESMTP id D767067C13
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Jul 2005 23:47:13 +1000 (EST)
From: "Absolut Hunter" <absoluthunter@comcast.net>
To: <linuxppc-embedded@ozlabs.org>
Date: Mon, 11 Jul 2005 06:38:11 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-Id: <20050711134713.D767067C13@ozlabs.org>
Subject: Linux 2.4.25 / MPC8280 / ram config vs Linux instability?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Anybody,

I ran into a peculiar issue, though it could be user error. 

I am using U-boot to configure up the SDRAM and SRAM in our system before we
launch Linux. We have 32 Mb of SDRAM and 2 MB of SRAM in the system. 

If I leave the SRAM mapped at higher addresses 0x10000000 and SDRAM at
0x00000000, like U-boot defaults to Linux works great. However, my goal is
to map SRAM <8ns speeds> down to the address 0x00000000, to map the vector
table, so I can achieve a very fast interrupt response time.

I hacked U-boot a little bit to remap these addresses, after all the init
code was finished. U-boot relocates itself to higher memory, i.e. the last
2MB's of SDRAM and all is well within U-boot. I ran a 14 hour test on the
memory area to proof it. Now we have 0x02200000 <34M> memory size being
reported to Linux, in the bd->memsize. However, now Linux crashes randomly
all over the place, mostly sig11's task: swapper. I know this is not an
issue with SDRAM stability, and I can't imagine SRAM having problems seeing
as its 8ns capable and we're running at 15ns at the moment (66mhz).

Linux reports BAT mappings as BAT2=32Mb, BAT3=2MB when all 34 Megs are
presented via U-boot. 

Does anyone have any idea what would cause this instability? Physically all
memory seems to be great if used by itself. I know very little about how
Linux manages its pages, BATS, TBLs, etc... Are the limits on odd memory
sizes? Or certain configurations that it expects to see?

Thanks in advance.

-Russell McGuire
