Return-Path: <anton@samba.org>
Date: Tue, 20 Aug 2013 16:05:16 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org,
 amodra@gmail.com
Subject: [PATCH] powerpc: Never handle VSX alignment exceptions from kernel
Message-ID: <20130820160516.596a85a4@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The VSX alignment handler needs to write out the existing VSX
state to memory before operating on it (flush_vsx_to_thread()).
If we take a VSX alignment exception in the kernel bad things
will happen. It looks like we could write the kernel state out
to the user process, or we could handle the kernel exception
using data from the user process (depending if MSR_VSX is set
or not).

Worse still, if the code to read or write the VSX state causes an
alignment exception, we will recurse forever. I ended up with
hundreds of megabytes of kernel stack to look through as a result.

Floating point and SPE code have similar issues but already include
a user check. Add the same check to emulate_vsx().

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/kernel/align.c
===================================================================
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -651,6 +651,10 @@ static int emulate_vsx(unsigned char __u
 	int sw = 0;
 	int i, j;
 
+	/* userland only */
+	if (unlikely(!user_mode(regs)))
+		return 0;
+
 	flush_vsx_to_thread(current);
 
 	if (reg < 32)
