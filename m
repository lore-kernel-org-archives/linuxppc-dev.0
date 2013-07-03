Return-Path: <B02008@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 919982C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 22:25:39 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH 1/2] powerpc/booke64: Use common defines for AltiVec
 interrupts numbers
Date: Wed, 3 Jul 2013 12:25:22 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF0A2A35E3@039-SN2MPN1-013.039d.mgd.msft.net>
References: <8F554F03-E6B0-4140-8830-D4FD6249CEF9@suse.de> (from
 agraf@suse.de on Mon Jul  1 19:18:21 2013) <1372726613.8183.104@snotra>
In-Reply-To: <1372726613.8183.104@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> So we can remove this hack in kvm_asm.h:

Not yet, this comment was added in the context of AltiVec RFC patches
which intended to remove a similar dependency.

>=20
> /*
>   * TODO: Unify 32-bit and 64-bit kernel exception handlers to use same
> defines
>   */
> #define BOOKE_INTERRUPT_SPE_UNAVAIL BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
> #define BOOKE_INTERRUPT_SPE_FP_DATA
> BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
> #define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL
> BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
> #define BOOKE_INTERRUPT_ALTIVEC_ASSIST \
>=20
> BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
>=20
> It was added as a compilation fix, and it was less intrusive to
> temporarily fix it this way.
>=20
> I am curious why the above code wasn't removed at the end of this
> patchset. :-)

Before removing it we also need to apply at least the first patch from
the Altivec set that I will send today.

-Mike
