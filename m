Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02E9CDDF38
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 21:13:20 +1100 (EST)
Date: Thu, 13 Mar 2008 11:12:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ppc: Export empty_zero_page
Message-ID: <20080313101248.GA4297@lst.de>
References: <E1JZGwo-0000vf-2v@closure.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1JZGwo-0000vf-2v@closure.thunk.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 11, 2008 at 10:44:06PM -0400, Theodore Ts'o wrote:
> Stephen Rothwell discovered this issue in the linux-next tree:
> 
> >Today's powerpc allmodconfig build of linux-next failed with:
> >
> >ERROR: "empty_zero_page" [fs/ext4/ext4dev.ko] undefined!
> >
> >This is because commit dde5f2130096f8469eb1aa1ad250cd2a39fee3f5 ("ext4:
> >ENOSPC error handling for writing to an uninitialized extent") uses
> >ZERO_PAGE() which on powerpc uses empty_zero_page which is not
> >EXPORT_SYMBOLed on powerpc.  I have reverted that commit and a later
> >one (1ae53f35fea49a9013353078e019469551d2ad74 "ext4: zero out
> >small extents when writing to prealloc area.") which depended on it.
> 
> Any chance you could get this pushed to Linus ASAP?  It would be nice if
> this could get pushed before the merge window, since it could be argued
> that rationalizing whether or not empty_zero_page is exported is a bug
> fix, and anyway this is pretty much a zero-risk patch.  Thanks!!

The real fix is that ext4 shouldn't be using ZERO_PAGE().  Please use
the same zeroing helpers all the other filesystems and drivers use.
