Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLmGM0gcSzDrCX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:12:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, stewart@linux.vnet.ibm.com, cyrilbur@gmail.com
Subject: Re: [PATCH 1/4] powerpc/tm: Add commandline option to disable
 hardware transactional memory
In-Reply-To: <20171023125642.r5qzr5u5dpjkiseh@gmail.com>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <20171020114539.piyh4wmby5gz7qnb@gmail.com>
 <1508547527.23934.4.camel@neuling.org>
 <20171023125642.r5qzr5u5dpjkiseh@gmail.com>
Date: Tue, 24 Oct 2017 10:12:16 +0200
Message-ID: <87mv4h3qxr.fsf@concordia.ellerman.id.au>
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

Breno Leitao <leitao@debian.org> writes:
> On Sat, Oct 21, 2017 at 11:58:47AM +1100, Michael Neuling wrote:
>> On Fri, 2017-10-20 at 09:45 -0200, Breno Leitao wrote:
>> > On Thu, Oct 12, 2017 at 09:17:16PM +1100, Michael Ellerman wrote:
>> > > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> > > index f83056297441..d9bd6555f980 100644
>> > > --- a/arch/powerpc/kernel/prom.c
>> > > +++ b/arch/powerpc/kernel/prom.c
>> > > @@ -658,6 +658,35 @@ static void __init early_reserve_mem(void)
>> > > =C2=A0#endif
>> > > =C2=A0}
>> > > =C2=A0
>> > > +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>> > > +static bool tm_disabled __initdata;
>> >=20
>> > I think the name 'tm_disabled' might cause more confusion on the TM
>> > code. Mainly because we already have tm_enable() and tm_enabled()
>> > functions which are related to the MSR register and TM bit, and, with
>> > your new variable, tm_enabled() and tm_disabled are not going to be
>> > exclusionary. Neither tm_enable() with be able to toggle the tm_disabl=
ed
>> > value.

I've merged it with that name, but I'm happy to take an incremental
patch to give it a better name.

>> Got a proposal for better names?
>
> That is the hardest part, but I thought about something as:
>
>  * tm_disabled_on_boot

Maybe.

>  * tm_off

Nah.

>  * tm_explicit_disabled

Maybe.

>  * tm_feature_disabled

No that's not quite accurate.

>  * tm_enablement_disabled

I refuse to use "enablement" ;)

> I think these names, although a bit longer, might avoid the confusion
> with tm_enable/tm_enabled nomenclature.

tm_cmdline_disabled would be OK. Or tm_force_disable, or ...

cheers
