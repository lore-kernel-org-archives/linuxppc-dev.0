Return-Path: <runet@innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Fri, 22 Oct 2004 10:56:21 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DB94@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Conor McLoughlin" <cml3227@eircom.net>,
	<Linuxppc-embedded@ozlabs.org>
Cc: 
Subject: RE: CPM2 Bug
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I do use PCI in u-boot, and it works (on an 8266, not 8xx)


> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> Conor McLoughlin
> Sent: Friday, October 22, 2004 10:29
> To: Linuxppc-embedded@ozlabs.org
> Subject: Re: CPM2 Bug
>=20
>=20
> Just to clarify, I don't use PCI in u-boot. The structure in=20
> u-boot may be wrong, I didn't look at it.
>=20
> Conor
>=20
> Conor McLoughlin wrote:
> > Rune,
> >=20
> > I don't think that there is a bug.
> > I have PCI working on an 8250 target.
> >=20
> > The new structure agrees with the rev 1 of the MPC8xx=20
> manual. The old=20
> > structure agreed with the rev 0 manual (without PCI).
> >=20
> > Conor
> >=20
> > Rune Torgersen wrote:
> >=20
> >> I think I found a bug in immap_cmp2.h
> >>
> >> (in structue sit_cpm2_t)
> >>
> >> I know that res7 was changed to make room for the PCI=20
> structure But=20
> >> res6 is 2 bytes shorter in the new one.
> >>
> >> I compared to the same structure in u-boot (that got the=20
> PCI change=20
> >> at about the same time) and it has it at 94 bytes long also.
> >>
> >>
> >> Old structure:
> >>  /* System Integration Timers.
> >>  */
> >> typedef struct sys_int_timers {
> >>     char    res1[32];
> >>     ushort    sit_tmcntsc;
> >>     char    res2[2];
> >>     uint    sit_tmcnt;
> >>     char    res3[4];
> >>     uint    sit_tmcntal;
> >>     char    res4[16];
> >>     ushort    sit_piscr;
> >>     char    res5[2];
> >>     uint    sit_pitc;
> >>     uint    sit_pitr;
> >>     char    res6[94];
> >>     char    res7[2390];
> >> } sit8260_t;
> >>
> >> New structue:
> >> typedef struct sys_int_timers {
> >>     u8    res1[32];
> >>     u16    sit_tmcntsc;
> >>     u8    res2[2];
> >>     u32    sit_tmcnt;
> >>     u8    res3[4];
> >>     u32    sit_tmcntal;
> >>     u8    res4[16];
> >>     u16    sit_piscr;
> >>     u8    res5[2];
> >>     u32    sit_pitc;
> >>     u32    sit_pitr;
> >>     u8    res6[92];
> >>     u8    res7[390];
> >> } sit_cpm2_t;
> >>
> >> Rune Torgersen
> >> System Developer
> >> Innovative Systems LLC
> >> 1000 Innovative Drive
> >> Mitchell, SD 57301
> >> Ph: 605-995-6120
> >> www.innovsys.com _______________________________________________
> >> Linuxppc-embedded mailing list
> >> Linuxppc-embedded@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >>
> >>
> >=20
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >=20
> >=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
