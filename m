Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 9BA5467CA6
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 18:18:46 +1100 (EST)
Date: Mon, 30 Oct 2006 18:17:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] Create compat_sys_migrate_pages.
Message-Id: <20061030181701.23ea7cba.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, ak@suse.de, ppc-dev <linuxppc-dev@ozlabs.org>,
	pj@sgi.com, paulus@samba.org, Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is needed on bigendian 64bit architectures.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/compat.h |    4 ++++
 kernel/compat.c        |   33 +++++++++++++++++++++++++++++++++
 kernel/sys_ni.c        |    1 +
 3 files changed, 38 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/linux/compat.h b/include/linux/compat.h
index f155319..80b17f4 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -230,5 +230,9 @@ asmlinkage long compat_sys_adjtimex(stru
 extern int compat_printk(const char *fmt, ...);
 extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
 
+asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
+		compat_ulong_t maxnode, const compat_ulong_t __user *old_nodes,
+		const compat_ulong_t __user *new_nodes);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff --git a/kernel/compat.c b/kernel/compat.c
index d4898aa..6952dd0 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -982,4 +982,37 @@ asmlinkage long compat_sys_move_pages(pi
 	}
 	return sys_move_pages(pid, nr_pages, pages, nodes, status, flags);
 }
+
+asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
+			compat_ulong_t maxnode,
+			const compat_ulong_t __user *old_nodes,
+			const compat_ulong_t __user *new_nodes)
+{
+	unsigned long __user *old = NULL;
+	unsigned long __user *new = NULL;
+	nodemask_t tmp_mask;
+	unsigned long nr_bits;
+	unsigned long size;
+
+	nr_bits = min_t(unsigned long, maxnode - 1, MAX_NUMNODES);
+	size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
+	if (old_nodes) {
+		if (compat_get_bitmap(nodes_addr(tmp_mask), old_nodes, nr_bits))
+			return -EFAULT;
+		old = compat_alloc_user_space(new_nodes ? size * 2 : size);
+		if (new_nodes)
+			new = old + size / sizeof(unsigned long);
+		if (copy_to_user(old, nodes_addr(tmp_mask), size))
+			return -EFAULT;
+	}
+	if (new_nodes) {
+		if (compat_get_bitmap(nodes_addr(tmp_mask), new_nodes, nr_bits))
+			return -EFAULT;
+		if (new == NULL)
+			new = compat_alloc_user_space(size);
+		if (copy_to_user(new, nodes_addr(tmp_mask), size))
+			return -EFAULT;
+	}
+	return sys_migrate_pages(pid, nr_bits + 1, old, new);
+}
 #endif
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 0e53314..d7306d0 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -135,6 +135,7 @@ cond_syscall(sys_madvise);
 cond_syscall(sys_mremap);
 cond_syscall(sys_remap_file_pages);
 cond_syscall(compat_sys_move_pages);
+cond_syscall(compat_sys_migrate_pages);
 
 /* block-layer dependent */
 cond_syscall(sys_bdflush);
-- 
1.4.3.2
