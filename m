Return-Path: <takuya.yoshikawa@gmail.com>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id B0C67B7D2E
	for <linuxppc-dev@ozlabs.org>; Tue,  4 May 2010 23:02:49 +1000 (EST)
Received: by pvc7 with SMTP id 7so893140pvc.15
	for <linuxppc-dev@ozlabs.org>; Tue, 04 May 2010 06:02:48 -0700 (PDT)
Date: Tue, 4 May 2010 22:02:47 +0900
From: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
To: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Subject: [RFC][PATCH 5/12] x86: introduce __set_bit() like function for
	bitmaps in user space
Message-Id: <20100504220247.2e97ac01.takuya.yoshikawa@gmail.com>
In-Reply-To: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, x86@kernel.org, arnd@arndb.de,
	kvm@vger.kernel.org, kvm-ia64@vger.kernel.org,
	fernando@oss.ntt.co.jp, mtosatti@redhat.com, agraf@suse.de,
	kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
	yoshikawa.takuya@oss.ntt.co.jp, linuxppc-dev@ozlabs.org,
	mingo@redhat.com, paulus@samba.org, avi@redhat.com,
	hpa@zytor.com, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During the work of KVM's dirty page logging optimization, we encountered
the need of manipulating bitmaps in user space efficiantly. To achive this,
we introduce a uaccess function for setting a bit in user space following
Avi's suggestion.

  KVM is now using dirty bitmaps for live-migration and VGA. Although we need
  to update them from kernel side, copying them every time for updating the
  dirty log is a big bottleneck. Especially, we tested that zero-copy bitmap
  manipulation improves responses of GUI manipulations a lot.

We also found one similar need in drivers/vhost/vhost.c in which the author
implemented set_bit_to_user() locally using inefficient functions: see TODO
at the top of that.

Probably, this kind of need would be common for virtualization area.

So we introduce a macro set_bit_user_non_atomic() following the implementation
style of x86's uaccess functions.

Note: there is a one restriction to this macro: bitmaps must be 64-bit
aligned (see the comment in this patch).

Signed-off-by: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
CC: Avi Kivity <avi@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/uaccess.h |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index abd3e0e..3138e65 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -98,6 +98,45 @@ struct exception_table_entry {
 
 extern int fixup_exception(struct pt_regs *regs);
 
+/**
+ * set_bit_user_non_atomic: - set a bit of a bitmap in user space.
+ * @nr:   Bit offset.
+ * @addr: Base address of a bitmap in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro set a bit of a bitmap in user space.
+ *
+ * Restriction: the bitmap pointed to by @addr must be 64-bit aligned:
+ * the kernel accesses the bitmap by its own word length, so bitmaps
+ * allocated by 32-bit processes may cause fault.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ */
+#define __set_bit_user_non_atomic_asm(nr, addr, err, errret)		\
+	asm volatile("1:	bts %1,%2\n"				\
+		     "2:\n"						\
+		     ".section .fixup,\"ax\"\n"				\
+		     "3:	mov %3,%0\n"				\
+		     "	jmp 2b\n"					\
+		     ".previous\n"					\
+		     _ASM_EXTABLE(1b, 3b)				\
+		     : "=r"(err)					\
+		     : "r" (nr), "m" (__m(addr)), "i" (errret), "0" (err))
+
+#define set_bit_user_non_atomic(nr, addr)				\
+({									\
+	int __ret_sbu;							\
+									\
+	might_fault();							\
+	if (access_ok(VERIFY_WRITE, addr, nr/8 + 1))			\
+		__set_bit_user_non_atomic_asm(nr, addr,	__ret_sbu, -EFAULT);\
+	else								\
+		__ret_sbu = -EFAULT;					\
+									\
+	__ret_sbu;							\
+})
+
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
-- 
1.7.0.4
