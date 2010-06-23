Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A9FA8B7755
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:33 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA0iDk022187
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:00:44 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4XDq1429536
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:33 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA4VHW028254
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:33 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 29/40] trace syscalls,
	PPC: Convert ppc32_ syscalls to ARCH_COMPAT_SYSCALL_DEFINE
Date: Wed, 23 Jun 2010 20:03:10 +1000
Message-Id: <1277287401-28571-30-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
Cc: Chase Douglas <cndougla@linux.vnet.ibm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ian Munsie <imunsie@au1.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch renames the 32bit compat syscalls prefixed with ppc32_ to
sys32_ and uses the ARCH_COMPAT_SYSCALL_DEFINE macros to record their
metadata for tracing.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/include/asm/systbl.h |    4 ++--
 arch/powerpc/kernel/sys_ppc32.c   |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 228eecb..bbcc700 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -236,9 +236,9 @@ COMPAT_SYS_SPU(io_getevents)
 COMPAT_SYS_SPU(io_submit)
 SYSCALL_SPU(io_cancel)
 SYSCALL(set_tid_address)
-SYSX_SPU(sys_fadvise64,ppc32_fadvise64,sys_fadvise64)
+SYSX_SPU(sys_fadvise64,sys32_fadvise64,sys_fadvise64)
 SYSCALL(exit_group)
-SYSX(sys_lookup_dcookie,ppc32_lookup_dcookie,sys_lookup_dcookie)
+SYSX(sys_lookup_dcookie,sys32_lookup_dcookie,sys_lookup_dcookie)
 SYSCALL_SPU(epoll_create)
 SYSCALL_SPU(epoll_ctl)
 SYSCALL_SPU(epoll_wait)
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 27cf460..cf18164 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -594,15 +594,15 @@ asmlinkage int compat_sys_ftruncate64(unsigned int fd, u32 reg4, unsigned long h
 	return sys_ftruncate(fd, (high << 32) | low);
 }
 
-long ppc32_lookup_dcookie(u32 cookie_high, u32 cookie_low, char __user *buf,
-			  size_t len)
+ARCH_COMPAT_SYSCALL_DEFINE4(lookup_dcookie, u32, cookie_high, u32, cookie_low,
+		char __user *, buf, size_t, len)
 {
 	return sys_lookup_dcookie((u64)cookie_high << 32 | cookie_low,
 				  buf, len);
 }
 
-long ppc32_fadvise64(int fd, u32 unused, u32 offset_high, u32 offset_low,
-		     size_t len, int advice)
+ARCH_COMPAT_SYSCALL_DEFINE6(fadvise64, int, fd, u32, unused, u32, offset_high,
+		u32, offset_low, size_t, len, int, advice)
 {
 	return sys_fadvise64(fd, (u64)offset_high << 32 | offset_low, len,
 			     advice);
-- 
1.7.1
