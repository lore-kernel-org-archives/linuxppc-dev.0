Return-Path: <runet@innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Mon, 25 Oct 2004 12:17:04 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DB99@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <Linuxppc-embedded@ozlabs.org>
Cc: 
Subject: [PATCH] RE: CPM2 Bug
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Did some more research.

Res6 should be 94 bytes long.

However... It does work @ 92 bytes because the compiler alligns the next
struct (pci_cpm2_t) on a int boundary anyways (no packing specified fo
the structs)

I tested it with a module that pronted out the address of the PCI struct
that follows the sit_cpm2_t struct.

Imap =3D 0xF0000000
With res6[92]
im-pci is @  0xf0010430

With res6[94]
im-pci is @  0xf0010430

So we're saved by the compiler.

Here's the patch

Signed-off by Rune Torgersen <runet@innovsys.com>

--- linux-2.5/include/asm-ppc/immap_cpm2.h      2004-10-21
10:00:14.607712610 -0500
+++ linux-innsys-2.6.9/include/asm-ppc/immap_cpm2.h     2004-10-25
12:09:58.000000000 -0500
@@ -133,7 +133,7 @@ typedef struct      sys_int_timers {
        u8      res5[2];
        u32     sit_pitc;
        u32     sit_pitr;
-       u8      res6[92];
+       u8      res6[94];
        u8      res7[390];
 } sit_cpm2_t;


> -----Original Message-----
> From: Rune Torgersen
> Sent: Friday, October 22, 2004 10:56
> I do use PCI in u-boot, and it works (on an 8266, not 8xx)
> > > Rune Torgersen wrote:
> > >=20
> > >> I think I found a bug in immap_cmp2.h
> > >>
> > >> (in structue sit_cpm2_t)
> > >>
> > >> I know that res7 was changed to make room for the PCI
> > structure But
> > >> res6 is 2 bytes shorter in the new one.
> > >>
> > >> I compared to the same structure in u-boot (that got the
> > PCI change
> > >> at about the same time) and it has it at 94 bytes long also.
> > >>
> > >>
> > >> Old structure:
> > >>  /* System Integration Timers.
> > >>  */
> > >> typedef struct sys_int_timers {
> > >>     char    res1[32];
> > >>     ushort    sit_tmcntsc;
> > >>     char    res2[2];
> > >>     uint    sit_tmcnt;
> > >>     char    res3[4];
> > >>     uint    sit_tmcntal;
> > >>     char    res4[16];
> > >>     ushort    sit_piscr;
> > >>     char    res5[2];
> > >>     uint    sit_pitc;
> > >>     uint    sit_pitr;
> > >>     char    res6[94];
> > >>     char    res7[2390];
> > >> } sit8260_t;
> > >>
> > >> New structue:
> > >> typedef struct sys_int_timers {
> > >>     u8    res1[32];
> > >>     u16    sit_tmcntsc;
> > >>     u8    res2[2];
> > >>     u32    sit_tmcnt;
> > >>     u8    res3[4];
> > >>     u32    sit_tmcntal;
> > >>     u8    res4[16];
> > >>     u16    sit_piscr;
> > >>     u8    res5[2];
> > >>     u32    sit_pitc;
> > >>     u32    sit_pitr;
> > >>     u8    res6[92];
> > >>     u8    res7[390];
> > >> } sit_cpm2_t;
> > >>
> > >> Rune Torgersen
> > >> System Developer
> > >> Innovative Systems LLC
> > >> 1000 Innovative Drive
> > >> Mitchell, SD 57301
> > >> Ph: 605-995-6120
> > >> www.innovsys.com _______________________________________________
> > >> Linuxppc-embedded mailing list Linuxppc-embedded@ozlabs.org
> > >> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > >>
> > >>
> > >=20
> > > _______________________________________________
> > > Linuxppc-embedded mailing list
> > > Linuxppc-embedded@ozlabs.org
> > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > >=20
> > >=20
> >=20
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >=20
> >=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
