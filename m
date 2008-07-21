Return-Path: <joachim.bader@diehl-aerospace.de>
Received: from mail02.diehl.de (mail02.diehl.de [193.201.236.151])
	by ozlabs.org (Postfix) with ESMTP id A2E94DDECA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jul 2008 17:27:25 +1000 (EST)
In-Reply-To: <037e01c8dc8c$3147a450$4b01a8c0@sanblaze.com>
To: vasbridge@sanblaze.com
Subject: Antwort: RE: Migrating from 2.6.11 to 2.6.23 breaks pci-e 
MIME-Version: 1.0
From: joachim.bader@diehl-aerospace.de
Message-ID: <OF1467D773.502FC20D-ONC125748D.00270EDF-C125748D.0027D110@diehl-gruppe.de>
Date: Mon, 21 Jul 2008 09:14:34 +0200
Content-Type: multipart/mixed; boundary="=_mixed 0027D10BC125748D_="
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

--=_mixed 0027D10BC125748D_=
Content-Type: multipart/alternative; boundary="=_alternative 0027D10DC125748D_="


--=_alternative 0027D10DC125748D_=
Content-Type: text/plain; charset="utf-8"
content-transfer-encoding: quoted-printable

Hello Vince,

we ran into the similar problem using U-boot version 1.1.4 and Linux=20
kernel 2.6.23 on a Freescale MPC8641D platform.
The kernel did not scan all buses and did not recognize the connected=20
pci-e bridges and devices.

Your mail was very helpfull and due to the information you sent we=20
disabled CONFIG_PCI in U-boot and now the kernel was able to detect all=20
connected bridges and devices. But during allocation of the pci-e=20
resources the kernel runs in an address access violation. We will continue=
=20
to investigate this behavior.

Do you have some more information? regarding behavior of newer kernels?

Thank you
Joachim Bader
--=20
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



"Vince Asbridge" <vasbridge@sanblaze.com>=20
Gesendet von:=20
linuxppc-embedded-bounces+joachim.bader=3Ddiehl-aerospace.de@ozlabs.org
02.07.2008 23:40

An
<linuxppc-embedded@ozlabs.org>, "'Stephen Shirron'"=20
<sshirron@sanblaze.com>, "'Mitul Patel'" <mpatel@sanblaze.com>, "'Dave=20
Maruska'" <dmaruska@sanblaze.com>, "'Geary Sean-R60898'"=20
<sean.geary@freescale.com>, "'Hynes, Stephen'" <Stephen.Hynes@lsi.com>
Kopie

Thema
RE: Migrating from 2.6.11 to 2.6.23 breaks pci-e with LSI 1068 SAS chip=20
(solved!)






Solved!

Problem summary.

LSI logic devices (1068e, 1064e, fc949e) do not work with uBoot version
1.3.0 and Linux kernel 2.6.23, where they work perfectly fine in kernel
2.6.11.

Symptom is that they do not show up at all to Linux once booted (lspci=20
shows
nothing).

We obtained a pci-e analyzer and found the following:

uBoot V1.3.0 now scans the pci configuration, and when it does it assigns
bus numbers to the pci-e devices it finds.  These numbers that are=20
assigned
are different from those that are assigned by Linux when the system boots.

It is legal to change pci-e bus numbers "on the fly" but doing so requires=
=20
a
config write cycle to the pci-e device, because the pci-e spec states that
the device must register a new bus number if a config write cycle is=20
issues
with the new bus number.

When we boot the Freescale machine with uBoot 1.3.0 and kernel 2.6.23, the
bus number under uBoot gets assigned to 1, and the bus number under Linux
gets assigned to 4.  Between the change of bus numbers we do not see a
config write go to the LSI device with the new bus number, and therefore=20
it
continues to respond on bus 1 and ignore config reads to bus 4.

We temporarily fixed the issue by defining the CONFIG_PCI_NOSCAN flag=20
under
uBoot, which causes the LSI device not to get assigned a bus number at
uBoot, and therefore when Linux begins doing config reads at bus 4 to the
LSI device registers the bus number and responds correctly.

We will do a bit more investigation to see if this has already been fixed=20
in
a newer kernel, but for now not scanning at uBoot fixes the issue.

It's a bit of a mystery why the LSI devices behave differently from any
other pci-e device we put in the system, but they seem to be adhering to=20
the
letter of the specification.

Vince Asbridge

------- original post -------

All,

I'm new to this mailing list, but have not had any luck finding=20
information
on this issue.

Please be kind if I break the forum rules on my first post.

We recently tried to upgrade our Freescale CDS 8548 look-alike module=20
(code
name ATCA1000) from the 2.6.11 based BSP to the 2.6.23 based BSP.

The upgrade went fairly smoothly, until we tried using SOME pci-e devices
(some work fine, some don't show up to lspci).

LSI pci-e controllers no longer show up at all!

We see the ixgbe (intel 10G), SiliconImage SATA controller but do not see
LSI devices (Specifically 1068 SAS, FC949-E fibrechannel).

We're guessing it's a resource issue behind the bridge, because the LSI
devices try to allocate 1 - 3M behind the bridge, but we can't find the=20
bug,
or where we would debug such an issue.

The devices seem to "train" correctly, because we have an LED on the pci-e
switch (PLX 8 port pci-e switch), and it's ON indicating pci-e link=20
between
the bridge and the 1068 device).

