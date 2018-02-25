Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcL3YFyzF1Nx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:22:58 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id t3so13276344wmc.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:22:58 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 03/21] powerpc: Mark the variable earlycon_acpi_spcr_enable
 maybe_unused
Date: Sun, 25 Feb 2018 18:22:18 +0100
Message-Id: <20180225172236.29650-4-malat@debian.org>
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

Re-use the object-like macro EARLYCON_USED_OR_UNUSED to mark
`earlycon_acpi_spcr_enable` as maybe_unused.

Fix the following warning (treated as error in W=1)

  CC      arch/powerpc/kernel/setup-common.o
In file included from ./include/linux/serial_8250.h:14:0,
                 from arch/powerpc/kernel/setup-common.c:33:
./include/linux/serial_core.h:382:19: error: ‘earlycon_acpi_spcr_enable’ defined but not used [-Werror=unused-const-variable=]
 static const bool earlycon_acpi_spcr_enable;
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 include/linux/serial_core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b32df49a3bd5..4d14ecd7dbe8 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -379,6 +379,7 @@ extern int of_setup_earlycon(const struct earlycon_id *match,
 extern bool earlycon_acpi_spcr_enable __initdata;
 int setup_earlycon(char *buf);
 #else
+EARLYCON_USED_OR_UNUSED
 static const bool earlycon_acpi_spcr_enable;
 static inline int setup_earlycon(char *buf) { return 0; }
 #endif
-- 
2.11.0
