Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 45636DDEFC
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Aug 2008 03:57:33 +1000 (EST)
Date: Sat, 16 Aug 2008 19:57:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATHC] powerpc: use generic compat_sys_old_readdir
Message-ID: <20080816175730.GA5233@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use the generic compat_sys_old_readdir instead of the powerpc one which
is almost the same except for the almost complete lack of error
handling.

Note that we can't just use SYSCALL() in systbl.h because the native
syscalls is named old_readdir, not sys_old_readdir or just sys_readdir
beeing the only one.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/include/asm/systbl.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/systbl.h	2008-08-16 13:08:35.000000000 -0300
+++ linux-2.6/arch/powerpc/include/asm/systbl.h	2008-08-16 13:14:37.000000000 -0300
@@ -92,7 +92,7 @@ COMPAT_SYS_SPU(readlink)
 SYSCALL(uselib)
 SYSCALL(swapon)
 SYSCALL(reboot)
-SYSX(sys_ni_syscall,old32_readdir,old_readdir)
+SYSX(sys_ni_syscall,compat_sys_old_readdir,old_readdir)
 SYSCALL_SPU(mmap)
 SYSCALL_SPU(munmap)
 SYSCALL_SPU(truncate)
Index: linux-2.6/arch/powerpc/kernel/sys_ppc32.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/sys_ppc32.c	2008-08-16 13:07:16.000000000 -0300
+++ linux-2.6/arch/powerpc/kernel/sys_ppc32.c	2008-08-16 13:09:22.000000000 -0300
@@ -52,63 +52,6 @@
 #include <asm/ppc-pci.h>
 #include <asm/syscalls.h>
 
-struct old_linux_dirent32 {
-	u32		d_ino;
-	u32		d_offset;
-	unsigned short	d_namlen;
-	char		d_name[1];
-};
-
-struct readdir_callback32 {
-	struct old_linux_dirent32 __user * dirent;
-	int count;
-};
-
-static int fillonedir(void * __buf, const char * name, int namlen,
-		                  off_t offset, u64 ino, unsigned int d_type)
-{
-	struct readdir_callback32 * buf = (struct readdir_callback32 *) __buf;
-	struct old_linux_dirent32 __user * dirent;
-	ino_t d_ino;
-
-	if (buf->count)
-		return -EINVAL;
-	d_ino = ino;
-	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino)
-		return -EOVERFLOW;
-	buf->count++;
-	dirent = buf->dirent;
-	put_user(d_ino, &dirent->d_ino);
-	put_user(offset, &dirent->d_offset);
-	put_user(namlen, &dirent->d_namlen);
-	copy_to_user(dirent->d_name, name, namlen);
-	put_user(0, dirent->d_name + namlen);
-	return 0;
-}
-
-asmlinkage int old32_readdir(unsigned int fd, struct old_linux_dirent32 __user *dirent, unsigned int count)
-{
-	int error = -EBADF;
-	struct file * file;
-	struct readdir_callback32 buf;
-
-	file = fget(fd);
-	if (!file)
-		goto out;
-
-	buf.count = 0;
-	buf.dirent = dirent;
-
-	error = vfs_readdir(file, (filldir_t)fillonedir, &buf);
-	if (error < 0)
-		goto out_putf;
-	error = buf.count;
-
-out_putf:
-	fput(file);
-out:
-	return error;
-}
 
 asmlinkage long ppc32_select(u32 n, compat_ulong_t __user *inp,
 		compat_ulong_t __user *outp, compat_ulong_t __user *exp,
