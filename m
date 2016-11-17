Return-Path: <boqun.feng@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKGN40TMgzDrBv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 20:41:08 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id e9so16829260pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:41:07 -0800 (PST)
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
Subject: [RFC] powerpc: xmon: Add address lookup for percpu symbols
Date: Thu, 17 Nov 2016 17:40:35 +0800
Message-Id: <20161117094051.21606-1-boqun.feng@gmail.com>
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
 arch/powerpc/xmon/xmon.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 760545519a0b..3556966a29a5 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -229,6 +229,7 @@ Commands:\n\
   f	flush cache\n\
   la	lookup symbol+offset of specified address\n\
   ls	lookup address of specified symbol\n\
+  lp s [#]	lookup address of percpu symbol s for current cpu, or cpu #\n\
   m	examine/change memory\n\
   mm	move a block of memory\n\
   ms	set a block of memory\n\
@@ -2943,7 +2944,7 @@ static void
 symbol_lookup(void)
 {
 	int type = inchar();
-	unsigned long addr;
+	unsigned long addr, cpu, offset;
 	static char tmp[64];
 
 	switch (type) {
@@ -2967,6 +2968,31 @@ symbol_lookup(void)
 		catch_memory_errors = 0;
 		termch = 0;
 		break;
+	case 'p':
+		getstring(tmp, 64);
+		if (setjmp(bus_error_jmp) == 0) {
+			catch_memory_errors = 1;
+			sync();
+			addr = kallsyms_lookup_name(tmp);
+			sync();
+		}
+
+		if (scanhex(&cpu) && cpu < num_possible_cpus())
+			offset = per_cpu_offset(cpu);
+		else {
+			offset = my_cpu_offset;
+			cpu = raw_smp_processor_id();
+		}
+
+		if (addr)
+			printf("%s for cpu 0x%lx: %lx\n", tmp, cpu,
+							  addr + offset);
+		else
+			printf("Percpu symbol '%s' not found.\n", tmp);
+
+		catch_memory_errors = 0;
+		termch = 0;
+		break;
 	}
 }
 
-- 
2.10.1
