Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41884DDEE9
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2008 09:56:38 +1100 (EST)
Subject: Re: [BUG/RFC/PATCH] drm: Fix for non-coherent DMA PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20080302223012.90210@gmx.net>
References: <20071125234254.B4405DDE49@ozlabs.org>
	<20080302110505.175270@gmx.net> <1204490829.15052.482.camel@pasglop>
	<20080302223012.90210@gmx.net>
Content-Type: text/plain
Date: Mon, 03 Mar 2008 09:56:09 +1100
Message-Id: <1204498569.15052.488.camel@pasglop>
Mime-Version: 1.0
Cc: airlied@linux.ie, linuxppc-dev@ozlabs.org, dri-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bah, I think I found the problem:

+static inline void *drm_vmalloc_dma(unsigned long size)
+{
+#if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
+       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM,
+                        PAGE_KERNEL | _PAGE_NO_CACHE);
+#else
+       return vmalloc_32(size);
+#endif
+}
+

Remove the GFP_HIGHMEM from the above. It looks like our cache
flushing isn't going to work for highmem, it would need some
kmap's for that.

Ben.
