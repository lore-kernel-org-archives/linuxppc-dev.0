Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3bxp1jjNzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 20:05:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] powernv:idle: Set LPCR_UPRT on wakeup from deep-stop
In-Reply-To: <20170413171817.2854f597@roar.ozlabs.ibm.com>
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
 <9be8410e0abe5ae1afa16a6f987c53046ef51757.1491996797.git.ego@linux.vnet.ibm.com>
 <8737ddq7py.fsf@skywalker.in.ibm.com>
 <1492056725.7236.95.camel@kernel.crashing.org>
 <1492064854.4624.48.camel@neuling.org>
 <20170413171817.2854f597@roar.ozlabs.ibm.com>
Date: Thu, 13 Apr 2017 20:05:01 +1000
Message-ID: <878tn4aaia.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Thu, 13 Apr 2017 16:27:34 +1000
> Michael Neuling <mikey@neuling.org> wrote:
>
>> On Thu, 2017-04-13 at 14:12 +1000, Benjamin Herrenschmidt wrote:
>> > On Thu, 2017-04-13 at 09:28 +0530, Aneesh Kumar K.V wrote:=20=20
>> > > > =C2=A0 #endif
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtctr=C2=A0=C2=A0=C2=A0r=
12
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bctrl
>> > > > +/*
>> > > > + * cur_cpu_spec->cpu_restore would restore LPCR to a
>> > > > + * sane value that is set at early boot time,
>> > > > + * thereby clearing LPCR_UPRT.
>> > > > + * LPCR_UPRT is required if we are running in Radix mode.
>> > > > + * Set it here if that be the case.
>> > > > + */
>> > > > +BEGIN_MMU_FTR_SECTION
>> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mfspr=C2=A0=C2=A0=C2=A0r3, SPRN_LPCR
>> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LOAD_REG_IMMEDIATE(r4, LPCR_UPRT)
>> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0or=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0r3, r3, r4
>> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mtspr=C2=A0=C2=A0=C2=A0SPRN_LPCR, r3
>> > > > +END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)=20=20
>> >=20
>> > We are probably better off saving the value somewhere during boot
>> > and just "blasting" it whole back.=20=20
>>=20
>> We seem to touch LPCR in a bunch of places these days.  Not sure when "s=
ometimes
>>  during boot" should actually be.
>
> In the short term, what if we just save LPCR and restore it after calling
> cpu_restore? As you say there are a lot of things that touch LPCR we're
> not catching here.

Yeah can we save it on the way down and restore that value on the way
back up?

The real problem here is that cpu_restore() does not "restore" anything,
it programs a set of fixed values.

We should probably rework it so that it actually does a save/restore to
avoid more bugs like this.

cheers