We're totally at a loss as to why this always worked on the 2.6.11 kernel
but doesn't work on 2.6.23.

Using lspci, the LSI adapters do not show up in the list at all, as though
they are not plugged into the system.

Is there something that needs to be done with respect to PCI-E devices=20
that
is new in the 2.6.23 based BSP that did not need to be done in the 2.6.11
based kit?  For example, are pci resources allocated by a different piece=20
of
code, that may have some issue allocating resources for the LSI adapters?

I currently do not have access to a pci-e analyzer.

Thanks for any help,
Vince Asbridge



_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded




___________________________________________________________________________=
____________________________________________
Der Inhalt dieser E-Mail ist f=C3=BCr den Absender rechtlich nicht verbindl=
ich.=20
Informieren Sie uns bitte, wenn Sie diese E-Mail f=C3=A4lschlicherweise erh=
alten haben (Fax: +49-69-5805-1399). Bitte l=C3=B6schen Sie in diesem Fall =
die Nachricht. Jede Form der weiteren Benutzung ist untersagt.

The content of this e-mail is not legally binding upon the sender.
If this e-mail was transmitted to you by error, then please inform us accor=
dingly (Fax: +49-69-5805-1399). In such case you are requested to erase the=
 message. Any use of such e-mail message is strictly prohibited.

