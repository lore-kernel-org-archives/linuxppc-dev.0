Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CA371B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 08:23:43 +1100 (EST)
Date: Wed, 7 Mar 2012 21:23:30 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] spufs raises two exceptions
Message-ID: <20120307212330.GT23916@ZenIV.linux.org.uk>
References: <4F55D84B.7030306@gmail.com> <1331092190.3105.3.camel@pasglop>
 <1331092280.3105.5.camel@pasglop>
 <201203071248.54887.arnd@arndb.de>
 <1331154095.3105.25.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331154095.3105.25.camel@pasglop>
Sender: Al Viro <viro@ftp.linux.org.uk>
Cc: linuxppc-dev@lists.ozlabs.org, masterzorag <masterzorag@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> No it's not, it all goes together. spufs_create_context() always
> unlocked & dropped the dentry before returning, so I assumed the
> lock had to be dropped before fsnotify.
> 
> Note that if the problem is that the lock has to be dropped before
> spu_forget(), then we should indeed move it back into the leaf functions
> and just remove all the unlock path from the top ones. It's a bit nasty
> how we drop the mutex first, then do spu_forget, then drop the dentry
> but we could go back to doing that.
> 
> What I want is consistent semantics. It's just silly to have 3 different
> stacking levels which all 3 may or may not be responsible to dropping
> the lock & dentry depending on circumstances.

Why not leave unlock/dput to the caller?  Details of deadlocks caused
by that approach, please...
