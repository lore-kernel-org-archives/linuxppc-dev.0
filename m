Return-Path: <ilevex.linux@gmail.com>
Received: from mail-ee0-x230.google.com (mail-ee0-x230.google.com
 [IPv6:2a00:1450:4013:c00::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 418832C0084
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 02:04:11 +1100 (EST)
Received: by mail-ee0-f48.google.com with SMTP id e49so530448eek.35
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 07:04:07 -0800 (PST)
Sender: Levente Kurusa <ilevex.linux@gmail.com>
From: Levente Kurusa <levex@linux.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/38] powerpc: kernel: add missing put_device call
Date: Thu, 19 Dec 2013 16:03:15 +0100
Message-Id: <1387465429-3568-5-git-send-email-levex@linux.com>
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Levente Kurusa <levex@linux.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org
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
 arch/powerpc/kernel/vio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index e7d0c88f..e8ed87e 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1494,6 +1494,7 @@ static int __init vio_bus_init(void)
 	if (err) {
 		printk(KERN_WARNING "%s: device_register returned %i\n",
 				__func__, err);
+		put_device(&vio_bus_device.dev);
 		return err;
 	}
 
-- 
1.8.3.1
