Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415JKJ33RkzF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 17:29:08 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5D7SvSv126368
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 03:29:06 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jjuv2xya1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 03:29:05 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Wed, 13 Jun 2018 01:29:04 -0600
Subject: [PATCH V3 1/2] powerpc/powernv: Export opal_check_token symbol
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: herbert@gondor.apana.org.au, stewart@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Jun 2018 00:28:57 -0700
Mime-Version: 1.0
Message-Id: <1528874937.14408.2.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Export opal_check_token symbol for modules to check the availability
of OPAL calls before using them.

Signed-off-by: Haren Myneni <haren@us.ibm.com>

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 48fbb41..838b79b 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -923,6 +923,7 @@ void opal_shutdown(void)
 EXPORT_SYMBOL_GPL(opal_flash_write);
 EXPORT_SYMBOL_GPL(opal_flash_erase);
 EXPORT_SYMBOL_GPL(opal_prd_msg);
+EXPORT_SYMBOL_GPL(opal_check_token);
 
 /* Convert a region of vmalloc memory to an opal sg list */
 struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
