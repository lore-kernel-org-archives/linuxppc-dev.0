Return-Path: <B32721@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CEA0B2C0106
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2013 18:29:59 +1000 (EST)
From: Udma Catalin-Dan-B32721 <B32721@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH v2] powerpc: Update compilation flags with core specific
 options
Date: Mon, 29 Jul 2013 08:29:51 +0000
Message-ID: <FE751157F0442848A159F3AB4CB1F55B3F9F27@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1374753254-10381-1-git-send-email-catalin.udma@freescale.com>
 <6CCCB1C2-FA50-476A-B3D0-9F8FCAC404E5@kernel.crashing.org>
In-Reply-To: <6CCCB1C2-FA50-476A-B3D0-9F8FCAC404E5@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > The assembler option is redundant if the -mcpu=3D flag is set.
> > The patch fixes the kernel compilation problem for e5500/e6500
> > when using gcc option -mcpu=3De5500/e6500.
> >
> > Signed-off-by: Catalin Udma <catalin.udma@freescale.com>
> > ---
> > changes for v2:
> >    - update also KBUILD_AFLAGS with -mcpu and -msoft-float flags
> >
> > arch/powerpc/Makefile |   16 +++++++++++++++-
> > 1 files changed, 15 insertions(+), 1 deletions(-)
>=20
> Is the assembler redundant for older toolchains?
>=20
> - k
[CU] gcc defines the mapping from -mcpu to assembler options in file
gcc/config/rs6000/rs6000.h, like this:
	%{mcpu=3D8540: -me500} \
	%{mcpu=3D8548: -me500} \
	%{mcpu=3De300c2: -me300} \
	%{mcpu=3De300c3: -me300} \
	%{mcpu=3De500mc: -me500mc} \
	%{mcpu=3De500mc64: -me500mc64} \
	%{mcpu=3De5500: -me5500} \
	%{mcpu=3De6500: -me6500} \

I have checked this mapping from gcc 3.3 (where 8540 entry was added) to
3.4, 4.3, 4.4 and 4.8.1...The -Wa option is redundant for all these
older toolchains.
Catalin
