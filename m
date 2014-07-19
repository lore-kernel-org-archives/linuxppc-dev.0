Return-Path: <himangi774@gmail.com>
Received: from mail-pd0-x232.google.com (mail-pd0-x232.google.com
 [IPv6:2607:f8b0:400e:c02::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A36C21A028E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Jul 2014 07:50:10 +1000 (EST)
Received: by mail-pd0-f178.google.com with SMTP id w10so6999195pde.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jul 2014 14:50:07 -0700 (PDT)
Date: Sun, 20 Jul 2014 03:19:59 +0530
From: Himangi Saraogi <himangi774@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] powerpc/fsl-pci: Correct use of ! and &
Message-ID: <20140719214958.GA22123@himangi-Dell>
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

In commit ae91d60ba88ef0bdb1b5e9b2363bd52fc45d2af7, a bug was fixed that
involved converting !x & y to !(x & y).  The code below shows the same
pattern, and thus should perhaps be fixed in the same way.

This is not tested and clearly changes the semantics, so it is only
something to consider.

The Coccinelle semantic patch that makes this change is as follows:

// <smpl>
@@ expression E1,E2; @@
(
  !E1 & !E2
|
- !E1 & E2
+ !(E1 & E2)
)
// </smpl>

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4bd091a..c507767 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -853,8 +853,8 @@ u64 fsl_pci_immrbar_base(struct pci_controller *hose)
 		in = pcie->cfg_type0 + PEX_RC_INWIN_BASE;
 		for (i = 0; i < 4; i++) {
 			/* not enabled, skip */
-			if (!in_le32(&in[i].ar) & PEX_RCIWARn_EN)
-				 continue;
+			if (!(in_le32(&in[i].ar) & PEX_RCIWARn_EN))
+				continue;
 
 			if (get_immrbase() == in_le32(&in[i].tar))
 				return (u64)in_le32(&in[i].barh) << 32 |
-- 
1.9.1
