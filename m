Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3hVw24ySzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 23:30:32 +1000 (AEST)
Date: Thu, 13 Apr 2017 15:30:27 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, "Leonidas S. Barbosa"
 <leosilva@linux.vnet.ibm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S.
 Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: vmx: Remove dubiously licensed crypto code
Message-ID: <20170413153027.01e34e1f@kitsune.suse.cz>
In-Reply-To: <8591ac8ff6ef6fa9c4bd264017ac360d@linux.vnet.ibm.com>
References: <20170329125639.14288-1-msuchanek@suse.de>
 <20170329145135.GA28057@kroah.com>
 <20170329171327.38d4fdd6@kitsune.suse.cz>
 <7ec54553-610c-a5dc-d4d9-3c83f6a161d9@linux.vnet.ibm.com>
 <8591ac8ff6ef6fa9c4bd264017ac360d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 30 Mar 2017 13:30:17 -0300
Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com> wrote:

> On 2017-03-29 20:08, Tyrel Datwyler wrote:
> > On 03/29/2017 08:13 AM, Michal Such=C3=A1nek wrote: =20
> >> On Wed, 29 Mar 2017 16:51:35 +0200
> >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >>  =20
> >>> On Wed, Mar 29, 2017 at 02:56:39PM +0200, Michal Suchanek wrote: =20
> >>>> While reviewing commit 11c6e16ee13a ("crypto: vmx - Adding asm
> >>>> subroutines for XTS") which adds the OpenSSL license header to
> >>>> drivers/crypto/vmx/aesp8-ppc.pl licensing of this driver came
> >>>> into qestion. The whole license reads:
> >>>>=20
> >>>>  # Licensed under the OpenSSL license (the "License").  You may
> >>>> not use # this file except in compliance with the License.  You
> >>>> can obtain a # copy
> >>>>  # in the file LICENSE in the source distribution or at
> >>>>  # https://www.openssl.org/source/license.html
> >>>>=20
> >>>>  #
> >>>>  #
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> # Written by Andy Polyakov <appro@openssl.org> for the OpenSSL #
> >>>> project. The module is, however, dual licensed under OpenSSL and
> >>>> # CRYPTOGAMS licenses depending on where you obtain it. For
> >>>> further # details see http://www.openssl.org/~appro/cryptogams/.
> >>>> #
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>=20
> >>>> After seeking legal advice it is still not clear that this driver
> >>>> can be legally used in Linux. In particular the "depending on
> >>>> where you obtain it" part does not make it clear when you can
> >>>> apply the GPL and when the OpenSSL license.
> >>>>=20
> >>>> I tried contacting the author of the code for clarification but
> >>>> did not hear back. In absence of clear licensing the only
> >>>> solution I see is removing this code. =20
> >=20
> > A quick 'git grep OpenSSL' of the Linux tree returns several other
> > crypto files under the ARM architecture that are similarly
> > licensed. Namely:
> >=20
> > arch/arm/crypto/sha1-armv4-large.S
> > arch/arm/crypto/sha256-armv4.pl
> > arch/arm/crypto/sha256-core.S_shipped
> > arch/arm/crypto/sha512-armv4.pl
> > arch/arm/crypto/sha512-core.S_shipped
> > arch/arm64/crypto/sha256-core.S_shipped
> > arch/arm64/crypto/sha512-armv8.pl
> > arch/arm64/crypto/sha512-core.S_shipped
> >=20
> > On closer inspection of some of those files have the addendum that
> > "Permission to use under GPL terms is granted", but not all of them.
> >=20
> > -Tyrel =20
>=20
> In 2015, Andy Polyakov, the author, replied in this mailing list [1]:
>=20
> "I have no problems with reusing assembly modules in kernel context.
> The whole idea behind cryptogams initiative was exactly to reuse code
> in different contexts."
>=20
> [1] https://patchwork.kernel.org/patch/6027481/
>=20

So what? You also got a statement from whoever is relevant from OpenSSL
from where this code is obviously merged? Even if you did has the
e-mail discussion any value whatsoever?

Neither is a replacement for including a proper license statement with
the code. Not by reference to an e-mail discussion or a web site.

Thanks

Michal
