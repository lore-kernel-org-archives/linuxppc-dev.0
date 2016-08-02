Return-Path: <mcgrof@gmail.com>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3pqn2VHlzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 07:14:45 +1000 (AEST)
Received: by mail-yw0-x243.google.com with SMTP id z8so15553689ywa.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 14:14:45 -0700 (PDT)
MIME-Version: 1.0
Sender: mcgrof@gmail.com
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 2 Aug 2016 14:14:22 -0700
Message-ID: <CAB=NE6Xu2t7JYUfvZcPSpX_Yt2yN9ooWgzctZFMr3LZGG1hVzw@mail.gmail.com>
Subject: linker tables on powerpc - build issues
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Fengguang Wu <fengguang.wu@intel.com>,
 Guenter Roeck <linux@roeck-us.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've run into a few compilation issues with linker tables support [0]
[1] on only a few architectures:

blackfin - compiler issue it seems, I have a work around now in place
arm  - some alignment issue - still need to iron this out
powerpc - issue with including <asm/sections.h> on <asm/jump_labels.h>

The issue with powerpc can be replicated easily with the patch below,
and compilation fails even on a 'make defconfig' configuration, the
issues are recurring include header ordering issues. I've given this
some tries to fix but am still a bit bewildered how to best do this
without affecting non-powerpc compilations.  The patch below
replicates the changes in question, it does not include the linker
table work at all, it just includes <asm/sections.h> instead of
<asm/tables.h> to reduce and provide an example of the issues
observed. The list of errors are also pretty endless... so was hoping
some power folks might be able to take a glance if possible. If you
have any ideas, please let me know.

[0] https://lkml.kernel.org/r/1469222687-1600-1-git-send-email-mcgrof@kernel.org
[1] https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/log/?h=20160729-linker-table-v4-blackfin2

diff --git a/arch/powerpc/include/asm/jump_label.h
b/arch/powerpc/include/asm/jump_label.h
index 9a287e0ac8b1..68e46825b0f8 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -9,6 +9,7 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
+#include <asm/sections.h>

 #ifndef __ASSEMBLY__
 #include <linux/types.h>
diff --git a/arch/powerpc/include/asm/sections.h
b/arch/powerpc/include/asm/sections.h
index 7dc006b58369..929decb62d9c 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -1,11 +1,14 @@
 #ifndef _ASM_POWERPC_SECTIONS_H
 #define _ASM_POWERPC_SECTIONS_H
-#ifdef __KERNEL__

+#if defined(__KERNEL__) && !defined(__ASSEMBLER__) && !defined(__ASSEMBLY__)
 #include <linux/elf.h>
 #include <linux/uaccess.h>
+#endif /* defined(__KERNEL__) && !defined(__ASSEMBLER__) &&
!defined(__ASSEMBLY__) */
+
 #include <asm-generic/sections.h>

+#if defined(__KERNEL__) && !defined(__ASSEMBLER__) && !defined(__ASSEMBLY__)
 #ifdef __powerpc64__

 extern char __start_interrupts[];
@@ -77,5 +80,5 @@ static inline void *dereference_function_descriptor(void *ptr)

 #endif

-#endif /* __KERNEL__ */
+#endif /* defined(__KERNEL__) && !defined(__ASSEMBLER__) &&
!defined(__ASSEMBLY__) */
 #endif /* _ASM_POWERPC_SECTIONS_H */
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index af0254c09424..06bceee909da 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_GENERIC_SECTIONS_H_
 #define _ASM_GENERIC_SECTIONS_H_

+#if defined(__KERNEL__) && !defined(__ASSEMBLER__) && !defined(__ASSEMBLY__)
+
 /* References to section boundaries */

 #include <linux/compiler.h>
@@ -128,4 +130,6 @@ static inline bool init_section_intersects(void
*virt, size_t size)
  return memory_intersects(__init_begin, __init_end, virt, size);
 }

+#endif /* defined(__KERNEL__) && !defined(__ASSEMBLER__) &&
!defined(__ASSEMBLY__)  */
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */


  Luis
