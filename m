Return-Path: <linux@rasmusvillemoes.dk>
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41t15J2jqWzF0gL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Aug 2018 23:24:52 +1000 (AEST)
Received: by mail-ed1-x542.google.com with SMTP id b10-v6so5979156eds.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Aug 2018 06:24:52 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 7/8] powerpc/pseries: use seq_open_data in
 hcall_inst_seq_open
Date: Sat, 18 Aug 2018 15:24:33 +0200
Message-Id: <20180818132434.9515-7-linux@rasmusvillemoes.dk>
In-Reply-To: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
References: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This code should check the return value of seq_open(); if it failed,
file->private_data is NULL. But we can avoid the issue entirely and
simplify the code by letting seq_open_data() set the ->private member.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Depends on 1/8 introducing seq_open_data.

arch/powerpc/platforms/pseries/hvCall_inst.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index 6da320c786cd..4816916dc8a1 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -92,14 +92,7 @@ static const struct seq_operations hcall_inst_seq_ops = {
 
 static int hcall_inst_seq_open(struct inode *inode, struct file *file)
 {
-	int rc;
-	struct seq_file *seq;
-
-	rc = seq_open(file, &hcall_inst_seq_ops);
-	seq = file->private_data;
-	seq->private = file_inode(file)->i_private;
-
-	return rc;
+	return seq_open_data(file, &hcall_inst_seq_ops, file_inode(file)->i_private);
 }
 
 static const struct file_operations hcall_inst_seq_fops = {
-- 
2.16.4
