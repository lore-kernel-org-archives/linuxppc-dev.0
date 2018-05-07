Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fRRK59rNzF0Vv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 12:30:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?utf-8?Q?C=C3=A9dr?=
 =?utf-8?Q?ic_Le=09Goater?= <clg@kaod.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/4] powerpc/xive: prepare all hcalls to support long busy
 delays
In-Reply-To: <90144e7d99aca5c620b1e79a5152f150d76210cc.camel@kernel.crashing.org>
References: <20180403071548.19829-1-clg@kaod.org>
 <20180403071548.19829-5-clg@kaod.org>
 <87d0yb8zye.fsf@concordia.ellerman.id.au>
 <90144e7d99aca5c620b1e79a5152f150d76210cc.camel@kernel.crashing.org>
Date: Mon, 07 May 2018 12:30:01 +1000
Message-ID: <8736z48afq.fsf@concordia.ellerman.id.au>
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
> On Fri, 2018-05-04 at 20:42 +1000, Michael Ellerman wrote:
>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>=20
>> > This is not the case for the moment, but future releases of pHyp might
>> > need to introduce some synchronisation routines under the hood which
>> > would make the XIVE hcalls longer to complete.
>> >=20
>> > As this was done for H_INT_RESET, let's wrap the other hcalls in a
>> > loop catching the H_LONG_BUSY_* codes.
>>=20
>> Are we sure it's safe to msleep() in all these paths?
>
> Probably not. We can have the IRQ descriptor lock. We might need to
> mdelay.
>
> There's a Kconfig option (forgot which one) that will add checks for
> attempts to sleep inside locks, you should run with that.

CONFIG_DEBUG_ATOMIC_SLEEP

cheers
