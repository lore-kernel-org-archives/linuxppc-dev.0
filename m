Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 4AB5ADDF56
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Aug 2008 23:46:08 +1000 (EST)
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 04/59] CRED: Wrap task credential accesses in the PowerPC arch
To: linux-kernel@vger.kernel.org
Date: Wed, 27 Aug 2008 14:46:02 +0100
Message-ID: <20080827134602.19980.59222.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080827134541.19980.61042.stgit@warthog.procyon.org.uk>
References: <20080827134541.19980.61042.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, linux-security-module@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Serge Hallyn <serue@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wrap access to task credentials so that they can be separated more easily from
the task_struct during the introduction of COW creds.

Change most current->(|e|s|fs)[ug]id to current_(|e|s|fs)[ug]id().

Change some task->e?[ug]id to task_e?[ug]id().  In some places it makes more
sense to use RCU directly rather than a convenient wrapper; these will be
addressed by later patches.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <jmorris@namei.org>
Acked-by: Serge Hallyn <serue@us.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
---

 arch/powerpc/mm/fault.c                   |    2 +-
 arch/powerpc/platforms/cell/spufs/inode.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 565b7a2..8660986 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -339,7 +339,7 @@ bad_area_nosemaphore:
 	    && printk_ratelimit())
 		printk(KERN_CRIT "kernel tried to execute NX-protected"
 		       " page (%lx) - exploit attempt? (uid: %d)\n",
-		       address, current->uid);
+		       address, current_uid());
 
 	return SIGSEGV;
 
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 690ca7b..60bd5ed 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -95,8 +95,8 @@ spufs_new_inode(struct super_block *sb, int mode)
 		goto out;
 
 	inode->i_mode = mode;
-	inode->i_uid = current->fsuid;
-	inode->i_gid = current->fsgid;
+	inode->i_uid = current_fsuid();
+	inode->i_gid = current_fsgid();
 	inode->i_blocks = 0;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 out:
