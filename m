Return-Path: <daveg@sonartech.com.au>
Received: from sonartech.com.au (newgate.sonartech.com.au [203.28.130.2])
	by ozlabs.org (Postfix) with ESMTP id 306012BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Sep 2004 08:43:54 +1000 (EST)
Message-ID: <4159E96D.5040207@sonartech.com.au>
Date: Wed, 29 Sep 2004 08:45:01 +1000
From: David Gardiner <daveg@sonartech.com.au>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <4153A362.8010604@sonartech.com.au>
	<AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
	<4158DD68.2060707@sonartech.com.au>
	<20040927221323.A30581@home.com>
	<C617C694-1110-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927224825.B30772@home.com>
	<7C908338-1113-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927231438.D30772@home.com>
	<415908DC.3090409@sonartech.com.au>
	<20040927235948.G30772@home.com>
In-Reply-To: <20040927235948.G30772@home.com>
Content-Type: multipart/mixed; boundary="------------020408030705030802050304"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: powerpc with gigabit card hanging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020408030705030802050304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>only the PMCSPAN IDSEL routing is missing. Don't know what your 2.4
>  
>
linuxppc_2_4_devel

>kernel looks like or your current map in your 2.6 port.
>  
>
Thanks Matt, that was pretty easy once I knew where to look, being that 
the gigabit was on the span card and they were all set to zero and in 
the linuxppc_2_4_devel tree they weren't, anyway the patch is attatched. 
I don't want anything to be done with this patch as I still would like 
to "try" and fold the mvme5100 into pplus and I'm only attatching it in 
case I get hit by a bus.

dodah,
dlg
 

--------------020408030705030802050304
Content-Type: text/plain;
 name="irq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq.patch"

--- play-2.6.9.patched.changed.compile/arch/ppc/platforms/mvme5100.c.orig	2004-09-29 08:25:47.549383101 +1000
+++ play-2.6.9.patched.changed.compile/arch/ppc/platforms/mvme5100.c	2004-09-29 08:25:54.199430187 +1000
@@ -81,7 +81,7 @@ mvme5100_map_irq(struct pci_dev *dev, un
 		{ 28, 25, 26, 27 },	/* IDSEL 17 - PMC Slot 2 */
 		{  0,  0,  0,  0 },	/* IDSEL 18 - unused */
 		{ 29,  0,  0,  0 },	/* IDSEL 19 - Enet 2 */
-		{  0,  0,  0,  0 },	/* IDSEL 20 - PMCSPAN */
+		{ 25, 26, 27, 28 }, /* IDSEL 20 - PMCSPAN */
 	};
 
 	const long min_idsel = 11, max_idsel = 20, irqs_per_slot = 4;

--------------020408030705030802050304--
