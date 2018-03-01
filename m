Return-Path: <linux@rasmusvillemoes.dk>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zspkp6ZPSzF1nx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 10:37:35 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id t3so3405wmc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Mar 2018 15:37:35 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [RFC 3/5] powerpc/pseries: use seq_open_data in hcall_inst_seq_open
Date: Fri,  2 Mar 2018 00:37:22 +0100
Message-Id: <20180301233724.20440-3-linux@rasmusvillemoes.dk>
In-Reply-To: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
References: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
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
 arch/powerpc/platforms/pseries/hvCall_inst.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index 89b7ce807e70..05990c9fe264 100644
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
2.15.1
