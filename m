Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 63A37679F2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 15:17:11 +1000 (EST)
In-Reply-To: <6f231f4afce0886929ca99426a86b47a@embeddededge.com>
References: <20050505172035.GB3339@logos.cnet>
	<1b2c7da800815bcdd76ddf27a2ab9c55@embeddededge.com>
	<20050506133858.GA6032@logos.cnet>
	<3ebef94782a6090ac3eb44bd7e78efbf@embeddededge.com>
	<20050506200338.GC14486@logos.cnet>
	<84773f72b8bba863c9471c0d121223a8@embeddededge.com>
	<20050506230523.GA15908@logos.cnet>
	<6f231f4afce0886929ca99426a86b47a@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <74ed4a55c402b0e380ab4bdbd92e00d6@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 7 May 2005 01:16:36 -0400
To: Dan Malek <dan@embeddededge.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: fix usage of pinned 8Mbyte TLB entries
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



The following patch is needed to properly wire the TLB
entries on the newer 8xx processors.  I think it will work
on all of them with sufficient entries to allow the pinning.
Don't do this on an 823 or 850.

	-- Dan

--- linux-2.6.11.5/arch/ppc/kernel/head_8xx.S   2005-03-19 
01:34:56.000000000 -0500
+++ linux-2.6-tlbpin/arch/ppc/kernel/head_8xx.S 2005-05-07 
00:57:32.000000000 -0400
@@ -663,7 +663,7 @@
	tlbia                   /* Invalidate all TLB entries */
  #ifdef CONFIG_PIN_TLB
	lis     r8, MI_RSV4I@h
-	ori     r8, r8, 0x1c00
+	ori     r8, r8, 0x1f00
  #else
	li      r8, 0
  #endif
@@ -671,7 +671,7 @@

  #ifdef CONFIG_PIN_TLB
	lis     r10, (MD_RSV4I | MD_RESETVAL)@h
-	ori     r10, r10, 0x1c00
+	ori     r10, r10, 0x1f00
	mr      r8, r10
  #else
	lis     r10, MD_RESETVAL@h
