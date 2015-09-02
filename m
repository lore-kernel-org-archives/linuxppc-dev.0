Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0119.outbound.protection.outlook.com [157.56.110.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 271ED1A234F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 03:43:53 +1000 (AEST)
Message-ID: <1441215814.4966.168.camel@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: Add support for Varisys Cyrus board
From: Scott Wood <scottwood@freescale.com>
To: Andy Fleming <afleming@gmail.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Kumar
 Gala" <galak@kernel.crashing.org>
Date: Wed, 2 Sep 2015 12:43:34 -0500
In-Reply-To: <1441215745.4966.167.camel@freescale.com>
References: <1441175814-14940-1-git-send-email-afleming@gmail.com>
 <1441212781.4966.166.camel@freescale.com>
 <CAKWjMd60FAMPpwGyw9=A1kPzhsBCxne99V-AL=9+94AEKKA4tg@mail.gmail.com>
 <1441215745.4966.167.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-02 at 12:42 -0500, Scott Wood wrote:
> On Wed, 2015-09-02 at 12:23 -0500, Andy Fleming wrote:
> > On Wed, Sep 2, 2015 at 11:53 AM, Scott Wood <scottwood@freescale.com> 
> > wrote:
> > > 
> > > On Wed, 2015-09-02 at 01:36 -0500, Andy Fleming wrote:
> > > > This board uses a P5020 or P5040 chip, and boots just fine using
> > > > the corenet_generic code. The device tree is very similar to the
> > > > P5020DS, except that there is no Flash memory. The environment is,
> > > > instead, stored on an MMC card on the motherboard.
> > > > 
> > > > Signed-off-by: Andy Fleming <afleming@gmail.com>
> > > > ---
> > > >  arch/powerpc/boot/dts/cyrus.dts               | 175
> > > > ++++++++++++++++++++++++++
> > > >  arch/powerpc/platforms/85xx/corenet_generic.c |   1 +
> > > >  2 files changed, 176 insertions(+)
> > > >  create mode 100644 arch/powerpc/boot/dts/cyrus.dts
> > > > 
> > > > diff --git a/arch/powerpc/boot/dts/cyrus.dts
> > > > b/arch/powerpc/boot/dts/cyrus.dts
> > > > new file mode 100644
> > > > index 0000000..07fe509
> > > > --- /dev/null
> > > > +++ b/arch/powerpc/boot/dts/cyrus.dts
> > > > @@ -0,0 +1,175 @@
> > > > +/*
> > > > + * P5020DS Device Tree Source
> > > > + *
> > > > + * Copyright 2010 - 2014 Freescale Semiconductor Inc.
> > > > + *
> > > > + * Redistribution and use in source and binary forms, with or without
> > > > + * modification, are permitted provided that the following 
> > > > conditions 
> > > > are
> > > > met:
> > > > + *     * Redistributions of source code must retain the above 
> > > > copyright
> > > > + *       notice, this list of conditions and the following 
> > > > disclaimer.
> > > > + *     * Redistributions in binary form must reproduce the above 
> > > > copyright
> > > > + *       notice, this list of conditions and the following 
> > > > disclaimer 
> > > > in
> > > > the
> > > > + *       documentation and/or other materials provided with the
> > > > distribution.
> > > > + *     * Neither the name of Freescale Semiconductor nor the
> > > > + *       names of its contributors may be used to endorse or promote
> > > > products
> > > > + *       derived from this software without specific prior written
> > > > permission.
> > > > + *
> > > > + *
> > > > + * ALTERNATIVELY, this software may be distributed under the terms 
> > > > of 
> > > > the
> > > > + * GNU General Public License ("GPL") as published by the Free 
> > > > Software
> > > > + * Foundation, either version 2 of that License or (at your option) 
> > > > any
> > > > + * later version.
> > > > + *
> > > > + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' 
> > > > AND 
> > > > ANY
> > > > + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> > > > IMPLIED
> > > > + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
> > > > PURPOSE 
> > > > ARE
> > > > + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE 
> > > > FOR 
> > > > ANY
> > > > + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> > > > DAMAGES
> > > > + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> > > > SERVICES;
> > > > + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
> > > > CAUSED
> > > > AND
> > > > + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
> > > > LIABILITY, 
> > > > OR
> > > > TORT
> > > > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE 
> > > > USE
> > > > OF THIS
> > > > + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > > > + */
> > > > +
> > > > +/include/ "fsl/p5020si-pre.dtsi"
> > > 
> > > What happens when the board has a p5040?
> > 
> > 
> > Hmm...I hadn't thought of that. I can respin the dts to be
> > cyrus_5020.dts, and provide a cyrus_5040.dts later. That version of
> > the product doesn't exist yet. Does that make sense?
> 
> Sure.

...though I'd prefer "cyrus_p5020.dts" and "cyrus_p5040.dts".

-SCott
