Return-Path: <smaclennan@pikatech.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B2344B7169
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 07:56:11 +1000 (EST)
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 5E012DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 07:56:06 +1000 (EST)
Date: Wed, 10 Jun 2009 17:56:02 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: next branch update
Message-ID: <20090610175602.722bf68d@lappy.seanm.ca>
In-Reply-To: <1242890760.5109.1.camel@pasglop>
References: <1242890760.5109.1.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

What ever happened to this patch?

diff --git b/arch/powerpc/platforms/44x/warp.c
a/arch/powerpc/platforms/44x/warp.c index c511880..7f3c1c7 100644
--- b/arch/powerpc/platforms/44x/warp.c
+++ a/arch/powerpc/platforms/44x/warp.c
@@ -43,7 +43,13 @@ static int __init warp_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	return of_flat_dt_is_compatible(root, "pika,warp");
+	if (!of_flat_dt_is_compatible(root, "pika,warp"))
+		return 0;
+
+	/* For __dma_alloc_coherent */
+	ISA_DMA_THRESHOLD = ~0L;
+
+	return 1;
 }
 
I don't see it in patchworks and I don't see it in Ben's or Josh's tree.

Cheers,
   Sean
