Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C9426DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 13:16:34 +1100 (EST)
Date: Thu, 3 Jan 2008 13:16:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Clifford Wolf <clifford@clifford.at>
Subject: Re: [patch] powerpc systbl.h broken
Message-Id: <20080103131624.5a3e98e8.sfr@canb.auug.org.au>
In-Reply-To: <20080102141127.GA11870@clifford.at>
References: <20080102141127.GA11870@clifford.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Clifford,

Thanks for the report.

PowerPC problems should be reported to linuxppc-dev@ozlabs.org.

This has been fixed in the current (approaching 2.6.24) kernel.  It
should be fixed in 2.6.23.xx, so I have cc'd this to
stable@vger.kernel.org (and linuxppc-dev, of course).

(Also, please post patches inline, don't attach them.  And you need to
reply to this with a Signed-off-by: line.)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
------------------------------------------------------------------------
From:	Clifford Wolf <clifford@clifford.at>

Hi,

In current 2.6.23 (I have checked 2.6.23.12 and 2.6.23.9) the end of
include/asm-powerpc/systbl.h reads:

--snip--
SYSCALL_SPU(getcpu)
COMPAT_SYS(epoll_pwait)
COMPAT_SYS_SPU(utimensat)
COMPAT_SYS(fallocate)
COMPAT_SYS_SPU(signalfd)
COMPAT_SYS_SPU(timerfd)
SYSCALL_SPU(eventfd)
COMPAT_SYS_SPU(sync_file_range2)
--snap--

This obviously does not match the definitions in asm-powerpc/unistd.h:

--snip--
#define __NR_getcpu		302
#define __NR_epoll_pwait	303
#define __NR_utimensat		304
#define __NR_signalfd		305
#define __NR_timerfd		306
#define __NR_eventfd		307
#define __NR_sync_file_range2	308
#define __NR_fallocate		309
--snap--

which breaks the system calls 305 to 309 inclusive.

--- linux-2.6.23.12/include/asm-powerpc/systbl.h.orig	2008-01-02 15:09:04.000000000 +0100
+++ linux-2.6.23.12/include/asm-powerpc/systbl.h	2008-01-02 15:09:29.000000000 +0100
@@ -308,8 +308,8 @@
 SYSCALL_SPU(getcpu)
 COMPAT_SYS(epoll_pwait)
 COMPAT_SYS_SPU(utimensat)
-COMPAT_SYS(fallocate)
 COMPAT_SYS_SPU(signalfd)
 COMPAT_SYS_SPU(timerfd)
 SYSCALL_SPU(eventfd)
 COMPAT_SYS_SPU(sync_file_range2)
+COMPAT_SYS(fallocate)
