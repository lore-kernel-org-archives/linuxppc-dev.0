Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x2cY3FCczF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 21:43:56 +1000 (AEST)
Received: from mail-qk0-f178.google.com (mail-qk0-f178.google.com
 [209.85.220.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AAD5121566
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 11:43:54 +0000 (UTC)
Received: by mail-qk0-f178.google.com with SMTP id b19-v6so3347976qkc.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 04:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
 <3335cff2cc999c1dda58d75949ab3d12185fca79.camel@kernel.crashing.org>
 <CAL_JsqKqkO31ekVMFKs+osLvKdZyDzRowF1thWXn5=tWhrJgvw@mail.gmail.com>
 <18175413a0148f7859ab36ed9715dce7a598f318.camel@kernel.crashing.org>
 <13bf5b39-0461-351e-57e3-60264eaa374d@arm.com>
In-Reply-To: <13bf5b39-0461-351e-57e3-60264eaa374d@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 23 Aug 2018 06:43:42 -0500
Message-ID: <CAL_Jsq+1T8k5mtc-DgDBtX3Qco9sQG9RWv6FTZ8NXppNbNg3Ww@mail.gmail.com>
Subject: Re: DT case sensitivity
To: Grant Likely <grant.likely@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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

On Thu, Aug 23, 2018 at 4:02 AM Grant Likely <grant.likely@arm.com> wrote:
>
> On 23/08/2018 02:29, Benjamin Herrenschmidt wrote:
> > On Wed, 2018-08-22 at 20:26 -0500, Rob Herring wrote:
> >> On Wed, Aug 22, 2018 at 8:14 PM Benjamin Herrenschmidt
> >> <benh@kernel.crashing.org> wrote:
> >>>
> >>> On Wed, 2018-08-22 at 19:47 -0500, Rob Herring wrote:
> >>>> The default DT string handling in the kernel is node names and
> >>>> compatibles are case insensitive and property names are case sensitive
> >>>> (Sparc is the the only variation and is opposite). It seems only PPC
> >>>> (and perhaps only Power Macs?) needs to support case insensitive
> >>>> comparisons. It was probably a mistake to follow PPC for new arches
> >>>> and we should have made everything case sensitive from the start. So I
> >>>> have a few questions for the DT historians. :)
> >>>
> >>> Open Firmware itself is insensitive.
> >>
> >> Doesn't it depend on the implementation? Otherwise, how is Sparc different?
> >
> > Not sure ... Forth itself is insensitive for words but maybe not for
> > string comparisons.
>
> What problem are you trying to solve?

I'm looking at removing device_node.name and using full_name instead
(which now is only the local node name plus unit-address). This means
replacing of_node_cmp() (and still some strcmp) calls in a lot of
places. I need to use either strncmp or strncasecmp instead.

> I would think making everything
> case insensitive would be the direction to go if you do anything. Least
> possibility of breaking existing platforms in that scenario.

Really? Even if all the "new" arches are effectively case sensitive?
Anything using dtc and libfdt are (and json-schema certainly will be).
But I frequently say the kernel's job is not DT validation, so you
pass crap in, you get undefined results.

Rob
