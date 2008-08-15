Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE541DDF39
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 14:51:57 +1000 (EST)
Date: Fri, 15 Aug 2008 05:51:49 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: oops in proc_sys_compare
Message-ID: <20080815045149.GC28946@ZenIV.linux.org.uk>
References: <Pine.LNX.4.64.0808141908290.15191@blonde.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0808141908290.15191@blonde.site>
Sender: Al Viro <viro@ftp.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2008 at 07:31:06PM +0100, Hugh Dickins wrote:
> I got this oops below, after several hours of swap-heavy kernel builds
> in tmpfs, on 2.6.27-rc1-mm1 a couple of weeks ago.  Tried to reproduce
> it without success, then got a very similar trace (not saved) from
> 2.6.27-rc3 itself doing the same test yesterday: again oopsing in
> proc_sys_compare on address -16, looks like it's trying for
> PROC_I(dentry->d_inode)->sysctl but d_inode is NULL.
> 
> I looked to see what's been going on in fs/proc recently, and your
> [PATCH] sanitize proc_sysctl 9043476f726802f4b00c96d0c4f418dde48d1304
> does sound like it might be implicated.  I've only seen this on
> PowerPC G5, similar tests on x86_32 and _64 haven't shown it:
> maybe a memory barrier needed somewhere?
 
Bloody interesting.  We never create negative hashed dentries in there and
AFAICS we should never get d_delete() called on those...  Missing barrier
would mean serious trouble in dcache.c and not just for /proc/sys...

Are you sure about oops decoding?  At least disassembly of proc_sys_compare()
in the kernel image in question would be nice to see...
