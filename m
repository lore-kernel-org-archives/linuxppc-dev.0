Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (mail.tranzeo.com [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id 45543DDF1C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Apr 2008 08:32:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Ethernet Jumbo Frames
Date: Wed, 2 Apr 2008 14:32:21 -0700
Message-ID: <D61182AC8012EA4EBC531B3AF23BE109582F86@tranzeo-mail2.12stewart.tranzeo.com>
In-Reply-To: <20080402211552.729E82B007F@mail93-dub.bigfish.com>
References: <D61182AC8012EA4EBC531B3AF23BE109582F00@tranzeo-mail2.12stewart.tranzeo.com>
	<20080402211552.729E82B007F@mail93-dub.bigfish.com>
From: "Darcy Watkins" <DWatkins@tranzeo.com>
To: "LinuxPPC-Embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the comments...

I have hacked the IBM EMAC driver (Xenomai-2.3.0 Real Time Linux
2.6.19.2) and got jumbo frames to pass back and forth between two such
embedded boards.  Checked it using ping, iperf and httpd / wget file
transfer with md5sum check.

Still have to clean things up a bit and do some more tests before I can
share it as a patch.

Regards,

Darcy



-----Original Message-----
Sure, it can be done.  The Xilinx 10/100 Ethernet drivers have jumbo
frame support in MontaVista/WindRiver Linux.  As long as both ends are
talking jumbo frames, works just fine.

-Rick

-----Original Message-----
We've done it for our 2.4 based kernel that runs on a Freescale MPC8270.
10/100/1000 doesn't really make any difference. For us the trick was to
support receving jumbo frames in multiple RX BufDescriptors (because our
MPC8270 FCC eth driver pre-allocates 2k buffers per RX BD).
For transmitting hardly any changes were necessary.

 From linux (driver) standpoint there should be no problems,
the question is whether your ethernet MAC (IBM EMAC) properly supports
it.

hth,
N. van Bolhuis.