--=_alternative 0027D10DC125748D_=
Content-Type: text/html; charset="utf-8"
content-transfer-encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hello Vince,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">we ran into the similar problem using
U-boot version 1.1.4 and Linux kernel 2.6.23 on a Freescale MPC8641D platfo=
rm.</font>
<br><font size=3D2 face=3D"sans-serif">The kernel did not scan all buses and
did not recognize the connected pci-e bridges and devices.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Your mail was very helpfull and due
to the information you sent we disabled CONFIG_PCI in U-boot and now the
kernel was able to detect all connected bridges and devices. But during
allocation of the pci-e resources the kernel runs in an address access
violation. We will continue to investigate this behavior.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Do you have some more information? r=
egarding
behavior of newer kernels?</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Thank you</font>
<br><font size=3D2 face=3D"sans-serif">Joachim Bader</font>
<br><font size=3D2 face=3D"sans-serif">-- <br>
Dipl.-Ing. Joachim Bader<br>
Research &amp; Technology<br>
Cockpit and Display Systems<br>
<br>
Diehl Aerospace GmbH<br>
An der Sandelmuehle 13<br>
D-60439 Frankfurt<br>
Phone +49-69-5805-1270<br>
Fax &nbsp; &nbsp; &nbsp; +49-69-5805-1400<br>
e-mail: &nbsp;joachim.bader@diehl-aerospace.de<br>
http://www.diehl-aerospace.de</font>
<br>
<br>
<br>
<table width=3D100%>
<tr valign=3Dtop>
<td width=3D40%><font size=3D1 face=3D"sans-serif"><b>&quot;Vince Asbridge&=
quot;
&lt;vasbridge@sanblaze.com&gt;</b> </font>
<br><font size=3D1 face=3D"sans-serif">Gesendet von: linuxppc-embedded-boun=
ces+joachim.bader=3Ddiehl-aerospace.de@ozlabs.org</font>
<p><font size=3D1 face=3D"sans-serif">02.07.2008 23:40</font>
<td width=3D59%>
<table width=3D100%>
<tr valign=3Dtop>
<td>
<div align=3Dright><font size=3D1 face=3D"sans-serif">An</font></div>
<td><font size=3D1 face=3D"sans-serif">&lt;linuxppc-embedded@ozlabs.org&gt;,
&quot;'Stephen Shirron'&quot; &lt;sshirron@sanblaze.com&gt;, &quot;'Mitul
Patel'&quot; &lt;mpatel@sanblaze.com&gt;, &quot;'Dave Maruska'&quot; &lt;dm=
aruska@sanblaze.com&gt;,
&quot;'Geary Sean-R60898'&quot; &lt;sean.geary@freescale.com&gt;, &quot;'Hy=
nes,
Stephen'&quot; &lt;Stephen.Hynes@lsi.com&gt;</font>
<tr valign=3Dtop>
<td>
<div align=3Dright><font size=3D1 face=3D"sans-serif">Kopie</font></div>
<td>
<tr valign=3Dtop>
<td>
<div align=3Dright><font size=3D1 face=3D"sans-serif">Thema</font></div>
<td><font size=3D1 face=3D"sans-serif">RE: Migrating from 2.6.11 to 2.6.23
breaks pci-e with LSI 1068 SAS &nbsp; &nbsp; &nbsp; &nbsp;chip
(solved!)</font></table>
<br>
<table>
<tr valign=3Dtop>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=3D2><tt>Solved!<br>
<br>
Problem summary.<br>
<br>
LSI logic devices (1068e, 1064e, fc949e) do not work with uBoot version<br>
1.3.0 and Linux kernel 2.6.23, where they work perfectly fine in kernel<br>
2.6.11.<br>
<br>
Symptom is that they do not show up at all to Linux once booted (lspci
shows<br>
nothing).<br>
<br>
We obtained a pci-e analyzer and found the following:<br>
<br>
uBoot V1.3.0 now scans the pci configuration, and when it does it assigns<b=
r>
bus numbers to the pci-e devices it finds. &nbsp;These numbers that are
assigned<br>
are different from those that are assigned by Linux when the system boots.<=
br>
<br>
It is legal to change pci-e bus numbers &quot;on the fly&quot; but doing
so requires a<br>
config write cycle to the pci-e device, because the pci-e spec states that<=
br>
the device must register a new bus number if a config write cycle is issues=
<br>
with the new bus number.<br>
<br>
When we boot the Freescale machine with uBoot 1.3.0 and kernel 2.6.23,
the<br>
bus number under uBoot gets assigned to 1, and the bus number under Linux<b=
r>
gets assigned to 4. &nbsp;Between the change of bus numbers we do not see
a<br>
config write go to the LSI device with the new bus number, and therefore
it<br>
continues to respond on bus 1 and ignore config reads to bus 4.<br>
<br>
We temporarily fixed the issue by defining the CONFIG_PCI_NOSCAN flag under=
<br>
uBoot, which causes the LSI device not to get assigned a bus number at<br>
uBoot, and therefore when Linux begins doing config reads at bus 4 to the<b=
r>
LSI device registers the bus number and responds correctly.<br>
<br>
We will do a bit more investigation to see if this has already been fixed
in<br>
a newer kernel, but for now not scanning at uBoot fixes the issue.<br>
<br>
It's a bit of a mystery why the LSI devices behave differently from any<br>
other pci-e device we put in the system, but they seem to be adhering to
the<br>
letter of the specification.<br>
<br>
Vince Asbridge<br>
<br>
------- original post -------<br>
<br>
All,<br>
<br>
I'm new to this mailing list, but have not had any luck finding information=
<br>
on this issue.<br>
<br>
Please be kind if I break the forum rules on my first post.<br>
<br>
We recently tried to upgrade our Freescale CDS 8548 look-alike module (code=
<br>
name ATCA1000) from the 2.6.11 based BSP to the 2.6.23 based BSP.<br>
<br>
The upgrade went fairly smoothly, until we tried using SOME pci-e devices<b=
r>
(some work fine, some don't show up to lspci).<br>
<br>
LSI pci-e controllers no longer show up at all!<br>
<br>
We see the ixgbe (intel 10G), SiliconImage SATA controller but do not see<b=
r>
LSI devices (Specifically 1068 SAS, FC949-E fibrechannel).<br>
<br>
We're guessing it's a resource issue behind the bridge, because the LSI<br>
devices try to allocate 1 - 3M behind the bridge, but we can't find the
bug,<br>
or where we would debug such an issue.<br>
<br>
The devices seem to &quot;train&quot; correctly, because we have an LED
on the pci-e<br>
switch (PLX 8 port pci-e switch), and it's ON indicating pci-e link between=
<br>
the bridge and the 1068 device).<br>
<br>
We're totally at a loss as to why this always worked on the 2.6.11 kernel<b=
r>
but doesn't work on 2.6.23.<br>
<br>
Using lspci, the LSI adapters do not show up in the list at all, as though<=
br>
they are not plugged into the system.<br>
<br>
Is there something that needs to be done with respect to PCI-E devices
that<br>
is new in the 2.6.23 based BSP that did not need to be done in the 2.6.11<b=
r>
based kit? &nbsp;For example, are pci resources allocated by a different
piece of<br>
code, that may have some issue allocating resources for the LSI adapters?<b=
r>
<br>
I currently do not have access to a pci-e analyzer.<br>
<br>
Thanks for any help,<br>
Vince Asbridge<br>
<br>
<br>
<br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
Linuxppc-embedded@ozlabs.org<br>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</tt></font>
<br>
<br>
<br>
<br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">______________________________________________________________________=
_________________________________________________</span><br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">Der Inhalt dieser E-Mail ist f=C3=BCr den Absender rechtlich nicht ver=
bindlich. </span><br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">Informieren Sie uns bitte, wenn Sie diese E-Mail f=C3=A4lschlicherweis=
e erhalten haben (Fax: +49-69-5805-1399). Bitte l=C3=B6schen Sie in diesem =
Fall die Nachricht. Jede Form der weiteren Benutzung ist untersagt.</span><=
br>
<br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">The content of this e-mail is not legally binding upon the sender.</sp=
an><br>
<span style=3D"font-family:sans-serif,helvetica; font-size:10pt; color:#000=
000">If this e-mail was transmitted to you by error, then please inform us =
accordingly (Fax: +49-69-5805-1399). In such case you are requested to eras=
e the message. Any use of such e-mail message is strictly prohibited.</span=
><br>
<br>
--=_alternative 0027D10DC125748D_=--

--=_mixed 0027D10BC125748D_=
Content-Type: application/octet-stream; name="winmail.dat"
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64

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

--=_mixed 0027D10BC125748D_=--
