Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2EC4B7BFF
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Dec 2009 22:58:12 +1100 (EST)
Date: Sun, 6 Dec 2009 12:32:47 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Scott Wood <scottwood@freescale.com>
Subject: [RFC] doc/powerpc: try to explain why the interrupt numbers are
	off by 16
Message-ID: <20091206113247.GB9937@Chamillionaire.breakpoint.cc>
References: <d970ff420909040604h1bb3874eg5c79f79f85e713a3@mail.gmail.com>
	<d970ff420909041228h3638e840r34c0c0e79f178e55@mail.gmail.com>
	<d970ff420909041229hb3aa96dya329e06ea56dd1ac@mail.gmail.com>
	<20090906110641.GA11350@Chamillionaire.breakpoint.cc>
	<20090909182857.GB8215@b07421-ec1.am.freescale.net>
	<20090910131544.GB23433@Chamillionaire.breakpoint.cc>
	<20090910222400.GB26587@Chamillionaire.breakpoint.cc>
	<4AA97D50.40209@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <4AA97D50.40209@freescale.com>
Cc: linuxppc-dev@ozlabs.org,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	Alemao <xcarandiru@gmail.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 Documentation/powerpc/dts-bindings/fsl/mpic.txt |   42 +++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/mpic.txt

diff --git a/Documentation/powerpc/dts-bindings/fsl/mpic.txt b/Documentation/powerpc/dts-bindings/fsl/mpic.txt
new file mode 100644
index 0000000..71e39cf
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/mpic.txt
@@ -0,0 +1,42 @@
+* OpenPIC and its interrupt numbers on Freescale's e500/e600 cores
+
+The OpenPIC specification does not specify which interrupt source has to
+become which interrupt number. This is up to the software implementation
+of the interrupt controller. The only requirement is that every
+interrupt source has to have an unique interrupt number / vector number.
+To accomplish this the current implementation assigns the number zero to
+the first source, the number one to the second source and so on until
+all interrupt sources have their unique number.
+Usually the assigned vector number equals the interrupt number mentioned
+in the documentation for a given core / CPU. This is however not true
+for the e500 cores (MPC85XX CPUs) where the documentation distinguishes
+between internal and external interrupt sources and starts counting at
+zero for both of them.
+
+So what to write for external interrupt source X or internal interrupt
+source Y into the device tree? Here is an example:
+
+The memory map for the interrupt controller in the MPC8544[0] shows,
+that the first interrupt source starts at 0x5_0000 (PIC Register Address
+Map-Interrupt Source Configuration Registers). This source becomes the
+number zero therefore:
+ External interrupt 0 = interrupt number 0
+ External interrupt 1 = interrupt number 1
+ External interrupt 2 = interrupt number 2
+ ...
+Every interrupt number allocates 0x20 bytes register space. So to get
+its number it is sufficient to shift the lower 16bits to right by five.
+So for the external interrupt 10 we have:
+  0x0140 >> 5 = 10
+
+After the external sources, the internal sources follow. The in core I2C
+controller on the MPC8544 for instance has the internal source number
+27. Oo obtain its interrupt number we take the lower 16bits of its memory
+address (0x5_0560) and shift it right:
+ 0x0560 >> 5 = 43
+
+Therefore the I2C device node for the MPC8544 CPU has to have the
+interrupt number 43 specified in the device tree.
+
+[0] MPC8544E PowerQUICCTM III, Integrated Host Processor Family Reference Manual
+    MPC8544ERM Rev. 1 10/2007
-- 
1.6.5.3
