Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkDjW4B00zDqZ0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 19:39:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] powerpc/64s: idle ESL=0 stop can avoid MSR and
 save/restore overhead
In-Reply-To: <20170830221045.6fd10787@roar.ozlabs.ibm.com>
References: <20170825043036.18236-1-npiggin@gmail.com>
 <20170825043036.18236-5-npiggin@gmail.com>
 <87pobd1em0.fsf@concordia.ellerman.id.au>
 <20170830221045.6fd10787@roar.ozlabs.ibm.com>
Date: Fri, 01 Sep 2017 19:39:41 +1000
Message-ID: <87k21i69lu.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Wed, 30 Aug 2017 21:25:59 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> 
>> > When stop is executed with EC=ESL=0, it appears to execute like a
>> > normal instruction (resuming from NIP when woken by interrupt).
>> > So all the save/restore handling can be avoided completely. In
>> > particular NV GPRs do not have to be saved, and MSR does not have
>> > to be switched back to kernel MSR.
>> >
>> > So move the test for "lite" sleep states out to power9_idle_stop.
>> >
>> > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > ---
>> >  arch/powerpc/kernel/idle_book3s.S | 35 ++++++++++++++++++++++++-----------
>> >  1 file changed, 24 insertions(+), 11 deletions(-)  
>> 
>> This is blowing up for me on mambo:
>
> Oh this is a known bug in mambo that does not match the hardware.
>
> You need >= Mambo.7.8.21, or this firmware patch to work around
> the issue for old mambos.

As discussed elsewhere this still breaks on new mambo with more than one
CPU. So I've dropped it for now.

cheers
