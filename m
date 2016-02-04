Return-Path: <takahiro.akashi@linaro.org>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9D881A007F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 20:31:50 +1100 (AEDT)
Received: by mail-pf0-x22c.google.com with SMTP id n128so38975445pfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2016 01:31:49 -0800 (PST)
Subject: Re: [PATCH v6 1/9] ppc64 (le): prepare for -mprofile-kernel
To: Torsten Duwe <duwe@lst.de>, Jiri Kosina <jikos@kernel.org>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170723.D2CCE692CE@newverein.lst.de> <56B1AAE5.10500@linaro.org>
 <alpine.LNX.2.00.1602030952220.22727@cbobk.fhfr.pm>
 <20160203112449.GA27247@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Message-ID: <56B31A7C.2050803@linaro.org>
Date: Thu, 4 Feb 2016 18:31:40 +0900
MIME-Version: 1.0
In-Reply-To: <20160203112449.GA27247@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri, Torsten

Thank you for your explanation.

On 02/03/2016 08:24 PM, Torsten Duwe wrote:
> On Wed, Feb 03, 2016 at 09:55:11AM +0100, Jiri Kosina wrote:
>> On Wed, 3 Feb 2016, AKASHI Takahiro wrote:
>>> those efforts, we are proposing[1] a new *generic* gcc option, -fprolog-add=N.
>>> This option will insert N nop instructions at the beginning of each function.
>
>> The interesting part of the story with ppc64 is that you indeed want to
>> create the callsite before the *most* of the prologue, but not really :)
>
> I was silently assuming that GCC would do this right on ppc64le; add the NOPs
> right after the TOC load. Or after TOC load and LR save? ...

On arm/arm64, link register must be saved before any function call. So anyhow
we will have to add something, 3 instructions at the minimum, like:
    save lr
    branch _mcount
    restore lr
    <prologue>
    ...
    <body>
    ...

>> The part of the prologue where TOC pointer is saved needs to happen before
>> the fentry/profiling call.
>
> Yes, any call, to any profiler/tracer/live patcher is potentially global
> and needs the _new_ TOC value.

I don't want to bother you, but for my better understandings, could you show me
an example of asm instructions for a function prologue under -mprofile-kernel, please?

-Takahiro AKASHI

> This proposal, if implemented in a too naive fashion, will worsen the problem
> we currently discuss: a few NOPs _never_ cause any global reference. GCC might
> be even more inclined to not load a new TOC value. That change would need to be
> fairly smart on ppc64le.
>
> 	Torsten
>
