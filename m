Return-Path: <vasbridge@sanblaze.com>
Received: from mail.gazungle.com (mail.gazungle.com [207.210.240.68])
	by ozlabs.org (Postfix) with ESMTP id 75827DDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 08:28:16 +1000 (EST)
From: "Vince Asbridge" <vasbridge@sanblaze.com>
To: <joachim.bader@diehl-aerospace.de>
Subject: RE: Antwort: RE: Migrating from 2.6.11 to 2.6.23 breaks pci-e 
Date: Mon, 21 Jul 2008 18:34:44 -0400
Message-ID: <021301c8eb81$f9c895c0$4b01a8c0@sanblaze.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0214_01C8EB60.72B6F5C0"
In-Reply-To: <OF1467D773.502FC20D-ONC125748D.00270EDF-C125748D.0027D110@diehl-gruppe.de>
Cc: 'Geary Sean-R60898' <sean.geary@freescale.com>,
	'Dave Maruska' <dmaruska@sanblaze.com>,
	'Mitul Patel' <mpatel@sanblaze.com>, "'Hynes,
	Stephen'" <Stephen.Hynes@lsi.com>, linuxppc-embedded@ozlabs.org,
	'Stephen Shirron' <sshirron@sanblaze.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0214_01C8EB60.72B6F5C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Joachim,
 
No, we are stable now once we fixed the bus numbering issue.
 
Vince


  _____  

From: joachim.bader@diehl-aerospace.de
[mailto:joachim.bader@diehl-aerospace.de] 
Sent: Monday, July 21, 2008 3:15 AM
To: vasbridge@sanblaze.com
Cc: 'Dave Maruska'; linuxppc-embedded@ozlabs.org; 'Mitul Patel'; 'Geary
Sean-R60898'; 'Stephen Shirron'; 'Hynes, Stephen'
Subject: Antwort: RE: Migrating from 2.6.11 to 2.6.23 breaks pci-e 



Hello Vince, 

we ran into the similar problem using U-boot version 1.1.4 and Linux kernel
2.6.23 on a Freescale MPC8641D platform. 
The kernel did not scan all buses and did not recognize the connected pci-e
bridges and devices. 

Your mail was very helpfull and due to the information you sent we disabled
CONFIG_PCI in U-boot and now the kernel was able to detect all connected
bridges and devices. But during allocation of the pci-e resources the kernel
runs in an address access violation. We will continue to investigate this
behavior. 

Do you have some more information? regarding behavior of newer kernels? 

Thank you 
Joachim Bader 
-- 
Dipl.-Ing. Joachim Bader
Research & Technology
Cockpit and Display Systems

Diehl Aerospace GmbH
An der Sandelmuehle 13
D-60439 Frankfurt
Phone +49-69-5805-1270
Fax       +49-69-5805-1400
e-mail:  joachim.bader@diehl-aerospace.de
http://www.diehl-aerospace.de 



"Vince Asbridge" <vasbridge@sanblaze.com> 
Gesendet von:
linuxppc-embedded-bounces+joachim.bader=diehl-aerospace.de@ozlabs.org 


02.07.2008 23:40 


An
<linuxppc-embedded@ozlabs.org>, "'Stephen Shirron'" <sshirron@sanblaze.com>,
"'Mitul Patel'" <mpatel@sanblaze.com>, "'Dave Maruska'"
<dmaruska@sanblaze.com>, "'Geary Sean-R60898'" <sean.geary@freescale.com>,
"'Hynes, Stephen'" <Stephen.Hynes@lsi.com> 

Kopie

Thema
RE: Migrating from 2.6.11 to 2.6.23 breaks pci-e with LSI 1068 SAS
chip (solved!)

	




Solved!

Problem summary.

LSI logic devices (1068e, 1064e, fc949e) do not work with uBoot version
1.3.0 and Linux kernel 2.6.23, where they work perfectly fine in kernel
2.6.11.

