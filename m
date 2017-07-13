Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7Ks66dmVzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 12:44:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matt Brown <matthew.brown.dev@gmail.com>, Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/powernv: Use darn instr for random_seed on p9
In-Reply-To: <CAPoR37YUGNKre=YyBixvG7iNjr-ZHy1-zYOtjyMRaVzqS8BLxw@mail.gmail.com>
References: <20170707070249.15773-1-matthew.brown.dev@gmail.com>
 <8737a3mi5l.fsf@linkitivity.dja.id.au>
 <CAPoR37YUGNKre=YyBixvG7iNjr-ZHy1-zYOtjyMRaVzqS8BLxw@mail.gmail.com>
Date: Thu, 13 Jul 2017 12:44:10 +1000
Message-ID: <874luhkqdh.fsf@concordia.ellerman.id.au>
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

Matt Brown <matthew.brown.dev@gmail.com> writes:
> On Tue, Jul 11, 2017 at 7:34 PM, Daniel Axtens <dja@axtens.net> wrote:
>>> @@ -67,6 +69,21 @@ int powernv_get_random_real_mode(unsigned long *v)
>>>       return 1;
>>>  }
>>>
>>> +int powernv_get_random_darn(unsigned long *v)
>>
>> This is only referenced in this file so it should probably be labelled
>> as 'static'.
>>
>
> That's true, my thinking was to then use the get_random_darn where the
> get_random_long was being used.
> Looks like there is only one other caller of it at the moment,
> kvmppc_h_random (in arch/powerpc/kvm/book3s_hv_builtin.c).
> We may want to change that to get_random_darn.

It needs to use the right one depending on whether it's running on P8 or
P9.

It should really just use ppc_md.get_random_seed(), except that it can
be called in real mode, which means it needs to be more careful. So as
usual it's complicated :)

cheers
