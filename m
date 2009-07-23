Return-Path: <cndougla@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A42F9B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 01:16:42 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6NFBgVR003724
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2009 09:11:42 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6NFCTm8155818
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2009 09:12:29 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6NFCRT1026120
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2009 09:12:28 -0600
Message-Id: <8349EEAE-34B9-4D7E-837F-1320057E59D2@linux.vnet.ibm.com>
From: Chase Douglas <cndougla@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: [PATCH] powerpc: Add compat_sys_truncate
Date: Thu, 23 Jul 2009 11:12:26 -0400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The truncate syscall has a signed long parameter, so when using a 32- 
bit userspace with a 64-bit kernel the argument is zero-extended  
instead of sign-extended. Adding the compat_sys_truncate function  
fixes the issue.

This was noticed during an LSB truncate test failure. The test was  
checking for the correct error number set when truncate is called with  
a length of -1. The test can be found at:

http://bzr.linuxfoundation.org/lsb/devel/runtime-test?cmd=inventory;rev=stewb%40linux-foundation.org-20090626205411-sfb23cc0tjj7jzgm;path=modules/vsx-pcts/tset/POSIX.os/files/truncate/

Signed-off-by: Chase Douglas <cndougla@linux.vnet.ibm.com>

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/ 
asm/systbl.h
index 370600c..3cca167 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -95,7 +95,7 @@ SYSCALL(reboot)
SYSX(sys_ni_syscall,compat_sys_old_readdir,sys_old_readdir)
SYSCALL_SPU(mmap)
SYSCALL_SPU(munmap)
-SYSCALL_SPU(truncate)
+COMPAT_SYS_SPU(truncate)
SYSCALL_SPU(ftruncate)
SYSCALL_SPU(fchmod)
SYSCALL_SPU(fchown)
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/ 
sys_ppc32.c
index bb1cfcf..da9a65b 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -343,6 +343,12 @@ off_t ppc32_lseek(unsigned int fd, u32 offset,  
unsigned int origin)
        return sys_lseek(fd, (int)offset, origin);
}

+long compat_sys_truncate(const char __user * path, u32 length)
+{
+       /* sign extend length */
+       return sys_truncate(path, (int)length);
+}
+
/* Note: it is necessary to treat bufsiz as an unsigned int,
  * with the corresponding cast to a signed int to insure that the
  * proper conversion (sign extension) between the register  
representation of a signed int (msr in 32-bit mode)
