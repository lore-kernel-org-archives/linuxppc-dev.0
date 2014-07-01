Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF96B1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 13:15:58 +1000 (EST)
Message-ID: <1404184557.18325.32.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Check for IRQHAPPENED before sleeping
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 30 Jun 2014 22:15:57 -0500
In-Reply-To: <1404175926.30002.1.camel@concordia>
References: <20140630062404.29315.23382.stgit@preeti.in.ibm.com>
 <1404175926.30002.1.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, shreyas@linux.vnet.ibm.com,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-07-01 at 10:52 +1000, Michael Ellerman wrote:
> On Mon, 2014-06-30 at 11:54 +0530, Preeti U Murthy wrote:
> > Commit 8d6f7c5a: "powerpc/powernv: Make it possible to skip the IRQHAPP=
ENED
> > check in power7_nap()" added code that prevents even cores which enter =
sleep
> > on idle, from checking for pending interrupts. Fix this.
>=20
> To be clear, it is a bug in the original commit. Mikey and I pair program=
med
> that code, and he was *definitely* typing at that point ;)

It's always nice to know that in battle a comrade will throw himself on
a grenade to save you. :-P

Actually, I'm pretty sure this happened when you were away (probably on
a beach somewhere), I was forward porting the patch set, hit a conflict
and fucked it up. =20

Mikey

>=20
> Can you please include in the changelog what the symptom of the bug is, a=
nd
> have you seen it in practice?
>=20
> The bad commit went into 3.16-rc1, so we don't need to backport this to a=
ny
> stable release.
>=20
> cheers
>=20
> > diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/id=
le_power7.S
> > index 2480256..5cf3d36 100644
> > --- a/arch/powerpc/kernel/idle_power7.S
> > +++ b/arch/powerpc/kernel/idle_power7.S
> > @@ -131,7 +131,7 @@ _GLOBAL(power7_nap)
> > =20
> >  _GLOBAL(power7_sleep)
> >  	li	r3,1
> > -	li	r4,0
> > +	li	r4,1
> >  	b	power7_powersave_common
> >  	/* No return */
> > =20
> >=20
>=20
>=20
>=20
>=20
>=20
