Return-Path: <clg@kaod.org>
Received: from 18.mo5.mail-out.ovh.net (18.mo5.mail-out.ovh.net [178.33.45.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fZ8z2TjvzF15J
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 17:33:06 +1000 (AEST)
Received: from player714.ha.ovh.net (unknown [10.109.120.51])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 500971A9043
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 09:33:01 +0200 (CEST)
Subject: Re: [PATCH 4/4] powerpc/xive: prepare all hcalls to support long busy
 delays
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <20180403071548.19829-1-clg@kaod.org>
 <20180403071548.19829-5-clg@kaod.org>
 <87d0yb8zye.fsf@concordia.ellerman.id.au>
 <90144e7d99aca5c620b1e79a5152f150d76210cc.camel@kernel.crashing.org>
 <8736z48afq.fsf@concordia.ellerman.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e6352dc6-e3ab-2a6b-585b-754733d8b876@kaod.org>
Date: Mon, 7 May 2018 09:32:57 +0200
MIME-Version: 1.0
In-Reply-To: <8736z48afq.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/2018 04:30 AM, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>> On Fri, 2018-05-04 at 20:42 +1000, Michael Ellerman wrote:
>>> Cédric Le Goater <clg@kaod.org> writes:
>>>
>>>> This is not the case for the moment, but future releases of pHyp might
>>>> need to introduce some synchronisation routines under the hood which
>>>> would make the XIVE hcalls longer to complete.
>>>>
>>>> As this was done for H_INT_RESET, let's wrap the other hcalls in a
>>>> loop catching the H_LONG_BUSY_* codes.
>>>
>>> Are we sure it's safe to msleep() in all these paths?
>>
>> Probably not. We can have the IRQ descriptor lock. We might need to
>> mdelay.
>>
>> There's a Kconfig option (forgot which one) that will add checks for
>> attempts to sleep inside locks, you should run with that.
> 
> CONFIG_DEBUG_ATOMIC_SLEEP

[  435.757986] kexec_core: Starting new kernel
[  435.778162] BUG: scheduling while atomic: kexec/1633/0x00000003

That proved to be useful. Thanks.

I will resend the full series changing msleep() to mdelay() and fixing
a bit the changelog.

Cheers,

C.
