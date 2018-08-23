Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x3QP2LZZzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 22:20:12 +1000 (AEST)
Date: Thu, 23 Aug 2018 07:19:29 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rob Herring <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Grant Likely <grant.likely@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Kumar Gala <kumar.gala@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Frank Rowand <frowand.list@gmail.com>, devicetree-spec@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: DT case sensitivity
Message-ID: <20180823121929.GS24439@gate.crashing.org>
References: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
 <3335cff2cc999c1dda58d75949ab3d12185fca79.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3335cff2cc999c1dda58d75949ab3d12185fca79.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 23, 2018 at 11:03:28AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2018-08-22 at 19:47 -0500, Rob Herring wrote:
> > The default DT string handling in the kernel is node names and
> > compatibles are case insensitive and property names are case sensitive
> > (Sparc is the the only variation and is opposite). It seems only PPC
> > (and perhaps only Power Macs?) needs to support case insensitive
> > comparisons. It was probably a mistake to follow PPC for new arches
> > and we should have made everything case sensitive from the start. So I
> > have a few questions for the DT historians. :)
> 
> Open Firmware itself is insensitive.

Some implementations are, yes.  But those are technically broken.

> > What PPC systems are case insensitive? Can we limit that to certain systems?
> 
> All PowerMacs at least, the problem is that I don't have DT images or
> access to all the historical systems (and yes some people occasionally
> still use them) to properly test a change in that area.

If one implementation does case insensitive, it will most likely just work,
because people do not make insane names differing only in case on purpose.
Now people write other things that they only test against that implementation,
and those things now only work with case-insensitive.  And you do not know
without testing if anything breaks.  (But the laws of big numbers are against
you here).  Since there isn't really a drawback to doing case-insensitive
always, that is a much safer way forward, much less work for everyone, even
if technically the wrong thing to do :-)


Segher
