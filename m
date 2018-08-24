Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xlDm3JkSzDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 01:14:15 +1000 (AEST)
Received: from mail-qk0-f178.google.com (mail-qk0-f178.google.com
 [209.85.220.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 648DF20893
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 15:14:13 +0000 (UTC)
Received: by mail-qk0-f178.google.com with SMTP id f17-v6so6061962qkh.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 08:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
 <3335cff2cc999c1dda58d75949ab3d12185fca79.camel@kernel.crashing.org>
 <CAL_JsqKqkO31ekVMFKs+osLvKdZyDzRowF1thWXn5=tWhrJgvw@mail.gmail.com>
 <18175413a0148f7859ab36ed9715dce7a598f318.camel@kernel.crashing.org>
 <20180823123650.GT24439@gate.crashing.org>
In-Reply-To: <20180823123650.GT24439@gate.crashing.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 24 Aug 2018 10:14:01 -0500
Message-ID: <CAL_Jsq+VnhT_4H4yECWsuXnmpQRnSHNRXAohRYds1LxcRjUHkw@mail.gmail.com>
Subject: Re: DT case sensitivity
To: segher@kernel.crashing.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Kumar Gala <kumar.gala@linaro.org>, devicetree@vger.kernel.org,
 devicetree-spec@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Grant Likely <grant.likely@arm.com>, Frank Rowand <frowand.list@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 23, 2018 at 7:37 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Thu, Aug 23, 2018 at 11:29:01AM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2018-08-22 at 20:26 -0500, Rob Herring wrote:
> > > On Wed, Aug 22, 2018 at 8:14 PM Benjamin Herrenschmidt
> > > <benh@kernel.crashing.org> wrote:
> > > >
> > > > On Wed, 2018-08-22 at 19:47 -0500, Rob Herring wrote:
> > > > > The default DT string handling in the kernel is node names and
> > > > > compatibles are case insensitive and property names are case sensitive
> > > > > (Sparc is the the only variation and is opposite). It seems only PPC
> > > > > (and perhaps only Power Macs?) needs to support case insensitive
> > > > > comparisons. It was probably a mistake to follow PPC for new arches
> > > > > and we should have made everything case sensitive from the start. So I
> > > > > have a few questions for the DT historians. :)
> > > >
> > > > Open Firmware itself is insensitive.
> > >
> > > Doesn't it depend on the implementation? Otherwise, how is Sparc different?
> >
> > Not sure ...
>
> The standard requires case-sensitive.
>
> > Forth itself is insensitive for words
>
> Not even.   http://forth.sourceforge.net/std/dpans/dpans3.htm#3.3.1.2
>
> (Most non-ancient implementations are though).
>
> > but maybe not for string comparisons.
>
> Only COMPARE is standardised, and that is case-sensitive comparison.  Many
> systems have other words to do case-insensitive comparisons, or words where
> some runtime flag determines the case-sensitivity.
>
> Btw.  A node name in Open Firmware is generically
>   driver-name@unit-address:device-arguments
> where driver-name is the part that is in the "name" property; this whole
> case-sensitivity business is even worse for FDT, where you also treat the
> unit address as part of the name.  In real Open Firmware the address is
> compared *as a number* (or as a few numbers), so it is naturally case-
> insensitive (it does not care if you write 01a0 or 01A0, or 1a0 or 000001a0
> etc.)

True, but it is very rare at least in Linux to look at the
unit-addresses. dtc now does some checking on unit-addresses too, so
we should at least be consistent.

Another question: Is there ever a case where the node name in the path
aka 'driver-name' doesn't match the 'name' property? I think this
generally can't happen on FDT as the 'name' property is generated when
we unflatten it though I suppose one could craft an FDT with name
properties.

There's also various places in the kernel that check for a NULL name
which doesn't seem like it could happen either other than the root
node.

Rob
