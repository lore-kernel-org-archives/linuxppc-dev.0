Return-Path: <schindele@nentec.de>
Received: from dmz-mail.nentec.de (gate.nentec.de [213.218.23.37])
 by lists.ozlabs.org (Postfix) with SMTP id 3w1tk30sPpzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 01:03:53 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.nentec.de (Postfix) with ESMTP id BEE3317E0DC2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:44:05 +0200 (CEST)
Received: from zimbra.nentec.de ([127.0.0.1])
 by localhost (zimbra.nentec.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LxcvB7L_7o0k for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 10 Apr 2017 16:44:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.nentec.de (Postfix) with ESMTP id A47AC17E0EF8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:44:05 +0200 (CEST)
Received: from zimbra.nentec.de ([127.0.0.1])
 by localhost (zimbra.nentec.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id n27iB4d4MppH for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 10 Apr 2017 16:44:05 +0200 (CEST)
Received: from sherry.localnet (sherry.nentec.de [153.92.64.8])
 by zimbra.nentec.de (Postfix) with ESMTPS id 8EE2017E0DC2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:44:05 +0200 (CEST)
From: Juergen Schindele <schindele@nentec.de>
To: linuxppc-dev@lists.ozlabs.org
Reply-To: schindele@nentec.de
Subject: Freescale mpc8315 IRQ0 setup
Date: Mon, 10 Apr 2017 16:53:18 +0200
Message-ID: <2666241.ms6yMRjznt@sherry>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="nextPart5740079.IIbRtX7q1Z"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--nextPart5740079.IIbRtX7q1Z
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dear mailing list,
i found out on our platform with freescale mpc8315 SOC that in
linux kernel code the setup of IRQ0 which we use is not correct.
One should be able to use falling EDGE interrupt capabilities like on
IRQ1-IRQ7. These setups are fixed in "arch/powerpc/sysdev/ipic.c"
The internal interrupt number of IRQ0 is not like IRQ1-IRQ7 in one bloc=
k
but on number 48. To verify details please consult MPC8315ERM.pdf
developpers manual.

To correct these "EDGE" capabilities of IRQ0 i suggest the following=20=

patch:
please consider integrating it to your patches.

--- arch/powerpc/sysdev/ipic.c  (Revision correct)
+++ arch/powerpc/sysdev/ipic.c  (Arbeitskopie)
@@ -316,6 +316,7 @@
                .prio_mask =3D 7,
        },
        [48] =3D {
+               .ack    =3D IPIC_SEPNR,
                .mask   =3D IPIC_SEMSR,
                .prio   =3D IPIC_SMPRR_A,
                .force  =3D IPIC_SEFCR,

Thank you for your attention
--=20
i. A.
J=FCrgen Schindele
Softwareentwicklung

PSI Nentec GmbH
Greschbachstra=DFe 12
76229 Karlsruhe
Deutschland
Telefon: +49 721 94249-51
Telefax: +49 721 94249-10
schindele@nentec.de
www.nentec.de

Gesch=E4ftsf=FChrung: Klaus Becker, Wolfgang Fischer
Sitz der Gesellschaft: Karlsruhe
Handelsregister: Amtsgericht Mannheim HRB 107658

Diese E-Mail enth=E4lt vertrauliche oder rechtlich gesch=FCtzte=20
Informationen. Wenn Sie nicht der vorgesehene Empf=E4nger sind,=20
informieren Sie bitte sofort den Absender und l=F6schen Sie diese E-Mai=
l.=20
Das unbefugte Kopieren dieser E-Mail oder die unbefugte Weitergabe=20
der enthaltenen Informationen ist nicht gestattet.

The information contained in this message is confidential or protected=20=

by law. If you are not the intended recipient, please contact the sende=
r=20
and delete this message. Any unauthorised copying of this message or=20=

unauthorised distribution of the information contained herein is=20
prohibited.=20

--nextPart5740079.IIbRtX7q1Z
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/=
REC-html40/strict.dtd">
<html><head><meta name=3D"qrichtext" content=3D"1" /><style type=3D"tex=
t/css">
p, li { white-space: pre-wrap; }
</style></head><body style=3D" font-family:'Sans Serif'; font-size:9pt;=
 font-weight:400; font-style:normal;">
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Dea=
r mailing list,</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">i found out on our pl=
atform with freescale mpc8315 SOC that in</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">linux kernel code the=
 setup of IRQ0 which we use is not correct.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">One should be able to=
 use falling EDGE interrupt capabilities like on</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">IRQ1-IRQ7. These setu=
ps are fixed in &quot;arch/powerpc/sysdev/ipic.c&quot;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">The internal interrup=
t number of IRQ0 is not like IRQ1-IRQ7 in one block</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">but on number 48. To =
verify details please consult MPC8315ERM.pdf</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">developpers manual.</=
p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px=
; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0p=
x; ">&nbsp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">To correct these &quo=
t;EDGE&quot; capabilities of IRQ0 i suggest the following patch:</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">please consider integ=
rating it to your patches.</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px=
; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0p=
x; ">&nbsp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">--- arch/powerpc/sysd=
ev/ipic.c  (Revision correct)</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">+++ arch/powerpc/sysd=
ev/ipic.c  (Arbeitskopie)</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">@@ -316,6 +316,7 @@</=
p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">                .prio=
_mask =3D 7,</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">        },</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">        [48] =3D {</p=
>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">+               .ack =
   =3D IPIC_SEPNR,</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">                .mask=
   =3D IPIC_SEMSR,</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">                .prio=
   =3D IPIC_SMPRR_A,</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;">                .forc=
e  =3D IPIC_SEFCR,</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px=
; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0p=
x; ">&nbsp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=3D" font-=
size:12px; color:#181615; background-color:#ffffff;">Thank you for your=
 attention</span></p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">-- =
</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">i. =
A.</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">J=FC=
rgen Schindele</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Sof=
twareentwicklung</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px=
; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0p=
x; ">&nbsp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">PSI=
 Nentec GmbH</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Gre=
schbachstra=DFe 12</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">762=
29 Karlsruhe</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Deu=
tschland</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Tel=
efon: +49 721 94249-51</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Tel=
efax: +49 721 94249-10</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">sch=
indele@nentec.de</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">www=
.nentec.de</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px=
; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0p=
x; ">&nbsp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Ges=
ch=E4ftsf=FChrung: Klaus Becker, Wolfgang Fischer</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Sit=
z der Gesellschaft: Karlsruhe</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Han=
delsregister: Amtsgericht Mannheim HRB 107658</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px=
; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0p=
x; ">&nbsp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Die=
se E-Mail enth=E4lt vertrauliche oder rechtlich gesch=FCtzte Informatio=
nen. Wenn Sie nicht der vorgesehene Empf=E4nger sind, informieren Sie b=
itte sofort den Absender und l=F6schen Sie diese E-Mail. Das unbefugte =
Kopieren dieser E-Mail oder die unbefugte Weitergabe der enthaltenen In=
formationen ist nicht gestattet.</p>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px=
; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0p=
x; ">&nbsp;</p>
<p style=3D" margin-top:0px; margin-bottom:0px; margin-left:0px; margin=
-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">The=
 information contained in this message is confidential or protected by =
law. If you are not the intended recipient, please contact the sender a=
nd delete this message. Any unauthorised copying of this message or una=
uthorised distribution of the information contained herein is prohibite=
d. </p></body></html>
--nextPart5740079.IIbRtX7q1Z--
