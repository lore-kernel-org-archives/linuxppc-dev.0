Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d6b34db0a2fc1979448c0408bafb9ed33688fc54.1232001859.git.michael@ellerman.id.au>
In-Reply-To: <aab322f087db2ecc390ea5e224db143cf77d3067.1232001859.git.michael@ellerman.id.au>
References: <aab322f087db2ecc390ea5e224db143cf77d3067.1232001859.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/2] lmb: Rework lmb_dump_all() output
Date: Thu, 15 Jan 2009 17:46:02 +1100 (EST)
Cc: "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The lmb_dump_all() output didn't include the RMO size, which is
interesting on powerpc. The output was also a bit spacey and not well
aligned, and didn't show you the end addresses.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 lib/lmb.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)


DaveM, if you like we could make the RMO display conditional on it being
non-zero, which would hide it on sparc presumably.

Old output:

lmb_dump_all:
    memory.cnt            = 0x1
    memory.size           = 0x80000000
    memory.region[0x0].base       = 0x0
                      .size     = 0x80000000
    reserved.cnt          = 0x3
    reserved.size         = 0x80000000
    reserved.region[0x0].base       = 0x0
                      .size     = 0xea2000
    reserved.region[0x1].base       = 0x2aa6000
                      .size     = 0xc000
    reserved.region[0x2].base       = 0x76a1000
                      .size     = 0x95f000

New output:

LMB configuration:
 rmo_size    = 0x8000000
 memory.size = 0x80000000
 memory.cnt  = 0x1
 memory[0x0]    0x0000000000000000 - 0x000000007fffffff, 0x80000000 bytes
 reserved.cnt  = 0x3
 reserved[0x0]  0x0000000000000000 - 0x0000000000ea1fff, 0xea2000 bytes
 reserved[0x1]  0x0000000002aa6000 - 0x0000000002ab1fff, 0xc000 bytes
 reserved[0x2]  0x00000000076a1000 - 0x0000000007ffffff, 0x95f000 bytes


diff --git a/lib/lmb.c b/lib/lmb.c
index 97e5470..e4a6482 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -29,33 +29,33 @@ static int __init early_lmb(char *p)
 }
 early_param("lmb", early_lmb);
 
-void lmb_dump_all(void)
+static void lmb_dump(struct lmb_region *region, char *name)
 {
-	unsigned long i;
+	unsigned long long base, size;
+	int i;
+
+	pr_info(" %s.cnt  = 0x%lx\n", name, region->cnt);
+
+	for (i = 0; i < region->cnt; i++) {
+		base = region->region[i].base;
+		size = region->region[i].size;
+
+		pr_info(" %s[0x%x]\t0x%016llx - 0x%016llx, 0x%llx bytes\n",
+		    name, i, base, base + size - 1, size);
+	}
+}
 
+void lmb_dump_all(void)
+{
 	if (!lmb_debug)
 		return;
 
-	pr_info("lmb_dump_all:\n");
-	pr_info("    memory.cnt		  = 0x%lx\n", lmb.memory.cnt);
-	pr_info("    memory.size		  = 0x%llx\n",
-	    (unsigned long long)lmb.memory.size);
-	for (i=0; i < lmb.memory.cnt ;i++) {
-		pr_info("    memory.region[0x%lx].base       = 0x%llx\n",
-		    i, (unsigned long long)lmb.memory.region[i].base);
-		pr_info("		      .size     = 0x%llx\n",
-		    (unsigned long long)lmb.memory.region[i].size);
-	}
+	pr_info("LMB configuration:\n");
+	pr_info(" rmo_size    = 0x%llx\n", (unsigned long long)lmb.rmo_size);
+	pr_info(" memory.size = 0x%llx\n", (unsigned long long)lmb.memory.size);
 
-	pr_info("    reserved.cnt	  = 0x%lx\n", lmb.reserved.cnt);
-	pr_info("    reserved.size	  = 0x%llx\n",
-	    (unsigned long long)lmb.memory.size);
-	for (i=0; i < lmb.reserved.cnt ;i++) {
-		pr_info("    reserved.region[0x%lx].base       = 0x%llx\n",
-		    i, (unsigned long long)lmb.reserved.region[i].base);
-		pr_info("		      .size     = 0x%llx\n",
-		    (unsigned long long)lmb.reserved.region[i].size);
-	}
+	lmb_dump(&lmb.memory, "memory");
+	lmb_dump(&lmb.reserved, "reserved");
 }
 
 static unsigned long lmb_addrs_overlap(u64 base1, u64 size1, u64 base2,
-- 
1.5.5
