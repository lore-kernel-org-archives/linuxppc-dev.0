Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ACDBEB7129
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 11:39:28 +1000 (EST)
Subject: Re: [PATCH 05/33] block: Add bio_list_peek()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 11:39:12 +1000
Message-Id: <1245029952.19217.4.camel@pasglop>
Mime-Version: 1.0
Cc: Jens Axboe <axboe@kernel.dk>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-10 at 16:38 +0200, Geert Uytterhoeven wrote:
> Introduce bio_list_peek(), to obtain a pointer to the first bio on the bio_list
> without actually removing it from the list. This is needed when you want to
> serialize based on the list being empty or not.

Leaving that one (and the next one) out for now until Jens Ack them.

Cheers,
Ben.

> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> ---
>  include/linux/bio.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 7b214fd..618bb7d 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -590,6 +590,11 @@ static inline void bio_list_merge_head(struct bio_list *bl,
>  	bl->head = bl2->head;
>  }
>  
> +static inline struct bio *bio_list_peek(struct bio_list *bl)
> +{
> +	return bl->head;
> +}
> +
>  static inline struct bio *bio_list_pop(struct bio_list *bl)
>  {
>  	struct bio *bio = bl->head;
