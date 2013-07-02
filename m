Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8ECE02C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 10:58:18 +1000 (EST)
Date: Mon, 1 Jul 2013 19:56:53 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/booke64: Use common defines for AltiVec
 interrupts numbers
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <8F554F03-E6B0-4140-8830-D4FD6249CEF9@suse.de> (from
 agraf@suse.de on Mon Jul  1 19:18:21 2013)
Message-ID: <1372726613.8183.104@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/01/2013 07:18:21 PM, Alexander Graf wrote:
>=20
> On 01.07.2013, at 17:35, Mihai Caraman wrote:
>=20
> > On Book3E some SPE/FP/AltiVec interrupts share the same number. Use
> > common defines to indentify these numbers.
>=20
> So why didn't this happen from the beginning?

Ask Kumar.

> Why the change?

So we can remove this hack in kvm_asm.h:

/*
  * TODO: Unify 32-bit and 64-bit kernel exception handlers to use same =20
defines
  */
#define BOOKE_INTERRUPT_SPE_UNAVAIL BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
#define BOOKE_INTERRUPT_SPE_FP_DATA =20
BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST
#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL =20
BOOKE_INTERRUPT_SPE_ALTIVEC_UNAVAIL
#define BOOKE_INTERRUPT_ALTIVEC_ASSIST \
                                 =20
BOOKE_INTERRUPT_SPE_FP_DATA_ALTIVEC_ASSIST

It was added as a compilation fix, and it was less intrusive to =20
temporarily fix it this way.

I am curious why the above code wasn't removed at the end of this =20
patchset. :-)

-Scott=
