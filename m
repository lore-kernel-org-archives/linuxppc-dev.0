Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnXLX05KgzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 13:34:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 svaidy@linux.vnet.ibm.com, Nicholas Piggin <npiggin@gmail.com>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 13/14] powerpc/64: runlatch CTRL[RUN] set optimisation
In-Reply-To: <1497361558.2897.12.camel@kernel.crashing.org>
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-14-npiggin@gmail.com>
 <20170612171138.GB4340@drishya.in.ibm.com>
 <87zidcgq50.fsf@concordia.ellerman.id.au>
 <1497361558.2897.12.camel@kernel.crashing.org>
Date: Wed, 14 Jun 2017 13:34:27 +1000
Message-ID: <87fuf344zg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2017-06-13 at 20:04 +1000, Michael Ellerman wrote:
>> > Good idea.=C2=A0 Writing to CTRL register can change only the RUN fiel=
d.
>> > Was this any different in older generations?
>>=20
>> No AFAICS back to 2.02.
>>=20
>> > Anton and Ben kept the mfspr/mtspr part in earlier updates to this
>> > routine.
>>=20
>> Doing the read/modify write is forward compatible vs a new writable
>> field, whereas writing the whole register with a known value is not.
>
> At this stage I wouldn't worry too much about it. What we can do is
> write a pre-cooked value (from reading it earlier once at boot) if we
> are paranoid or just do what Nick does and put the onus on future
> designs that might want to re-use it for other things to add a mode
> bits to configure the new feature in.

Fine by me.

cheers
