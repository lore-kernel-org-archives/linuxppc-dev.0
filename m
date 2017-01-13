Return-Path: <joel.stan@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v07zJ2XVzzDqV8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 14:54:04 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id b22so6255797pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 19:54:04 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	jk@ozlabs.org
Subject: [PATCH] powerpc: opal-msglog: Report size of memcons log
Date: Fri, 13 Jan 2017 14:23:49 +1030
Message-Id: <20170113035349.15923-1-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The OPAL memory console is reported to be size zero, as we do not
initialise the struct attr with any size information due to the size
being variable. This leads users to think that the console is empty.

Instead report the maximum size.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/platforms/powernv/opal-msglog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
index 39d6ff9e5630..8486b2ceb510 100644
--- a/arch/powerpc/platforms/powernv/opal-msglog.c
+++ b/arch/powerpc/platforms/powernv/opal-msglog.c
@@ -123,6 +123,10 @@ void __init opal_msglog_init(void)
 		return;
 	}
 
+	/* Report maximum size */
+	opal_msglog_attr.size =  be64_to_cpu(mc->ibuf_size) +
+		be64_to_cpu(mc->obuf_size);
+
 	opal_memcons = mc;
 }
 
-- 
2.11.0
