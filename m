Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcZ1tkwzF1Mq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:10 +1100 (AEDT)
Received: by mail-wr0-x244.google.com with SMTP id v65so18817570wrc.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:10 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 13/21] powerpc: Add missing prototype for arch_dup_task_struct
Date: Sun, 25 Feb 2018 18:22:28 +0100
Message-Id: <20180225172236.29650-14-malat@debian.org>
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 55ccf3fe3f9a ("fork: move the real prepare_to_copy() users to
arch_dup_task_struct()") a new arch_dup_task_struct was added without a
prototype declared in thread_info.h header. Fix the following warning
(treated as error in W=1):

  CC      arch/powerpc/kernel/process.o
arch/powerpc/kernel/process.c:1609:5: error: no previous prototype for ‘arch_dup_task_struct’ [-Werror=missing-prototypes]
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
     ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/thread_info.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 4a12c00f8de3..5964145db03d 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -70,6 +70,7 @@ static inline struct thread_info *current_thread_info(void)
 	return (struct thread_info *)val;
 }
 
+extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #endif /* __ASSEMBLY__ */
 
 /*
-- 
2.11.0
