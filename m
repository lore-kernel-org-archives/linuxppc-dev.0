Return-Path: <leigh@solinno.co.uk>
Received: from george.solinno.co.uk (george.solinno.co.uk [193.110.88.138])
	by ozlabs.org (Postfix) with ESMTP id 9F8E62BD3C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2004 05:35:14 +1000 (EST)
Date: Thu, 16 Sep 2004 19:25:31 +0100
To: trini@kernel.crashing.org
Message-ID: <20040916182531.GA20649@george.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: leigh@solinno.co.uk (Leigh Brown)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PReP][PATCH] Fix ISA PIC interrupt acknowledge address detection
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ISA PIC address for acknowledging interrupts is actually defined
in residual data as a 32-bit system address, rather than a 32-bit 
memory address.  This is rather embarrasing, as I don't think this
function has done the right thing, ever.

Tested and working fine on my Carolina and 140.

Thanks,

Leigh.

Signed-off-by: Leigh Brown <leigh@solinno.co.uk>

--- arch/ppc/platforms/residual.c.orig	2004-09-14 20:50:16.000000000 +0100
+++ arch/ppc/platforms/residual.c	2004-09-14 20:50:29.000000000 +0100
@@ -935,8 +935,8 @@
 		goto unknown;
 
 #define p pkt->L4_Pack.L4_Data.L4_PPCPack
-	/* Must be 32-bit memory address */
-	if (!((p.PPCData[0] == 2) && (p.PPCData[1] == 32)))
+	/* Must be 32-bit system address */
+	if (!((p.PPCData[0] == 3) && (p.PPCData[1] == 32)))
 		goto unknown;
 
 	/* It doesn't seem to work where length != 1 (what can I say? :-/ ) */
