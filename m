Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3619F1A198F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 15:28:13 +1000 (AEST)
Message-ID: <1432272492.29160.32.camel@neuling.org>
Subject: Re: [PATCH 15/19] cxl: Configure PSL for kernel contexts
From: Michael Neuling <mikey@neuling.org>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: mpe <mpe@ellerman.id.au>, benh <benh@kernel.crashing.org>, "Matthew R.
 Ochs" <mrochs@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking
 <brking@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Date: Fri, 22 May 2015 15:28:12 +1000
In-Reply-To: <1432199871-sup-8243@delenn.ozlabs.ibm.com>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
 <1432034556-32400-16-git-send-email-mikey@neuling.org>
 <1432199871-sup-8243@delenn.ozlabs.ibm.com>
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

On Thu, 2015-05-21 at 19:32 +1000, Ian Munsie wrote:
> Excerpts from Michael Neuling's message of 2015-05-19 21:22:32 +1000:
> > +    if (ctx->kernel) {
> > +        sr |=3D CXL_PSL_SR_An_R | (mfmsr() & MSR_SF) | CXL_PSL_SR_An_H=
V;
> > +        pid =3D 0;
> > +    } else {
> > +        sr |=3D CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
>=20
> CXL_PSL_SR_An_R is common between these two cases - you could probably
> move it to the initial sr =3D ... line instead of here.
>=20
> > +        set_endian(sr);
>=20
> We should call set_endian(sr) for kernel contexts as well.
>=20
> > +    if (ctx->kernel) {
> > +        sr |=3D CXL_PSL_SR_An_R | (mfmsr() & MSR_SF) | CXL_PSL_SR_An_H=
V;
> > +        pid =3D 0;
> > +    } else { /* User space */
> > +        sr |=3D CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
>=20
> CXL_PSL_SR_An_R is common here as well.

Yeah, I meant to merge these.  Will do.

Mikey
