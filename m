Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 7AAA3B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 23:49:06 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] spufs raises two exceptions
Date: Wed, 7 Mar 2012 12:48:54 +0000
References: <4F55D84B.7030306@gmail.com> <1331092190.3105.3.camel@pasglop>
 <1331092280.3105.5.camel@pasglop>
In-Reply-To: <1331092280.3105.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201203071248.54887.arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, masterzorag <masterzorag@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 07 March 2012, Benjamin Herrenschmidt wrote:
> On Wed, 2012-03-07 at 14:49 +1100, Benjamin Herrenschmidt wrote:
> > On Tue, 2012-03-06 at 10:26 +0100, masterzorag wrote:
> > > I'm running my test program, it uses all available spus to compute via 
> > > OpenCL
> > > kernel 3.2.5 on a ps3
> > > even on testing spu directly, it crashes
> > 
> > I think the patch is not 100% right yet. Looking at the code, we
> > have a real mess of who gets to clean what up here. This is an
> > attempt at sorting things by having the mutex and dentry dropped
> > in spufs_create() always. Can you give it a spin (untested):
> > 
> > Al, I'm not familiar with the vfs, can you take a quick look ?
> 
> Better with the actual patch :-)
> 
> powerpc/cell: Fix locking in spufs_create()
> 
> The error path in spufs_create() could cause double unlocks
> among other horrors. Clean it up.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reported-by: masterzorag@gmail.com
> 
> diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
> index d4a094c..63b4e43 100644
> --- a/arch/powerpc/platforms/cell/spufs/inode.c
> +++ b/arch/powerpc/platforms/cell/spufs/inode.c
> @@ -454,19 +454,16 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
>  	struct spu_gang *gang;
>  	struct spu_context *neighbor;
>  
> -	ret = -EPERM;
>  	if ((flags & SPU_CREATE_NOSCHED) &&
> -	    !capable(CAP_SYS_NICE))
> -		goto out_unlock;
> +	    !capable(CAP_SYa_NICE))

                    ^typo

> +		return -EPERM;
>  
> -	ret = -EINVAL;
>  	if ((flags & (SPU_CREATE_NOSCHED | SPU_CREATE_ISOLATE))
>  	    == SPU_CREATE_ISOLATE)
> -		goto out_unlock;
> +		return -EINVAL;
>  
> -	ret = -ENODEV;
>  	if ((flags & SPU_CREATE_ISOLATE) && !isolated_loader)
> -		goto out_unlock;
> +		return -ENODEV;
>  
>  	gang = NULL;
>  	neighbor = NULL;

This mostly changes coding style, pointlessly.

> @@ -512,10 +509,6 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
>  out_aff_unlock:
>  	if (affinity)
>  		mutex_unlock(&gang->aff_mutex);
> -out_unlock:
> -	mutex_unlock(&inode->i_mutex);
> -out:
> -	dput(dentry);
>  	return ret;
>  }

The original intention of this was to always unlock in the error case. It
seems that Al changed this in 1ba10681 "switch do_spufs_create() to
user_path_create(), fix double-unlock" to never unlock early but always
unlock in do_spu_create, fixing a different bug, but it looks like
he forgot this one in the process.

The reason why we originally had the unlock in the leaf functions is to
avoid a problem with spu_forget(), which had to be called without
the i_mutex held to avoid deadlocks.

> @@ -600,10 +591,6 @@ static int spufs_create_gang(struct inode *inode,
>  		int err = simple_rmdir(inode, dentry);
>  		WARN_ON(err);
>  	}
> -
> -out:
> -	mutex_unlock(&inode->i_mutex);
> -	dput(dentry);
>  	return ret;
>  }

Right, this obviously goes together with the one above,

> @@ -613,22 +600,21 @@ static struct file_system_type spufs_type;
>  long spufs_create(struct path *path, struct dentry *dentry,
>  		unsigned int flags, umode_t mode, struct file *filp)
>  {
> -	int ret;
> +	int ret = -EINVAL;
>  
> -	ret = -EINVAL;
>  	/* check if we are on spufs */
>  	if (path->dentry->d_sb->s_type != &spufs_type)
> -		goto out;
> +		goto fail;
>  
>  	/* don't accept undefined flags */
>  	if (flags & (~SPU_CREATE_FLAG_ALL))
> -		goto out;
> +		goto fail;
>  
>  	/* only threads can be underneath a gang */
>  	if (path->dentry != path->dentry->d_sb->s_root) {
>  		if ((flags & SPU_CREATE_GANG) ||
>  		    !SPUFS_I(path->dentry->d_inode)->i_gang)
> -			goto out;
> +		goto fail;
>  	}
>  
>  	mode &= ~current_umask();

These just change coding style, and not in a helpful way.

> @@ -640,12 +626,17 @@ long spufs_create(struct path *path, struct dentry *dentry,
>  		ret = spufs_create_context(path->dentry->d_inode,
>  					    dentry, path->mnt, flags, mode,
>  					    filp);
> -	if (ret >= 0)
> +	if (ret >= 0) {
> +		/* We drop these before fsnotify */
> +		mutex_unlock(&inode->i_mutex);
> +		dput(dentry);
>  		fsnotify_mkdir(path->dentry->d_inode, dentry);
> -	return ret;
>  
> -out:
> -	mutex_unlock(&path->dentry->d_inode->i_mutex);
> +		return ret;
> +	}
> + fail:
> +	mutex_unlock(&inode->i_mutex);
> +	dput(dentry);
>  	return ret;
>  }
>  
> diff --git a/arch/powerpc/platforms/cell/spufs/syscalls.c b/arch/powerpc/platforms/cell/spufs/syscalls.c
> index 8591bb6..1a65ef2 100644
> --- a/arch/powerpc/platforms/cell/spufs/syscalls.c
> +++ b/arch/powerpc/platforms/cell/spufs/syscalls.c
> @@ -70,11 +70,8 @@ static long do_spu_create(const char __user *pathname, unsigned int flags,
>  	ret = PTR_ERR(dentry);
>  	if (!IS_ERR(dentry)) {
>  		ret = spufs_create(&path, dentry, flags, mode, neighbor);
> -		mutex_unlock(&path.dentry->d_inode->i_mutex);
> -		dput(dentry);
>  		path_put(&path);
>  	}
> -
>  	return ret;
>  }

This moves the unlock in front of the fsnotify_mkdir, where it was before Al's
change. This seems independent of the other change. 

	Arnd
