Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xVTS64r8zDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 15:39:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Grant Likely <grant.likely@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Kumar Gala <kumar.gala@linaro.org>, David Gibson <david@gibson.dropbear.id.au>,
 Frank Rowand <frowand.list@gmail.com>, devicetree-spec@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: DT case sensitivity
In-Reply-To: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
References: <CAL_Jsq+XacT2O15CQ=F_6dmWf6OqNf8_fKAOrMJNR79a6mORaw@mail.gmail.com>
Date: Fri, 24 Aug 2018 15:39:19 +1000
Message-ID: <87tvnkjpbs.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rob Herring <robh@kernel.org> writes:

> The default DT string handling in the kernel is node names and
> compatibles are case insensitive and property names are case sensitive
> (Sparc is the the only variation and is opposite). It seems only PPC
> (and perhaps only Power Macs?) needs to support case insensitive
> comparisons. It was probably a mistake to follow PPC for new arches
> and we should have made everything case sensitive from the start. So I
> have a few questions for the DT historians. :)
>
> What PPC systems are case insensitive? Can we limit that to certain systems?
>
> AFAICT, dtc at least (if not anything FDT based) has always been case
> sensitive at least for node and property names. I'm not sure about
> compatible strings?
>
> Anyone see potential issues with switching all platforms except PPC
> and Sparc to case sensitive comparisons?

Looking at some old device trees, on ppc we do definitely have mixed
case compatible strings, and I see a few hundred of those appear in the
kernel source. So I think for us it's too late.

But I don't see why that prevents other arches from switching to case
sensitive, I don't think it really hurts us in any way.

cheers
