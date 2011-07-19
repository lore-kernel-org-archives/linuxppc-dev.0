Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 76847B73C8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 18:54:55 +1000 (EST)
Received: by mail-ew0-f51.google.com with SMTP id 6so1840091ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:54:54 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 06/14] 85xx/sbc8560: correct compilation if
	CONFIG_PHYS_ADDR_T_64BIT is set
Date: Tue, 19 Jul 2011 12:53:43 +0400
Message-Id: <1311065631-3429-7-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If CONFIG_PHYS_ADDR_T_64BIT is set, compilation of sbc8560 fails with
the following error:

arch/powerpc/platforms/85xx/sbc8560.c: In function ‘sbc8560_bdrstcr_init’:
arch/powerpc/platforms/85xx/sbc8560.c:286: error: format ‘%x’ expects type ‘unsigned int’, but argument 2 has type ‘resource_size_t’

Fix that by using %pR format instead of just printing the start of
resource.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/85xx/sbc8560.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index d2dfd46..678f5a8 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -283,7 +283,7 @@ static int __init sbc8560_bdrstcr_init(void)
 
 	of_address_to_resource(np, 0, &res);
 
-	printk(KERN_INFO "sbc8560: Found BRSTCR at i/o 0x%x\n", res.start);
+	printk(KERN_INFO "sbc8560: Found BRSTCR at %pR\n", &res);
 
 	brstcr = ioremap(res.start, res.end - res.start);
 	if(!brstcr)
-- 
1.7.2.5
