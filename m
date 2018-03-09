Return-Path: <andreyknvl@google.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyTbH6JDyzF1qt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Mar 2018 01:02:19 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id i3so4062804wmi.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Mar 2018 06:02:19 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Shaohua Li <shli@fb.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Shakeel Butt <shakeelb@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Hugh Dickins <hughd@google.com>, Mel Gorman <mgorman@techsingularity.net>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Zi Yan <zi.yan@cs.rutgers.edu>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>,
 Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
 Mikael Starvik <starvik@axis.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <jhogan@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>,
 David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E . J . Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
 Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S . Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linux-am33-list@redhat.com,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-arch@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>,
 Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>
Subject: [RFC PATCH 2/6] arm64: untag user addresses in copy_from_user and
 others
Date: Fri,  9 Mar 2018 15:02:00 +0100
Message-Id: <d681c0dee907ee5cc55d313e2f843237c6087bf0.1520600533.git.andreyknvl@google.com>
In-Reply-To: <cover.1520600533.git.andreyknvl@google.com>
References: <cover.1520600533.git.andreyknvl@google.com>
In-Reply-To: <cover.1520600533.git.andreyknvl@google.com>
References: <cover.1520600533.git.andreyknvl@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

copy_from_user (and a few other similar functions) are used to copy data
from user memory into the kernel memory or vice versa. Since a user can
provided a tagged pointer to one of the syscalls that use copy_from_user,
we need to correctly handle such pointers.

Do this by untagging user pointers in access_ok and in __uaccess_mask_ptr.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 2d6451cbaa86..24a221678fe3 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -105,7 +105,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 #define untagged_addr(addr)		\
 	((__typeof__(addr))sign_extend64((__u64)(addr), 55))
 
-#define access_ok(type, addr, size)	__range_ok(addr, size)
+#define access_ok(type, addr, size)	\
+	__range_ok(untagged_addr(addr), size)
 #define user_addr_max			get_fs
 
 #define _ASM_EXTABLE(from, to)						\
@@ -238,12 +239,15 @@ static inline void uaccess_enable_not_uao(void)
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
  * current addr_limit.
+ * Also untag user pointers that have the top byte tag set.
  */
 #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
 static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 {
 	void __user *safe_ptr;
 
+	ptr = untagged_addr(ptr);
+
 	asm volatile(
 	"	bics	xzr, %1, %2\n"
 	"	csel	%0, %1, xzr, eq\n"
-- 
2.16.2.395.g2e18187dfd-goog
