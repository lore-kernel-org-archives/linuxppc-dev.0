Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 134D0DE31A
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 06:28:01 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n05JRu2b000299
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 12:27:56 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n05JRtii014145
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 13:27:55 -0600 (CST)
Date: Mon, 5 Jan 2009 13:27:55 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/8313erdb: fix kernel crash
Message-ID: <20090105192755.GC23766@ld0162-tx32.am.freescale.net>
References: <1231152455-8296-1-git-send-email-leoli@freescale.com>
	<1C3FA775-7C2A-4218-BE14-95FF2DD9F6D2@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1C3FA775-7C2A-4218-BE14-95FF2DD9F6D2@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 05, 2009 at 10:25:08AM -0600, Kumar Gala wrote:
> 
> On Jan 5, 2009, at 4:47 AM, Li Yang wrote:
> 
> >Probe the new mdio node added by b31a1d8b.  Fix kernel panic problem  
> >when
> >gianfar driver wants to get the of_platform_device of that mdio.
> >
> >Signed-off-by: Li Yang <leoli@freescale.com>
> >---
> >arch/powerpc/boot/dts/mpc8313erdb.dts |    2 +-
> >1 files changed, 1 insertions(+), 1 deletions(-)
> >
> >diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/ 
> >boot/dts/mpc8313erdb.dts
> >index d4df8b6..917d466 100644
> >--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
> >+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> >@@ -222,7 +222,7 @@
> >			cell-index = <1>;
> >			device_type = "network";
> >			model = "eTSEC";
> >-			compatible = "gianfar";
> >+			compatible = "gianfar", "simple-bus";
> >			reg = <0x25000 0x1000>;
> >			local-mac-address = [ 00 00 00 00 00 00 ];
> >			interrupts = <34 0x8 33 0x8 32 0x8>;
> 
> This isn't correct at all.  Not sure what the panic is but adding  
> "simple-bus" isn't correct.

It looks like the mdio node got added in the wrong place on 8313erdb,
relative to where it went on all other boards -- though if we were to
ignore existing practice, it probably does belong under the gianfar node
(and not as a freestanding device).

-Scott
