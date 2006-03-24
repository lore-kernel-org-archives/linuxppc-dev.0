Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix spider-pic affinity setting
Date: Fri, 24 Mar 2006 19:46:29 +0100
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<32140afe2349e8f1726d188eb85c780c@bga.com>
	<200603241905.04356.arnd.bergmann@de.ibm.com>
In-Reply-To: <200603241905.04356.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603241946.30419.arnd.bergmann@de.ibm.com>
Cc: Arnd Bergmann <abergman@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As noticed by Milton Miller, setting the initial affinity in
spider-pic can go wrong if the target node field was not orinally
empty.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

--- linus-2.6.orig/arch/powerpc/platforms/cell/spider-pic.c
+++ linus-2.6/arch/powerpc/platforms/cell/spider-pic.c
@@ -88,7 +88,7 @@ static void spider_enable_irq(unsigned i
 	void __iomem *cfg = spider_get_irq_config(irq);
 	irq = spider_get_nr(irq);
 
-	out_be32(cfg, in_be32(cfg) | 0x3107000eu | nodeid);
+	out_be32(cfg, (in_be32(cfg) & ~0xf0)| 0x3107000eu | nodeid);
 	out_be32(cfg + 4, in_be32(cfg + 4) | 0x00020000u | irq);
 }
 
