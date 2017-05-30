Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcVh12f8mzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 20:48:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, paulus@samba.org,
 npiggin@gmail.com
Subject: Re: [PATCH] powerpc/64: Reclaim CPU_FTR_SUBCORE
In-Reply-To: <20170530124800.11dbc61b@firefly.ozlabs.ibm.com>
References: <1496022790-2017-1-git-send-email-mpe@ellerman.id.au>
 <20170530124800.11dbc61b@firefly.ozlabs.ibm.com>
Date: Tue, 30 May 2017 20:48:16 +1000
Message-ID: <878tle62of.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On Mon, 29 May 2017 11:53:10 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> We are running low on CPU feature bits, so we only want to use them when
>> it's really necessary.
>> 
>> CPU_FTR_SUBCORE is only used in one place, and only in C, so we don't
>> need it in order to make asm patching work. It can only be set on
>> "Power8" CPUs, which in practice means POWER8, POWER8E and POWER8NVL.
>> There are no plans to implement it on future CPUs, but if there ever
>> were we could retrofit it then.
>> 
>> Although KVM uses subcores, it never looks at the CPU feature, it either
>> looks at the ISA level or the threads_per_subcore value.
>> 
>> So drop the CPU feature and do a PVR check instead. Drop the device tree
>> "subcore" feature as we no longer support doing anything with it, and we
>> will drop it from skiboot too.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
>
> I looked at CPU_FTR_DBELL and its used for initialization and in
> arch_show_interrupts(), no assembly

But the other criteria is that there is a small set of CPUs where it can
be enabled, so that the PVR check is not horrible.

I don't think DBELL fits that, I see it enabled for at least Power8,
Power8E, Power9, e6500, e5500, e500mc.

cheers
