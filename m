Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23FB91A0551
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 13:01:02 +1000 (AEST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>, Scott Wood
 <scottwood@freescale.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 04/15] powerpc: don't use module_init in non-modular 83xx
 suspend code
Date: Thu, 28 May 2015 20:48:02 -0400
Message-ID: <1432860493-23831-5-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1432860493-23831-1-git-send-email-paul.gortmaker@windriver.com>
References: <1432860493-23831-1-git-send-email-paul.gortmaker@windriver.com>
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

The suspend.o is built for SUSPEND -- which is bool, and hence
this code is either present or absent.  It will never be modular,
so using module_init as an alias for __initcall can be somewhat
misleading.

Fix this up now, so that we can relocate module_init from
init.h into module.h in the future.  If we don't do this, we'd
have to add module.h to obviously non-modular code, and that
would be a worse thing.

Note that direct use of __initcall is discouraged, vs. one
of the priority categorized subgroups.  As __initcall gets
mapped onto device_initcall, our use of device_initcall
directly in this change means that the runtime impact is
zero -- it will remain at level 6 in initcall ordering.

Cc: Scott Wood <scottwood@freescale.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/platforms/83xx/suspend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index c9adbfb65006..fcbea4b51a78 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -445,5 +445,4 @@ static int pmc_init(void)
 {
 	return platform_driver_register(&pmc_driver);
 }
-
-module_init(pmc_init);
+device_initcall(pmc_init);
-- 
2.2.1