Symptom is that they do not show up at all to Linux once booted (lspci shows
nothing).

We obtained a pci-e analyzer and found the following:

uBoot V1.3.0 now scans the pci configuration, and when it does it assigns
bus numbers to the pci-e devices it finds.  These numbers that are assigned
are different from those that are assigned by Linux when the system boots.

It is legal to change pci-e bus numbers "on the fly" but doing so requires a
config write cycle to the pci-e device, because the pci-e spec states that
the device must register a new bus number if a config write cycle is issues
with the new bus number.

When we boot the Freescale machine with uBoot 1.3.0 and kernel 2.6.23, the
bus number under uBoot gets assigned to 1, and the bus number under Linux
gets assigned to 4.  Between the change of bus numbers we do not see a
config write go to the LSI device with the new bus number, and therefore it
continues to respond on bus 1 and ignore config reads to bus 4.

We temporarily fixed the issue by defining the CONFIG_PCI_NOSCAN flag under
uBoot, which causes the LSI device not to get assigned a bus number at
uBoot, and therefore when Linux begins doing config reads at bus 4 to the
LSI device registers the bus number and responds correctly.

We will do a bit more investigation to see if this has already been fixed in
a newer kernel, but for now not scanning at uBoot fixes the issue.

It's a bit of a mystery why the LSI devices behave differently from any
other pci-e device we put in the system, but they seem to be adhering to the
letter of the specification.

Vince Asbridge

------- original post -------

All,

I'm new to this mailing list, but have not had any luck finding information
on this issue.

Please be kind if I break the forum rules on my first post.

We recently tried to upgrade our Freescale CDS 8548 look-alike module (code
name ATCA1000) from the 2.6.11 based BSP to the 2.6.23 based BSP.

The upgrade went fairly smoothly, until we tried using SOME pci-e devices
(some work fine, some don't show up to lspci).

LSI pci-e controllers no longer show up at all!

We see the ixgbe (intel 10G), SiliconImage SATA controller but do not see
LSI devices (Specifically 1068 SAS, FC949-E fibrechannel).

We're guessing it's a resource issue behind the bridge, because the LSI
devices try to allocate 1 - 3M behind the bridge, but we can't find the bug,
or where we would debug such an issue.

The devices seem to "train" correctly, because we have an LED on the pci-e
switch (PLX 8 port pci-e switch), and it's ON indicating pci-e link between
the bridge and the 1068 device).

We're totally at a loss as to why this always worked on the 2.6.11 kernel
but doesn't work on 2.6.23.

Using lspci, the LSI adapters do not show up in the list at all, as though
they are not plugged into the system.

Is there something that needs to be done with respect to PCI-E devices that
is new in the 2.6.23 based BSP that did not need to be done in the 2.6.11
based kit?  For example, are pci resources allocated by a different piece of
code, that may have some issue allocating resources for the LSI adapters?

I currently do not have access to a pci-e analyzer.

Thanks for any help,
Vince Asbridge



_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded 



____________________________________________________________________________
___________________________________________
Der Inhalt dieser E-Mail ist fC
Informieren Sie uns bitte, wenn Sie diese E-Mail fC$lschlicherweise erhalten
haben (Fax: +49-69-5805-1399). Bitte lC6schen Sie in diesem Fall die
Nachricht. Jede Form der weiteren Benutzung ist untersagt.

The content of this e-mail is not legally binding upon the sender.
If this e-mail was transmitted to you by error, then please inform us
accordingly (Fax: +49-69-5805-1399). In such case you are requested to erase
the message. Any use of such e-mail message is strictly prohibited.




------=_NextPart_000_0214_01C8EB60.72B6F5C0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16674" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D451413322-21072008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Joachim,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D451413322-21072008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D451413322-21072008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>No, we are stable now once we fixed the bus =
numbering=20
issue.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D451413322-21072008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D451413322-21072008><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Vince</FONT></SPAN></DIV><BR>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B> =
joachim.bader@diehl-aerospace.de=20
  [mailto:joachim.bader@diehl-aerospace.de] <BR><B>Sent:</B> Monday, =
