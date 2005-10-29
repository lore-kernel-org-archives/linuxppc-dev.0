Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lT8B030132@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:58 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, apw@shadowen.org,
	jschopp@austin.ibm.com, linuxppc64-dev@ozlabs.org
Subject: [patch 43/43] ppc64 memory model depends on NUMA
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Andy Whitcroft <apw@shadowen.org>

Currently when we first select memory model (FLAT, DISCONTIG, SPARSE) then
select whether the machine is NUMA.  However NUMA systems may not be FLAT. 
This constraint it not honoured and we may configure a NUMA/FLAT system.

Reorder the configuration such that we choose NUMA first which allows us to
only list the memory models which are valid.  We now default NUMA for known
NUMA systems.  Note that this new order also matches that used in x86.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/Kconfig |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff -puN arch/ppc64/Kconfig~ppc64-memory-model-depends-on-numa arch/ppc64/Kconfig
--- devel/arch/ppc64/Kconfig~ppc64-memory-model-depends-on-numa	2005-10-28 17:44:05.000000000 -0700
+++ devel-akpm/arch/ppc64/Kconfig	2005-10-28 17:44:05.000000000 -0700
@@ -245,6 +245,10 @@ config HMT
 	  This option enables hardware multithreading on RS64 cpus.
 	  pSeries systems p620 and p660 have such a cpu type.
 
+config NUMA
+	bool "NUMA support"
+	default y if SMP && PPC_PSERIES
+
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
@@ -260,9 +264,6 @@ config ARCH_DISCONTIGMEM_DEFAULT
 	def_bool y
 	depends on ARCH_DISCONTIGMEM_ENABLE
 
-config ARCH_FLATMEM_ENABLE
-	def_bool y
-
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	depends on ARCH_DISCONTIGMEM_ENABLE
@@ -285,10 +286,6 @@ config NODES_SPAN_OTHER_NODES
 	def_bool y
 	depends on NEED_MULTIPLE_NODES
 
-config NUMA
-	bool "NUMA support"
-	default y if DISCONTIGMEM || SPARSEMEM
-
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
 	depends on SMP
_
