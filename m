Return-Path: <till.smejkal@googlemail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhsc54HFLzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 09:14:45 +1100 (AEDT)
Received: by mail-wr0-x241.google.com with SMTP id g10so21791449wrg.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 15:14:45 -0700 (PDT)
From: Till Smejkal <till.smejkal@googlemail.com>
To: Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S. Miller" <davem@davemloft.net>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@atmel.com>,
 Felipe Balbi <balbi@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Benjamin LaHaise <bcrl@kvack.org>,
 Nadia Yvette Chambers <nyc@holomorphy.com>,
 Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 Peter Zijlstra <peterz@infradead.org>, Hugh Dickins <hughd@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-usb@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 alsa-devel@alsa-project.org
Subject: [RFC PATCH 06/13] mm/mmap: Export 'vma_link' and 'find_vma_links' to
 mm subsystem
Date: Mon, 13 Mar 2017 15:14:08 -0700
Message-Id: <20170313221415.9375-7-till.smejkal@gmail.com>
In-Reply-To: <20170313221415.9375-1-till.smejkal@gmail.com>
References: <20170313221415.9375-1-till.smejkal@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make the functions 'vma_link' and 'find_vma_links' accessible to other
source files in the mm/ source directory of the kernel so that other files
in that directory can also perform low level changes to mm_struct data
structures.

Signed-off-by: Till Smejkal <till.smejkal@gmail.com>
---
 mm/internal.h | 11 +++++++++++
 mm/mmap.c     | 12 ++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 7aa2ea0a8623..e22cb031b45b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -76,6 +76,17 @@ static inline void set_page_refcounted(struct page *page)
 extern unsigned long highest_memmap_pfn;
 
 /*
+ * in mm/mmap.c
+ */
+extern void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
+		     struct vm_area_struct *prev, struct rb_node **rb_link,
+		     struct rb_node *rb_parent);
+extern int find_vma_links(struct mm_struct *mm, unsigned long addr,
+			  unsigned long end, struct vm_area_struct **pprev,
+			  struct rb_node ***rb_link,
+			  struct rb_node **rb_parent);
+
+/*
  * in mm/vmscan.c:
  */
 extern int isolate_lru_page(struct page *page);
diff --git a/mm/mmap.c b/mm/mmap.c
index 3f60c8ebd6b6..d35c6b51cadf 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -466,9 +466,9 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
 
-static int find_vma_links(struct mm_struct *mm, unsigned long addr,
-		unsigned long end, struct vm_area_struct **pprev,
-		struct rb_node ***rb_link, struct rb_node **rb_parent)
+int find_vma_links(struct mm_struct *mm, unsigned long addr,
+		   unsigned long end, struct vm_area_struct **pprev,
+		   struct rb_node ***rb_link, struct rb_node **rb_parent)
 {
 	struct rb_node **__rb_link, *__rb_parent, *rb_prev;
 
@@ -580,9 +580,9 @@ __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 }
 
-static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev, struct rb_node **rb_link,
-			struct rb_node *rb_parent)
+void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
+	      struct vm_area_struct *prev, struct rb_node **rb_link,
+	      struct rb_node *rb_parent)
 {
 	struct address_space *mapping = NULL;
 
-- 
2.12.0
