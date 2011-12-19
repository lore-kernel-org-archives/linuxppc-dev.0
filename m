Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0E6C6B703F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2011 13:03:26 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 19 Dec 2011 01:58:34 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBJ1xG9n3338428
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2011 12:59:16 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBJ236dF023130
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2011 13:03:07 +1100
Message-ID: <1324260184.3006.15.camel@ThinkPad-T61>
Subject: [PATCH powerpc] fix unpaired probe_hcall_entry and probe_hcall_exit
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 19 Dec 2011 10:03:04 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulmck@linux.vnet.ibm.com, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unpaired calling of probe_hcall_entry and probe_hcall_exit might happen
as following, which could cause incorrect preempt count. 

__trace_hcall_entry => trace_hcall_entry -> probe_hcall_entry =>
get_cpu_var => preempt_disable

__trace_hcall_exit => trace_hcall_exit -> probe_hcall_exit =>
put_cpu_var => preempt_enable

where: 
A => B and A -> B means A calls B, but
=> means A will call B through function name, and B will definitely be
called.
-> means A will call B through function pointer, so B might not be
called if the function pointer is not set.

So error happens when only one of probe_hcall_entry and probe_hcall_exit
get called during a hcall.

This patch tries to move the preempt count operations from
probe_hcall_entry and probe_hcall_exit to its callers.

Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hvCall_inst.c |    4 +---
 arch/powerpc/platforms/pseries/lpar.c        |    2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index f106662..c9311cf 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -109,7 +109,7 @@ static void probe_hcall_entry(void *ignored, unsigned long opcode, unsigned long
 	if (opcode > MAX_HCALL_OPCODE)
 		return;
 
-	h = &get_cpu_var(hcall_stats)[opcode / 4];
+	h = &__get_cpu_var(hcall_stats)[opcode / 4];
 	h->tb_start = mftb();
 	h->purr_start = mfspr(SPRN_PURR);
 }
@@ -126,8 +126,6 @@ static void probe_hcall_exit(void *ignored, unsigned long opcode, unsigned long
 	h->num_calls++;
 	h->tb_total += mftb() - h->tb_start;
 	h->purr_total += mfspr(SPRN_PURR) - h->purr_start;
-
-	put_cpu_var(hcall_stats);
 }
 
 static int __init hcall_inst_init(void)
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 27a4950..dc36ea6 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -554,6 +554,7 @@ void __trace_hcall_entry(unsigned long opcode, unsigned long *args)
 		goto out;
 
 	(*depth)++;
+	preempt_disable();
 	trace_hcall_entry(opcode, args);
 	(*depth)--;
 
@@ -576,6 +577,7 @@ void __trace_hcall_exit(long opcode, unsigned long retval,
 
 	(*depth)++;
 	trace_hcall_exit(opcode, retval, retbuf);
+	preempt_enable();
 	(*depth)--;
 
 out:
-- 
1.7.5.4
