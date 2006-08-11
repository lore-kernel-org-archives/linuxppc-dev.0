Return-Path: <ananth@in.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 546EE67B86
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 21:30:35 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7BBUVss018228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 07:30:32 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7BBUMxs297362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 05:30:23 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7BBUM0K030620
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 05:30:22 -0600
Date: Fri, 11 Aug 2006 17:01:34 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] kprobes/powerpc: Fix possible system crash during out-of-line
	single-stepping
Message-ID: <20060811113134.GA24462@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: willschm@us.ibm.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

- On archs that have no-exec support, we vmalloc() a executable scratch
area of PAGE_SIZE and divide it up into an array of slots of maximum
instruction size for that arch
- On a kprobe registration, the original instruction is copied to the
first available free slot, so if multiple kprobes are registered, chances
are, they get contiguous slots
- On POWER4, due to not having coherent icaches, we could hit a situation
where a probe that is registered on one processor, is hit immediately on
another. This second processor could have fetched the stream of text from
the out-of-line single-stepping area *before* the probe registration
completed, possibly due to an earlier (and a different) kprobe hit and
hence would see stale data at the slot.

Executing such an arbitrary instruction lead to a problem as reported
in LTC bugzilla 23555.

The correct solution is to call flush_icache_range() as soon as the
instruction is copied for out-of-line single-stepping, so the correct
instruction is seen on all processors.

Thanks to Will Schmidt who tracked this down.

Ananth
---

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

---
 arch/powerpc/kernel/kprobes.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.18-rc4/arch/powerpc/kernel/kprobes.c
===================================================================
--- linux-2.6.18-rc4.orig/arch/powerpc/kernel/kprobes.c
+++ linux-2.6.18-rc4/arch/powerpc/kernel/kprobes.c
@@ -61,6 +61,8 @@ int __kprobes arch_prepare_kprobe(struct
 	if (!ret) {
 		memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 		p->opcode = *p->addr;
+		flush_icache_range((unsigned long)p->ainsn.insn,
+			(unsigned long)p->ainsn.insn + sizeof(kprobe_opcode_t));
 	}
 
 	return ret;
