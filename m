Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXNwZ1DYTzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 14:14:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc/powernv: add hdat attribute to sysfs
In-Reply-To: <CAOSf1CF2-E6eV5bf95qr-uYxcxEdhpLevWbmHW97virJhNxS4g@mail.gmail.com>
References: <20170224062054.31408-1-matthew.brown.dev@gmail.com>
 <87lgsrrjfb.fsf@concordia.ellerman.id.au>
 <CAOSf1CF2-E6eV5bf95qr-uYxcxEdhpLevWbmHW97virJhNxS4g@mail.gmail.com>
Date: Tue, 28 Feb 2017 14:14:37 +1100
Message-ID: <8760jvqa5e.fsf@concordia.ellerman.id.au>
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

Oliver O'Halloran <oohall@gmail.com> writes:

> On Mon, Feb 27, 2017 at 9:56 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Matt Brown <matthew.brown.dev@gmail.com> writes:
>>> diff --git a/arch/powerpc/platforms/powernv/opal-hdat.c b/arch/powerpc/platforms/powernv/opal-hdat.c
>>> new file mode 100644
>>> index 0000000..3315dd3
>>> --- /dev/null
>>> +++ b/arch/powerpc/platforms/powernv/opal-hdat.c
>>> @@ -0,0 +1,65 @@
>> ...
>>> +
>>> +
>>> +/* HDAT attribute for sysfs */
>>> +static struct bin_attribute hdat_attr = {
>>> +     .attr = {.name = "hdat", .mode = 0444},
>>                                          ^^^^
>> ajd and oohal report to my office.
>
> I don't think there's anything in the HDAT that's sensitive. That
> said, this might not be true in the future so making it only readable
> by root might be a good idea.

Right. What's sensitive can also change over time, in addition to the
actual content changing without our knowledge.

This is also firmly a debugging thing, so unless there's a compelling
reason why it should be world readable then it shouldn't be.

So 0400 please.

cheers
