Return-Path: <B40534@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9AC982C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 19:55:53 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 1/2] powerpc: add Book E support to 64-bit hibernation
Date: Thu, 13 Jun 2013 09:55:43 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259F74985@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1370774260-31072-1-git-send-email-dongsheng.wang@freescale.com>
 (from	dongsheng.wang@freescale.com on Sun Jun  9 05:37:39 2013)
 <1371074628.18413.53@snotra>
In-Reply-To: <1371074628.18413.53@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "anton@enomsg.org" <anton@enomsg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, June 13, 2013 6:04 AM
> To: Wang Dongsheng-B40534
> Cc: benh@kernel.crashing.org; johannes@sipsolutions.net; anton@enomsg.org=
;
> galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-
> B40534
> Subject: Re: [PATCH 1/2] powerpc: add Book E support to 64-bit
> hibernation
>=20
> On 06/09/2013 05:37:39 AM, Wang Dongsheng wrote:
> >  /* these macros rely on the save area being
> >   * pointed to by r11 */
> > +
> > +#define SAVE_SPR(register)		\
> > +	mfspr	r0,SPRN_##register	;\
> > +	std	r0,SL_##register(r11)
> > +#define RESTORE_SPR(register)		\
> > +	ld	r0,SL_##register(r11)	;\
> > +	mtspr	SPRN_##register,r0
> > +#define RESTORE_SPRG(n)			\
> > +	ld	r0,SL_SPRG##n(r11)	;\
> > +	mtsprg	n,r0
> >  #define SAVE_SPECIAL(special)		\
> >  	mf##special	r0		;\
> >  	std	r0, SL_##special(r11)
>=20
> Is there a particular SPR that you're trying to save, for which
> SAVE_SPECIAL doesn't work?
>=20
Yes, like pid, tcr.

> > +#else
> > +	/* Save SPRGs */
> > +	RESTORE_SPRG(0)
> > +	RESTORE_SPRG(1)
> > +	RESTORE_SPRG(2)
> > +	RESTORE_SPRG(3)
> > +	RESTORE_SPRG(4)
> > +	RESTORE_SPRG(5)
> > +	RESTORE_SPRG(6)
> > +	RESTORE_SPRG(7)
>=20
> Why do we need this on book3e and not on book3s?
>=20
Book3e: SPRG1 used save paca, SPRG2 be defined SPRN_SPRG_TLB_EXFRAME,...
I think those register should be save, even now some SPRG register not be u=
se.

Book3s: Sorry, I not clear why book3s not do this. I think Anton or Ben cou=
ld know the reason.

> > +
> > +	RESTORE_SPECIAL(MSR)
> > +
> > +	/* Restore TCR and clear any pending bits in TSR. */
> > +	RESTORE_SPR(TCR)
> > +	lis	r0, (TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS)@h
> > +	mtspr	SPRN_TSR,r0
>=20
> Please be internally consistent with whitespace after commas, even if the
> rest of the file is already inconsistent. :-P
>=20
Thanks.

> > +
> > +	/* Kick decrementer */
> > +	li	r0,1
> > +	mtdec	r0
>=20
> Why doesn't book3s need to kick the decrementer?
>=20
Sorry, I not clear why book3s not do this. I think Anton or Ben could know =
the reason.

> -Scott
