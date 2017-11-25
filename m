Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ykqBv0BNlzDqyH
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Nov 2017 10:33:56 +1100 (AEDT)
Received: from [192.168.1.134] (ppp-188-174-95-49.dynamic.mnet-online.de
 [188.174.95.49]) by smtp.strato.de (RZmta 42.9 DYNA|AUTH)
 with ESMTPSA id m08e38tAPNXmoMV
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Sun, 26 Nov 2017 00:33:48 +0100 (CET)
Subject: Qoriq P5020 PowerPC board doesn't boot with the latest git version
 anymore
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: linuxppc-dev@lists.ozlabs.org
References: <ce2c842f-df48-6763-4626-adead5606acc@xenosoft.de>
 <3e4805a4-6114-205d-653b-ea6cd7fdc057@xenosoft.de>
 <8ed2edc7-a14b-35b3-86c1-a9995f41df84@xenosoft.de>
 <d8bf23c2-1805-a9c3-566d-74c0f28e88e8@xenosoft.de>
Message-ID: <ab5f9c39-e801-0c6c-15fb-c5b782ab10b7@xenosoft.de>
Date: Sun, 26 Nov 2017 00:33:48 +0100
MIME-Version: 1.0
In-Reply-To: <d8bf23c2-1805-a9c3-566d-74c0f28e88e8@xenosoft.de>
Content-Type: multipart/mixed; boundary="------------5EE2804635FC960AE405758A"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------5EE2804635FC960AE405758A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I compiled the latest git kernel today. Unfortunately my Varisys Cyrus 
Plus board still doesn't boot with the latest git kernel.

After that I patched the kernel source code with the spinlock patch and 
compiled the kernel again. With the spinlock patch, the latest git 
kernel boots without any problems.

Please find attached the spinlock patch.

Cheers,
Christian


On 20 November 2017 at 00:34AM, Christian Zigotzky wrote:
> Hi All,
>
> I created a patch for the git kernel today. (see attachment)
> Without the patch, the latest git kernel doesn't boot on my Cyrus Plus 
> board.
>
> Cheers,
> Christian
>
>
> On 19 November 2017 at 5:57PM, Christian Zigotzky wrote:
>> Hi All,
>>
>> A little success. :-) I reverted the following files from the bad 
>> commit a8a217c22116eff6c120d753c9934089fb229af0 [1]:
>>
>> arch/powerpc/include/asm/spinlock.h
>> kernel/locking/spinlock.c
>> include/linux/spinlock_up.h
>> include/linux/spinlock.h
>> include/linux/rwlock.h
>>
>> After that I compiled the latest git kernel again. Then I was able to 
>> boot the latest git kernel on my Varisys Cyrus Plus board [2][3]. :-)
>>
>> That means the bug is in one of these files.
>>
>> Please help me to find the bug in these files above.
>>
>> Thanks,
>> Christian
>>
>>
>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a8a217c22116eff6c120d753c9934089fb229af0
>> [2] http://www.amigaos.net/hardware/133/amigaone-x5000
>> [3] http://wiki.amiga.org/index.php?title=AmigaONE_X5000
>>
>


--------------5EE2804635FC960AE405758A
Content-Type: text/x-patch;
 name="spinlock_4.15-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="spinlock_4.15-1.patch"

--- a/arch/powerpc/include/asm/spinlock.h	2017-11-18 20:57:47.921703650 +0100
+++ b/arch/powerpc/include/asm/spinlock.h	2017-11-19 18:51:51.630906446 +0100
@@ -182,6 +182,9 @@ static inline void arch_spin_unlock(arch
  * read-locks.
  */
 
+#define arch_read_can_lock(rw)		((rw)->lock >= 0)
+#define arch_write_can_lock(rw)	(!(rw)->lock)
+
 #ifdef CONFIG_PPC64
 #define __DO_SIGN_EXTEND	"extsw	%0,%0\n"
 #define WRLOCK_TOKEN		LOCK_TOKEN	/* it's negative */
--- a/kernel/locking/spinlock.c	2017-11-18 20:57:48.974708915 +0100
+++ b/kernel/locking/spinlock.c	2017-11-19 18:26:18.526892449 +0100
@@ -35,6 +35,9 @@
  */
 #else
 
+#define raw_read_can_lock(l)	read_can_lock(l)
+#define raw_write_can_lock(l)	write_can_lock(l)
+
 /*
  * Some architectures can relax in favour of the CPU owning the lock.
  */
@@ -68,7 +71,7 @@ void __lockfunc __raw_##op##_lock(lockty
 									\
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
-		while ((lock)->break_lock)				\
+		while (!raw_##op##_can_lock(lock) && (lock)->break_lock)\	
 			arch_##op##_relax(&lock->raw_lock);		\
 	}								\
 	(lock)->break_lock = 0;						\
@@ -88,7 +91,7 @@ unsigned long __lockfunc __raw_##op##_lo
 									\
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
-		while ((lock)->break_lock)				\
+		while (!raw_##op##_can_lock(lock) && (lock)->break_lock)\	
 			arch_##op##_relax(&lock->raw_lock);		\
 	}								\
 	(lock)->break_lock = 0;						\
--- a/include/linux/spinlock_up.h	2017-11-18 20:57:38.788657985 +0100
+++ b/include/linux/spinlock_up.h	2017-11-19 18:48:19.787635450 +0100
@@ -69,4 +69,7 @@ static inline void arch_spin_unlock(arch
 
 #define arch_spin_is_contended(lock)	(((void)(lock), 0))
 
+#define arch_read_can_lock(lock)	(((void)(lock), 1))
+#define arch_write_can_lock(lock)	(((void)(lock), 1))
+
 #endif /* __LINUX_SPINLOCK_UP_H */
--- a/include/linux/spinlock.h	2017-11-18 20:57:38.693657510 +0100
+++ b/include/linux/spinlock.h	2017-11-19 18:37:36.933284464 +0100
@@ -283,6 +283,12 @@ static inline void do_raw_spin_unlock(ra
 	1 : ({ local_irq_restore(flags); 0; }); \
 })
 
+/**
+ * raw_spin_can_lock - would raw_spin_trylock() succeed?
+ * @lock: the spinlock in question.
+ */
+#define raw_spin_can_lock(lock)	(!raw_spin_is_locked(lock))
+
 /* Include rwlock functions */
 #include <linux/rwlock.h>
 
@@ -395,6 +401,11 @@ static __always_inline int spin_is_conte
 	return raw_spin_is_contended(&lock->rlock);
 }
 
+static __always_inline int spin_can_lock(spinlock_t *lock)
+{
+	return raw_spin_can_lock(&lock->rlock);
+}
+
 #define assert_spin_locked(lock)	assert_raw_spin_locked(&(lock)->rlock)
 
 /*
--- a/include/linux/rwlock.h	2017-11-18 20:57:38.652657305 +0100
+++ b/include/linux/rwlock.h	2017-11-19 18:19:54.045970054 +0100
@@ -59,6 +59,9 @@ do {								\
 # define do_raw_write_unlock(rwlock)	do {arch_write_unlock(&(rwlock)->raw_lock); __release(lock); } while (0)
 #endif
 
+#define read_can_lock(rwlock)		arch_read_can_lock(&(rwlock)->raw_lock)
+#define write_can_lock(rwlock)		arch_write_can_lock(&(rwlock)->raw_lock)
+
 /*
  * Define the various rw_lock methods.  Note we define these
  * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various

--------------5EE2804635FC960AE405758A--
