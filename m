Return-Path: <bobby.prani@gmail.com>
Received: from mail-yk0-x235.google.com (mail-yk0-x235.google.com
 [IPv6:2607:f8b0:4002:c07::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20A7A1A0BF2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 10:52:41 +1100 (AEDT)
Received: by mail-yk0-f181.google.com with SMTP id 79so5260259ykr.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 15:52:38 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Rob Herring <robh@kernel.org>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] powerpc/powernv: Skip registering log region when
 CONFIG_PRINTK=n
Date: Tue, 20 Jan 2015 18:51:50 -0500
Message-Id: <1421797911-23650-2-git-send-email-bobby.prani@gmail.com>
In-Reply-To: <1421797911-23650-1-git-send-email-bobby.prani@gmail.com>
References: <1421797911-23650-1-git-send-email-bobby.prani@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_PRINTK=n, log_buf_addr_get() returns NULL and log_buf_len_get()
return 0. Check for these return values and skip registering the dump buffer.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
CC: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/opal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f10b9ec..1db119f0 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -667,7 +667,13 @@ static void __init opal_dump_region_init(void)
 
 	/* Register kernel log buffer */
 	addr = log_buf_addr_get();
+	if (addr == NULL)
+		return;
+
 	size = log_buf_len_get();
+	if (size == 0)
+		return;
+
 	rc = opal_register_dump_region(OPAL_DUMP_REGION_LOG_BUF,
 				       __pa(addr), size);
 	/* Don't warn if this is just an older OPAL that doesn't
-- 
1.9.1
