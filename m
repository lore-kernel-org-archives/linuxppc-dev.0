Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17037.36468.232093.480365@cargo.ozlabs.ibm.com>
Date: Fri, 20 May 2005 17:15:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
Subject: [PATCH] ppc32: remove unused computation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We are computing phys in the code below and never using.  This patch
takes out the redundant computation.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff -urN linux-2.6/arch/ppc/syslib/open_pic.c pmac-2.5/arch/ppc/syslib/open_pic.c
--- linux-2.6/arch/ppc/syslib/open_pic.c	2005-04-26 15:37:55.000000000 +1000
+++ pmac-2.5/arch/ppc/syslib/open_pic.c	2005-04-26 20:34:39.000000000 +1000
@@ -557,12 +557,10 @@
  */
 void openpic_cause_IPI(u_int ipi, cpumask_t cpumask)
 {
-	cpumask_t phys;
 	DECL_THIS_CPU;
 
 	CHECK_THIS_CPU;
 	check_arg_ipi(ipi);
-	phys = physmask(cpumask);
 	openpic_write(&OpenPIC->THIS_CPU.IPI_Dispatch(ipi),
 		      cpus_addr(physmask(cpumask))[0]);
 }
