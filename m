Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT6Ys3KT3zDqgp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 20:17:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: gromero@br.ibm.com
Subject: Re: kernel BUG at mm/usercopy.c:72!
In-Reply-To: <20170515191949.GA13641@gmail.com>
References: <20170515191949.GA13641@gmail.com>
Date: Thu, 18 May 2017 20:17:20 +1000
Message-ID: <87zieajwpb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Breno Leitao <leitao@debian.org> writes:

> Hello,
>
> Kernel 4.12-rc1 is showing a bug when I try it on a POWER8 virtual
> machine. Justing SSHing into the machine causes this issue.

Can you try this?

cheers

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 2a32483c7b6c..8da5d4c1cab2 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -132,7 +132,19 @@ extern long long virt_phys_offset;
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * On hash the vmalloc and other regions alias to the kernel region when passed
+ * through __pa(), which virt_to_pfn() uses. That means virt_addr_valid() can
+ * return true for some vmalloc addresses, which is incorrect. So explicitly
+ * check that the address is in the kernel region.
+ */
+#define virt_addr_valid(kaddr) (REGION_ID(kaddr) == KERNEL_REGION_ID && \
+				pfn_valid(virt_to_pfn(kaddr)))
+#else
 #define virt_addr_valid(kaddr)	pfn_valid(virt_to_pfn(kaddr))
+#endif
 
 /*
  * On Book-E parts we need __va to parse the device tree and we can't
