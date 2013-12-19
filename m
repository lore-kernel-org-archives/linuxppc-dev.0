Return-Path: <ilevex.linux@gmail.com>
Received: from mail-ea0-x22f.google.com (mail-ea0-x22f.google.com
 [IPv6:2a00:1450:4013:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DB6152C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 02:04:09 +1100 (EST)
Received: by mail-ea0-f175.google.com with SMTP id z10so535262ead.20
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 07:04:03 -0800 (PST)
Sender: Levente Kurusa <ilevex.linux@gmail.com>
From: Levente Kurusa <levex@linux.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/38] powerpc: qe_lib: add missing put_device call
Date: Thu, 19 Dec 2013 16:03:13 +0100
Message-Id: <1387465429-3568-3-git-send-email-levex@linux.com>
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Cc: Levente Kurusa <levex@linux.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is required so that we give up the last reference to the device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/powerpc/sysdev/qe_lib/qe_ic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index b2b87c3..2e15262 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -493,6 +493,7 @@ static int __init init_qe_ic_sysfs(void)
 	rc = device_register(&device_qe_ic);
 	if (rc) {
 		printk(KERN_ERR "Failed registering qe_ic sys device\n");
+		put_device(&device_qe_ic);
 		return -ENODEV;
 	}
 	return 0;
-- 
1.8.3.1
