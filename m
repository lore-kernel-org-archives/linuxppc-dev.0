Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9E26567A72
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 10:36:07 +1100 (EST)
Date: Thu, 17 Feb 2005 15:36:05 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
Message-ID: <20050217233605.GA10915@gate.ebshome.net>
References: <45ABD2373C33C4459D42B40EC4F346F205E1A4F0@FTWMLVEM03.e2k.ad.ge.com>
	<20050217225414.GA32623@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050217225414.GA32623@gate.ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 440GX interrupt
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 17, 2005 at 02:54:14PM -0800, Eugene Surovegin wrote:
> Probably it's a race which cannot be avoided anyway because external 
> IRQs are completely async, and your version of ppc4xx_pic.c just has a 
> bug. I'll think about it a little more.

Uhh, yes, I think it's a bug in 4xx version of disable_irq.

We have to ACK parent UIC after disabling IRQ to prevent false 
triggering in case this IRQ was already pending during disable_irq 
call.

Here is a patch against current 2.6, so you can get an idea what I'm 
talking about :):

===== arch/ppc/syslib/ppc4xx_pic.c 1.13 vs edited =====
--- 1.13/arch/ppc/syslib/ppc4xx_pic.c	2005-01-03 15:49:19 -08:00
+++ edited/arch/ppc/syslib/ppc4xx_pic.c	2005-02-17 15:31:07 -08:00
@@ -48,6 +48,7 @@
 {									\
 	ppc_cached_irq_mask[n] &= ~IRQ_MASK_UIC##n(irq);		\
 	mtdcr(DCRN_UIC_ER(UIC##n), ppc_cached_irq_mask[n]);		\
+	ACK_UIC##n##_PARENT						\
 }									\
 									\
 static void ppc4xx_uic##n##_ack(unsigned int irq)			\


You can send me your version of ppc4xx_pic.c or put it somewhere on 
www and I'll make a patch for it.

--
Eugene
