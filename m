Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E7942B7012
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 14:51:20 +1100 (EST)
Message-ID: <1331092280.3105.5.camel@pasglop>
Subject: Re: [PATCH] spufs raises two exceptions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: masterzorag <masterzorag@gmail.com>
Date: Wed, 07 Mar 2012 14:51:20 +1100
In-Reply-To: <1331092190.3105.3.camel@pasglop>
References: <4F55D84B.7030306@gmail.com> <1331092190.3105.3.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-03-07 at 14:49 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2012-03-06 at 10:26 +0100, masterzorag wrote:
> > I'm running my test program, it uses all available spus to compute via 
> > OpenCL
> > kernel 3.2.5 on a ps3
> > even on testing spu directly, it crashes
> 
> I think the patch is not 100% right yet. Looking at the code, we
> have a real mess of who gets to clean what up here. This is an
> attempt at sorting things by having the mutex and dentry dropped
> in spufs_create() always. Can you give it a spin (untested):
> 
> Al, I'm not familiar with the vfs, can you take a quick look ?

Better with the actual patch :-)

powerpc/cell: Fix locking in spufs_create()

The error path in spufs_create() could cause double unlocks
among other horrors. Clean it up.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reported-by: masterzorag@gmail.com

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index d4a094c..63b4e43 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -454,19 +454,16 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 	struct spu_gang *gang;
 	struct spu_context *neighbor;
 
-	ret = -EPERM;
 	if ((flags & SPU_CREATE_NOSCHED) &&
-	    !capable(CAP_SYS_NICE))
-		goto out_unlock;
+	    !capable(CAP_SYa_NICE))
+		return -EPERM;
 
-	ret = -EINVAL;
 	if ((flags & (SPU_CREATE_NOSCHED | SPU_CREATE_ISOLATE))
 	    == SPU_CREATE_ISOLATE)
-		goto out_unlock;
+		return -EINVAL;
 
-	ret = -ENODEV;
 	if ((flags & SPU_CREATE_ISOLATE) && !isolated_loader)
-		goto out_unlock;
+		return -ENODEV;
 
 	gang = NULL;
 	neighbor = NULL;
@@ -512,10 +509,6 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 out_aff_unlock:
 	if (affinity)
 		mutex_unlock(&gang->aff_mutex);
-out_unlock:
-	mutex_unlock(&inode->i_mutex);
-out:
-	dput(dentry);
 	return ret;
 }
 
@@ -585,11 +578,9 @@ static int spufs_create_gang(struct inode *inode,
 			struct dentry *dentry,
 			struct vfsmount *mnt, umode_t mode)
 {
-	int ret;
-
-	ret = spufs_mkgang(inode, dentry, mode & S_IRWXUGO);
+	int ret = spufs_mkgang(inode, dentry, mode & S_IRWXUGO);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * get references for dget and mntget, will be released
@@ -600,10 +591,6 @@ static int spufs_create_gang(struct inode *inode,
 		int err = simple_rmdir(inode, dentry);
 		WARN_ON(err);
 	}
-
-out:
-	mutex_unlock(&inode->i_mutex);
-	dput(dentry);
 	return ret;
 }
 
@@ -613,22 +600,21 @@ static struct file_system_type spufs_type;
 long spufs_create(struct path *path, struct dentry *dentry,
 		unsigned int flags, umode_t mode, struct file *filp)
 {
-	int ret;
+	int ret = -EINVAL;
 
-	ret = -EINVAL;
 	/* check if we are on spufs */
 	if (path->dentry->d_sb->s_type != &spufs_type)
-		goto out;
+		goto fail;
 
 	/* don't accept undefined flags */
 	if (flags & (~SPU_CREATE_FLAG_ALL))
-		goto out;
+		goto fail;
 
 	/* only threads can be underneath a gang */
 	if (path->dentry != path->dentry->d_sb->s_root) {
 		if ((flags & SPU_CREATE_GANG) ||
 		    !SPUFS_I(path->dentry->d_inode)->i_gang)
-			goto out;
+		goto fail;
 	}
 
 	mode &= ~current_umask();
@@ -640,12 +626,17 @@ long spufs_create(struct path *path, struct dentry *dentry,
 		ret = spufs_create_context(path->dentry->d_inode,
 					    dentry, path->mnt, flags, mode,
 					    filp);
-	if (ret >= 0)
+	if (ret >= 0) {
+		/* We drop these before fsnotify */
+		mutex_unlock(&inode->i_mutex);
+		dput(dentry);
 		fsnotify_mkdir(path->dentry->d_inode, dentry);
-	return ret;
 
-out:
-	mutex_unlock(&path->dentry->d_inode->i_mutex);
+		return ret;
+	}
+ fail:
+	mutex_unlock(&inode->i_mutex);
+	dput(dentry);
 	return ret;
 }
 
diff --git a/arch/powerpc/platforms/cell/spufs/syscalls.c b/arch/powerpc/platforms/cell/spufs/syscalls.c
index 8591bb6..1a65ef2 100644
--- a/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ b/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -70,11 +70,8 @@ static long do_spu_create(const char __user *pathname, unsigned int flags,
 	ret = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		ret = spufs_create(&path, dentry, flags, mode, neighbor);
-		mutex_unlock(&path.dentry->d_inode->i_mutex);
-		dput(dentry);
 		path_put(&path);
 	}
-
 	return ret;
 }
 
