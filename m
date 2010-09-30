Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.179.29])
	by ozlabs.org (Postfix) with ESMTP id 4F56AB6F0D
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Oct 2010 02:39:45 +1000 (EST)
Date: Thu, 30 Sep 2010 11:39:39 -0500
From: Robin Holt <holt@sgi.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 0/8] v2 De-Couple sysfs memory directories from memory
	sections
Message-ID: <20100930163939.GL14068@sgi.com>
References: <4CA0EBEB.1030204@austin.ibm.com> <20100928123848.GH14068@sgi.com>
	<4CA2313D.2030508@austin.ibm.com> <20100929192830.GK14068@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100929192830.GK14068@sgi.com>
Cc: linux-mm@kvack.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Robin Holt <holt@sgi.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 29, 2010 at 02:28:30PM -0500, Robin Holt wrote:
> On Tue, Sep 28, 2010 at 01:17:33PM -0500, Nathan Fontenot wrote:
...
> My next task is to implement a x86_64 SGI UV specific chunk of code
> to memory_block_size_bytes().  Would you consider adding that to your
> patch set?  I expect to have that either later today or early tomorrow.

The patch is below.

I left things at a u32, but I would really like it if you changed to an
unsigned long and adjusted my patch for me.

Thanks,
Robin

------------------------------------------------------------------------
Subject: [Patch] Implement memory_block_size_bytes for x86_64 when CONFIG_X86_UV


Nathan Fontenot has implemented a patch set for large memory configuration
systems which will combine drivers/base/memory.c memory sections
together into memory blocks with the default behavior being
unchanged from the current behavior.

In his patch set, he implements a memory_block_size_bytes() function
for PPC.  This is the equivalent patch for x86_64 when it has
CONFIG_X86_UV set.

Signed-off-by: Robin Holt <holt@sgi.com>
Signed-off-by: Jack Steiner <steiner@sgi.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: lkml <linux-kernel@vger.kernel.org>

---

 arch/x86/mm/init_64.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: memory_block/arch/x86/mm/init_64.c
===================================================================
--- memory_block.orig/arch/x86/mm/init_64.c	2010-09-29 14:46:50.711824616 -0500
+++ memory_block/arch/x86/mm/init_64.c	2010-09-29 14:46:55.683997672 -0500
@@ -50,6 +50,7 @@
 #include <asm/numa.h>
 #include <asm/cacheflush.h>
 #include <asm/init.h>
+#include <asm/uv/uv.h>
 #include <linux/bootmem.h>
 
 static unsigned long dma_reserve __initdata;
@@ -928,6 +929,20 @@ const char *arch_vma_name(struct vm_area
 	return NULL;
 }
 
+#ifdef CONFIG_X86_UV
+#define MIN_MEMORY_BLOCK_SIZE   (1 << SECTION_SIZE_BITS)
+
+u32 memory_block_size_bytes(void)
+{
+	if (is_uv_system()) {
+		printk("UV: memory block size 2GB\n");
+		return 2UL * 1024 * 1024 * 1024;
+	}
+	return MIN_MEMORY_BLOCK_SIZE;
+}
+#endif
+
+
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 /*
  * Initialise the sparsemem vmemmap using huge-pages at the PMD level.
