Return-Path: <boqun.feng@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNKh41G0KzDvmk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 20:20:35 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id p66so1597389pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 01:20:35 -0800 (PST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Rashmica Gupta <rashmicy@gmail.com>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>
Subject: [RFC v2] powerpc: xmon: Add address lookup for percpu symbols
Date: Tue, 22 Nov 2016 17:20:09 +0800
Message-Id: <20161122092033.7869-1-boqun.feng@gmail.com>
In-Reply-To: <20161117094051.21606-1-boqun.feng@gmail.com>
References: <20161117094051.21606-1-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, in xmon, there is no obvious way to get an address for a
percpu symbol for a particular cpu. Having such an ability would be good
for debugging the system when percpu variables got involved.

Therefore, this patch introduces a new xmon command "lp" to lookup the
address for percpu symbols. Usage of "lp" is similar to "ls", except
that we could add a cpu number to choose the variable of which cpu we
want to lookup. If no cpu number is given, lookup for current cpu.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
v1 --> v2:

o	Using per_cpu_ptr() and this_cpu_ptr() instead of
	per_cpu_offset() and my_cpu_offset, because the latter
	are undefined on !SMP kernel.

o	Only print the address of percpu symbols, i.e. symbols
	in [__per_cpu_start, __per_cpu_end)

 arch/powerpc/xmon/xmon.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 760545519a0b..2747c94400a2 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -49,6 +49,7 @@
 
 #include <asm/opal.h>
 #include <asm/firmware.h>
+#include <asm/sections.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
@@ -229,6 +230,7 @@ Commands:\n\
   f	flush cache\n\
   la	lookup symbol+offset of specified address\n\
   ls	lookup address of specified symbol\n\
+  lp s [#]	lookup address of percpu symbol s for current cpu, or cpu #\n\
   m	examine/change memory\n\
   mm	move a block of memory\n\
   ms	set a block of memory\n\
@@ -2943,7 +2945,8 @@ static void
 symbol_lookup(void)
 {
 	int type = inchar();
-	unsigned long addr;
+	unsigned long addr, cpu;
+	void __percpu *ptr = NULL;
 	static char tmp[64];
 
 	switch (type) {
@@ -2967,6 +2970,36 @@ symbol_lookup(void)
 		catch_memory_errors = 0;
 		termch = 0;
 		break;
+	case 'p':
+		getstring(tmp, 64);
+		if (setjmp(bus_error_jmp) == 0) {
+			catch_memory_errors = 1;
+			sync();
+			ptr = (void __percpu *)kallsyms_lookup_name(tmp);
+			sync();
+		}
+
+		if (ptr && ptr >= (void __percpu *)__per_cpu_start
+			&& ptr < (void __percpu *)__per_cpu_end) {
+
+			if (scanhex(&cpu) && cpu < num_possible_cpus())
+				addr = (unsigned long)per_cpu_ptr(ptr, cpu);
+			else {
+				cpu = raw_smp_processor_id();
+				addr = (unsigned long)this_cpu_ptr(ptr);
+			}
+
+			printf("%s for cpu 0x%lx: %lx\n", tmp, cpu, addr);
+
+		} else {
+			printf("Percpu symbol '%s' not found.\n", tmp);
+		}
+
+
+
+		catch_memory_errors = 0;
+		termch = 0;
+		break;
 	}
 }
 
-- 
2.10.1
