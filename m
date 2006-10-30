Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E91CB67D0C
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 16:29:55 +1100 (EST)
Subject: Re: [PATCH 2/3] Create compat_sys_migrate_pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <clameter@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0610270622480.7342@schroedinger.engr.sgi.com>
References: <20061026132659.2ff90dd1.sfr@canb.auug.org.au>
	<20061026133305.b0db54e6.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0610261158130.2802@schroedinger.engr.sgi.com>
	<20061027102834.5db261af.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0610270622480.7342@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 16:29:09 +1100
Message-Id: <1162186149.25682.171.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>,
	ak@suse.de, LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-27 at 06:24 -0700, Christoph Lameter wrote:
> On Fri, 27 Oct 2006, Stephen Rothwell wrote:
> 
> > No they aren't because they have compat routines that convert the bitmaps
> > before calling the "normal" syscall.  They, importantly, only use
> > compat_alloc_user_space once each.
> 
> Ah...
> 
> > > Fixing get_nodes() to do the proper thing would fix all of these
> > > without having to touch sys_migrate_pages or creating a compat_ function
> > > (which usually is placed in kernel/compat.c)
> > 
> > You need the compat_ version of the syscalls to know if you were called
> > from a 32bit application in order to know if you may need to fixup the
> > bitmaps that are passed from/to user mode.
> 
> The compat functions should be placed in kernel/compat.c next to 
> compat_sys_move_pages.

I disagree.. it's really annoying when they are away from their
respective "non-compat" function, especially when they are more than
just wrappers copying/converting arguments...

Now, if only we had done a sane ABI in the first place...
 
Ben.
