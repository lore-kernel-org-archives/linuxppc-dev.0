Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcQ54yszF1NX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:02 +1100 (AEDT)
Received: by mail-wr0-x243.google.com with SMTP id z12so18856502wrg.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:02 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 07/21] powerpc: Make functions flipper_pic_init & ug_udbg_putc
 static
Date: Sun, 25 Feb 2018 18:22:22 +0100
Message-Id: <20180225172236.29650-8-malat@debian.org>
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

Change signature of two functions, adding static keyword to prevent the
following two warnings (treated as errors on W=1):

  CC      kernel/sys.o
arch/powerpc/platforms/embedded6xx/flipper-pic.c:135:28: error: no previous prototype for ‘flipper_pic_init’ [-Werror=missing-prototypes]
 struct irq_domain * __init flipper_pic_init(struct device_node *np)
                            ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

and

  CC      arch/powerpc/platforms/embedded6xx/usbgecko_udbg.o
arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c:172:6: error: no previous prototype for ‘ug_udbg_putc’ [-Werror=missing-prototypes]
 void ug_udbg_putc(char ch)
      ^~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   | 2 +-
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index ade83829d5e8..7206f3f573d4 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -132,7 +132,7 @@ static void __flipper_quiesce(void __iomem *io_base)
 	out_be32(io_base + FLIPPER_ICR, 0xffffffff);
 }
 
-struct irq_domain * __init flipper_pic_init(struct device_node *np)
+static struct irq_domain * __init flipper_pic_init(struct device_node *np)
 {
 	struct device_node *pi;
 	struct irq_domain *irq_domain = NULL;
diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
index 7feb325b636b..5c7e7ce6dbab 100644
--- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
+++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
@@ -169,7 +169,7 @@ static int ug_getc(void)
 /*
  * Transmits a character.
  */
-void ug_udbg_putc(char ch)
+static void ug_udbg_putc(char ch)
 {
 	ug_putc(ch);
 }
-- 
2.11.0
