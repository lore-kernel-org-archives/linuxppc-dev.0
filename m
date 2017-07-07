Return-Path: <srs0=gn1y=6k=ftp.linux.org.uk=viro@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3yyj4P5NzDr5d
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 01:22:21 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3x3yyj3lbSz8t5D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 01:22:21 +1000 (AEST)
Date: Fri, 7 Jul 2017 16:22:15 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: torvalds@linux-fondation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/fcntl: Fix F_GET/SETLK etc. for compat processes
Message-ID: <20170707152215.GE10672@ZenIV.linux.org.uk>
References: <1499431731-27058-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499431731-27058-1-git-send-email-mpe@ellerman.id.au>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 07, 2017 at 10:48:51PM +1000, Michael Ellerman wrote:
> Commit 8c6657cb50cb ("Switch flock copyin/copyout primitives to
> copy_{from,to}_user()") added copy_flock_fields(from, to), but then in all cases
> called it with arguments of (to, from). eg:
> 
>   static int get_compat_flock(struct flock *kfl, struct compat_flock __user *ufl)
>   {
>   	struct compat_flock fl;
> 
>   	if (copy_from_user(&fl, ufl, sizeof(struct compat_flock)))
>   		return -EFAULT;
>   	copy_flock_fields(*kfl, fl);
>   	return 0;
>   }
> 
> We are reading the compat_flock ufl from userspace, into flock kfl. First we
> copy all of ufl into fl on the stack, and then we want to assign each field of
> fl to kfl. So we are copying from fl and to kfl. But as written the
> copy_flock_fields() macro takes the arguments in the other order.
> 
> copy_to/from_user() take "to" as the first argument, so change the order of
> arguments in the copy_flock_fields() macro, rather than changing the callers.

D'oh...

Acked-by: Al Viro <viro@zeniv.linux.org.uk>
