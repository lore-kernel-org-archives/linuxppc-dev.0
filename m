Date: Wed, 29 May 2002 13:48:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: Armin <akuster@pacbell.net>,
	Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
Message-ID: <20020529034854.GC16537@zax>
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county> <20020528005728.GO16537@zax> <20020528012516.GE1295@opus.bloom.county> <3CF32B87.4010908@pacbell.net> <20020528065027.GT16537@zax> <3CF3612B.8020102@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CF3612B.8020102@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 28, 2002 at 06:51:23AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> >...  In some ways, since we're PPC specific anyway, I think it would
> >make as much sense as anything just to directly call
> >dcache_flush_range() and so forth, rather than consistent_sync() or
> >dma_cache_*().
>
> Yes, that's true.  These consistent_* functions were added when we
> started using non-PCI drivers that are common across multiple platforms.
> It seems none of the platforms had common names for data cache management
> functions, so people started using the consistent_sync() in it's place.
> It also made sense because they were using the other consistent_* functions
> as well.  No one probably noticed, but at the same time we also changed
> the cache management function names to be similar to other architectures
> as well.

Well, actually, dma_cache_wback() and friends still appear to be more
widely used than consistent_sync().  AFAICT only PPC and ARM use
consistent_sync().

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