July 21,=20
  2008 3:15 AM<BR><B>To:</B> vasbridge@sanblaze.com<BR><B>Cc:</B> 'Dave=20
  Maruska'; linuxppc-embedded@ozlabs.org; 'Mitul Patel'; 'Geary =
Sean-R60898';=20
  'Stephen Shirron'; 'Hynes, Stephen'<BR><B>Subject:</B> Antwort: RE: =
Migrating=20
  from 2.6.11 to 2.6.23 breaks pci-e <BR></FONT><BR></DIV>
  <DIV></DIV><BR><FONT face=3Dsans-serif size=3D2>Hello Vince,</FONT> =
<BR><BR><FONT=20
  face=3Dsans-serif size=3D2>we ran into the similar problem using =
U-boot version=20
  1.1.4 and Linux kernel 2.6.23 on a Freescale MPC8641D platform.</FONT> =

  <BR><FONT face=3Dsans-serif size=3D2>The kernel did not scan all buses =
and did not=20
  recognize the connected pci-e bridges and devices.</FONT> =
<BR><BR><FONT=20
  face=3Dsans-serif size=3D2>Your mail was very helpfull and due to the =
information=20
  you sent we disabled CONFIG_PCI in U-boot and now the kernel was able =
to=20
  detect all connected bridges and devices. But during allocation of the =
pci-e=20
  resources the kernel runs in an address access violation. We will =
continue to=20
  investigate this behavior.</FONT> <BR><BR><FONT face=3Dsans-serif =
size=3D2>Do you=20
  have some more information? regarding behavior of newer =
kernels?</FONT>=20
  <BR><BR><FONT face=3Dsans-serif size=3D2>Thank you</FONT> <BR><FONT=20
  face=3Dsans-serif size=3D2>Joachim Bader</FONT> <BR><FONT =
face=3Dsans-serif=20
  size=3D2>-- <BR>Dipl.-Ing. Joachim Bader<BR>Research &amp; =
Technology<BR>Cockpit=20
  and Display Systems<BR><BR>Diehl Aerospace GmbH<BR>An der Sandelmuehle =

  13<BR>D-60439 Frankfurt<BR>Phone +49-69-5805-1270<BR>Fax &nbsp; &nbsp; =
&nbsp;=20
  +49-69-5805-1400<BR>e-mail:=20
  =
&nbsp;joachim.bader@diehl-aerospace.de<BR>http://www.diehl-aerospace.de</=
FONT>=20
  <BR><BR><BR>
  <TABLE width=3D"100%">
    <TBODY>
    <TR vAlign=3Dtop>
      <TD width=3D"40%"><FONT face=3Dsans-serif size=3D1><B>"Vince =
Asbridge"=20
        &lt;vasbridge@sanblaze.com&gt;</B> </FONT><BR><FONT =
face=3Dsans-serif=20
        size=3D1>Gesendet von:=20
        =
linuxppc-embedded-bounces+joachim.bader=3Ddiehl-aerospace.de@ozlabs.org</=
FONT>=20

        <P><FONT face=3Dsans-serif size=3D1>02.07.2008 23:40</FONT> </P>
      <TD width=3D"59%">
        <TABLE width=3D"100%">
          <TBODY>
          <TR vAlign=3Dtop>
            <TD>
              <DIV align=3Dright><FONT face=3Dsans-serif =
size=3D1>An</FONT></DIV>
            <TD><FONT face=3Dsans-serif=20
              size=3D1>&lt;linuxppc-embedded@ozlabs.org&gt;, "'Stephen =
