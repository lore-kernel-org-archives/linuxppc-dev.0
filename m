Return-Path: <afleming@gmail.com>
Received: from mail-ig0-x22c.google.com (mail-ig0-x22c.google.com
 [IPv6:2607:f8b0:4001:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C62681A1E41
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 03:23:38 +1000 (AEST)
Received: by igbkq10 with SMTP id kq10so30141217igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2015 10:23:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1441212781.4966.166.camel@freescale.com>
References: <1441175814-14940-1-git-send-email-afleming@gmail.com>
 <1441212781.4966.166.camel@freescale.com>
Date: Wed, 2 Sep 2015 12:23:36 -0500
Message-ID: <CAKWjMd60FAMPpwGyw9=A1kPzhsBCxne99V-AL=9+94AEKKA4tg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/85xx: Add support for Varisys Cyrus board
From: Andy Fleming <afleming@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 2, 2015 at 11:53 AM, Scott Wood <scottwood@freescale.com> wrote:
>
> On Wed, 2015-09-02 at 01:36 -0500, Andy Fleming wrote:
> > This board uses a P5020 or P5040 chip, and boots just fine using
> > the corenet_generic code. The device tree is very similar to the
> > P5020DS, except that there is no Flash memory. The environment is,
> > instead, stored on an MMC card on the motherboard.
> >
> > Signed-off-by: Andy Fleming <afleming@gmail.com>
> > ---
> >  arch/powerpc/boot/dts/cyrus.dts               | 175
> > ++++++++++++++++++++++++++
> >  arch/powerpc/platforms/85xx/corenet_generic.c |   1 +
> >  2 files changed, 176 insertions(+)
> >  create mode 100644 arch/powerpc/boot/dts/cyrus.dts
> >
> > diff --git a/arch/powerpc/boot/dts/cyrus.dts
> > b/arch/powerpc/boot/dts/cyrus.dts
> > new file mode 100644
> > index 0000000..07fe509
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/cyrus.dts
> > @@ -0,0 +1,175 @@
> > +/*
> > + * P5020DS Device Tree Source
> > + *
> > + * Copyright 2010 - 2014 Freescale Semiconductor Inc.
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions are
> > met:
> > + *     * Redistributions of source code must retain the above copyright
> > + *       notice, this list of conditions and the following disclaimer.
> > + *     * Redistributions in binary form must reproduce the above copyright
> > + *       notice, this list of conditions and the following disclaimer in
> > the
> > + *       documentation and/or other materials provided with the
> > distribution.
> > + *     * Neither the name of Freescale Semiconductor nor the
> > + *       names of its contributors may be used to endorse or promote
> > products
> > + *       derived from this software without specific prior written
> > permission.
> > + *
> > + *
> > + * ALTERNATIVELY, this software may be distributed under the terms of the
> > + * GNU General Public License ("GPL") as published by the Free Software
> > + * Foundation, either version 2 of that License or (at your option) any
> > + * later version.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
> > + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> > IMPLIED
> > + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> > + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
> > + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> > DAMAGES
> > + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> > SERVICES;
> > + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
> > AND
> > + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> > TORT
> > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> > OF THIS
> > + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + */
> > +
> > +/include/ "fsl/p5020si-pre.dtsi"
>
> What happens when the board has a p5040?


Hmm...I hadn't thought of that. I can respin the dts to be
cyrus_5020.dts, and provide a cyrus_5040.dts later. That version of
the product doesn't exist yet. Does that make sense?


>
> > +
> > +/ {
> > +     model = "fsl,P5020DS";
> > +     compatible = "fsl,P5020DS";
>
> This is not a P5020DS.


Well that's just a stupid mistake I made when I remade the device tree
by copying the 5020. I'll fix this.


>
> > diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c
> > b/arch/powerpc/platforms/85xx/corenet_generic.c
> > index b395571..76e521e 100644
> > --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> > +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> > @@ -161,6 +161,7 @@ static const char * const boards[] __initconst = {
> >       "fsl,T1042RDB",
> >       "fsl,T1042RDB_PI",
> >       "keymile,kmcoge4",
> > +     "varisys,CYRUS",
> >       NULL
>
> I don't see this compatible in the dts.  Why allcaps?

I wondered about the allcaps, too, but there are already systems
floating around, possibly with dtbs with that compatible in there. I'm
reluctant to change it.

Andy
