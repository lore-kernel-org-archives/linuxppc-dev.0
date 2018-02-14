Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhXHq54vVzF1Jj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 08:15:35 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id a84so13959491wmi.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 13:15:35 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/via-pmu: Fix section mismatch warning
Date: Wed, 14 Feb 2018 22:15:18 +0100
Message-Id: <20180214211519.15683-1-malat@debian.org>
In-Reply-To: <20180207194439.32680-1-malat@debian.org>
References: <20180207194439.32680-1-malat@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make the struct via_pmu_driver const to avoid following warning:

WARNING: vmlinux.o(.data+0x4739c): Section mismatch in reference from the variable via_pmu_driver to the function .init.text:pmu_init()
The variable via_pmu_driver references
the function __init pmu_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Suggested-by: Laurent Vivier <lvivier@redhat.com>
---
v2: pmu_init() is really an init function, leave __init marker

 drivers/macintosh/via-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 94c0f3f7df69..fc56c7067732 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -198,7 +198,7 @@ static const struct file_operations pmu_battery_proc_fops;
 static const struct file_operations pmu_options_proc_fops;
 
 #ifdef CONFIG_ADB
-struct adb_driver via_pmu_driver = {
+const struct adb_driver via_pmu_driver = {
 	"PMU",
 	pmu_probe,
 	pmu_init,
-- 
2.11.0
