Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 84B102C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 03:25:44 +1000 (EST)
Date: Mon, 22 Jul 2013 12:25:32 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: split the math emulation into two parts
To: Kumar Gala <galak@kernel.crashing.org>
References: <1373975836-11928-1-git-send-email-haokexin@gmail.com>
 <1373975836-11928-2-git-send-email-haokexin@gmail.com>
 <4E35EEC3-D4D8-4C03-B22E-5574584539AE@kernel.crashing.org>
In-Reply-To: <4E35EEC3-D4D8-4C03-B22E-5574584539AE@kernel.crashing.org>
 (from galak@kernel.crashing.org on Mon Jul 22 09:36:05 2013)
Message-ID: <1374513932.15592.5@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Kevin Hao <haokexin@gmail.com>, linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2013 09:36:05 AM, Kumar Gala wrote:
>=20
> On Jul 16, 2013, at 6:57 AM, Kevin Hao wrote:
>=20
> > For some SoC (such as the FSL BookE) even though there does have
> > a hardware FPU, but not all floating point instructions are
> > implemented. Unfortunately some versions of gcc do use these
> > unimplemented instructions. Then we have to enable the math =20
> emulation
> > to workaround this issue. It seems a little redundant to have the
> > support to emulate all the floating point instructions in this case.
> > So split the math emulation into two parts. One is for the SoC which
> > doesn't have FPU at all and the other for the SoC which does have =20
> the
> > hardware FPU and only need some special floating point instructions =20
> to
> > be emulated.
> >
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> > arch/powerpc/Kconfig           | 20 ++++++++++++++++++++
> > arch/powerpc/math-emu/Makefile | 24 ++++++++++++------------
> > arch/powerpc/math-emu/math.c   | 20 ++++++++++++++------
> > 3 files changed, 46 insertions(+), 18 deletions(-)
>=20
> why make the split, what harm is there in just turning on the full =20
> emulation code to handle the unimplemented cases?

My main motivation in requesting it was to contain the increase in =20
build time -- math-emu always stuck out to me as something that took a =20
noticeable amount of time to build.  It also reduces the increase in =20
kernel image size.

> who says what some other implementation doesn't need something that =20
> you have in CONFIG_MATH_EMULATION_FULL?

The point is to include any instructions that are known to be missing =20
in any chip's FPU (excluding chips that don't have an FPU at all).  If =20
it is discovered that some chip is missing an instruction that we =20
didn't account for, then we'd move that instruction from one list to =20
the other.

> Is the kernel code size really an issue?

It can be when you're storing it on flash -- especially when the growth =20
is out of control because of the need to justify pruning low-hanging =20
fruit such as this.

-Scott=
