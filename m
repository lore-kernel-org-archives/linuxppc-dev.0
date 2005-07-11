Return-Path: <markc@mail.com>
Received: from relay03.roc.ny.frontiernet.net (relay03.roc.ny.frontiernet.net
	[66.133.182.166]) by ozlabs.org (Postfix) with ESMTP id DDA1D67C0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jul 2005 00:02:27 +1000 (EST)
Message-ID: <007d01c58621$55b8e2f0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Absolut Hunter" <absoluthunter@comcast.net>,
	<linuxppc-embedded@ozlabs.org>
References: <20050711134713.D767067C13@ozlabs.org>
Date: Mon, 11 Jul 2005 10:03:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Linux 2.4.25 / MPC8280 / ram config vs Linux instability?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I am using U-boot to configure up the SDRAM and SRAM in our system before
we
> launch Linux. We have 32 Mb of SDRAM and 2 MB of SRAM in the system.
>
> If I leave the SRAM mapped at higher addresses 0x10000000 and SDRAM at
> 0x00000000, like U-boot defaults to Linux works great. However, my goal is
> to map SRAM <8ns speeds> down to the address 0x00000000, to map the vector
> table, so I can achieve a very fast interrupt response time.
>

Your core is probably running at about 400MHz, so 66MHz SRAM is still slow.
This is what cache is for.  Maybe you should look into locking interrupt
code in
cache.  Probably, however, you will find that messing with the overall
optimizations
of the kernel will be a net slowdown.

Mark Chambers
