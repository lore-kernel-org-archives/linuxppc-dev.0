Return-Path: <penberg@cs.helsinki.fi>
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 337DEDDF11
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 21:20:34 +1000 (EST)
Subject: Re: Next April 28: boot failure on PowerPC with SLQB
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20090430111825.GC6900@wotan.suse.de>
References: <84144f020904280422s6a9a277fjc4619c904f37e5ca@mail.gmail.com>
	<20090429113604.GE3398@wotan.suse.de> <49F87FAB.9050408@in.ibm.com>
	<20090430041146.GB23746@wotan.suse.de> <49F938E4.2030703@in.ibm.com>
	<20090430064127.GF23746@wotan.suse.de> <49F973A0.8070106@in.ibm.com>
	<20090430103528.GA6900@wotan.suse.de>
	<1241087884.19252.5.camel@penberg-laptop>
	<20090430210004.05a61841.sfr@canb.auug.org.au>
	<20090430111825.GC6900@wotan.suse.de>
Date: Thu, 30 Apr 2009 14:20:29 +0300
Message-Id: <1241090429.19252.7.camel@penberg-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Christoph Lameter <cl@linux-foundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-30 at 13:18 +0200, Nick Piggin wrote:
> OK thanks. So I think we have 2 problems. One with MAX_ORDER <= 9
> that is fixed by the previous patch, and another which is probably
> due to having no memory on node 0 which I will take another look
> at now.
> 
> We can merge the previous patch now, though.

Hmm, I'll bet this BUG_ON triggers for Stephen.

diff --git a/mm/slqb.c b/mm/slqb.c
index a651843..e4b3859 100644
--- a/mm/slqb.c
+++ b/mm/slqb.c
@@ -1391,6 +1391,7 @@ static noinline void *__slab_alloc_page(struct kmem_cache *s,
 		struct kmem_cache_node *n;
 
 		n = s->node_slab[slqb_page_to_nid(page)];
+		BUG_ON(!n);
 		l = &n->list;
 		page->list = l;
 
