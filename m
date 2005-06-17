Return-Path: <rober@opnet.com.tw>
Received: from opnet2.opnet.com.tw (unknown [210.243.240.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA94867A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 18:08:24 +1000 (EST)
Message-ID: <006901c57313$9f6bc460$a40e000a@RoberHsu>
From: =?big5?B?rn2z06vC?= <rober@opnet.com.tw>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 17 Jun 2005 16:07:27 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0066_01C57356.A7E4F970"
Cc: R64382@freescale.com, HHPPC Support <hhppc-support@hhcn.com>
Subject: Does any body have HYNIX or AMIC 32M SDRAM reference cdoe?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0066_01C57356.A7E4F970
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi All:

       I used HY57641620 * 2 total all 16M SDRAM at my MPC852T board, =
now i want to=20
used HY57V281620ET-H * 2 or AMIC A43L3616-6 * 2 total all  32M SDRAM, =
but i don't know
how to setting UPM to control it, i need help.If you used another 32M =
SDRAM solution,
please tell me, thanks.


#define _NOT_USED_      0xFFFFFFFF

const uint sdram_table[] =3D   /* for HY57641620 * 2 16M  SDRAM */
{
        /* Single Read. (offset 0x0-0x4 in UPM RAM)     */
        /* Precharge and MRS(offset 0x5-0x7 in UPM RAM) */
        0x1F07FC04, 0xEEAEFC04, 0x11ADFC04, 0xEFBBBC00,
        0x1FF77C47, 0x1FF77C35, 0xEFEABC34, 0x1FB57C35,

        /* Burst Read. (offset 0x8-0xf in UPM RAM) */
        0x1F07FC04, 0xEEAEFC04, 0x10ADFC04, 0xF0AFFC00,
        0xF0AFFC00, 0xF1AFFC00, 0xEFBBBC00, 0x1FF77C47,
        _NOT_USED_, _NOT_USED_, _NOT_USED_, _NOT_USED_,
        _NOT_USED_, _NOT_USED_, _NOT_USED_, _NOT_USED_,

        /* Single Write. (offset 0x18-0x1F in UPM RAM) */
        0x1F27FC04, 0xEEAEBC00, 0x01B93C04, 0x1FF77C47,
        _NOT_USED_, _NOT_USED_, _NOT_USED_, _NOT_USED_,

        /* Burst Write. (offset 20-2F in UPM RAM) */
        0x1F07FC04, 0xEEAEBC00, 0x10AD7C00, 0xF0AFFC00,
        0xF0AFFC00, 0xE1BBBC04, 0x1FF77C47, _NOT_USED_,
        _NOT_USED_, _NOT_USED_, _NOT_USED_, _NOT_USED_,
        _NOT_USED_, _NOT_USED_, _NOT_USED_, _NOT_USED_,

        /* Refresh timer expired (offset 30-3B in UPM RAM) */
        0x1FF5FC84, 0xFFFFFC04, 0xFFFFFC04, 0xFFFFFC04,
        0xFFFFFC84, 0xFFFFFC07, 0xffffffff, _NOT_USED_,
        _NOT_USED_, _NOT_USED_, _NOT_USED_, _NOT_USED_,

        /* Exception. (offset 3c-3f in UPM RAM) */
        0x7FFFFC07, _NOT_USED_, _NOT_USED_, _NOT_USED_
};

long int initdram(int board_type)
{
 volatile immap_t     *immap =3D (immap_t *)CFG_IMMR;
 volatile memctl8xx_t *memctl =3D &immap->im_memctl;

 upmconfig(UPMA, (uint *)sdram_table, sizeof(sdram_table)/sizeof(uint));
 =20
 memctl->memc_mptpr =3D 0x0400;

 /*
  * Configure the refresh (mostly).  This needs to be
  * based upon processor clock speed and optimized to provide
  * the highest level of performance.  For multiple banks,
  * this time has to be divided by the number of banks.
  * Although it is not clear anywhere, it appears the
  * refresh steps through the chip selects for this UPM
  * on each refresh cycle.
  * We have to be careful changing
  * UPM registers after we ask it to run these commands.
  */

 memctl->memc_mamr =3D 0xD0904114;
 memctl->memc_mar =3D 0x00000088;
 udelay(200);

 memctl->memc_mcr =3D 0x80004105;     /* precharge */
 udelay(200);

 memctl->memc_mamr =3D 0xD0904114;
 memctl->memc_mcr =3D 0x80004830;     /* refresh */
 udelay(200);

 memctl->memc_mamr =3D 0xD0904114;
 memctl->memc_mcr =3D 0x80004106;=20
 udelay(200);

 memctl->memc_or2 =3D 0xFE000A00;
 memctl->memc_br2 =3D 0x00000081;

 return (32 * 1024 *1024);
} /* end of initdram */

=20

------=_NextPart_000_0066_01C57356.A7E4F970
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2>Hi All:</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I used =
</FONT><FONT=20
size=3D3>HY57641620 * 2 total all 16M SDRAM at my MPC852T board, now i =
want to=20
</FONT></DIV>
<DIV>used HY57V281620ET-H * 2&nbsp;or AMIC A43L3616-6 * 2&nbsp;total =
all&nbsp;=20
32M SDRAM, but i don't know</DIV>
<DIV>how to setting UPM to control it, i need help.If you&nbsp;used =
another 32M=20
SDRAM&nbsp;solution,</DIV>
<DIV>please tell me, thanks.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>#define _NOT_USED_&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xFFFFFFFF<BR><BR>const=20
uint sdram_table[] =3D&nbsp;&nbsp; /* for HY57641620 * 2 16M&nbsp; SDRAM =

*/<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Single Read. =
(offset=20
0x0-0x4 in UPM RAM)&nbsp;&nbsp;&nbsp;&nbsp;=20
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Precharge and =
MRS(offset=20
0x5-0x7 in UPM RAM) */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x1F07FC04,=20
0xEEAEFC04, 0x11ADFC04,=20
0xEFBBBC00,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1FF77C47,=20
0x1FF77C35, 0xEFEABC34,=20
0x1FB57C35,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Burst =
Read.=20
(offset 0x8-0xf in UPM RAM) =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0x1F07FC04, 0xEEAEFC04, 0x10ADFC04,=20
0xF0AFFC00,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xF0AFFC00,=20
0xF1AFFC00, 0xEFBBBC00,=20
0x1FF77C47,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _NOT_USED_,=20
_NOT_USED_, _NOT_USED_,=20
_NOT_USED_,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _NOT_USED_,=20
_NOT_USED_, _NOT_USED_,=20
_NOT_USED_,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Single =
Write.=20
(offset 0x18-0x1F in UPM RAM) =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0x1F27FC04, 0xEEAEBC00, 0x01B93C04,=20
0x1FF77C47,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _NOT_USED_,=20
_NOT_USED_, _NOT_USED_,=20
_NOT_USED_,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Burst =
Write.=20
(offset 20-2F in UPM RAM) =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0x1F07FC04, 0xEEAEBC00, 0x10AD7C00,=20
0xF0AFFC00,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xF0AFFC00,=20
0xE1BBBC04, 0x1FF77C47,=20
_NOT_USED_,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _NOT_USED_,=20
_NOT_USED_, _NOT_USED_,=20
_NOT_USED_,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _NOT_USED_,=20
_NOT_USED_, _NOT_USED_,=20
_NOT_USED_,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Refresh =
timer=20
expired (offset 30-3B in UPM RAM)=20
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1FF5FC84, 0xFFFFFC04, =

0xFFFFFC04, 0xFFFFFC04,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0xFFFFFC84, 0xFFFFFC07, 0xffffffff,=20
_NOT_USED_,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _NOT_USED_,=20
_NOT_USED_, _NOT_USED_,=20
_NOT_USED_,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Exception.=20
(offset 3c-3f in UPM RAM) =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0x7FFFFC07, _NOT_USED_, _NOT_USED_, _NOT_USED_<BR>};</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>long int initdram(int =
board_type)<BR>{<BR>&nbsp;volatile=20
immap_t&nbsp;&nbsp;&nbsp;&nbsp; *immap =3D (immap_t =
*)CFG_IMMR;<BR>&nbsp;volatile=20
memctl8xx_t *memctl =3D &amp;immap-&gt;im_memctl;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>&nbsp;upmconfig(UPMA, (uint *)sdram_table,=20
sizeof(sdram_table)/sizeof(uint));<BR>&nbsp; =
<BR>&nbsp;memctl-&gt;memc_mptpr =3D=20
0x0400;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>&nbsp;/*<BR>&nbsp; * Configure the refresh =
(mostly).&nbsp;=20
This needs to be<BR>&nbsp; * based upon processor clock speed and =
optimized to=20
provide<BR>&nbsp; * the highest level of performance.&nbsp; For multiple =

banks,<BR>&nbsp; * this time has to be divided by the number of =
banks.<BR>&nbsp;=20
* Although it is not clear anywhere, it appears the<BR>&nbsp; * refresh =
steps=20
through the chip selects for this UPM<BR>&nbsp; * on each refresh=20
cycle.<BR>&nbsp; * We have to be careful changing<BR>&nbsp; * UPM =
registers=20
after we ask it to run these commands.<BR>&nbsp; */</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>&nbsp;memctl-&gt;memc_mamr =3D=20
0xD0904114;<BR>&nbsp;memctl-&gt;memc_mar =3D=20
0x00000088;<BR>&nbsp;udelay(200);</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>&nbsp;memctl-&gt;memc_mcr =3D=20
0x80004105;&nbsp;&nbsp;&nbsp;&nbsp; /* precharge=20
*/<BR>&nbsp;udelay(200);</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>&nbsp;memctl-&gt;memc_mamr =3D=20
0xD0904114;<BR>&nbsp;memctl-&gt;memc_mcr =3D =
0x80004830;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* refresh */<BR>&nbsp;udelay(200);</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>&nbsp;memctl-&gt;memc_mamr =3D=20
0xD0904114;<BR>&nbsp;memctl-&gt;memc_mcr =3D 0x80004106;=20
<BR>&nbsp;udelay(200);</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>&nbsp;memctl-&gt;memc_or2 =3D=20
0xFE000A00;<BR>&nbsp;memctl-&gt;memc_br2 =3D 0x00000081;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>&nbsp;return (32 * 1024 *1024);<BR>}&nbsp;/* end of =
initdram=20
*/<BR></FONT><BR>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0066_01C57356.A7E4F970--
