Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3616DDDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 16:41:35 +1000 (EST)
Date: Thu, 30 Apr 2009 08:41:27 +0200
From: Nick Piggin <npiggin@suse.de>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: Next April 28: boot failure on PowerPC with SLQB
Message-ID: <20090430064127.GF23746@wotan.suse.de>
References: <20090428165343.2e357d7a.sfr@canb.auug.org.au>
	<49F6E421.401@in.ibm.com>
	<84144f020904280422s6a9a277fjc4619c904f37e5ca@mail.gmail.com>
	<20090429113604.GE3398@wotan.suse.de> <49F87FAB.9050408@in.ibm.com>
	<20090430041146.GB23746@wotan.suse.de>
	<49F938E4.2030703@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49F938E4.2030703@in.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Christoph Lameter <cl@linux-foundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 30, 2009 at 11:06:36AM +0530, Sachin Sant wrote:
> Nick Piggin wrote:
> >Well kmalloc is failing. It should not be though, even if the
> >current node is offline, it should be able to fall back to other
> >nodes. Stephen's trace indicates the same thing.
> >
> >Could you try the following patch please, and capture the output
> >it generates?
> With this patch i don't get any extra information other that what is 
> already reported.
> Have attached the boot log captured using loglevel=8 mminit_loglevel=4 
> options.

Hmm, forget that. Actually my last patch had a silly mistake because I
forgot MAX_ORDER shift is applied to PAGE_SIZE, rather than 1. So
kmalloc(PAGE_SIZE) was failing as too large.

This patch should do the trick I hope.

Thanks,
Nick
---
 include/linux/slqb_def.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/include/linux/slqb_def.h
===================================================================
--- linux-2.6.orig/include/linux/slqb_def.h
+++ linux-2.6/include/linux/slqb_def.h
@@ -172,7 +172,8 @@ struct kmem_cache {
 #endif
 
 #define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
-#define KMALLOC_SHIFT_SLQB_HIGH (PAGE_SHIFT + 9)
+#define KMALLOC_SHIFT_SLQB_HIGH (PAGE_SHIFT + 			\
+				 ((9 <= (MAX_ORDER - 1)) ? 9 : (MAX_ORDER - 1)))
 
 extern struct kmem_cache kmalloc_caches[KMALLOC_SHIFT_SLQB_HIGH + 1];
 extern struct kmem_cache kmalloc_caches_dma[KMALLOC_SHIFT_SLQB_HIGH + 1];
