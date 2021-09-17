Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8132C433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Sep 2021 14:33:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED9960EE2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Sep 2021 14:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2ED9960EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H9xJD3gz5z3bN5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Sep 2021 00:33:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aculab.com (client-ip=185.58.85.151;
 helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com;
 receiver=<UNKNOWN>)
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H9xHj0p8jz2yHP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Sep 2021 00:32:31 +1000 (AEST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-62-I8DWIADxNXumcC2ZvYPdxg-1; Fri, 17 Sep 2021 15:32:25 +0100
X-MC-Unique: I8DWIADxNXumcC2ZvYPdxg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Fri, 17 Sep 2021 15:32:23 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Fri, 17 Sep 2021 15:32:23 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe Leroy' <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>
Subject: RE: [PATCH v2] powerpc/32: Don't use a struct based type for pte_t
Thread-Topic: [PATCH v2] powerpc/32: Don't use a struct based type for pte_t
Thread-Index: AQHXq8wPR5JW25uF60m9xktVKLekzquoSMug
Date: Fri, 17 Sep 2021 14:32:22 +0000
Message-ID: <505920070e5f4bf8ad7ccaa12f346469@AcuMS.aculab.com>
References: <c904599f33aaf6bb7ee2836a9ff8368509e0d78d.1631887042.git.christophe.leroy@csgroup.eu>
In-Reply-To: <c904599f33aaf6bb7ee2836a9ff8368509e0d78d.1631887042.git.christophe.leroy@csgroup.eu>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy
> Sent: 17 September 2021 14:58
>=20
> Long time ago we had a config item called STRICT_MM_TYPECHECKS
> to build the kernel with pte_t defined as a structure in order
> to perform additional build checks or build it with pte_t
> defined as a simple type in order to get simpler generated code.
>=20
...
> diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/incl=
ude/asm/pgtable-types.h
> index d11b4c61d686..c60199fc6fa6 100644
> --- a/arch/powerpc/include/asm/pgtable-types.h
> +++ b/arch/powerpc/include/asm/pgtable-types.h
> @@ -5,14 +5,26 @@
>  /* PTE level */
>  #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
>  typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
> -#else
> +#elif defined(__CHECKER__) || !defined(CONFIG_PPC32)
>  typedef struct { pte_basic_t pte; } pte_t;
> +#else
> +typedef pte_basic_t pte_t;
>  #endif
> +
> +#if defined(__CHECKER__) || !defined(CONFIG_PPC32) || \
> +    (defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES))
>  #define __pte(x)=09((pte_t) { (x) })
>  static inline pte_basic_t pte_val(pte_t x)
>  {
>  =09return x.pte;
>  }
> +#else
> +#define __pte(x)=09((pte_t)(x))
> +static inline pte_basic_t pte_val(pte_t x)
> +{
> +=09return x;
> +}
> +#endif

Would it be better to define:
static inline pte_basic_*pte_basic(pte_t *x)
{
#if xxx
=09return x;
#else
=09return &x->pte;
#endif
}

Then pte_val(x) is always *pt_basic(x)
and the casts like:

> -=09pte_basic_t *entry =3D &ptep->pte;
> +=09pte_basic_t *entry =3D (pte_basic_t *)ptep;

can go away.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

