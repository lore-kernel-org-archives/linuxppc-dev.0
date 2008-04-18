Return-Path: <akpm@linux-foundation.org>
Date: Thu, 17 Apr 2008 21:19:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@ozlabs.org>
Subject: Re: [PATCH 1/2] Add thread_info_cache_init() to all archs
Message-Id: <20080417211905.8ff769fa.akpm@linux-foundation.org>
In-Reply-To: <1208491086.6958.381.camel@pasglop>
References: <20080410032354.90CB1DDF0F@ozlabs.org>
	<20080413171953.bde5e9ac.akpm@linux-foundation.org>
	<1208133506.6958.82.camel@pasglop>
	<20080413191338.9776ebd0.akpm@linux-foundation.org>
	<1208491086.6958.381.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-m32r@ml.linux-m32r.org,
	takata@linux-m32r.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 Apr 2008 13:58:06 +1000 Benjamin Herrenschmidt <benh@ozlabs.org> wrote:

> 
> > > > otoh, if only one .c file will ever call this function then I think that
> > > > all problems are solved by
> > > > 
> > > > a) moving the above ifdeffery into the .c file
> > > > b) adding a comment explaining which arch file must provide the override
> > > > c) directly including that file from within the .c file.
> > > 
> > > I can definitely do that. I have no problem either way. I can add to all
> > > archs too, it's just that whatever way I choose, some people won't be
> > > happy with it :-)
> > > 
> > > Anyway, I'll move the ifdeferry to init/main.c then.
> > 
> > Thanks ;)
> > 
> > I'm still wounded by my recent encounter with set_softirq_pending()
> > and or_softirq_pending().
> 
> Well, looking there, I saw we already used weak symbols for that

Yes, `weak' is a nice solution.  It does add a few bytes of text which we
could avoid with compile-time trickery, but only a very few.

Plus this is __init anyway, although I don't know how well the combination
of `weak' and __init works.


> so what
> about the patch below ?

I like it, but the compiler won't ;)

> If you're ok, I'll re-send with appropriate sob
> & adapted powerpc part.

Sure.

> +void __init __attribute__((weak) thread_info_cache_init(void)

s/weak)/weak))/
