Return-Path: <martyn.welch@ge.com>
Received: from exprod5og109.obsmtp.com (exprod5og109.obsmtp.com [64.18.0.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 69CC4B6EFF
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 18:50:26 +1000 (EST)
From: Martyn Welch <martyn.welch@ge.com>
Subject: [PATCH v2] Correct PowerPC Parport interrupt parsing.
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Date: Tue, 27 Apr 2010 09:50:21 +0100
Message-ID: <20100427084708.11358.87171.stgit@ES-J7S4D2J.amer.consind.ge.com>
In-Reply-To: <1272317225.29889.1.camel@pasglop>
References: <1272317225.29889.1.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: sfr@canb.auug.org.au, mikey@neuling.org
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

v2: Corrected irq_of_parse_and_map() index.

 arch/powerpc/include/asm/parport.h |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/parport.h b/arch/powerpc/include/asm/parport.h
index 94942d6..1ca1102 100644
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
+		virq = irq_of_parse_and_map(np, 0);
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
