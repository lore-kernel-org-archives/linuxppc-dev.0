Return-Path: <hhppc-support@hhcn.com>
Received: from mxvip4.hichina.com (unknown [218.30.103.132])
	by ozlabs.org (Postfix) with ESMTP id 580DC67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 19 Jun 2005 11:40:37 +1000 (EST)
From: "HHPPC Support" <hhppc-support@hhcn.com>
To: =?GB2312?Q?=AE}=B3=D3=AB=C2?= <rober@opnet.com.tw>,
	linuxppc-embedded@ozlabs.org <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====002_Dragon785106016606_====="
Date: Sun, 19 Jun 2005 9:33:54 +0800
Message-Id: <20050619014037.580DC67A6C@ozlabs.org>
Cc: R64382@freescale.com
Subject: Re: Does any body have HYNIX or AMIC 32M SDRAM reference cdoe?
Reply-To: hhppc-support@hhcn.com
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

--=====002_Dragon785106016606_=====
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: quoted-printable

hi,
   This is out of reach of our support , and we have to turn to=
 our R&D for help.
and thus, you may post this to our BBS:  bbs.hhcn.com


BR
HHPPC support
=3D=3D=3D=3D=3D=3D=3D=3D 2005-06-17 16:07:00 =C4=FA=D4=DA=C0=B4=D0=C5=D6=D0=D0=B4=B5=C0=A3=BA =3D=3D=3D=3D=3D=3D=3D=3D

Hi All:

       I used HY57641620 * 2 total all 16M SDRAM at my MPC852T=
 board, now i want to 
used HY57V281620ET-H * 2 or AMIC A43L3616-6 * 2 total all  32M=
 SDRAM, but i don't know
how to setting UPM to control it, i need help.If you used another=
 32M SDRAM solution,
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

 upmconfig(UPMA, (uint *)sdram_table,=
 sizeof(sdram_table)/sizeof(uint));
  
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
 memctl->memc_mcr =3D 0x80004106; 
 udelay(200);

 memctl->memc_or2 =3D 0xFE000A00;
 memctl->memc_br2 =3D 0x00000081;

 return (32 * 1024 *1024);
} /* end of initdram */

 


=3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D 

=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1HHPPC Support
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1hhppc-support@hhcn.com
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1

--=====002_Dragon785106016606_=====
Content-Type: text/html;
      charset="GB2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html;=
 charset=3Dgb2312">
<META content=3D"MSHTML 6.00.2800.1226" name=3DGENERATOR></HEAD>
<BODY>
<DIV>hi,</DIV>
<DIV>&nbsp;&nbsp; This is out of reach of our support , and we=
 have to turn to 
our R&amp;D for help.</DIV>
<DIV>and thus, you may post this to our BBS:&nbsp;=
 bbs.hhcn.com</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>BR</DIV>
<DIV>HHPPC support</DIV>
<DIV><FONT face=3D=CB=CE=CC=E5 size=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=
 2005-06-17&nbsp;16:07:00&nbsp;=C4=FA=D4=DA=C0=B4=D0=C5=D6=D0=D0=B4=B5=C0=A3=BA 
