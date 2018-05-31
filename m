Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xF3r2XnFzDrYj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 14:34:32 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 11/11] powerpc: Check prom_init for disallowed sections
Date: Thu, 31 May 2018 14:33:49 +1000
Message-Id: <20180531043349.24783-12-benh@kernel.crashing.org>
In-Reply-To: <20180531043349.24783-1-benh@kernel.crashing.org>
References: <20180531043349.24783-1-benh@kernel.crashing.org>
Reply-To: [RFC.PATCH.00/11]prom_init.cleanups.and.sanitization@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

prom_init.c must not modify the kernel image outside
of the .bss.prominit section. Thus make sure that
prom_init.o doesn't have anything in any of these:

	.data
	.bss
	.init.data

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init_check.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index acb6b9226352..667df97d2595 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -28,6 +28,18 @@ OBJ="$2"
 
 ERROR=0
 
+function check_section()
+{
+    file=$1
+    section=$2
+    size=$(objdump -h -j $section $file 2>/dev/null | awk "\$2 == \"$section\" {print \$3}")
+    size=${size:-0}
+    if [ $size -ne 0 ]; then
+	ERROR=1
+	echo "Error: Section $section not empty in prom_init.c" >&2
+    fi
+}
+
 for UNDEF in $($NM -u $OBJ | awk '{print $2}')
 do
 	# On 64-bit nm gives us the function descriptors, which have
@@ -66,4 +78,8 @@ do
 	fi
 done
 
+check_section $OBJ .data
+check_section $OBJ .bss
+check_section $OBJ .init.data
+
 exit $ERROR
-- 
2.17.0
