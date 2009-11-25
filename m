Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 718A3B7B63
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 03:12:24 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAPG6rpB013981
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 09:06:53 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	nAPGCCBR068906
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 09:12:14 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAPGCBkK015135
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Nov 2009 09:12:11 -0700
Subject: hypervisor call tracepoints  hcall_stats touchup.
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>, Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, mingo@redhat.com,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Nov 2009 10:12:09 -0600
Message-ID: <1259165529.16349.191.camel@lexx>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	will_schmidt <will_schmidt@vnet.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The tb_total and purr_total values reported via the hcall_stats code
should be cumulative, rather than being replaced by the latest delta tb
or purr value. 

Tested-by: Will Schmidt <will_schmidt@vnet.ibm.com>
Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>

---
[ This is a touch-up to the "[3/6] powerpc: tracing: Add hypervisor call
tracepoints" patch submitted by Anton a few weeks back, so I've copied
folks Anton had on CC for his original patch, this fix is rather ppc
specific, so can probably go in via the ppc tree, but I've no real
preference. ]

diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index 2f58c71..1fefae7 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -124,8 +124,8 @@ static void probe_hcall_exit(unsigned long opcode, unsigned long retval,
 
 	h = &__get_cpu_var(hcall_stats)[opcode / 4];
 	h->num_calls++;
-	h->tb_total = mftb() - h->tb_start;
-	h->purr_total = mfspr(SPRN_PURR) - h->purr_start;
+	h->tb_total += mftb() - h->tb_start;
+	h->purr_total += mfspr(SPRN_PURR) - h->purr_start;
 
 	put_cpu_var(hcall_stats);
 }
