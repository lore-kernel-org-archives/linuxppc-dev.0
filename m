Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
 by ozlabs.org (Postfix) with ESMTP id 24D18B7031
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 09:38:03 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] spufs raises two exceptions
Date: Wed, 7 Mar 2012 22:32:47 +0000
References: <4F55D84B.7030306@gmail.com> <1331154095.3105.25.camel@pasglop>
 <20120307212330.GT23916@ZenIV.linux.org.uk>
In-Reply-To: <20120307212330.GT23916@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201203072232.47895.arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, masterzorag <masterzorag@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 07 March 2012, Al Viro wrote:
> > No it's not, it all goes together. spufs_create_context() always
> > unlocked & dropped the dentry before returning, so I assumed the
> > lock had to be dropped before fsnotify.
> > 
> > Note that if the problem is that the lock has to be dropped before
> > spu_forget(), then we should indeed move it back into the leaf functions
> > and just remove all the unlock path from the top ones. It's a bit nasty
> > how we drop the mutex first, then do spu_forget, then drop the dentry
> > but we could go back to doing that.
> > 
> > What I want is consistent semantics. It's just silly to have 3 different
> > stacking levels which all 3 may or may not be responsible to dropping
> > the lock & dentry depending on circumstances.
> 
> Why not leave unlock/dput to the caller?  Details of deadlocks caused
> by that approach, please...

If only I could remember that part exactly. I think I was remembering
0309f02d8 "spufs: fix deadlock in spu_create error path", which had a
double lock problem in this path. Please bear with me here because it's
been six years since I debugged that particular problem.

A lot of the nastyness of spu_forget() is about the problem of having
to give up a reference on current->mm that is held by an spu context,
while the mm contains a vma that maps this context and holds a refence
on the inode, in particular in case of calling exit().

However, I don't see now how either of these two issues requires that
we call spu_forget without the i_mutex held during a context creation
failure.

	Arnd
