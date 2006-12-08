Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Patch] Add necessary #includes to asm-powerpc/spu.h
Date: Fri, 8 Dec 2006 18:54:12 +0100
References: <45799CA2.2090407@us.ibm.com>
In-Reply-To: <45799CA2.2090407@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200612081854.13200.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 08 December 2006 18:10, Maynard Johnson wrote:
>  #define _SPU_H
>  #ifdef __KERNEL__
>  
> +#include <linux/fs.h>
> +#include <linux/notifier.h>
>  #include <linux/workqueue.h>
>  #include <linux/sysdev.h>
>  
Thanks for pointing this out. I'm fixing this in a different way though,
with by adding forward-declarations of the structures to spu.h in order
to avoid making the include hierarchy worse. I'll submit that in a clean
patch along with my next batch of fixes.

	Arnd <><
 
--- a/include/asm-powerpc/spu.h
+++ b/include/asm-powerpc/spu.h
@@ -161,6 +161,7 @@ struct spu_syscall_block {
 extern long spu_sys_callback(struct spu_syscall_block *s);
 
 /* syscalls implemented in spufs */
+struct file;
 extern struct spufs_calls {
 	asmlinkage long (*create_thread)(const char __user *name,
 					unsigned int flags, mode_t mode);
@@ -232,6 +233,7 @@ void spu_remove_sysdev_attr_group(struct
  * to object-id spufs file from user space and the notifer
  * function can assume that spu->ctx is valid.
  */
+struct notifier_block;
 int spu_switch_event_register(struct notifier_block * n);
 int spu_switch_event_unregister(struct notifier_block * n);
 
