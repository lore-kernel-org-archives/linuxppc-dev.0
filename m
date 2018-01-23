Return-Path: <dan.carpenter@oracle.com>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQwX129BZzDqp6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 04:38:56 +1100 (AEDT)
Date: Tue, 23 Jan 2018 11:33:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Geoff Levand <geoff@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] powerpc/ps3: remove an unneeded NULL check
Message-ID: <20180123083318.GB10091@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Static checkers don't like the inconsistent NULL checking on "ops".
This function is only called once and "ops" isn't NULL so the check can
be removed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/ps3/sys-manager-core.c b/drivers/ps3/sys-manager-core.c
index c429ffca1ab7..a5a6def77bb9 100644
--- a/drivers/ps3/sys-manager-core.c
+++ b/drivers/ps3/sys-manager-core.c
@@ -43,7 +43,7 @@ void ps3_sys_manager_register_ops(const struct ps3_sys_manager_ops *ops)
 {
 	BUG_ON(!ops);
 	BUG_ON(!ops->dev);
-	ps3_sys_manager_ops = ops ? *ops : ps3_sys_manager_ops;
+	ps3_sys_manager_ops = *ops;
 }
 EXPORT_SYMBOL_GPL(ps3_sys_manager_register_ops);
 
