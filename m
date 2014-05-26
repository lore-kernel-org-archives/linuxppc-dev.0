Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 716F41A0590
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 May 2014 21:44:35 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v3] powerpc: Add cpu family documentation
Date: Mon, 26 May 2014 21:44:25 +1000
Message-Id: <1401104665-7819-1-git-send-email-mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 tommusta@gmail.com, James.Yang@freescale.com, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds some documentation on the different cpu families
supported by arch/powerpc.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
Please send any further corrections as patches :)

v3: Dropped 740, don't need that level of detail.
    Don't list 850 separately from 8xx.
    Rename 8xx to MPC8xx Core as per James.
    Moved Book3e to e500mc.
    Add e300 and e600.
    Show ambiguous Cell/Power6 relationship.

v2: Reworked formatting to avoid wrapping.
    Fixed up Freescale details.
---
 Documentation/powerpc/cpu_families.txt | 221 +++++++++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)
 create mode 100644 Documentation/powerpc/cpu_families.txt

diff --git a/Documentation/powerpc/cpu_families.txt b/Documentation/powerpc/cpu_families.txt
new file mode 100644
index 0000000..fc08e22
--- /dev/null
+++ b/Documentation/powerpc/cpu_families.txt
@@ -0,0 +1,221 @@
+CPU Families
+============
+
+This document tries to summarise some of the different cpu families that exist
+and are supported by arch/powerpc.
+
+
+Book3S (aka sPAPR)
+------------------
+
+ - Hash MMU
+ - Mix of 32 & 64 bit
+
+   +--------------+                 +----------------+
+   |  Old POWER   | --------------> | RS64 (threads) |
+   +--------------+                 +----------------+
+          |
+          |
+          v
+   +--------------+                 +----------------+      +------+
+   |     601      | --------------> |      603       | ---> | e300 |
+   +--------------+                 +----------------+      +------+
+          |                                 |
+          |                                 |
+          v                                 v
+   +--------------+                 +----------------+      +-------+
+   |     604      |                 |    750 (G3)    | ---> | 750CX |
+   +--------------+                 +----------------+      +-------+
+          |                                 |                   |
+          |                                 |                   |
+          v                                 v                   v
+   +--------------+                 +----------------+      +-------+
+   | 620 (64 bit) |                 |      7400      |      | 750CL |
+   +--------------+                 +----------------+      +-------+
+          |                                 |                   |
+          |                                 |                   |
+          v                                 v                   v
+   +--------------+                 +----------------+      +-------+
+   |  POWER3/630  |                 |      7410      |      | 750FX |
+   +--------------+                 +----------------+      +-------+
+          |                                 |
+          |                                 |
+          v                                 v
+   +--------------+                 +----------------+
+   |   POWER3+    |                 |      7450      |
+   +--------------+                 +----------------+
+          |                                 |
+          |                                 |
+          v                                 v
+   +--------------+                 +----------------+
+   |    POWER4    |                 |      7455      |
+   +--------------+                 +----------------+
+          |                                 |
+          |                                 |
+          v                                 v
+   +--------------+     +-------+   +----------------+
+   |   POWER4+    | --> |  970  |   |      7447      |
+   +--------------+     +-------+   +----------------+
+          |                 |               |
+          |                 |               |
+          v                 v               v
+   +--------------+     +-------+   +----------------+
+   |    POWER5    |     | 970FX |   |      7448      |
+   +--------------+     +-------+   +----------------+
+          |                 |               |
+          |                 |               |
+          v                 v               v
+   +--------------+     +-------+   +----------------+
+   |   POWER5+    |     | 970MP |   |      e600      |
+   +--------------+     +-------+   +----------------+
+          |
+          |
+          v
+   +--------------+
+   |   POWER5++   |
+   +--------------+
+          |
+          |
+          v
+   +--------------+       +-------+
+   |    POWER6    | <-?-> | Cell  |
+   +--------------+       +-------+
+          |
+          |
+          v
+   +--------------+
+   |    POWER7    |
+   +--------------+
+          |
+          |
+          v
+   +--------------+
+   |   POWER7+    |
+   +--------------+
+          |
+          |
+          v
+   +--------------+
+   |    POWER8    |
+   +--------------+
+
+
+   +---------------+
+   | PA6T (64 bit) |
+   +---------------+
+
+
+IBM BookE
+---------
+
+ - Software loaded TLB.
+ - All 32 bit
+
+   +--------------+
+   |     401      |
+   +--------------+
+          |
+          |
+          v
+   +--------------+
+   |     403      |
+   +--------------+
+          |
+          |
+          v
+   +--------------+
+   |     405      |
+   +--------------+
+          |
+          |
+          v
+   +--------------+
+   |     440      |
+   +--------------+
+          |
+          |
+          v
+   +--------------+     +----------------+
+   |     450      | --> |      BG/P      |
+   +--------------+     +----------------+
+          |
+          |
+          v
+   +--------------+
+   |     460      |
+   +--------------+
+          |
+          |
+          v
+   +--------------+
+   |     476      |
+   +--------------+
+
+
+Motorola/Freescale 8xx
+----------------------
+
+ - Software loaded with hardware assist.
+ - All 32 bit
+
+   +-------------+
+   | MPC8xx Core |
+   +-------------+
+
+
+Freescale BookE
+---------------
+
+ - Software loaded TLB.
+ - e6500 adds HW loaded indirect TLB entries.
+ - Mix of 32 & 64 bit
+
+   +--------------+
+   |     e200     |
+   +--------------+
+
+
+   +--------------------------------+
+   |              e500              |
+   +--------------------------------+
+                   |
+                   |
+                   v
+   +--------------------------------+
+   |             e500v2             |
+   +--------------------------------+
+                   |
+                   |
+                   v
+   +--------------------------------+
+   |        e500mc (Book3e)         |
+   +--------------------------------+
+                   |
+                   |
+                   v
+   +--------------------------------+
+   |          e5500 (64 bit)        |
+   +--------------------------------+
+                   |
+                   |
+                   v
+   +--------------------------------+
+   | e6500 (HW TLB) (Multithreaded) |
+   +--------------------------------+
+
+
+IBM A2 core
+-----------
+
+ - Book3E, software loaded TLB + HW loaded indirect TLB entries.
+ - 64 bit
+
+   +--------------+     +----------------+
+   |   A2 core    | --> |      WSP       |
+   +--------------+     +----------------+
+           |
+           |
+           v
+   +--------------+
+   |     BG/Q     |
+   +--------------+
-- 
1.9.1
