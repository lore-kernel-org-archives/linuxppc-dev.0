Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e6.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6CAB32C0087
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2012 16:53:54 +1100 (EST)
Received: from /spool/local
 by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 18 Oct 2012 01:53:51 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 58A4038C803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2012 01:53:49 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9I5rm87257822
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2012 01:53:48 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9I5rlCP014896
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2012 23:53:48 -0600
Date: Thu, 18 Oct 2012 13:53:30 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pnv: Avoid bogus output
Message-ID: <20121018055330.GA9360@shangw.(null)>
References: <1350528404-8009-1-git-send-email-shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
In-Reply-To: <1350528404-8009-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 18, 2012 at 10:46:44AM +0800, Gavin Shan wrote:
>There're couples of functions defined to print debugging messages
>during initializing P7IOC. However, we got bogus output from those
>functions like pe_info(). The problem here is that the message
>level (the first parameter to printk()) isn't printable and that
>caused the bogus output.
>
>The patch fixes the issue by merging __pe_printk() to the macro
>define_pe_printk_level() so that we can pass the message level
>directly to printk().
>
>Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>---
> arch/powerpc/platforms/powernv/pci-ioda.c |   25 +++++++++++--------------
> 1 files changed, 11 insertions(+), 14 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 07ce33c..ff7e7a1 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -34,24 +34,12 @@
> #include "powernv.h"
> #include "pci.h"
>
>-static int __pe_printk(const char *level, const struct pnv_ioda_pe *pe,
>-		       struct va_format *vaf)
>-{
>-	char pfix[32];
>-
>-	if (pe->pdev)
>-		strlcpy(pfix, dev_name(&pe->pdev->dev), sizeof(pfix));
>-	else
>-		sprintf(pfix, "%04x:%02x     ",
>-			pci_domain_nr(pe->pbus), pe->pbus->number);
>-	return printk("pci %s%s: [PE# %.3d] %pV", level, pfix, pe->pe_number, vaf);
>-}
>-
> #define define_pe_printk_level(func, kern_level)		\
> static int func(const struct pnv_ioda_pe *pe, const char *fmt, ...)	\
> {								\
> 	struct va_format vaf;					\
> 	va_list args;						\
>+	char pfix[32];						\
> 	int r;							\
> 								\
> 	va_start(args, fmt);					\
>@@ -59,7 +47,16 @@ static int func(const struct pnv_ioda_pe *pe, const char *fmt, ...)	\
> 	vaf.fmt = fmt;						\
> 	vaf.va = &args;						\
> 								\
>-	r = __pe_printk(kern_level, pe, &vaf);			\
>+	if (pe->pdev)						\
>+		strlcpy(pfix, dev_name(&pe->pdev->dev),		\
>+			sizeof(pfix));				\
>+        else							\
>+                sprintf(pfix, "%04x:%02x     ",			\
>+                        pci_domain_nr(pe->pbus),		\

The space before sprintf() should be replaced by "tab" as
the attached patch :-)

>+			pe->pbus->number);			\
>+	r = printk(kern_level "pci %s: [PE# %.3d] %pV",		\
>+		   pfix, pe->pe_number, &vaf);			\
>+								\
> 	va_end(args);						\
> 								\
> 	return r;	 					\

Thanks,
Gavin


--mP3DRpeJDSE+ciuQ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-powerpc-pnv-Avoid-bogus-output.patch"

>From 4ee539b85676c986122087fe84d59e3b764396d5 Mon Sep 17 00:00:00 2001
From: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Thu, 18 Oct 2012 10:09:12 +0800
Subject: [PATCH] powerpc/pnv: Avoid bogus output

There're couples of functions defined to print debugging messages
during initializing P7IOC. However, we got bogus output from those
functions like pe_info(). The problem here is that the message
level (the first parameter to printk()) isn't printable and that
caused the bogus output.

The patch fixes the issue by merging __pe_printk() to the macro
define_pe_printk_level() so that we can pass the message level
directly to printk().

Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 07ce33c..7687778 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -34,24 +34,12 @@
 #include "powernv.h"
 #include "pci.h"
 
-static int __pe_printk(const char *level, const struct pnv_ioda_pe *pe,
-		       struct va_format *vaf)
-{
-	char pfix[32];
-
-	if (pe->pdev)
-		strlcpy(pfix, dev_name(&pe->pdev->dev), sizeof(pfix));
-	else
-		sprintf(pfix, "%04x:%02x     ",
-			pci_domain_nr(pe->pbus), pe->pbus->number);
-	return printk("pci %s%s: [PE# %.3d] %pV", level, pfix, pe->pe_number, vaf);
-}
-
 #define define_pe_printk_level(func, kern_level)		\
 static int func(const struct pnv_ioda_pe *pe, const char *fmt, ...)	\
 {								\
 	struct va_format vaf;					\
 	va_list args;						\
+	char pfix[32];						\
 	int r;							\
 								\
 	va_start(args, fmt);					\
@@ -59,7 +47,16 @@ static int func(const struct pnv_ioda_pe *pe, const char *fmt, ...)	\
 	vaf.fmt = fmt;						\
 	vaf.va = &args;						\
 								\
-	r = __pe_printk(kern_level, pe, &vaf);			\
+	if (pe->pdev)						\
+		strlcpy(pfix, dev_name(&pe->pdev->dev),		\
+			sizeof(pfix));				\
+	else							\
+		sprintf(pfix, "%04x:%02x     ",			\
+			pci_domain_nr(pe->pbus),		\
+			pe->pbus->number);			\
+	r = printk(kern_level "pci %s: [PE# %.3d] %pV",		\
+		   pfix, pe->pe_number, &vaf);			\
+								\
 	va_end(args);						\
 								\
 	return r;						\
-- 
1.7.5.4


--mP3DRpeJDSE+ciuQ--
