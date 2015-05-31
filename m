Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 9E3A71A0CA8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:17:02 +1000 (AEST)
Message-Id: <20150531010136.329454159@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:48 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC 16/24] powerpc: Implement nvram sync ioctl
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the powerpc-specific sync() method to struct nvram_ops and implement
the corresponding ioctl in the nvram module. This allows the nvram module
to replace the generic_nvram module.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

On PPC32, the IOC_NVRAM_SYNC ioctl call always returns 0, even for those
platforms that don't implement ppc_md.nvram_sync. This patch retains
that quirk. It might be better to return failure (which is what PPC64 does).

---
 arch/powerpc/include/asm/nvram.h |    3 ---
 arch/powerpc/kernel/setup_32.c   |    6 +++---
 drivers/char/generic_nvram.c     |    2 +-
 drivers/char/nvram.c             |   38 ++++++++++++++++++++++++++++++++++++++
 include/linux/nvram.h            |    4 ++++
 5 files changed, 46 insertions(+), 7 deletions(-)

Index: linux/drivers/char/nvram.c
===================================================================
--- linux.orig/drivers/char/nvram.c	2015-05-31 11:01:13.000000000 +1000
+++ linux/drivers/char/nvram.c	2015-05-31 11:01:17.000000000 +1000
@@ -48,6 +48,11 @@
 #include <linux/mutex.h>
 
 
+#ifdef CONFIG_PPC
+#include <asm/nvram.h>
+#include <asm/machdep.h>
+#endif
+
 static DEFINE_MUTEX(nvram_mutex);
 static DEFINE_SPINLOCK(nvram_state_lock);
 static int nvram_open_cnt;	/* #times opened */
@@ -338,6 +343,36 @@ static long nvram_misc_ioctl(struct file
 	long ret = -ENOTTY;
 
 	switch (cmd) {
+#ifdef CONFIG_PPC
+#ifdef CONFIG_PPC_PMAC
+	case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
+		pr_warn("nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
+		/* fall through */
+	case IOC_NVRAM_GET_OFFSET: {
+		int part, offset;
+
+		if (!machine_is(powermac))
+			return -EINVAL;
+		if (copy_from_user(&part,
+		                   (void __user *)arg, sizeof(part)) != 0)
+			return -EFAULT;
+		if (part < pmac_nvram_OF || part > pmac_nvram_NR)
+			return -EINVAL;
+		offset = pmac_get_partition(part);
+		if (copy_to_user((void __user *)arg,
+		                 &offset, sizeof(offset)) != 0)
+			return -EFAULT;
+		ret = 0;
+		break;
+	}
+#endif
+	case IOC_NVRAM_SYNC:
+		mutex_lock(&nvram_mutex);
+		if (arch_nvram_ops.sync != NULL)
+			ret = arch_nvram_ops.sync();
+		mutex_unlock(&nvram_mutex);
+		break;
+#else /* !CONFIG_PPC */
 	case NVRAM_INIT:
 		/* initialize NVRAM contents and checksum */
 		if (!capable(CAP_SYS_ADMIN))
@@ -359,6 +394,7 @@ static long nvram_misc_ioctl(struct file
 			ret = arch_nvram_ops.set_checksum();
 		mutex_unlock(&nvram_mutex);
 		break;
+#endif /* CONFIG_PPC */
 	}
 	return ret;
 }
@@ -374,6 +410,7 @@ static int nvram_misc_open(struct inode
 		return -EBUSY;
 	}
 
+#ifndef CONFIG_PPC
 	/* Prevent multiple writers if the set_checksum ioctl is implemented. */
 	if ((arch_nvram_ops.set_checksum != NULL) &&
 	    (file->f_mode & FMODE_WRITE) &&
@@ -381,6 +418,7 @@ static int nvram_misc_open(struct inode
 		spin_unlock(&nvram_state_lock);
 		return -EBUSY;
 	}
+#endif
 
 	if (file->f_flags & O_EXCL)
 		nvram_open_mode |= NVRAM_EXCL;
Index: linux/include/linux/nvram.h
===================================================================
--- linux.orig/include/linux/nvram.h	2015-05-31 11:01:08.000000000 +1000
+++ linux/include/linux/nvram.h	2015-05-31 11:01:17.000000000 +1000
@@ -17,8 +17,12 @@ struct nvram_ops {
 	unsigned char   (*read_byte)(int);
 	void            (*write_byte)(unsigned char, int);
 	ssize_t         (*get_size)(void);
+#ifdef CONFIG_PPC
+	long            (*sync)(void);
+#else
 	long            (*set_checksum)(void);
 	long            (*initialize)(void);
+#endif
 };
 
 extern const struct nvram_ops arch_nvram_ops;
Index: linux/arch/powerpc/include/asm/nvram.h
===================================================================
--- linux.orig/arch/powerpc/include/asm/nvram.h	2015-05-31 11:01:16.000000000 +1000
+++ linux/arch/powerpc/include/asm/nvram.h	2015-05-31 11:01:17.000000000 +1000
@@ -78,9 +78,6 @@ extern int	pmac_get_partition(int partit
 extern u8	pmac_xpram_read(int xpaddr);
 extern void	pmac_xpram_write(int xpaddr, u8 data);
 
-/* Synchronize NVRAM */
-extern void	nvram_sync(void);
-
 /* Initialize NVRAM OS partition */
 extern int __init nvram_init_os_partition(struct nvram_os_partition *part);
 
Index: linux/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux.orig/arch/powerpc/kernel/setup_32.c	2015-05-31 11:01:16.000000000 +1000
+++ linux/arch/powerpc/kernel/setup_32.c	2015-05-31 11:01:17.000000000 +1000
@@ -170,7 +170,6 @@ __setup("l3cr=", ppc_setup_l3cr);
 
 #ifdef CONFIG_GENERIC_NVRAM
 
-/* Generic nvram hooks used by drivers/char/gen_nvram.c */
 unsigned char nvram_read_byte(int addr)
 {
 	if (ppc_md.nvram_read_val)
@@ -193,15 +192,16 @@ static ssize_t ppc_nvram_get_size(void)
 	return -ENODEV;
 }
 
-void nvram_sync(void)
+static long ppc_nvram_sync(void)
 {
 	if (ppc_md.nvram_sync)
 		ppc_md.nvram_sync();
+	return 0;
 }
-EXPORT_SYMBOL(nvram_sync);
 
 const struct nvram_ops arch_nvram_ops = {
 	.get_size       = ppc_nvram_get_size,
+	.sync           = ppc_nvram_sync,
 };
 EXPORT_SYMBOL(arch_nvram_ops);
 
Index: linux/drivers/char/generic_nvram.c
===================================================================
--- linux.orig/drivers/char/generic_nvram.c	2015-05-31 11:01:16.000000000 +1000
+++ linux/drivers/char/generic_nvram.c	2015-05-31 11:01:17.000000000 +1000
@@ -112,7 +112,7 @@ static int nvram_ioctl(struct file *file
 	}
 #endif /* CONFIG_PPC_PMAC */
 	case IOC_NVRAM_SYNC:
-		nvram_sync();
+		arch_nvram_ops.sync();
 		break;
 	default:
 		return -EINVAL;
