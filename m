Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F2F962C031A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 00:30:25 +1000 (EST)
Date: Thu, 11 Jul 2013 09:30:02 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/math-emu: keep track of the instructions
 unimplemented by FPU
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1373546721.19894.90.camel@pasglop> (from
 benh@kernel.crashing.org on Thu Jul 11 07:45:21 2013)
Message-ID: <1373553002.8183.245@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, Kevin Hao <haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2013 07:45:21 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-07-11 at 20:21 +0800, Kevin Hao wrote:
> > Some cores (such as Freescale BookE) don't implement all floating
> > point instructions in ISA. But some gcc versions do use these
> > instructions. So we would have to enable the math emulation in this
> > case. Add this to emulated instructions tracking statistics so that
> > the user has a way to know that its toolcahin emit these =20
> unimplemented
> > floating point instructions.
>=20
> That patch is gross, it makes the function even more nasty than it
> already is. Besides, CONFIG_PPC_FPU doesn't mean you have a HW FPU,
> you need to check the CPU feature bits.
>=20
> Also the caller already does PPC_WARN_EMULATED, so this patch makes
> you call it twice or am I missing something ?

Sorry, that was my fault -- for some reason I didn't see that when I =20
grepped for PPC_WARN_EMULATED looking for math stuff, and thus =20
requested it be added.  In any case, I don't see why it should be =20
conditional on having an FPU (and indeed, the warning in the caller =20
isn't conditional).

-Scott=
