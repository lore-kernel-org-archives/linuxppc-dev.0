Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7DE6DE083
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 20:37:40 +1000 (EST)
Subject: Re: powerpc stacktrace and lockdep support
From: Johannes Berg <johannes@sipsolutions.net>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <1183713827.3818.71.camel@johannes.berg>
References: <20070108135458.GA23395@lst.de>
	<1182898073.4769.6.camel@johannes.berg>
	<1182970829.4769.62.camel@johannes.berg>
	<1183047642.3735.0.camel@johannes.berg> <20070630085808.GA15386@lst.de>
	<1183588814.3818.1.camel@johannes.berg>
	<1183713827.3818.71.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+dCgfBqgYCg2eSin6u0A"
Date: Fri, 06 Jul 2007 11:54:21 +0200
Message-Id: <1183715661.3818.91.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+dCgfBqgYCg2eSin6u0A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

*sigh* I really shouldn't have mailed this out in the first place. Every
time I look at it I find new bugs despite the fact that it actually
works on my machine.

>  	ld	r3,SOFTE(r1)
> -	bl	.local_irq_restore
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	cmpdi	r3,0
> +	beq	14f
> +	bl	.trace_hardirqs_on
> +	ld	r3,SOFTE(r1)
> +14:
> +	bl	.raw_local_irq_restore
> +	cmpdi	r3,0

This should reload r3 before the second compare as raw_local_irq_restore
returns nothing (void). And why does it need a second compare anyway?
Just rewrite as

	ld	r3, SOFTE(r1)
#ifdef CONFIG_TRACE_IRQFLAGS
	cmpdi	r3, 0
	bne	14f
	bl	.raw_local_irq_restore
	bl	.trace_hardirqs_off
	b	15f
14:
	bl	.trace_hardirqs_on
	li	r3, 1
#endif
	bl	.raw_local_irq_restore
15:

which has the advantage of having only one conditional branch and less
preprocessor foo.

> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	cmpdi	r5,0
> +	beq	5f
> +	bl	.trace_hardirqs_on
> +	ld	r5,SOFTE(r1)
>  	stb	r5,PACASOFTIRQEN(r13)
> -
> +	b	6f
> +5:
> +	stb	r5,PACASOFTIRQEN(r13)
> +	bl	.trace_hardirqs_off
> +6:
> +#else
> +	stb	r5,PACASOFTIRQEN(r13)
> +#endif

Similarly, that could be rewritten as

#ifdef CONFIG_TRACE_IRQFLAGS
	cmpdi	r5, 0
	bne	5f
	stb	r5, PACASOFTIRQEN(r13)
	bl	.trace_hardirqs_off
	b	6f
5:
	bl	.trace_hardirqs_on
	li	r5, 1
#endif
	stb	r5, PACASOFTIRQEN(r13)
6:

I can't test these modifications over the weekend but they should be
fine.

johannes

--=-+dCgfBqgYCg2eSin6u0A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGjhFN/ETPhpq3jKURArX7AJwOKM43q+iFsvhfvoR65iYmCJaGkQCglfvM
WL57Ru2e65Kd8s57eOB4dFc=
=KURj
-----END PGP SIGNATURE-----

--=-+dCgfBqgYCg2eSin6u0A--
