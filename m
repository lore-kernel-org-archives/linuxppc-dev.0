Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcb0Zf4zF1Nq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:11 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id 191so13030800wmm.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:10 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 15/21] powerpc: Add missing prototype for MMU_setup
Date: Sun, 25 Feb 2018 18:22:30 +0100
Message-Id: <20180225172236.29650-16-malat@debian.org>
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

Add a function declaration for MMU_setup at the beginning of the file to
fix a warning (treated as error in W=1):

  CC      kernel/sys.o
arch/powerpc/mm/init_32.c:102:13: error: no previous prototype for ‘MMU_setup’ [-Werror=missing-prototypes]
 void __init MMU_setup(void)
             ^~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/mm/init_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 6419b33ca309..e88bcad9a63b 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -79,6 +79,7 @@ EXPORT_SYMBOL(agp_special_page);
 #endif
 
 void MMU_init(void);
+void __init MMU_setup(void);
 
 /*
  * this tells the system to map all of ram with the segregs
-- 
2.11.0
