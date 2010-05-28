Return-Path: <bounces.tip@hpa.at.zytor.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E2F4B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 May 2010 04:28:55 +1000 (EST)
Date: Fri, 28 May 2010 18:27:40 GMT
Sender: tip tree robot <bounces.tip@hpa.at.zytor.com>
From: tip-bot for Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20100528150842.d5a751ba.sfr@canb.auug.org.au>
References: <20100528150842.d5a751ba.sfr@canb.auug.org.au>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tracing, powerpc: Fix for tracepoint API change
Message-ID: <tip-a578f4255763514dc9d0c4f2a60cf5b9323e0b6b@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: sfr@canb.auug.org.au, peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, srostedt@redhat.com,
	mingo@redhat.com, anton@samba.org, hpa@zytor.com,
	tglx@linutronix.de, torvalds@linux-foundation.org, mingo@elte.hu
Reply-To: mingo@redhat.com, hpa@zytor.com, anton@samba.org,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
	srostedt@redhat.com, sfr@canb.auug.org.au, tglx@linutronix.de,
	mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  a578f4255763514dc9d0c4f2a60cf5b9323e0b6b
Gitweb:     http://git.kernel.org/tip/a578f4255763514dc9d0c4f2a60cf5b9323e0b6b
Author:     Stephen Rothwell <sfr@canb.auug.org.au>
AuthorDate: Fri, 28 May 2010 15:08:42 +1000
Committer:  Ingo Molnar <mingo@elte.hu>
CommitDate: Fri, 28 May 2010 16:27:11 +0200

tracing, powerpc: Fix for tracepoint API change

Commit 38516ab59fbc5b3bb278cf5e1fe2867c70cff32e "tracing: Let
tracepoints have data passed to tracepoint callbacks" requires
this fixup to the powerpc code.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Steven Rostedt <srostedt@redhat.com>
Cc: Linus <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: paulus@samba.org
Cc: Anton Blanchard ZZ <anton@samba.org>
LKML-Reference: <20100528150842.d5a751ba.sfr@canb.auug.org.au>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/powerpc/platforms/pseries/hvCall_inst.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index 1fefae7..e19ff02 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -102,7 +102,7 @@ static const struct file_operations hcall_inst_seq_fops = {
 #define CPU_NAME_BUF_SIZE	32
 
 
-static void probe_hcall_entry(unsigned long opcode, unsigned long *args)
+static void probe_hcall_entry(void *ignored, unsigned long opcode, unsigned long *args)
 {
 	struct hcall_stats *h;
 
@@ -114,7 +114,7 @@ static void probe_hcall_entry(unsigned long opcode, unsigned long *args)
 	h->purr_start = mfspr(SPRN_PURR);
 }
 
-static void probe_hcall_exit(unsigned long opcode, unsigned long retval,
+static void probe_hcall_exit(void *ignored, unsigned long opcode, unsigned long retval,
 			     unsigned long *retbuf)
 {
 	struct hcall_stats *h;
@@ -140,11 +140,11 @@ static int __init hcall_inst_init(void)
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		return 0;
 
-	if (register_trace_hcall_entry(probe_hcall_entry))
+	if (register_trace_hcall_entry(probe_hcall_entry, NULL))
 		return -EINVAL;
 
-	if (register_trace_hcall_exit(probe_hcall_exit)) {
-		unregister_trace_hcall_entry(probe_hcall_entry);
+	if (register_trace_hcall_exit(probe_hcall_exit, NULL)) {
+		unregister_trace_hcall_entry(probe_hcall_entry, NULL);
 		return -EINVAL;
 	}
 
