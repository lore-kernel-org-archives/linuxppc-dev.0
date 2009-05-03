Return-Path: <penberg@cs.helsinki.fi>
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD55BDDDF6
	for <linuxppc-dev@ozlabs.org>; Sun,  3 May 2009 21:51:08 +1000 (EST)
Subject: Re: Next April 28: boot failure on PowerPC with SLQB
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090430141013.GA17480@oksana.dev.rtsoft.ru>
References: <20090430041146.GB23746@wotan.suse.de>
	<49F938E4.2030703@in.ibm.com> <20090430064127.GF23746@wotan.suse.de>
	<49F973A0.8070106@in.ibm.com> <20090430103528.GA6900@wotan.suse.de>
	<1241087884.19252.5.camel@penberg-laptop>
	<20090430210004.05a61841.sfr@canb.auug.org.au>
	<20090430111825.GC6900@wotan.suse.de>
	<1241090429.19252.7.camel@penberg-laptop>
	<20090430130542.GF6900@wotan.suse.de>
	<20090430141013.GA17480@oksana.dev.rtsoft.ru>
Date: Sun, 03 May 2009 14:51:01 +0300
Message-Id: <1241351461.26995.4.camel@penberg-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Nick Piggin <npiggin@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
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

On Thu, 2009-04-30 at 18:10 +0400, Anton Vorontsov wrote:
> > @@ -2194,16 +2197,16 @@ static void *kmem_cache_dyn_array_alloc(
> >  		 * never get freed by definition so we can do it rather
> >  		 * simply.
> >  		 */
> > -		if (!nextmem) {
> > -			nextmem = alloc_pages_exact(size, GFP_KERNEL);
> > -			if (!nextmem)
> > -				return NULL;
> > +		if (size > nextleft) {
> > +                        nextmem = alloc_pages_exact(size, GFP_KERNEL);
> > +                        if (!nextmem)
> > +                                return NULL;
> 
> Cosmetic issue: spaces instead of tabs are used on these
> three lines.

I fixed that up. Thanks!
