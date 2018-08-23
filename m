Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x39Q1glQzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 22:08:57 +1000 (AEST)
Received: from mail-qt0-f173.google.com (mail-qt0-f173.google.com
 [209.85.216.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 10B1A20C0C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 12:08:56 +0000 (UTC)
Received: by mail-qt0-f173.google.com with SMTP id x7-v6so5874596qtk.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 05:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
 <3335cff2cc999c1dda58d75949ab3d12185fca79.camel@kernel.crashing.org>
 <CAL_JsqKqkO31ekVMFKs+osLvKdZyDzRowF1thWXn5=tWhrJgvw@mail.gmail.com>
 <18175413a0148f7859ab36ed9715dce7a598f318.camel@kernel.crashing.org>
 <13bf5b39-0461-351e-57e3-60264eaa374d@arm.com>
 <CAL_Jsq+1T8k5mtc-DgDBtX3Qco9sQG9RWv6FTZ8NXppNbNg3Ww@mail.gmail.com>
 <e9009f6dd3aded2b9aa735973f4eed8386dd9afb.camel@kernel.crashing.org>
In-Reply-To: <e9009f6dd3aded2b9aa735973f4eed8386dd9afb.camel@kernel.crashing.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 23 Aug 2018 07:08:43 -0500
Message-ID: <CAL_JsqKnbFAydf7ets0=KySm3P3b_7np-EVWz3Gh6qO+imJ+eg@mail.gmail.com>
Subject: Re: DT case sensitivity
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Likely <grant.likely@arm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>, Kumar Gala <kumar.gala@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Frank Rowand <frowand.list@gmail.com>,
 devicetree-spec@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 23, 2018 at 6:48 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Thu, 2018-08-23 at 06:43 -0500, Rob Herring wrote:
> > On Thu, Aug 23, 2018 at 4:02 AM Grant Likely <grant.likely@arm.com> wrote:
> > >
> > >
> > > What problem are you trying to solve?
> >
> > I'm looking at removing device_node.name and using full_name instead
> > (which now is only the local node name plus unit-address). This means
> > replacing of_node_cmp() (and still some strcmp) calls in a lot of
> > places. I need to use either strncmp or strncasecmp instead.
> >
> > > I would think making everything
> > > case insensitive would be the direction to go if you do anything. Least
> > > possibility of breaking existing platforms in that scenario.
> >
> > Really? Even if all the "new" arches are effectively case sensitive?
> > Anything using dtc and libfdt are (and json-schema certainly will be).
> > But I frequently say the kernel's job is not DT validation, so you
> > pass crap in, you get undefined results.
>
> I tend to agree with Grant. Let's put it this way:
>
> What is the drawback of being case insensitive ?

It's a more expensive comparison. I don't think it's a hot path, but
we do do a lot of string compares.

Property names are case sensitive already. It would be nice if
everything was treated the same way.

If we're case sensitive then it is well defined which node we'll match
and which one will be ignored. Otherwise, it is whichever one we
happen to match first.

> Do we expect that there exist a case where we will want to distinguish
> between nodes that have the same name with a different case ?

If someone has a DT with a node in the wrong case (as defined in the
DT spec or a binding doc) and the kernel accepts it, then it's an ABI.
Yes, as Grant says, validation is the place that should catch it, but
we're not there yet and it's cheap (cheaper in fact) for the kernel to
do.

Rob
