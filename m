Return-Path: <michael@ozlabs.org>
To: <linux-kernel@vger.kernel.org>
Message-Id: <78935473b1f70c863ab0be7d6cf4bcb04922b20b.1182822366.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/3] Make struct jprobe.entry a void *
Date: Tue, 26 Jun 2007 11:48:50 +1000 (EST)
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-ia64@vger.kernel.org, anil.s.keshavamurthy@intel.com,
	linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently jprobe.entry is a kprobe_opcode_t *, but that's a lie. On some
platforms it doesn't point to an opcode at all, it points to a function
descriptor.

It's really a pointer to something that the arch code can turn into a
function entry point. And that's what actually happens, none of the
generic code ever looks at jprobe.entry, it's only ever dereferenced
by arch code.

So just make it a void *.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

It isn't obvious where kprobes patches should go, is anyone "the" maintainer?
Instead I've just sent this to everyone who'd touched the code lately, or
might be otherwise interested.


 include/linux/kprobes.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 23adf60..f4e53b7 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -116,7 +116,7 @@ struct kprobe {
  */
 struct jprobe {
 	struct kprobe kp;
-	kprobe_opcode_t *entry;	/* probe handling code to jump to */
+	void *entry;	/* probe handling code to jump to */
 };
 
 DECLARE_PER_CPU(struct kprobe *, current_kprobe);
-- 
1.5.1.3.g7a33b
