Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <a586cd660c12ce1ec05fc9e8f83b765a75aaf96d.1302593231.git.michael@ellerman.id.au>
In-Reply-To: <a19ba86ac6fd999e3482e2c04b6fb10af04bb4a4.1302593231.git.michael@ellerman.id.au>
References: <a19ba86ac6fd999e3482e2c04b6fb10af04bb4a4.1302593231.git.michael@ellerman.id.au>
Subject: [PATCH 4/4] powerpc/pci: Properly initialize IO workaround "private"
Date: Tue, 12 Apr 2011 17:25:02 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Even when no initfunc is provided.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/io-workarounds.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
index d36515e..ffafaea 100644
--- a/arch/powerpc/kernel/io-workarounds.c
+++ b/arch/powerpc/kernel/io-workarounds.c
@@ -175,6 +175,7 @@ void __devinit iowa_register_bus(struct pci_controller *phb,
 	bus = &iowa_busses[iowa_bus_count];
 	bus->phb = phb;
 	bus->ops = ops;
+	bus->private = data;
 
 	if (initfunc)
 		if ((*initfunc)(bus, data))
-- 
1.7.1
