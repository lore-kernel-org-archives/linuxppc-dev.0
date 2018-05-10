Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hnFx5TMRzF2B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 08:00:05 +1000 (AEST)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mathieu Malaterre <malat@debian.org>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/2] powerpc: hlwd-pic: Prevent interrupts from being handled
 by Starlet
Date: Thu, 10 May 2018 23:59:19 +0200
Message-Id: <20180510215919.27808-3-j.neuschaefer@gmx.net>
In-Reply-To: <20180510215919.27808-1-j.neuschaefer@gmx.net>
References: <20180510215919.27808-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The interrupt controller inside the Wii's Hollywood chip is connected to
two masters, the "Broadway" PowerPC and the "Starlet" ARM926, each with
their own interrupt status and mask registers.

When booting the Wii with mini[1], interrupts from the SD card
controller (IRQ 7) are handled by the ARM, because mini provides SD
access over IPC. Linux however can't currently use or disable this IPC
service, so both sides try to handle IRQ 7 without coordination.

Let's instead make sure that all interrupts that are unmasked on the PPC
side are masked on the ARM side; this will also make sure that Linux can
properly talk to the SD card controller (and potentially other devices).

If access to a device through IPC is desired in the future, interrupts
from that device should not be handled by Linux directly.

[1]: https://github.com/lewurm/mini

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index e3e3af73e9d8..8112b39879d6 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -35,6 +35,8 @@
  */
 #define HW_BROADWAY_ICR		0x00
 #define HW_BROADWAY_IMR		0x04
+#define HW_STARLET_ICR		0x08
+#define HW_STARLET_IMR		0x0c
 
 
 /*
@@ -74,6 +76,9 @@ static void hlwd_pic_unmask(struct irq_data *d)
 	void __iomem *io_base = irq_data_get_irq_chip_data(d);
 
 	setbits32(io_base + HW_BROADWAY_IMR, 1 << irq);
+
+	/* Make sure the ARM (aka. Starlet) doesn't handle this interrupt. */
+	clrbits32(io_base + HW_STARLET_IMR, 1 << irq);
 }
 
 
-- 
2.17.0
