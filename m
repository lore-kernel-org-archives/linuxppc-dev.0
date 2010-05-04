Return-Path: <takuya.yoshikawa@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id E0804B7D2E
	for <linuxppc-dev@ozlabs.org>; Tue,  4 May 2010 23:03:35 +1000 (EST)
Received: by pxi18 with SMTP id 18so1790855pxi.15
	for <linuxppc-dev@ozlabs.org>; Tue, 04 May 2010 06:03:34 -0700 (PDT)
Date: Tue, 4 May 2010 22:03:33 +0900
From: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
To: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Subject: [RFC][PATCH 6/12 not tested yet] PPC: introduce copy_in_user() for
	32-bit
Message-Id: <20100504220333.61e44128.takuya.yoshikawa@gmail.com>
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
the need of copy_in_user() for 32-bit ppc and x86: these will be used for
manipulating dirty bitmaps in user space.

So we implement copy_in_user() for 32-bit with __copy_tofrom_user().

Signed-off-by: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
CC: Alexander Graf <agraf@suse.de>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/uaccess.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index bd0fb84..3a01ce8 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -359,6 +359,23 @@ static inline unsigned long copy_to_user(void __user *to,
 	return n;
 }
 
+static inline unsigned long copy_in_user(void __user *to,
+		const void __user *from, unsigned long n)
+{
+	unsigned long over;
+
+	if (likely(access_ok(VERIFY_READ, from, n) &&
+	    access_ok(VERIFY_WRITE, to, n)))
+		return __copy_tofrom_user(to, from, n);
+	if (((unsigned long)from < TASK_SIZE) ||
+	    ((unsigned long)to < TASK_SIZE)) {
+		over = max((unsigned long)from, (unsigned long)to)
+			+ n - TASK_SIZE;
+		return __copy_tofrom_user(to, from, n - over) + over;
+	}
+	return n;
+}
+
 #else /* __powerpc64__ */
 
 #define __copy_in_user(to, from, size) \
-- 
1.7.0.4
