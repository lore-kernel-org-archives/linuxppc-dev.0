Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRs6Y2bM1zDqsn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 17:08:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: pseries: use irq_of_parse_and_map helper
In-Reply-To: <CAL_JsqLS_7TiQDwAxrDnP=v+63ge0+2SaomDgXQDSfOvwh7XiQ@mail.gmail.com>
References: <20180104224542.15333-4-robh@kernel.org>
 <878tcpoyku.fsf@concordia.ellerman.id.au>
 <CAL_JsqLS_7TiQDwAxrDnP=v+63ge0+2SaomDgXQDSfOvwh7XiQ@mail.gmail.com>
Date: Thu, 25 Jan 2018 17:08:33 +1100
Message-ID: <87inbqv5b2.fsf@concordia.ellerman.id.au>
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

> On Tue, Jan 23, 2018 at 12:53 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Rob Herring <robh@kernel.org> writes:
>>
>>> Instead of calling both of_irq_parse_one and irq_create_of_mapping, call
>>> of_irq_parse_and_map instead which does the same thing. This gets us closer
>>> to making the former 2 functions static.
...
>> Are you trying to remove the low-level routines or is this just a
>> cleanup?
>
> The former, but I'm not sure that will happen. There's a handful of
> others left, but they aren't simply a call to of_irq_parse_one and
> then irq_create_of_mapping.
>
>> The patch below works, it loses the error handling if the interrupts
>> property is corrupt/empty, but that's probably overly paranoid anyway.
>
> Not quite. Previously, it was silent if parsing failed. Only the
> mapping would give an error which would mean the interrupt parent had
> some error.
>
> Actually, we could use of_irq_get here to preserve the error handling.
> It will return error codes from parsing, 0 on mapping failure, or the
> Linux irq number. It adds an irq_find_host call for deferred probe,
> but that should be harmless. I'll respin it.

OK thanks.

cheers
