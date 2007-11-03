Return-Path: <patmans@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 420F4DDDFE
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 04:42:21 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA3HhdYu010103
	for <linuxppc-dev@ozlabs.org>; Sat, 3 Nov 2007 13:43:39 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA3Hg43H136912
	for <linuxppc-dev@ozlabs.org>; Sat, 3 Nov 2007 13:42:04 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA3Hg44n028563
	for <linuxppc-dev@ozlabs.org>; Sat, 3 Nov 2007 13:42:04 -0400
Date: Sat, 3 Nov 2007 10:42:03 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, anton@samba.org
Subject: [PATCH] change fallocate to match unistd.h on powerpc
Message-ID: <20071103174203.GA25823@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix the fallocate system call on powerpc to match its unistd.h.

This implies none of these system calls are currently working with the
unistd.h sys call values:
	fallocate
	signalfd
	timerfd 
	eventfd 
	sync_file_range2

Signed-off-by: Patrick Mansfield <patmans@us.ibm.com>
Acked-by: Anton Blanchard <anton@samba.org>

diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index cc6d872..11d5383 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -308,8 +308,8 @@ COMPAT_SYS_SPU(move_pages)
 SYSCALL_SPU(getcpu)
 COMPAT_SYS(epoll_pwait)
 COMPAT_SYS_SPU(utimensat)
-COMPAT_SYS(fallocate)
 COMPAT_SYS_SPU(signalfd)
 COMPAT_SYS_SPU(timerfd)
 SYSCALL_SPU(eventfd)
 COMPAT_SYS_SPU(sync_file_range2)
+COMPAT_SYS(fallocate)

-- Patrick Mansfield
