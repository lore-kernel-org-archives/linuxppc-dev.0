Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 26/63] powerpc: Little endian fixes for legacy_serial.c
Date: Wed,  7 Aug 2013 02:01:43 +1000
Message-Id: <1375804940-22050-27-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alistair Popple <alistair@popple.id.au>

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/kernel/legacy_serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index af1c63f..179beea 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -152,7 +152,7 @@ static int __init add_legacy_soc_port(struct device_node *np,
 				      struct device_node *soc_dev)
 {
 	u64 addr;
-	const u32 *addrp;
+	const __be32 *addrp;
 	upf_t flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ
 		| UPF_FIXED_PORT;
 	struct device_node *tsi = of_get_parent(np);
@@ -237,7 +237,7 @@ static int __init add_legacy_pci_port(struct device_node *np,
 				      struct device_node *pci_dev)
 {
 	u64 addr, base;
-	const u32 *addrp;
+	const __be32 *addrp;
 	unsigned int flags;
 	int iotype, index = -1, lindex = 0;
 
@@ -270,7 +270,7 @@ static int __init add_legacy_pci_port(struct device_node *np,
 	if (iotype == UPIO_MEM)
 		base = addr;
 	else
-		base = addrp[2];
+		base = of_read_number(&addrp[2], 1);
 
 	/* Try to guess an index... If we have subdevices of the pci dev,
 	 * we get to their "reg" property
-- 
1.8.1.2
