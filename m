Return-Path: <xenidis@gmail.com>
Received: from mail-ye0-f179.google.com (mail-ye0-f179.google.com
 [209.85.213.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1034A2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2012 02:44:31 +1100 (EST)
Received: by mail-ye0-f179.google.com with SMTP id m4so841133yen.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2012 07:44:29 -0800 (PST)
Sender: Jimi Xenidis <xenidis@gmail.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: Hijacking CPU_FTR_VSX for BGQ QPX
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <3948.1352522003@neuling.org>
Date: Wed, 5 Dec 2012 09:44:22 -0600
Message-Id: <7FAFB642-039B-401C-9348-4D8E94511E6A@pobox.com>
References: <29970ED2-02E3-45F5-96FD-B4270385E3ED@pobox.com>
 <1352491029.23412.3.camel@pasglop> <3948.1352522003@neuling.org>
To: Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry for the pause, lots of other things getting done... questions =
below.

On Nov 9, 2012, at 10:33 PM, Michael Neuling <mikey@neuling.org> wrote:

> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>=20
>> On Fri, 2012-11-09 at 11:43 -0600, Jimi Xenidis wrote:
>>> The CPU_FTR_* values are pretty tight (a few bits left) yes I need =
to save and restore the QPX registers.
>>> There are 32 QPX registers, each 32 bytes in size, it is otherwise =
managed by the FPSCR and MSR[FP]
>>>=20
>>> I was thinking that I could hijack the VSX, since there is no plan =
to add it to embedded yet.
>>> I could be explicit or create an alieas fo the same bit, but the =
basic effect (after increasing the save area size) would be something =
like the diff below.
>>> Thoughts?
>>=20
>> Don't. Use a different bit, we can always split the mask again if
>> needed, move more bits to mmu_features etc...

Ok

>>=20
>>> -#ifdef CONFIG_VSX
>>> +#if defined (CONFIG_VSX) && defined(CONFIG_BGQ)
>>> +# error "This code depends on CONFIG_VSX and CONFIG_BGQ being =
exclusive
>>> +#elif defined (CONFIG_VSX)
>>> +# define _REST_32VSRS(n,c,base) REST_32VSRS(n,c,base)
>>> +# define _SAVE_32VSRS(n,c,base) SAVE_32VSRS(n,c,base)
>>> +#elif defined(CONFIG_BGQ)
>>=20
>> Make a CONFIG_PPC_QPX or something like that specifically for the QPX
>> stuff that you can then "select" from CONFIG_PPC_BGQ (don't do just
>> CONFIG_BGQ).

ack

>>=20
>> And don't just "hijack" stuff like that, it should be a runtime =
option,
>> so add a new set etc... it should be possible to build a kernel that
>> boots on a BGQ or a hypothetical BookE chip with VSX.

ack
>=20
> Yeah both bluegene and VSX are designed for HPC, so it's not =
completely
> crazy that someone would put them together.

Not sure that is possible, since they both "include" FPU state, which is =
why hijacking the the FPU routines is so delicious.

-jx


>=20
> Also, we need to fix the CPU FTR issue.  With PPR (Haren's stuff) and
> POWER8 we are going to blow CPU FTRs pretty soon anyway.  This just =
adds
> to that.
>=20
> Mikey
>=20
>>=20
>>> +# define _REST_32VSRS(n,c,base) REST_32QRS(n,c,base)
>>> +# define _SAVE_32VSRS(n,c,base) SAVE_32QRS(n,c,base)
>>> +#endif
>>> +
>>> +#if defined (CONFIG_VSX) || defined(CONFIG_BGQ)
>>> #define REST_32FPVSRS(n,c,base)						=
\
>>> BEGIN_FTR_SECTION							=
\
>>> 	b	2f;							=
\
>>> END_FTR_SECTION_IFSET(CPU_FTR_VSX);					=
\
>>> 	REST_32FPRS(n,base);						=
\
>>> 	b	3f;							=
\
>>> -2:	REST_32VSRS(n,c,base);						=
\
>>> +2:	_REST_32VSRS(n,c,base);						=
\
>>> 3:
>>>=20
>>> #define SAVE_32FPVSRS(n,c,base)						=
\
>>> @@ -41,7 +51,7 @@ BEGIN_FTR_SECTION						=
	\
>>> END_FTR_SECTION_IFSET(CPU_FTR_VSX);					=
\
>>> 	SAVE_32FPRS(n,base);						=
\
>>> 	b	3f;							=
\
>>> -2:	SAVE_32VSRS(n,c,base);						=
\
>>> +2:	_SAVE_32VSRS(n,c,base);						=
\
>>> 3:
>>> #else
>>> #define REST_32FPVSRS(n,b,base)	REST_32FPRS(n, base)
>>=20
>> Cheers,
>> Ben.
>>=20
>>=20
