Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id 109F667D2B
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 23:24:55 +1000 (EST)
Date: Fri, 27 Oct 2006 06:24:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3] Create compat_sys_migrate_pages
In-Reply-To: <20061027102834.5db261af.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0610270622480.7342@schroedinger.engr.sgi.com>
References: <20061026132659.2ff90dd1.sfr@canb.auug.org.au>
	<20061026133305.b0db54e6.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0610261158130.2802@schroedinger.engr.sgi.com>
	<20061027102834.5db261af.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: linux-mm@kvack.org, ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	LKML <linux-kernel@vger.kernel.org>, ak@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 27 Oct 2006, Stephen Rothwell wrote:

> No they aren't because they have compat routines that convert the bitmaps
> before calling the "normal" syscall.  They, importantly, only use
> compat_alloc_user_space once each.

Ah...

> > Fixing get_nodes() to do the proper thing would fix all of these
> > without having to touch sys_migrate_pages or creating a compat_ function
> > (which usually is placed in kernel/compat.c)
> 
> You need the compat_ version of the syscalls to know if you were called
> from a 32bit application in order to know if you may need to fixup the
> bitmaps that are passed from/to user mode.

The compat functions should be placed in kernel/compat.c next to 
compat_sys_move_pages.
