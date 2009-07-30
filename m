Return-Path: <ashish.kalra@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1E075B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 23:27:03 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7DD0DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 23:27:01 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n6UDQgrN016612
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 06:26:53 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net
	[10.232.192.5])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n6UDQuL3028104
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 08:26:57 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA1119.5E8FEC8E"
Subject: RE: [PATCH][sata_fsl] Defer non-ncq commands when ncq commands active
Date: Thu, 30 Jul 2009 18:53:17 +0530
Message-ID: <16444A0F3094A24C83EAB7836A12C63B032E5A@zin33exm20.fsl.freescale.net>
References: <Pine.WNT.4.64.0907292129310.4440@B00888-02.fsl.freescale.net>
	<4A70A78D.7070601@gmail.com>
From: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
To: "Robert Hancock" <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA1119.5E8FEC8E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,=20

>> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
>> ---
>> drivers/ata/sata_fsl.c | 1 +
>> 1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>> index 5a88b44..a33f130 100644
>> --- a/drivers/ata/sata_fsl.c
>> +++ b/drivers/ata/sata_fsl.c
>> @@ -1262,6 +1262,7 @@ static struct scsi_host_template sata_fsl_sht =
=3D {
>> static struct ata_port_operations sata_fsl_ops =3D {
>> .inherits =3D &sata_pmp_port_ops,
>>
>> + .qc_defer =3D ata_std_qc_defer;
>> .qc_prep =3D sata_fsl_qc_prep,
>> .qc_issue =3D sata_fsl_qc_issue,
>> .qc_fill_rtf =3D sata_fsl_qc_fill_rtf,

> This doesn't look like it should change anything. sata_fsl_ops =
inherits
> from sata_pmp_port_ops, which inherits from sata_port_ops, which =
already
> sets qc_defer to ata_std_qc_defer.

Oh, yes. Actually this patch was for older kernels where there =
inheritence was not there. As you mentioned, this patch is not required =
now.

Thanks,

Ashish




------_=_NextPart_001_01CA1119.5E8FEC8E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>Re: [PATCH][sata_fsl] Defer non-ncq =
commands when ncq commands active</TITLE>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.3562" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText21890 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>Hello, =
</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR><FONT size=3D2>&gt;&gt; Signed-off-by: Ashish Kalra =
&lt;Ashish.Kalra@freescale.com&gt;<BR>&gt;&gt; ---<BR>&gt;&gt; =
drivers/ata/sata_fsl.c | 1 +<BR>&gt;&gt; 1 files changed, 1 =
insertions(+), 0 deletions(-)<BR>&gt;&gt;<BR>&gt;&gt; diff --git =
a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c<BR>&gt;&gt; index =
5a88b44..a33f130 100644<BR>&gt;&gt; --- =
a/drivers/ata/sata_fsl.c<BR>&gt;&gt; +++ =
b/drivers/ata/sata_fsl.c<BR>&gt;&gt; @@ -1262,6 +1262,7 @@ static struct =
scsi_host_template sata_fsl_sht =3D {<BR>&gt;&gt; static struct =
ata_port_operations sata_fsl_ops =3D {<BR>&gt;&gt; .inherits =3D =
&amp;sata_pmp_port_ops,<BR>&gt;&gt;<BR>&gt;&gt; + .qc_defer =3D =
ata_std_qc_defer;<BR>&gt;&gt; .qc_prep =3D sata_fsl_qc_prep,<BR>&gt;&gt; =
.qc_issue =3D sata_fsl_qc_issue,<BR>&gt;&gt; .qc_fill_rtf =3D =
sata_fsl_qc_fill_rtf,<BR><BR>&gt; This doesn't look like it should =
change anything. sata_fsl_ops inherits<BR>&gt; from sata_pmp_port_ops, =
which inherits from sata_port_ops, which already<BR>&gt; sets qc_defer =
to ata_std_qc_defer.</FONT></DIV>=0A=
<P><FONT size=3D2>Oh, yes. Actually this patch was for older kernels =
where there inheritence was&nbsp;not there. As you mentioned, this patch =
is not required now.</FONT></P>=0A=
<P><FONT size=3D2>Thanks,</FONT></P>=0A=
<P><FONT size=3D2>Ashish</FONT></P>=0A=
<DIV dir=3Dltr><FONT size=3D2><BR></FONT></DIV></BODY></HTML>
------_=_NextPart_001_01CA1119.5E8FEC8E--
