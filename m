Return-Path: <himangi774@gmail.com>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA5431A0018
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Jul 2014 07:53:44 +1000 (EST)
Received: by mail-pa0-f54.google.com with SMTP id fa1so7385634pad.27
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jul 2014 14:53:42 -0700 (PDT)
Date: Sun, 20 Jul 2014 03:23:35 +0530
From: Himangi Saraogi <himangi774@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] powerpc/mpic_msgr: Use kcalloc and correct the
 argument to sizeof
Message-ID: <20140719215335.GA22646@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: julia.lawall@lip6.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpic_msgrs has type struct mpic_msgr **, not struct mpic_msgr *, so the
elements of the array should have pointer type, not structure type.
The advantage of kcalloc is, that will prevent integer overflows which
could result from the multiplication of number of elements and size and
it is also a bit nicer to read.

The Coccinelle semantic patch that makes the first change is as follows:

// <smpl>
@disable sizeof_type_expr@
type T;
T **x;
@@

  x =
  <+...sizeof(
- T
+ *x
  )...+>
// </smpl>

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 arch/powerpc/sysdev/mpic_msgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
index 2c9b52a..7bdf3cc 100644
--- a/arch/powerpc/sysdev/mpic_msgr.c
+++ b/arch/powerpc/sysdev/mpic_msgr.c
@@ -184,7 +184,7 @@ static int mpic_msgr_probe(struct platform_device *dev)
 		dev_info(&dev->dev, "Found %d message registers\n",
 				mpic_msgr_count);
 
-		mpic_msgrs = kzalloc(sizeof(struct mpic_msgr) * mpic_msgr_count,
+		mpic_msgrs = kcalloc(mpic_msgr_count, sizeof(*mpic_msgrs),
 							 GFP_KERNEL);
 		if (!mpic_msgrs) {
 			dev_err(&dev->dev,
-- 
1.9.1
