Return-Path: <axboe@kernel.dk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 397B9B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 15:56:33 +1000 (EST)
Date: Mon, 15 Jun 2009 07:56:23 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 05/33] block: Add bio_list_peek()
Message-ID: <20090615055622.GZ11363@kernel.dk>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1245029952.19217.4.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1245029952.19217.4.camel@pasglop>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 15 2009, Benjamin Herrenschmidt wrote:
> On Wed, 2009-06-10 at 16:38 +0200, Geert Uytterhoeven wrote:
> > Introduce bio_list_peek(), to obtain a pointer to the first bio on the bio_list
> > without actually removing it from the list. This is needed when you want to
> > serialize based on the list being empty or not.
> 
> Leaving that one (and the next one) out for now until Jens Ack them.

You can add my acked-by, this one is trivial and a good addition.

> 
> Cheers,
> Ben.
> 
> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > ---
> >  include/linux/bio.h |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index 7b214fd..618bb7d 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -590,6 +590,11 @@ static inline void bio_list_merge_head(struct bio_list *bl,
> >  	bl->head = bl2->head;
> >  }
> >  
> > +static inline struct bio *bio_list_peek(struct bio_list *bl)
> > +{
> > +	return bl->head;
> > +}
> > +
> >  static inline struct bio *bio_list_pop(struct bio_list *bl)
> >  {
> >  	struct bio *bio = bl->head;
> 

-- 
Jens Axboe
