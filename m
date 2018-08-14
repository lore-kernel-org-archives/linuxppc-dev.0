Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41qK3M2lzGzF0Qs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 14:13:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: cxl: remove a dead branch
In-Reply-To: <CA+7wUsxG-Ys7snbY_=wgGRxcUYTN-tEMM9gqHOWidvEBmB5ogA@mail.gmail.com>
References: <20180322210528.22017-1-malat@debian.org>
 <41ptcv2xyYz9sC7@ozlabs.org>
 <CA+7wUsxG-Ys7snbY_=wgGRxcUYTN-tEMM9gqHOWidvEBmB5ogA@mail.gmail.com>
Date: Tue, 14 Aug 2018 14:13:50 +1000
Message-ID: <87d0ullh4x.fsf@concordia.ellerman.id.au>
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

Mathieu Malaterre <malat@debian.org> writes:
> Frederic,
>
> Could you double check with Michael what is now best to do.

I decided it had been long enough (since March), so I just merged it.

If Fred et. al. want to do something better they can send me another
patch on top of it.

cheers

> On Mon, Aug 13, 2018 at 1:23 PM Michael Ellerman
> <patch-notifications@ellerman.id.au> wrote:
>>
>> On Thu, 2018-03-22 at 21:05:28 UTC, Mathieu Malaterre wrote:
>> > In commit 14baf4d9c739 ("cxl: Add guest-specific code") the following code
>> > was added:
>> >
>> >       if (afu->crs_len < 0) {
>> >               dev_err(&afu->dev, "Unexpected configuration record size value\n");
>> >               return -EINVAL;
>> >       }
>> >
>> > However the variable `crs_len` is of type u64 and cannot be compared < 0.
>> > Remove the dead code section. Fix the following warning treated as error
>> > with W=1:
>> >
>> > ../drivers/misc/cxl/guest.c:919:19: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
>> >
>> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>
>> Applied to powerpc next, thanks.
>>
>> https://git.kernel.org/powerpc/c/e4ecafb14fd9cd77d8f4320af1922e
>>
>> cheers
