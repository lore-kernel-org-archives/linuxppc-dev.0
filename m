Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z5dGy02c0zDrTl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Dec 2017 01:12:41 +1100 (AEDT)
Received: by mail-wr0-x243.google.com with SMTP id o2so34656923wro.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Dec 2017 06:12:41 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: 
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc: Fix old-style function definition
Date: Tue, 26 Dec 2017 15:12:33 +0100
Message-Id: <20171226141233.19444-1-malat@debian.org>
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

Fix warnings such as:

arch/powerpc/platforms/powermac/backlight.c: In function ‘pmac_backlight_get_legacy_brightness’:
arch/powerpc/platforms/powermac/backlight.c:189:5: error: old-style function definition [-Werror=old-style-definition]
 int pmac_backlight_get_legacy_brightness()
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/powermac/backlight.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/backlight.c b/arch/powerpc/platforms/powermac/backlight.c
index a00096b1c713..6b5dcccae1d3 100644
--- a/arch/powerpc/platforms/powermac/backlight.c
+++ b/arch/powerpc/platforms/powermac/backlight.c
@@ -186,7 +186,7 @@ int pmac_backlight_set_legacy_brightness(int brightness)
 	return __pmac_backlight_set_legacy_brightness(brightness);
 }
 
-int pmac_backlight_get_legacy_brightness()
+int pmac_backlight_get_legacy_brightness(void)
 {
 	int result = -ENXIO;
 
@@ -205,12 +205,12 @@ int pmac_backlight_get_legacy_brightness()
 	return result;
 }
 
-void pmac_backlight_disable()
+void pmac_backlight_disable(void)
 {
 	atomic_inc(&kernel_backlight_disabled);
 }
 
-void pmac_backlight_enable()
+void pmac_backlight_enable(void)
 {
 	atomic_dec(&kernel_backlight_disabled);
 }
-- 
2.11.0
