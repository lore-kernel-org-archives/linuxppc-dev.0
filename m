Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB402B6F29
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 00:25:30 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nANDKiac021516
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2009 06:20:44 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nANDPK9u184538
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2009 06:25:21 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nAN7IFlu017498
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2009 00:18:15 -0700
Date: Mon, 23 Nov 2009 08:25:06 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [RESEND] [PATCH] Fix wrong error code from ppc32 select syscall
Message-ID: <20091123132506.GT30489@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>

This patch was submitted, discussed, and eventually Acked by everyone, yet
still isn't in the tree.  See:

http://patchwork.ozlabs.org/patch/1240/

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Arnd Bergmann <arnd@anrdb.de>
Cc: Paul Mackerras <paulus@samba.org>

---

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl
index c7d671a..07d2d19 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -145,7 +145,7 @@ SYSCALL_SPU(setfsuid)
 SYSCALL_SPU(setfsgid)
 SYSCALL_SPU(llseek)
 COMPAT_SYS_SPU(getdents)
-SYSX_SPU(sys_select,ppc32_select,ppc_select)
+SYSX_SPU(sys_select,ppc32_select,sys_select)
 SYSCALL_SPU(flock)
 SYSCALL_SPU(msync)
 COMPAT_SYS_SPU(readv)
