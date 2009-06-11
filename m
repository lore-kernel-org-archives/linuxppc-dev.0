Return-Path: <smaclennan@pikatech.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 77DD1B7178
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 11:09:29 +1000 (EST)
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 43025DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 11:09:26 +1000 (EST)
Date: Wed, 10 Jun 2009 21:09:23 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: next branch update
Message-ID: <20090610210923.2323202f@lappy.seanm.ca>
In-Reply-To: <1244681452.5739.7.camel@pasglop>
References: <1242890760.5109.1.camel@pasglop>
	<20090610175602.722bf68d@lappy.seanm.ca>
	<1244681452.5739.7.camel@pasglop>
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

On Thu, 11 Jun 2009 10:50:52 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> n Wed, 2009-06-10 at 17:56 -0400, Sean MacLennan wrote:
> > What ever happened to this patch?  
> 
> Dunno... It should have been in patchwork. I remember the patch
> in fact and I intended to merge it... Can you re-submit with
> appropriate cset comment, signed-off-by etc... ?
> 
> (Mistakes -do- happen, which is why we can be flexible with the rules,
> btw, but heh, 33 new patches the day the merge window opens is a bit
> over the top).

I was expecting an rc9 and another week. Probably others where caught
off guard. Patch below.

Cheers,
   Sean

If no device is passed to __dma_alloc_coherent, it defaults to using ISA_DMA_THRESHOLD
for the mask. This patch provides a reasonable default rather than 0.

Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index 21ff868..7f3c1c7 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
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
 
 define_machine(warp) {