=3D=3D=3D=3D=3D=3D=3D=3D</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>
<TABLE width=3D"100%">
  <TBODY>
  <TR>
    <TD width=3D"100%">
      <BLOCKQUOTE 
      style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT:=
 5px; BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
        <DIV><FONT size=3D2>Hi All:</FONT></DIV>
        <DIV><FONT size=3D2></FONT>&nbsp;</DIV>
        <DIV><FONT size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I=
 used 
        </FONT><FONT size=3D3>HY57641620 * 2 total all 16M SDRAM at=
 my MPC852T 
        board, now i want to </FONT></DIV>
        <DIV>used HY57V281620ET-H * 2&nbsp;or AMIC A43L3616-6 *=
 2&nbsp;total 
        all&nbsp; 32M SDRAM, but i don't know</DIV>
        <DIV>how to setting UPM to control it, i need help.If=
 you&nbsp;used 
        another 32M SDRAM&nbsp;solution,</DIV>
        <DIV>please tell me, thanks.</DIV>
        <DIV>&nbsp;</DIV>
        <DIV>&nbsp;</DIV>
        <DIV>#define _NOT_USED_&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        0xFFFFFFFF<BR><BR>const uint sdram_table[] =3D&nbsp;&nbsp;=
 /* for 
        HY57641620 * 2 16M&nbsp; SDRAM 
        */<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 Single Read. 
        (offset 0x0-0x4 in UPM RAM)&nbsp;&nbsp;&nbsp;&nbsp; 
        */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 Precharge and 
        MRS(offset 0x5-0x7 in UPM RAM) 
        */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x1F07FC04, 0xEEAEFC04, 
        0x11ADFC04,=
 0xEFBBBC00,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        0x1FF77C47, 0x1FF77C35, 0xEFEABC34, 
       =
 0x1FB57C35,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 Burst 
        Read. (offset 0x8-0xf in UPM RAM) 
        */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x1F07FC04, 0xEEAEFC04, 
        0x10ADFC04,=
 0xF0AFFC00,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        0xF0AFFC00, 0xF1AFFC00, 0xEFBBBC00, 
        0x1FF77C47,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 _NOT_USED_, 
        _NOT_USED_, _NOT_USED_, 
        _NOT_USED_,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 _NOT_USED_, 
        _NOT_USED_, _NOT_USED_, 
       =
 _NOT_USED_,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 Single 
        Write. (offset 0x18-0x1F in UPM RAM) 
        */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x1F27FC04, 0xEEAEBC00, 
        0x01B93C04,=
 0x1FF77C47,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        _NOT_USED_, _NOT_USED_, _NOT_USED_, 
       =
 _NOT_USED_,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 Burst 
        Write. (offset 20-2F in UPM RAM) 
        */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x1F07FC04, 0xEEAEBC00, 
        0x10AD7C00,=
 0xF0AFFC00,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        0xF0AFFC00, 0xE1BBBC04, 0x1FF77C47, 
        _NOT_USED_,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 _NOT_USED_, 
        _NOT_USED_, _NOT_USED_, 
        _NOT_USED_,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 _NOT_USED_, 
        _NOT_USED_, _NOT_USED_, 
       =
 _NOT_USED_,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 Refresh 
        timer expired (offset 30-3B in UPM RAM) 
        */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x1FF5FC84, 0xFFFFFC04, 
        0xFFFFFC04,=
 0xFFFFFC04,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        0xFFFFFC84, 0xFFFFFC07, 0xffffffff, 
        _NOT_USED_,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 _NOT_USED_, 
        _NOT_USED_, _NOT_USED_, 
       =
 _NOT_USED_,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 
        Exception. (offset 3c-3f in UPM RAM) 
        */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x7FFFFC07, _NOT_USED_, 
        _NOT_USED_, _NOT_USED_<BR>};</DIV>
        <DIV>&nbsp;</DIV>
        <DIV><FONT size=3D2>long int initdram(int 
        board_type)<BR>{<BR>&nbsp;volatile=
 immap_t&nbsp;&nbsp;&nbsp;&nbsp; 
        *immap =3D (immap_t *)CFG_IMMR;<BR>&nbsp;volatile=
 memctl8xx_t *memctl =3D 
        &amp;immap-&gt;im_memctl;</FONT></DIV>
        <DIV>&nbsp;</DIV>
        <DIV><FONT size=3D2>&nbsp;upmconfig(UPMA, (uint=
 *)sdram_table, 
        sizeof(sdram_table)/sizeof(uint));<BR>&nbsp; 
        <BR>&nbsp;memctl-&gt;memc_mptpr =3D 0x0400;</FONT></DIV>
        <DIV>&nbsp;</DIV>
        <DIV><FONT size=3D2>&nbsp;/*<BR>&nbsp; * Configure the=
 refresh 
        (mostly).&nbsp; This needs to be<BR>&nbsp; * based upon=
 processor clock 
        speed and optimized to provide<BR>&nbsp; * the highest=
 level of 
        performance.&nbsp; For multiple banks,<BR>&nbsp; * this=
 time has to be 
        divided by the number of banks.<BR>&nbsp; * Although it=
 is not clear 
        anywhere, it appears the<BR>&nbsp; * refresh steps=
 through the chip 
        selects for this UPM<BR>&nbsp; * on each refresh=
 cycle.<BR>&nbsp; * We 
        have to be careful changing<BR>&nbsp; * UPM registers=
 after we ask it to 
        run these commands.<BR>&nbsp; */</FONT></DIV>
        <DIV>&nbsp;</DIV>
        <DIV><FONT size=3D2>&nbsp;memctl-&gt;memc_mamr =3D 
        0xD0904114;<BR>&nbsp;memctl-&gt;memc_mar =3D 
        0x00000088;<BR>&nbsp;udelay(200);</FONT></DIV>
        <DIV>&nbsp;</DIV>
        <DIV><FONT size=3D2>&nbsp;memctl-&gt;memc_mcr =3D 
        0x80004105;&nbsp;&nbsp;&nbsp;&nbsp; /* precharge 
        */<BR>&nbsp;udelay(200);</FONT></DIV>
        <DIV>&nbsp;</DIV>
        <DIV><FONT size=3D2>&nbsp;memctl-&gt;memc_mamr =3D 
        0xD0904114;<BR>&nbsp;memctl-&gt;memc_mcr =3D 
        0x80004830;&nbsp;&nbsp;&nbsp;&nbsp; /* refresh 
        */<BR>&nbsp;udelay(200);</FONT></DIV>
        <DIV>&nbsp;</DIV>
        <DIV><FONT size=3D2>&nbsp;memctl-&gt;memc_mamr =3D 
        0xD0904114;<BR>&nbsp;memctl-&gt;memc_mcr =3D 0x80004106; 
        <BR>&nbsp;udelay(200);</FONT></DIV>
        <DIV>&nbsp;</DIV>
        <DIV><FONT size=3D2>&nbsp;memctl-&gt;memc_or2 =3D 
        0xFE000A00;<BR>&nbsp;memctl-&gt;memc_br2 =3D=
 0x00000081;</FONT></DIV>
        <DIV>&nbsp;</DIV>
        <DIV><FONT size=3D2>&nbsp;return (32 * 1024=
 *1024);<BR>}&nbsp;/* end of 
        initdram */<BR></FONT><BR>&nbsp;</DIV>
       =
 <DIV>&nbsp;</DIV></BLOCKQUOTE></TD></TR></TBODY></TABLE></FONT><=
/DIV>
<DIV>
<P><FONT face=3D=CB=CE=CC=E5 size=3D2>=3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D=
 =3D =3D </FONT></P>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3D=CB=CE=CC=E5 size=3D2>=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1HHPPC=
 Support</FONT></DIV>
<DIV><FONT face=3D=CB=CE=CC=E5 size=3D2><FONT face=3D=CB=CE=CC=E5=
 size=3D2>=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1</FONT><A 
href=3D"mailto:hhppc-support@hhcn.com">hhppc-support@hhcn.com</A></=
FONT></DIV>
<DIV><FONT face=3D=CB=CE=CC=E5=
 size=3D2>=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1</FONT></DIV>
<DIV>&nbsp;</DIV></DIV></BODY></HTML>

--=====002_Dragon785106016606_=====--
