Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3A6B6B7D40
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 May 2010 15:08:49 +1000 (EST)
Date: Fri, 28 May 2010 15:08:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steven Rostedt <srostedt@redhat.com>
Subject: linux-next: build failure after merge of the final tree (linus'
	tree related)
Message-Id: <20100528150842.d5a751ba.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	paulus@samba.org, Anton Blanchard ZZ <anton@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Linus <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Steven,

After merging the final tree, today's linux-next build (powerpc allyesconfig) failed like this:

arch/powerpc/platforms/pseries/hvCall_inst.c: In function 'hcall_inst_init':
arch/powerpc/platforms/pseries/hvCall_inst.c:143: warning: passing argument 1 of 'register_trace_hcall_entry' from incompatible pointer type
arch/powerpc/include/asm/trace.h:100: note: expected 'void (*)(void *, long unsigned int,  long unsigned int *)' but argument is of type 'void (*)(long unsigned int,  long unsigned int *)'
arch/powerpc/platforms/pseries/hvCall_inst.c:143: error: too few arguments to function 'register_trace_hcall_entry'
arch/powerpc/platforms/pseries/hvCall_inst.c:146: warning: passing argument 1 of 'register_trace_hcall_exit' from incompatible pointer type
arch/powerpc/include/asm/trace.h:122: note: expected 'void (*)(void *, long unsigned int,  long unsigned int,  long unsigned int *)' but argument is of type 'void (*)(long unsigned int,  long unsigned int,  long unsigned int *)'
arch/powerpc/platforms/pseries/hvCall_inst.c:146: error: too few arguments to function 'register_trace_hcall_exit'
arch/powerpc/platforms/pseries/hvCall_inst.c:147: warning: passing argument 1 of 'unregister_trace_hcall_entry' from incompatible pointer type
arch/powerpc/include/asm/trace.h:100: note: expected 'void (*)(void *, long unsigned int,  long unsigned int *)' but argument is of type 'void (*)(long unsigned int,  long unsigned int *)'
arch/powerpc/platforms/pseries/hvCall_inst.c:147: error: too few arguments to function 'unregister_trace_hcall_entry'

Probably caused by commit 38516ab59fbc5b3bb278cf5e1fe2867c70cff32e
("tracing: Let tracepoints have data passed to tracepoint callbacks").

I applied this patch which builds (but may be incorrect).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 28 May 2010 15:05:00 +1000
Subject: [PATCH] tracing: fix for tracepoint API change

Commit 38516ab59fbc5b3bb278cf5e1fe2867c70cff32e "tracing: Let tracepoints
have data passed to tracepoint callbacks" requires this fixup to the
powerpc code.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
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
 
-- 
1.7.1


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
