Return-Path: <markn@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 34F46DDE05
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 11:38:06 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m421bSx9010019
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 11:37:28 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m421g5Sj158062
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 11:42:06 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m421cFxe000966
	for <linuxppc-dev@ozlabs.org>; Fri, 2 May 2008 11:38:16 +1000
From: Mark Nelson <markn@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/6] [POWERPC] Move device_to_mask() to dma-mapping.h
Date: Fri, 2 May 2008 11:38:14 +1000
References: <20080501042949.237603158@au1.ibm.com>
	<200805020947.47176.markn@au1.ibm.com>
	<b016a9cc9ea0ae22204dc6cbd583af7a@kernel.crashing.org>
In-Reply-To: <b016a9cc9ea0ae22204dc6cbd583af7a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805021138.14417.markn@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2 May 2008 10:32:35 am Segher Boessenkool wrote:
> > I'm not sure exactly what you mean - it was inline before the move.
> 
> Heh, I missed that.
> 
> > But if everybody thinks it would be better to leave it in dma_64.c and 
> > just
> > expose it for use outside, I'm fine with that.
> 
> That's what I meant, yes.

Thought so. How's this:

---
 arch/powerpc/kernel/dma_64.c      |    2 +-
 include/asm-powerpc/dma-mapping.h |    3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

Index: upstream/arch/powerpc/kernel/dma_64.c
===================================================================
--- upstream.orig/arch/powerpc/kernel/dma_64.c
+++ upstream/arch/powerpc/kernel/dma_64.c
@@ -15,7 +15,7 @@
  * Generic iommu implementation
  */
 
-static inline unsigned long device_to_mask(struct device *dev)
+unsigned long device_to_mask(struct device *dev)
 {
 	if (dev->dma_mask && *dev->dma_mask)
 		return *dev->dma_mask;
Index: upstream/include/asm-powerpc/dma-mapping.h
===================================================================
--- upstream.orig/include/asm-powerpc/dma-mapping.h
+++ upstream/include/asm-powerpc/dma-mapping.h
@@ -45,6 +45,9 @@ extern void __dma_sync_page(struct page 
 #endif /* ! CONFIG_NOT_COHERENT_CACHE */
 
 #ifdef CONFIG_PPC64
+
+extern unsigned long device_to_mask(struct device *dev);
+
 /*
  * DMA operations are abstracted for G5 vs. i/pSeries, PCI vs. VIO
  */


Thanks!

Mark.
> 
> 
> Segher
> 