Shirron'"=20
              &lt;sshirron@sanblaze.com&gt;, "'Mitul Patel'"=20
              &lt;mpatel@sanblaze.com&gt;, "'Dave Maruska'"=20
              &lt;dmaruska@sanblaze.com&gt;, "'Geary Sean-R60898'"=20
              &lt;sean.geary@freescale.com&gt;, "'Hynes, Stephen'"=20
              &lt;Stephen.Hynes@lsi.com&gt;</FONT>=20
          <TR vAlign=3Dtop>
            <TD>
              <DIV align=3Dright><FONT face=3Dsans-serif =
size=3D1>Kopie</FONT></DIV>
            <TD>
          <TR vAlign=3Dtop>
            <TD>
              <DIV align=3Dright><FONT face=3Dsans-serif =
size=3D1>Thema</FONT></DIV>
            <TD><FONT face=3Dsans-serif size=3D1>RE: Migrating from =
2.6.11 to=20
              2.6.23 breaks pci-e with LSI 1068 SAS &nbsp; &nbsp; &nbsp; =

              &nbsp;chip (solved!)</FONT></TR></TBODY></TABLE><BR>
        <TABLE>
          <TBODY>
          <TR vAlign=3Dtop>
            <TD>
            =
<TD></TR></TBODY></TABLE><BR></TR></TBODY></TABLE><BR><BR><BR><FONT=20
  size=3D2><TT>Solved!<BR><BR>Problem summary.<BR><BR>LSI logic devices =
(1068e,=20
  1064e, fc949e) do not work with uBoot version<BR>1.3.0 and Linux =
kernel=20
  2.6.23, where they work perfectly fine in =
kernel<BR>2.6.11.<BR><BR>Symptom is=20
  that they do not show up at all to Linux once booted (lspci=20
  shows<BR>nothing).<BR><BR>We obtained a pci-e analyzer and found the=20
  following:<BR><BR>uBoot V1.3.0 now scans the pci configuration, and =
when it=20
  does it assigns<BR>bus numbers to the pci-e devices it finds. =
&nbsp;These=20
  numbers that are assigned<BR>are different from those that are =
assigned by=20
  Linux when the system boots.<BR><BR>It is legal to change pci-e bus =
numbers=20
  "on the fly" but doing so requires a<BR>config write cycle to the =
pci-e=20
  device, because the pci-e spec states that<BR>the device must register =
a new=20
  bus number if a config write cycle is issues<BR>with the new bus=20
  number.<BR><BR>When we boot the Freescale machine with uBoot 1.3.0 and =
kernel=20
  2.6.23, the<BR>bus number under uBoot gets assigned to 1, and the bus =
number=20
  under Linux<BR>gets assigned to 4. &nbsp;Between the change of bus =
numbers we=20
  do not see a<BR>config write go to the LSI device with the new bus =
number, and=20
  therefore it<BR>continues to respond on bus 1 and ignore config reads =
to bus=20
  4.<BR><BR>We temporarily fixed the issue by defining the =
CONFIG_PCI_NOSCAN=20
  flag under<BR>uBoot, which causes the LSI device not to get assigned a =
bus=20
  number at<BR>uBoot, and therefore when Linux begins doing config reads =
at bus=20
  4 to the<BR>LSI device registers the bus number and responds=20
  correctly.<BR><BR>We will do a bit more investigation to see if this =
has=20
  already been fixed in<BR>a newer kernel, but for now not scanning at =
uBoot=20
  fixes the issue.<BR><BR>It's a bit of a mystery why the LSI devices =
behave=20
  differently from any<BR>other pci-e device we put in the system, but =
they seem=20
  to be adhering to the<BR>letter of the specification.<BR><BR>Vince=20
  Asbridge<BR><BR>------- original post -------<BR><BR>All,<BR><BR>I'm =
new to=20
  this mailing list, but have not had any luck finding information<BR>on =
this=20
  issue.<BR><BR>Please be kind if I break the forum rules on my first=20
  post.<BR><BR>We recently tried to upgrade our Freescale CDS 8548 =
look-alike=20
  module (code<BR>name ATCA1000) from the 2.6.11 based BSP to the 2.6.23 =
