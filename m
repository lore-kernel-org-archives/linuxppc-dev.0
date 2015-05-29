Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 380671A0551
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 13:12:45 +1000 (AEST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Geoff Levand
 <geoff@infradead.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 03/15] powerpc: use device_initcall for registering rtc devices
Date: Thu, 28 May 2015 20:48:01 -0400
Message-ID: <1432860493-23831-4-git-send-email-paul.gortmaker@windriver.com>
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

Currently these two RTC devices are in core platform code
where it is not possible for them to be modular.  It will
never be modular, so using module_init as an alias for
__initcall can be somewhat misleading.

Fix this up now, so that we can relocate module_init from
init.h into module.h in the future.  If we don't do this, we'd
have to add module.h to obviously non-modular code, and that
would be a worse thing.

Note that direct use of __initcall is discouraged, vs. one
of the priority categorized subgroups.  As __initcall gets
mapped onto device_initcall, our use of device_initcall
directly in this change means that the runtime impact is
zero -- they will remain at level 6 in initcall ordering.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Geoff Levand <geoff@infradead.org>
Acked-by: Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/kernel/time.c        | 2 +-
 arch/powerpc/platforms/ps3/time.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 56f44848b044..43922509a483 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -1124,4 +1124,4 @@ static int __init rtc_init(void)
 	return PTR_ERR_OR_ZERO(pdev);
 }
 
-module_init(rtc_init);
+device_initcall(rtc_init);
diff --git a/arch/powerpc/platforms/ps3/time.c b/arch/powerpc/platforms/ps3/time.c
index ce73ce865613..791c6142c4a7 100644
--- a/arch/powerpc/platforms/ps3/time.c
+++ b/arch/powerpc/platforms/ps3/time.c
@@ -92,5 +92,4 @@ static int __init ps3_rtc_init(void)
 
 	return PTR_ERR_OR_ZERO(pdev);
 }
-
-module_init(ps3_rtc_init);
+device_initcall(ps3_rtc_init);
-- 
2.2.1
