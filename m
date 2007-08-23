Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4B8ADDDE46
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 21:35:46 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id C82818817
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 16:35:44 +0500 (SAMST)
Date: Thu, 23 Aug 2007 15:35:53 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v7 1/3] [POWERPC] QE lib: extern par_io_config_pin and
	par_io_data_set funcs
Message-ID: <20070823113553.GA18080@localhost.localdomain>
References: <20070823113349.GA11870@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070823113349.GA11870@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is needed to configure and control QE pario pins from the kernel.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 include/asm-powerpc/qe.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 9d304b1..ad23c58 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -32,6 +32,9 @@
 extern void qe_reset(void);
 extern int par_io_init(struct device_node *np);
 extern int par_io_of_config(struct device_node *np);
+extern int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
+			     int assignment, int has_irq);
+extern int par_io_data_set(u8 port, u8 pin, u8 val);
 
 /* QE internal API */
 int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input);
-- 
1.5.0.6
