Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E1C31007D4
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 00:58:55 +1100 (EST)
Subject: Re: [PATCH 5/7] powerpc/85xx: Add power management support for
	MPC85xxMDS boards
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20090915214359.GE24821@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 07:58:49 -0600
Message-Id: <197B3989-3373-4172-B5FA-727CA1EEE2AA@kernel.crashing.org>
References: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
	<20090915214359.GE24821@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 15, 2009, at 4:43 PM, Anton Vorontsov wrote:

> - Add power management controller nodes;
> - Add interrupts for RTC nodes, the RTC interrupt may be used as a
>  wakeup source;
> - Add sleep properties and sleep-nexus nodes.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8568mds.dts      |  119 ++++++++++++++++++ 
> +----------
> arch/powerpc/boot/dts/mpc8569mds.dts      |  111 +++++++++++++++++ 
> +---------
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
> 3 files changed, 153 insertions(+), 78 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/ 
dts/mpc8568mds.dts
index 00c2bbd..6d892ba 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -40,6 +40,8 @@
			i-cache-line-size = <32>;	// 32 bytes
			d-cache-size = <0x8000>;		// L1, 32K
			i-cache-size = <0x8000>;		// L1, 32K
+			sleep = <&pmc 0x00008000	// core
+				 &pmc 0x00004000>;	// timebase

Just so I'm clear this is the devdisr bit position?

- k
