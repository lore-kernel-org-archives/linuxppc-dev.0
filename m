Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414231A0DD9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2015 04:30:37 +1100 (AEDT)
Date: Fri, 4 Dec 2015 17:30:31 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: more POLL... fun
Message-ID: <20151204173031.GJ22011@ZenIV.linux.org.uk>
References: <20151127050026.GX22011@ZenIV.linux.org.uk>
 <3199712.spOmaGJUoN@wuerfel>
 <20151204152133.GI22011@ZenIV.linux.org.uk>
 <2220761.5EzR0eY4bg@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2220761.5EzR0eY4bg@wuerfel>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 04, 2015 at 06:13:54PM +0100, Arnd Bergmann wrote:

> Yes, I think that would be best. Do you want me to send that patch, or do
> you prefer to do it yourself? In theory that patch should also go into stable
> kernels, but I suspect nobody who still owns a machine that is able to run
> this code will ever upgrade to a stable release, so we probably don't need
> that.

Probably better if it goes through ppc tree - the only relationship it has
to VFS is broken calls of kill_fasync() in now-removed code...  Something
like this, perhaps?

[spufs] get rid of broken fasync stuff
 
In all the years it's been in the tree it had never been used by
anything - it would instantly trigger BUG_ON() in fs/fcntl.c due
to bogus band argument passed to kill_fasync().  Since nobody
had ever used it in ten years, let's just rip it out and be
done with that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 5038fd5..88b7613 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -686,23 +686,13 @@ size_t spu_ibox_read(struct spu_context *ctx, u32 *data)
 	return ctx->ops->ibox_read(ctx, data);
 }
 
-static int spufs_ibox_fasync(int fd, struct file *file, int on)
-{
-	struct spu_context *ctx = file->private_data;
-
-	return fasync_helper(fd, file, on, &ctx->ibox_fasync);
-}
-
 /* interrupt-level ibox callback function. */
 void spufs_ibox_callback(struct spu *spu)
 {
 	struct spu_context *ctx = spu->ctx;
 
-	if (!ctx)
-		return;
-
-	wake_up_all(&ctx->ibox_wq);
-	kill_fasync(&ctx->ibox_fasync, SIGIO, POLLIN);
+	if (ctx)
+		wake_up_all(&ctx->ibox_wq);
 }
 
 /*
@@ -797,7 +787,6 @@ static const struct file_operations spufs_ibox_fops = {
 	.open	= spufs_pipe_open,
 	.read	= spufs_ibox_read,
 	.poll	= spufs_ibox_poll,
-	.fasync	= spufs_ibox_fasync,
 	.llseek = no_llseek,
 };
 
@@ -835,26 +824,13 @@ size_t spu_wbox_write(struct spu_context *ctx, u32 data)
 	return ctx->ops->wbox_write(ctx, data);
 }
 
-static int spufs_wbox_fasync(int fd, struct file *file, int on)
-{
-	struct spu_context *ctx = file->private_data;
-	int ret;
-
-	ret = fasync_helper(fd, file, on, &ctx->wbox_fasync);
-
-	return ret;
-}
-
 /* interrupt-level wbox callback function. */
 void spufs_wbox_callback(struct spu *spu)
 {
 	struct spu_context *ctx = spu->ctx;
 
-	if (!ctx)
-		return;
-
-	wake_up_all(&ctx->wbox_wq);
-	kill_fasync(&ctx->wbox_fasync, SIGIO, POLLOUT);
+	if (ctx)
+		wake_up_all(&ctx->wbox_wq);
 }
 
 /*
@@ -947,7 +923,6 @@ static const struct file_operations spufs_wbox_fops = {
 	.open	= spufs_pipe_open,
 	.write	= spufs_wbox_write,
 	.poll	= spufs_wbox_poll,
-	.fasync	= spufs_wbox_fasync,
 	.llseek = no_llseek,
 };
 
@@ -1523,28 +1498,8 @@ void spufs_mfc_callback(struct spu *spu)
 {
 	struct spu_context *ctx = spu->ctx;
 
-	if (!ctx)
-		return;
-
-	wake_up_all(&ctx->mfc_wq);
-
-	pr_debug("%s %s\n", __func__, spu->name);
-	if (ctx->mfc_fasync) {
-		u32 free_elements, tagstatus;
-		unsigned int mask;
-
-		/* no need for spu_acquire in interrupt context */
-		free_elements = ctx->ops->get_mfc_free_elements(ctx);
-		tagstatus = ctx->ops->read_mfc_tagstatus(ctx);
-
-		mask = 0;
-		if (free_elements & 0xffff)
-			mask |= POLLOUT;
-		if (tagstatus & ctx->tagwait)
-			mask |= POLLIN;
-
-		kill_fasync(&ctx->mfc_fasync, SIGIO, mask);
-	}
+	if (ctx)
+		wake_up_all(&ctx->mfc_wq);
 }
 
 static int spufs_read_mfc_tagstatus(struct spu_context *ctx, u32 *status)
@@ -1806,13 +1761,6 @@ static int spufs_mfc_fsync(struct file *file, loff_t start, loff_t end, int data
 	return err;
 }
 
-static int spufs_mfc_fasync(int fd, struct file *file, int on)
-{
-	struct spu_context *ctx = file->private_data;
-
-	return fasync_helper(fd, file, on, &ctx->mfc_fasync);
-}
-
 static const struct file_operations spufs_mfc_fops = {
 	.open	 = spufs_mfc_open,
 	.release = spufs_mfc_release,
@@ -1821,7 +1769,6 @@ static const struct file_operations spufs_mfc_fops = {
 	.poll	 = spufs_mfc_poll,
 	.flush	 = spufs_mfc_flush,
 	.fsync	 = spufs_mfc_fsync,
-	.fasync	 = spufs_mfc_fasync,
 	.mmap	 = spufs_mfc_mmap,
 	.llseek  = no_llseek,
 };
diff --git a/arch/powerpc/platforms/cell/spufs/spufs.h b/arch/powerpc/platforms/cell/spufs/spufs.h
index bcfd6f0..aac7339 100644
--- a/arch/powerpc/platforms/cell/spufs/spufs.h
+++ b/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -102,9 +102,6 @@ struct spu_context {
 	wait_queue_head_t stop_wq;
 	wait_queue_head_t mfc_wq;
 	wait_queue_head_t run_wq;
-	struct fasync_struct *ibox_fasync;
-	struct fasync_struct *wbox_fasync;
-	struct fasync_struct *mfc_fasync;
 	u32 tagwait;
 	struct spu_context_ops *ops;
 	struct work_struct reap_work;
