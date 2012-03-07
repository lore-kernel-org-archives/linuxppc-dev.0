Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AA2CEB6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 08:01:47 +1100 (EST)
Message-ID: <1331154095.3105.25.camel@pasglop>
Subject: Re: [PATCH] spufs raises two exceptions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 08 Mar 2012 08:01:35 +1100
In-Reply-To: <201203071248.54887.arnd@arndb.de>
References: <4F55D84B.7030306@gmail.com> <1331092190.3105.3.camel@pasglop>
 <1331092280.3105.5.camel@pasglop> <201203071248.54887.arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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


> > diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
> > index d4a094c..63b4e43 100644
> > --- a/arch/powerpc/platforms/cell/spufs/inode.c
> > +++ b/arch/powerpc/platforms/cell/spufs/inode.c
> > @@ -454,19 +454,16 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
> >  	struct spu_gang *gang;
> >  	struct spu_context *neighbor;
> >  
> > -	ret = -EPERM;
> >  	if ((flags & SPU_CREATE_NOSCHED) &&
> > -	    !capable(CAP_SYS_NICE))
> > -		goto out_unlock;
> > +	    !capable(CAP_SYa_NICE))
> 
>                     ^typo

Odd, probably an emacs fart

> > +		return -EPERM;
> >  
> > -	ret = -EINVAL;
> >  	if ((flags & (SPU_CREATE_NOSCHED | SPU_CREATE_ISOLATE))
> >  	    == SPU_CREATE_ISOLATE)
> > -		goto out_unlock;
> > +		return -EINVAL;
> >  
> > -	ret = -ENODEV;
> >  	if ((flags & SPU_CREATE_ISOLATE) && !isolated_loader)
> > -		goto out_unlock;
> > +		return -ENODEV;
> >  
> >  	gang = NULL;
> >  	neighbor = NULL;
> 
> This mostly changes coding style, pointlessly.

How so ? it's no longer necessary to store ret and goto out since there
is no cleanup at all, which makes things smaller/simpler. I wouldn't
call that 'pointlessly'.

I tend to dislike the use of "goto xxxx" when the xxx: label does no
cleanup whatsoever.

> > @@ -512,10 +509,6 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
> >  out_aff_unlock:
> >  	if (affinity)
> >  		mutex_unlock(&gang->aff_mutex);
> > -out_unlock:
> > -	mutex_unlock(&inode->i_mutex);
> > -out:
> > -	dput(dentry);
> >  	return ret;
> >  }
> 
> The original intention of this was to always unlock in the error case. It
> seems that Al changed this in 1ba10681 "switch do_spufs_create() to
> user_path_create(), fix double-unlock" to never unlock early but always
> unlock in do_spu_create, fixing a different bug, but it looks like
> he forgot this one in the process.
> 
> The reason why we originally had the unlock in the leaf functions is to
> avoid a problem with spu_forget(), which had to be called without
> the i_mutex held to avoid deadlocks.

Ok. I assumed it was fnotify that was the problem...

> > @@ -600,10 +591,6 @@ static int spufs_create_gang(struct inode *inode,
> >  		int err = simple_rmdir(inode, dentry);
> >  		WARN_ON(err);
> >  	}
> > -
> > -out:
> > -	mutex_unlock(&inode->i_mutex);
> > -	dput(dentry);
> >  	return ret;
> >  }
> 
> Right, this obviously goes together with the one above,

Yes, whatever they do they should do the same thing.

