Return-Path: <anton@ozlabs.org>
Date: Fri, 18 Jun 2010 10:33:06 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com
Subject: [PATCH] powerpc: Linux cannot run with 0 cores
Message-ID: <20100618003306.GA3463@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


If we configure with CONFIG_SMP=n or set NR_CPUS less than the number of
SMT threads we will set the max cores property to 0 in the
ibm,client-architecture-support structure. On new versions of firmware that
understand this property it obliges and terminates our partition.

Use DIV_ROUND_UP so we handle not only the CONFIG_SMP=n case but also the
case where NR_CPUS isn't a multiple of the number of SMT threads.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/prom_init.c	2010-06-17 09:08:20.000000000 +1000
+++ linux-2.6/arch/powerpc/kernel/prom_init.c	2010-06-17 09:10:02.000000000 +1000
@@ -872,7 +872,7 @@ static void __init prom_send_capabilitie
 				    "ibm_architecture_vec structure inconsistent: 0x%x !\n",
 				    *cores);
 		} else {
-			*cores = NR_CPUS / prom_count_smt_threads();
+			*cores = DIV_ROUND_UP(NR_CPUS, prom_count_smt_threads());
 			prom_printf("Max number of cores passed to firmware: 0x%x\n",
 				    (unsigned long)*cores);
 		}
