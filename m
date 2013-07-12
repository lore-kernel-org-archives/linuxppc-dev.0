Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B5FC12C0349
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 06:54:05 +1000 (EST)
Date: Fri, 12 Jul 2013 15:53:19 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/math-emu: keep track of the instructions
 unimplemented by FPU
To: Kevin Hao <haokexin@gmail.com>
References: <1373546721.19894.90.camel@pasglop> <1373553002.8183.245@snotra>
 <20130712022512.GB32154@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20130712022512.GB32154@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Thu Jul 11 21:25:12 2013)
Message-ID: <1373662399.8183.283@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2013 09:25:12 PM, Kevin Hao wrote:
> On Thu, Jul 11, 2013 at 09:30:02AM -0500, Scott Wood wrote:
> > Sorry, that was my fault -- for some reason I didn't see that when I
> > grepped for PPC_WARN_EMULATED looking for math stuff, and thus
> > requested it be added.  In any case, I don't see why it should be
> > conditional on having an FPU (and indeed, the warning in the caller
> > isn't conditional).
>=20
> I thought it only made sense to warn only for the case when the core
> does have a FPU but some unimplemented floating instructions are =20
> emulated.
> As for the core which doesn't have a FPU at all and we explicitly =20
> enable the
> math emulation it may seems a little redundant to warn in this case. =20
> But after
> a second thought, this is the statistics of all the emulated =20
> instructions,
> so it does seem reasonable to warn in all cases. I will remove the =20
> dependancy
> on FPU.

It's not redundant at all to warn when an FPU is absent.  It tells you =20
that you're being slowed down by running hard-FP code instead of =20
soft-FP code.

-Scott=