> > @@ -613,22 +600,21 @@ static struct file_system_type spufs_type;
> >  long spufs_create(struct path *path, struct dentry *dentry
> >  		unsigned int flags, umode_t mode, struct file *filp)
> >  {
> > -	int ret;
> > +	int ret = -EINVAL;
> >  
> > -	ret = -EINVAL;
> >  	/* check if we are on spufs */
> >  	if (path->dentry->d_sb->s_type != &spufs_type)
> > -		goto out;
> > +		goto fail;
> >  
> >  	/* don't accept undefined flags */
> >  	if (flags & (~SPU_CREATE_FLAG_ALL))
> > -		goto out;
> > +		goto fail;
> >  
> >  	/* only threads can be underneath a gang */
> >  	if (path->dentry != path->dentry->d_sb->s_root) {
> >  		if ((flags & SPU_CREATE_GANG) ||
> >  		    !SPUFS_I(path->dentry->d_inode)->i_gang)
> > -			goto out;
> > +		goto fail;
> >  	}
> >  
> >  	mode &= ~current_umask();
> 
> These just change coding style, and not in a helpful way.

Oh I just renamed the label, it's helpful because the label is
specifically only for the fail case, not the general exit path, hence
"fail" is a better naming than "out". It's about code clarity.

> > @@ -640,12 +626,17 @@ long spufs_create(struct path *path, struct dentry *dentry,
> >  		ret = spufs_create_context(path->dentry->d_inode,
> >  					    dentry, path->mnt, flags, mode,
> >  					    filp);
> > -	if (ret >= 0)
> > +	if (ret >= 0) {
> > +		/* We drop these before fsnotify */
> > +		mutex_unlock(&inode->i_mutex);
> > +		dput(dentry);
> >  		fsnotify_mkdir(path->dentry->d_inode, dentry);
> > -	return ret;
> >  
> > -out:
> > -	mutex_unlock(&path->dentry->d_inode->i_mutex);
> > +		return ret;
> > +	}
> > + fail:
> > +	mutex_unlock(&inode->i_mutex);
> > +	dput(dentry);
> >  	return ret;
> >  }
> >  
> > diff --git a/arch/powerpc/platforms/cell/spufs/syscalls.c b/arch/powerpc/platforms/cell/spufs/syscalls.c
> > index 8591bb6..1a65ef2 100644
> > --- a/arch/powerpc/platforms/cell/spufs/syscalls.c
> > +++ b/arch/powerpc/platforms/cell/spufs/syscalls.c
> > @@ -70,11 +70,8 @@ static long do_spu_create(const char __user *pathname, unsigned int flags,
> >  	ret = PTR_ERR(dentry);
> >  	if (!IS_ERR(dentry)) {
> >  		ret = spufs_create(&path, dentry, flags, mode, neighbor);
> > -		mutex_unlock(&path.dentry->d_inode->i_mutex);
> > -		dput(dentry);
> >  		path_put(&path);
> >  	}
> > -
> >  	return ret;
> >  }
> 
> This moves the unlock in front of the fsnotify_mkdir, where it was before Al's
> change. This seems independent of the other change. 

No it's not, it all goes together. spufs_create_context() always
unlocked & dropped the dentry before returning, so I assumed the
lock had to be dropped before fsnotify.

Note that if the problem is that the lock has to be dropped before
spu_forget(), then we should indeed move it back into the leaf functions
and just remove all the unlock path from the top ones. It's a bit nasty
how we drop the mutex first, then do spu_forget, then drop the dentry
but we could go back to doing that.

What I want is consistent semantics. It's just silly to have 3 different
stacking levels which all 3 may or may not be responsible to dropping
the lock & dentry depending on circumstances.

In any case, what about this instead then:

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index d4a094c..114ab14 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -646,6 +646,7 @@ long spufs_create(struct path *path, struct dentry *dentry,
 
 out:
 	mutex_unlock(&path->dentry->d_inode->i_mutex);
+	dput(dentry);
 	return ret;
 }
 
diff --git a/arch/powerpc/platforms/cell/spufs/syscalls.c b/arch/powerpc/platforms/cell/spufs/syscalls.c
index 8591bb6..5665dcc 100644
--- a/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ b/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -70,8 +70,6 @@ static long do_spu_create(const char __user *pathname, unsigned int flags,
 	ret = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		ret = spufs_create(&path, dentry, flags, mode, neighbor);
-		mutex_unlock(&path.dentry->d_inode->i_mutex);
-		dput(dentry);
 		path_put(&path);
 	}
 
Cheers,
Ben.
