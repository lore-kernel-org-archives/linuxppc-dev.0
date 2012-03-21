Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C116CB6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 07:21:05 +1100 (EST)
Subject: Re: [PATCH 12/38] powerpc/booke: Provide exception macros with
 interrupt name
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4F6A1B99.9030105@freescale.com>
Date: Wed, 21 Mar 2012 15:20:59 -0500
Message-Id: <BEC0D9DF-2949-4A0A-9F90-C08AE89FFC40@kernel.crashing.org>
References: <1330474206-14794-1-git-send-email-agraf@suse.de>
 <1330474206-14794-13-git-send-email-agraf@suse.de>
 <29EC69C4-816F-4B9E-9834-71176D2DECB9@kernel.crashing.org>
 <4F6A1B99.9030105@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 21, 2012, at 1:19 PM, Scott Wood wrote:

> On 03/21/2012 01:04 PM, Kumar Gala wrote:
>>=20
>> On Feb 28, 2012, at 6:09 PM, Alexander Graf wrote:
>>=20
>>> From: Scott Wood <scottwood@freescale.com>
>>>=20
>>> DO_KVM will need to identify the particular exception type.
>>>=20
>>> There is an existing set of arbitrary numbers that Linux passes,
>>> but it's an undocumented mess that sort of corresponds to =
server/classic
>>> exception vectors but not really.
>>=20
>> So what do the new names correspond to?
>=20
> The names are Linux-defined.  The values are IVOR numbers.
>=20
>> What header is defining MACHINE_CHECK, BOOKE_INTERRUPT_EXTERNAL, etc
>> (asm/kvm_asm.h)?
>=20
> Yes, it's asm/kvm_asm.h at the moment.
>=20
> It's actually BOOKE_INTERRUPT_MACHINE_CHECK, etc.  The exception =
macros
> paste on BOOKE_INTERRUPT_ when they use it, to keep the macro users =
from
> having to wrap lines even more often.
>=20
>> If so we really should move these out of
>> asm/kvm_asm.h and into something a bit more appropriate.
>=20
> Yes, that was one of the things I had been planning to fix post-RFC.
> Any preference what header it should be in?  asm/reg_booke.h seems to =
be
> the least bad option of the existing headers -- or perhaps move
> head_booke.h to arch/powerpc/include/asm.

asm/reg_booke.h seems the least painful right now.  head_booke.h is only =
used on 32-bit so that's not the best choice at this point.  We could =
create an <asm/head_booke.h> in addition to the one in =
arch/powerpc/kernel/

> Long-term it would also be nice for this to replace, rather than
> supplement, the current numbers, though as Ben pointed out there are a
> number of places throughout the code that will have to be fixed for =
that
> to happen.

Yeah, not too worried about that.  More just wanting it to be clear what =
one has to 'update' if adding support for a new exception.

- k=
