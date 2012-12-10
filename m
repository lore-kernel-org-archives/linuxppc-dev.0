Return-Path: <shuah.khan@hp.com>
Received: from g6t0184.atlanta.hp.com (g6t0184.atlanta.hp.com [15.193.32.61])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 098042C032E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2012 04:23:32 +1100 (EST)
Message-ID: <1355160196.2739.12.camel@lorien2>
Subject: [PATCH v2] powerpc: fix wii_memory_fixups() compile error on 3.0.y
 tree
From: Shuah Khan <shuah.khan@hp.com>
To: Ben Hutchings <ben@decadent.org.uk>, Greg KH
 <gregkh@linuxfoundation.org>,  paulus@samba.org, benh@kernel.crashing.org
Date: Mon, 10 Dec 2012 10:23:16 -0700
In-Reply-To: <CAKocOOPYv0L5dnVJ-jcKw6u3Axbe-tFRdz+F8FvE6fq-xRQH5A@mail.gmail.com>
References: <1354932445.7407.15.camel@lorien2>
 <1354987359.20838.67.camel@deadeye.wl.decadent.org.uk>
 <CAKocOOPYv0L5dnVJ-jcKw6u3Axbe-tFRdz+F8FvE6fq-xRQH5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, shuahkhan@gmail.com,
 stable <stable@vger.kernel.org>
Reply-To: shuah.khan@hp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix wii_memory_fixups() the following compile error on 3.0.y tree with 
wii_defconfig on 3.0.y tree.

  CC      arch/powerpc/platforms/embedded6xx/wii.o
arch/powerpc/platforms/embedded6xx/wii.c: In function ‘wii_memory_fixups’:
arch/powerpc/platforms/embedded6xx/wii.c:88:2: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 2 has type ‘phys_addr_t’ [-Werror=format]
arch/powerpc/platforms/embedded6xx/wii.c:88:2: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘phys_addr_t’ [-Werror=format]
arch/powerpc/platforms/embedded6xx/wii.c:90:2: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 2 has type ‘phys_addr_t’ [-Werror=format]
arch/powerpc/platforms/embedded6xx/wii.c:90:2: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘phys_addr_t’ [-Werror=format]
cc1: all warnings being treated as errors
make[2]: *** [arch/powerpc/platforms/embedded6xx/wii.o] Error 1
make[1]: *** [arch/powerpc/platforms/embedded6xx] Error 2
make: *** [arch/powerpc/platforms] Error 2

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
CC: stable@vger.kernel.org 3.0.y
---
 arch/powerpc/platforms/embedded6xx/wii.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 1b5dc1a..d8ff38f 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -85,9 +85,11 @@ void __init wii_memory_fixups(void)
 	wii_hole_start = p[0].base + p[0].size;
 	wii_hole_size = p[1].base - wii_hole_start;
 
-	pr_info("MEM1: <%08llx %08llx>\n", p[0].base, p[0].size);
+	pr_info("MEM1: <%08ulx %08ulx>\n",
+		(phys_addr_t) p[0].base, (phys_addr_t) p[0].size);
 	pr_info("HOLE: <%08lx %08lx>\n", wii_hole_start, wii_hole_size);
-	pr_info("MEM2: <%08llx %08llx>\n", p[1].base, p[1].size);
+	pr_info("MEM2: <%08ulx %08ulx>\n",
+		(phys_addr_t) p[1].base, (phys_addr_t) p[1].size);
 
 	p[0].size += wii_hole_size + p[1].size;
 
-- 
1.7.9.5
