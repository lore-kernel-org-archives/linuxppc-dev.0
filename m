Return-Path: <absoluthunter@comcast.net>
Received: from rwcrmhc12.comcast.net (rwcrmhc14.comcast.net [216.148.227.89])
	by ozlabs.org (Postfix) with ESMTP id C743F67C23
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jul 2005 00:07:14 +1000 (EST)
From: "Absolut Hunter" <absoluthunter@comcast.net>
To: <linuxppc-embedded@ozlabs.org>
Date: Mon, 11 Jul 2005 07:02:14 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-Id: <20050711140714.C743F67C23@ozlabs.org>
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


A useful piece to this might be that I am attempting to map these two memory
regions contiguously, so that Linux doesn't see any memory holes.

0-2MB SRAM
2MB-34MB SDRAM

I would be open to any other ways that SRAM / SDRAM might be mapped to work,
and still provide a performance increase for the kernel.

-Russell

-----Original Message-----
From: Absolut Hunter [mailto:absoluthunter@comcast.net] 
Sent: Monday, July 11, 2005 6:38 AM
To: 'linuxppc-embedded@ozlabs.org'
Subject: Linux 2.4.25 / MPC8280 / ram config vs Linux instability?

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
