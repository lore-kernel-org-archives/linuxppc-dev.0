Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xky3J5K6fzDqXs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Sep 2017 23:42:36 +1000 (AEST)
Message-ID: <1504359756.4728.7.camel@neuling.org>
Subject: Re: [PATCH V3 6/6] crypto/nx: Add P9 NX support for 842 compression
 engine
From: Michael Neuling <mikey@neuling.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>, Dan Streetman <ddstreet@ieee.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Ram Pai <linuxram@us.ibm.com>,
 npiggin@gmail.com, suka@us.ibm.com, Linux Crypto Mailing List
 <linux-crypto@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Date: Sat, 02 Sep 2017 23:42:36 +1000
In-Reply-To: <59AA6E71.8070704@linux.vnet.ibm.com>
References: <1500699702.23205.8.camel@hbabu-laptop>
 <CALZtONBGVQy2iwkb8WpVd-_QG7bLFTvUbnuub6CCXP55YpQiSQ@mail.gmail.com>
 <59AA6E71.8070704@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > > +static int nx842_powernv_crypto_init_vas(struct crypto_tfm *tfm)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nx842_crypto_ctx *c=
tx =3D crypto_tfm_ctx(tfm);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nx842_workmem *wmem=
;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nx842_coproc *copro=
c;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D nx842_crypto_init(=
tfm, &nx842_powernv_driver);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wmem =3D PTR_ALIGN((struct=
 nx842_workmem *)ctx->wmem,
> > > WORKMEM_ALIGN);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0coproc =3D per_cpu(coproc_=
inst, smp_processor_id());
> >=20
> > this is wrong.=C2=A0=C2=A0the crypto transform init function is not gua=
ranteed
> > to be called by the same processor that later uses it.=C2=A0=C2=A0Just =
because
> > that happens to be how zswap operates doesn't guarantee other crypto
> > users will do the same.
>=20
> Dan, Sorry missed this comment.=C2=A0
>=20
> Right, The actual crypto request can be executed on other processor than =
the
> CPU when the init is executed. The main goal is open send window on the N=
X
> engine which is on the same chip for the corresponding CPU. So we are OK =
if
> the request is scheduled on other CPU as long as it belongs to same chip.
> Otherwise in the worst case we will end up using remote NX.=C2=A0=C2=A0

You want the NX to be close to the requester CPU, but probably more importa=
ntly
you want the NX close to the memory it's going to be operating on.=C2=A0

Preferably they would all be on the same node.

Mikey=20
