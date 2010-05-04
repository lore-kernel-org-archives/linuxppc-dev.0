Return-Path: <takuya.yoshikawa@gmail.com>
Received: from mail-pz0-f185.google.com (mail-pz0-f185.google.com
	[209.85.222.185]) by ozlabs.org (Postfix) with ESMTP id 67E9AB7D21
	for <linuxppc-dev@ozlabs.org>; Tue,  4 May 2010 23:02:13 +1000 (EST)
Received: by pzk15 with SMTP id 15so896119pzk.15
	for <linuxppc-dev@ozlabs.org>; Tue, 04 May 2010 06:02:11 -0700 (PDT)
Date: Tue, 4 May 2010 22:02:09 +0900
From: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
To: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Subject: [RFC][PATCH 4/12] x86: introduce copy_in_user() for 32-bit
Message-Id: <20100504220209.c3836ef3.takuya.yoshikawa@gmail.com>
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
the need of copy_in_user() for 32-bit x86 and ppc: these will be used for
manipulating dirty bitmaps in user space.

So we implement copy_in_user() for 32-bit with existing generic copy user
helpers.

Signed-off-by: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
CC: Avi Kivity <avi@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/uaccess_32.h |    2 ++
 arch/x86/lib/usercopy_32.c        |   26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_32.h b/arch/x86/include/asm/uaccess_32.h
index 088d09f..85d396d 100644
--- a/arch/x86/include/asm/uaccess_32.h
+++ b/arch/x86/include/asm/uaccess_32.h
@@ -21,6 +21,8 @@ unsigned long __must_check __copy_from_user_ll_nocache
 		(void *to, const void __user *from, unsigned long n);
 unsigned long __must_check __copy_from_user_ll_nocache_nozero
 		(void *to, const void __user *from, unsigned long n);
+unsigned long __must_check copy_in_user
+		(void __user *to, const void __user *from, unsigned n);
 
 /**
  * __copy_to_user_inatomic: - Copy a block of data into user space, with less checking.
diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index e218d5d..e90ffc3 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -889,3 +889,29 @@ void copy_from_user_overflow(void)
 	WARN(1, "Buffer overflow detected!\n");
 }
 EXPORT_SYMBOL(copy_from_user_overflow);
+
+/**
+ * copy_in_user: - Copy a block of data from user space to user space.
+ * @to:   Destination address, in user space.
+ * @from: Source address, in user space.
+ * @n:    Number of bytes to copy.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Copy data from user space to user space.
+ *
+ * Returns number of bytes that could not be copied.
+ * On success, this will be zero.
+ */
+unsigned long
+copy_in_user(void __user *to, const void __user *from, unsigned n)
+{
+	if (access_ok(VERIFY_WRITE, to, n) && access_ok(VERIFY_READ, from, n)) {
+		if (movsl_is_ok(to, from, n))
+			__copy_user(to, from, n);
+		else
+			n = __copy_user_intel(to, (const void *)from, n);
+	}
+	return n;
+}
+EXPORT_SYMBOL(copy_in_user);
-- 
1.7.0.4