based=20
  BSP.<BR><BR>The upgrade went fairly smoothly, until we tried using =
SOME pci-e=20
  devices<BR>(some work fine, some don't show up to lspci).<BR><BR>LSI =
pci-e=20
  controllers no longer show up at all!<BR><BR>We see the ixgbe (intel =
10G),=20
  SiliconImage SATA controller but do not see<BR>LSI devices =
(Specifically 1068=20
  SAS, FC949-E fibrechannel).<BR><BR>We're guessing it's a resource =
issue behind=20
  the bridge, because the LSI<BR>devices try to allocate 1 - 3M behind =
the=20
  bridge, but we can't find the bug,<BR>or where we would debug such an=20
  issue.<BR><BR>The devices seem to "train" correctly, because we have =
an LED on=20
  the pci-e<BR>switch (PLX 8 port pci-e switch), and it's ON indicating =
pci-e=20
  link between<BR>the bridge and the 1068 device).<BR><BR>We're totally =
at a=20
  loss as to why this always worked on the 2.6.11 kernel<BR>but doesn't =
work on=20
  2.6.23.<BR><BR>Using lspci, the LSI adapters do not show up in the =
list at=20
  all, as though<BR>they are not plugged into the system.<BR><BR>Is =
there=20
  something that needs to be done with respect to PCI-E devices =
that<BR>is new=20
  in the 2.6.23 based BSP that did not need to be done in the =
2.6.11<BR>based=20
  kit? &nbsp;For example, are pci resources allocated by a different =
piece=20
  of<BR>code, that may have some issue allocating resources for the LSI=20
  adapters?<BR><BR>I currently do not have access to a pci-e=20
  analyzer.<BR><BR>Thanks for any help,<BR>Vince=20
  =
Asbridge<BR><BR><BR><BR>_______________________________________________<B=
R>Linuxppc-embedded=20
  mailing=20
  =
list<BR>Linuxppc-embedded@ozlabs.org<BR>https://ozlabs.org/mailman/listin=
fo/linuxppc-embedded</TT></FONT>=20
  <BR><BR><BR><BR><SPAN=20
  style=3D"FONT-SIZE: 10pt; COLOR: #000000; FONT-FAMILY: =
sans-serif,helvetica">___________________________________________________=
____________________________________________________________________</SPA=
N><BR><SPAN=20
  style=3D"FONT-SIZE: 10pt; COLOR: #000000; FONT-FAMILY: =
sans-serif,helvetica">Der=20
  Inhalt dieser E-Mail ist fC<R span < verbindlich. nicht rechtlich =
Absender=20
  den><BR><SPAN=20
  style=3D"FONT-SIZE: 10pt; COLOR: #000000; FONT-FAMILY: =
sans-serif,helvetica">Informieren=20
  Sie uns bitte, wenn Sie diese E-Mail fC$lschlicherweise erhalten haben =
(Fax:=20
  +49-69-5805-1399). Bitte lC6schen Sie in diesem Fall die Nachricht. =
Jede Form=20
  der weiteren Benutzung ist untersagt.</SPAN><BR><BR><SPAN=20
  style=3D"FONT-SIZE: 10pt; COLOR: #000000; FONT-FAMILY: =
sans-serif,helvetica">The=20
  content of this e-mail is not legally binding upon the =
sender.</SPAN><BR><SPAN=20
  style=3D"FONT-SIZE: 10pt; COLOR: #000000; FONT-FAMILY: =
sans-serif,helvetica">If=20
  this e-mail was transmitted to you by error, then please inform us =
accordingly=20
  (Fax: +49-69-5805-1399). In such case you are requested to erase the =
message.=20
  Any use of such e-mail message is strictly=20
prohibited.</SPAN><BR><BR></BLOCKQUOTE></SPAN></BODY></HTML>

------=_NextPart_000_0214_01C8EB60.72B6F5C0--
