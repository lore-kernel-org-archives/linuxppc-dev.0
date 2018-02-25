Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcY2Vl6zF1Nq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:09 +1100 (AEDT)
Received: by mail-wr0-x244.google.com with SMTP id p104so18823289wrc.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:09 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 12/21] powerpc: Add missing prototype for time_init
Date: Sun, 25 Feb 2018 18:22:27 +0100
Message-Id: <20180225172236.29650-13-malat@debian.org>
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

The function time_init did not have a prototype defined in the time.h
header. Fix the following warning (treated as error in W=1):

  CC      arch/powerpc/kernel/time.o
arch/powerpc/kernel/time.c:1068:13: error: no previous prototype for ‘time_init’ [-Werror=missing-prototypes]
 void __init time_init(void)
             ^~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/time.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index a7a8a9ac5991..828ebe7ba7dc 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -205,6 +205,7 @@ struct cpu_usage {
 DECLARE_PER_CPU(struct cpu_usage, cpu_usage_array);
 
 extern void secondary_cpu_time_init(void);
+extern void __init time_init(void);
 
 DECLARE_PER_CPU(u64, decrementers_next_tb);
 
-- 
2.11.0
