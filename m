Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 0DEA5DDE21
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 20:36:12 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [POWERPC] wire up sys_epoll_pwait
Date: Wed, 21 Feb 2007 10:36:01 +0100
References: <20070221153622.2aa958fa.sfr@canb.auug.org.au>
In-Reply-To: <20070221153622.2aa958fa.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702211036.01861.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 21 February 2007 05:36, Stephen Rothwell wrote:
> @@ -306,3 +306,4 @@ COMPAT_SYS_SPU(get_robust_list)
> =A0COMPAT_SYS_SPU(set_robust_list)
> =A0COMPAT_SYS(move_pages)
> =A0SYSCALL_SPU(getcpu)
> +COMPAT_SYS_SPU(epoll_pwait)

Sorry, but this is wrong. epoll_pwait manipulates the sigmask,
which is about the only thing that we can't let the SPU fiddle
with, so it should be COMPAT_SYS().

I just noticed the move_pages syscall that was added recently,
and that one should indeed be callable from an SPU.

This reminds me that I need to update the comment about what
calls are allowed from the SPU and which ones are not, since
we can now also allow optional ones like the mq_open mentioned
in the comment.

	Arnd <><
