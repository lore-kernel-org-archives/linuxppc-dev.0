Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3C0EDDE25
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 12:08:04 +1100 (EST)
Date: Thu, 11 Dec 2008 17:07:02 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH][v2] fork_init: fix division by zero
Message-Id: <20081211170702.fc880a5c.akpm@linux-foundation.org>
In-Reply-To: <18753.46301.944770.779390@cargo.ozlabs.ibm.com>
References: <200812101950.51958.yur@emcraft.com>
	<20081211121635.ff58193f.akpm@linux-foundation.org>
	<18753.46301.944770.779390@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: wd@denx.de, dzu@denx.de, linux-kernel@vger.kernel.org, miltonm@bga.com,
	linuxppc-dev@ozlabs.org, Geert.Uytterhoeven@sonycom.com,
	yanok@emcraft.com, viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 12 Dec 2008 11:48:29 +1100 Paul Mackerras <paulus@samba.org> wrote:

> Andrew Morton writes:
> 
> > > +#if (8 * THREAD_SIZE) > PAGE_SIZE
> > >  	max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);
> > > +#else
> > > +	max_threads = mempages * (PAGE_SIZE / (8 * THREAD_SIZE));
> > > +#endif
> > 
> > The expression you've chosen here can be quite inacccurate, because
> > ((PAGE_SIZE / (8 * THREAD_SIZE)) is a small number.  The way to
> > preserve accuracy is
> 
> The assumption is that THREAD_SIZE is a power of 2, as is PAGE_SIZE.
> 
> I think Yuri should be increasing THREAD_SIZE for the larger page
> sizes he's implementing, because we have on-stack arrays whose size
> depends on the page size.  I suspect that having THREAD_SIZE less than
> 1/8 of PAGE_SIZE risks stack overflows, and the better fix is for Yuri
> to make sure THREAD_SIZE is at least 1/8 of PAGE_SIZE.  (In fact, more
> may be needed - someone should work out what fraction is actually
> needed.)

OK, yes.

It's the MAX_BUF_PER_PAGE arrays which will hurt.  iirc they nest
three-deep on some codepaths.
