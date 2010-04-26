Return-Path: <martyn.welch@ge.com>
Received: from exprod5og107.obsmtp.com (exprod5og107.obsmtp.com [64.18.0.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 841E3B7D2E
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Apr 2010 21:20:41 +1000 (EST)
From: Martyn Welch <martyn.welch@ge.com>
Subject: [PATCH] Correct PowerPC Parport interrupt parsing.
To: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 26 Apr 2010 12:15:29 +0100
Message-ID: <20100426110810.22131.46466.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: tim@cyberelk.demon.co.uk, Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the parsing of the device tree in
arch/powerpc/include/asm/parport.h assumes that the interrupt provided in
the parallel port node is a valid virtual irq. The values for the
interrupts provided in the device tree should have meaning in the context
of the driver for the specific interrupt controller to which the interrupt
is connected and irq_of_parse_and_map() should be used to determine the
correct virtual irq.

Signed-off-by: Martyn Welch <martyn.welch@ge.com>
---

I believe this is the correct way to discover interrupt numbering. I assume
this has worked in the past as the interrupt routing hasn't been as
"interesting" as the board I'm currently working on.

I also don't have any other targets I could test this on, can anyone tell
me if this will break support on existing devices?

 arch/powerpc/include/asm/parport.h |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/parport.h b/arch/powerpc/include/asm/parport.h
index 94942d6..aa3f7bc 100644
--- a/arch/powerpc/include/asm/parport.h
+++ b/arch/powerpc/include/asm/parport.h
@@ -19,6 +19,8 @@ static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)
 	u32 io1, io2;
 	int propsize;
 	int count = 0;
+	int virq;
+
 	for (np = NULL; (np = of_find_compatible_node(np,
 						      "parallel",
 						      "pnpPNP,400")) != NULL;) {
@@ -26,10 +28,13 @@ static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)
 		if (!prop || propsize > 6*sizeof(u32))
 			continue;
 		io1 = prop[1]; io2 = prop[2];
-		prop = of_get_property(np, "interrupts", NULL);
-		if (!prop)
+
+		virq = irq_of_parse_and_map(np, 1);
+		if (virq == NO_IRQ)
 			continue;
-		if (parport_pc_probe_port(io1, io2, prop[0], autodma, NULL, 0) != NULL)
+
+		if (parport_pc_probe_port(io1, io2, virq, autodma, NULL, 0)
+				!= NULL)
 			count++;
 	}
 	return count;


--
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
