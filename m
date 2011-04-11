Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <59a54fd79356507b348f61cb5142e72710979518.1302501428.git.michael@ellerman.id.au>
In-Reply-To: <3ed7c174af4ccbab67467aa80fe84bd6c6e218ee.1302501428.git.michael@ellerman.id.au>
References: <3ed7c174af4ccbab67467aa80fe84bd6c6e218ee.1302501428.git.michael@ellerman.id.au>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc/pci: Properly initialize IO workaround "private"
Date: Mon, 11 Apr 2011 15:54:29 +1000 (EST)
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
