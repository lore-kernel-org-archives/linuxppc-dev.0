Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 0BF882C0561
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 21:14:56 +1000 (EST)
Date: Thu, 16 May 2013 14:12:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] mn10300: uaccess s/might_sleep/might_fault/
Message-ID: <affedb5f30410296ad0bb43a69158b38e32378ea.1368702323.git.mst@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1368702323.git.mst@redhat.com>
Cc: linux-m32r-ja@ml.linux-m32r.org, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-arch@vger.kernel.org, linux-am33-list@redhat.com,
 Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-m32r@ml.linux-m32r.org,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only reason uaccess routines might sleep
is if they fault. Make this explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/mn10300/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mn10300/include/asm/uaccess.h b/arch/mn10300/include/asm/uaccess.h
index 780560b..107508a 100644
--- a/arch/mn10300/include/asm/uaccess.h
+++ b/arch/mn10300/include/asm/uaccess.h
@@ -471,13 +471,13 @@ extern unsigned long __generic_copy_from_user(void *, const void __user *,
 
 #define __copy_to_user(to, from, n)			\
 ({							\
-	might_sleep();					\
+	might_fault();					\
 	__copy_to_user_inatomic((to), (from), (n));	\
 })
 
 #define __copy_from_user(to, from, n)			\
 ({							\
-	might_sleep();					\
+	might_fault();					\
 	__copy_from_user_inatomic((to), (from), (n));	\
 })
 
-- 
MST
