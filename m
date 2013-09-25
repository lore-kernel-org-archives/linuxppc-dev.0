Return-Path: <B40534@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E2422C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 12:34:35 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Bhushan Bharat-R65777
 <R65777@freescale.com>
Subject: RE: [PATCH v4 1/4] powerpc/fsl: add E6500 PVR and SPRN_PWRMGTCR0
 define
Date: Wed, 25 Sep 2013 02:34:27 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F154392590108FCD8@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1380014871-22937-1-git-send-email-dongsheng.wang@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0717DD00@039-SN2MPN1-011.039d.mgd.msft.net>
 <D3D5E237-6C31-424C-A340-E79F6AF5B0B2@kernel.crashing.org>
In-Reply-To: <D3D5E237-6C31-424C-A340-E79F6AF5B0B2@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >> /*
> >>  * For the 8xx processors, all of them report the same PVR family for
> >>  * the PowerPC core. The various versions of these processors must be
> >> diff -- git a/arch/powerpc/include/asm/reg_booke.h
> >> b/arch/powerpc/include/asm/reg_booke.h
> >> index ed8f836..4a6457e 100644
> >> --- a/arch/powerpc/include/asm/reg_booke.h
> >> +++ b/arch/powerpc/include/asm/reg_booke.h
> >> @@ -170,6 +170,7 @@
> >> #define SPRN_L2CSR1	0x3FA	/* L2 Data Cache Control and Status
> Register 1
> >> */
> >> #define SPRN_DCCR	0x3FA	/* Data Cache Cacheability Register */
> >> #define SPRN_ICCR	0x3FB	/* Instruction Cache Cacheability Register
> */
> >> +#define SPRN_PWRMGTCR0	0x3FB	/* Power management control register
> 0 */
> >
> > Is this generic for booke or e6500 specific? I can't see this register
> either in ISA and EREF.

Yes, now only e6500 have this register. There is no problem in this definit=
ion,
because no conflict in FSL platform.

> > Also I can see SPRN_ICCR also with same SPRN, how that is possible?
>=20
> Its possibly because the register maybe in implementation specific region=
.
> I'm guessing ICCR is a 40x specific register.

Yes, kumar is right. Its use only in 4xx series of chips.

ICTC(arch/powerpc/include/asm/reg.h) also use 0x3FB, Its use only in 6xx se=
ries of chips.

-dongsheng
