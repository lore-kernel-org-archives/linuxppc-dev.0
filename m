Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x2jQ3ZrdzF2Py
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 21:48:10 +1000 (AEST)
Message-ID: <e9009f6dd3aded2b9aa735973f4eed8386dd9afb.camel@kernel.crashing.org>
Subject: Re: DT case sensitivity
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@arm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michael Ellerman
 <mpe@ellerman.id.au>, Kumar Gala <kumar.gala@linaro.org>, David Gibson
 <david@gibson.dropbear.id.au>,
 Frank Rowand <frowand.list@gmail.com>, devicetree-spec@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 23 Aug 2018 21:47:30 +1000
In-Reply-To: <CAL_Jsq+1T8k5mtc-DgDBtX3Qco9sQG9RWv6FTZ8NXppNbNg3Ww@mail.gmail.com>
References: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
 <3335cff2cc999c1dda58d75949ab3d12185fca79.camel@kernel.crashing.org>
 <CAL_JsqKqkO31ekVMFKs+osLvKdZyDzRowF1thWXn5=tWhrJgvw@mail.gmail.com>
 <18175413a0148f7859ab36ed9715dce7a598f318.camel@kernel.crashing.org>
 <13bf5b39-0461-351e-57e3-60264eaa374d@arm.com>
 <CAL_Jsq+1T8k5mtc-DgDBtX3Qco9sQG9RWv6FTZ8NXppNbNg3Ww@mail.gmail.com>
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

On Thu, 2018-08-23 at 06:43 -0500, Rob Herring wrote:
> On Thu, Aug 23, 2018 at 4:02 AM Grant Likely <grant.likely@arm.com> wrote:
> > 
> > 
> > What problem are you trying to solve?
> 
> I'm looking at removing device_node.name and using full_name instead
> (which now is only the local node name plus unit-address). This means
> replacing of_node_cmp() (and still some strcmp) calls in a lot of
> places. I need to use either strncmp or strncasecmp instead.
> 
> > I would think making everything
> > case insensitive would be the direction to go if you do anything. Least
> > possibility of breaking existing platforms in that scenario.
> 
> Really? Even if all the "new" arches are effectively case sensitive?
> Anything using dtc and libfdt are (and json-schema certainly will be).
> But I frequently say the kernel's job is not DT validation, so you
> pass crap in, you get undefined results.

I tend to agree with Grant. Let's put it this way:

What is the drawback of being case insensitive ?

Do we expect that there exist a case where we will want to distinguish
between nodes that have the same name with a different case ?

If not, I don't see the point of being strict about it.

Cheers,
Ben.
