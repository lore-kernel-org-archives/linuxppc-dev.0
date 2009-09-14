Return-Path: <ludo.vanput@gmail.com>
Received: from mail-fx0-f219.google.com (mail-fx0-f219.google.com
	[209.85.220.219])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 2D227B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 22:36:18 +1000 (EST)
Received: by fxm19 with SMTP id 19so2253950fxm.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 05:36:15 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 14 Sep 2009 14:36:15 +0200
Message-ID: <5edaeed70909140536s53fb36ael4f0cb90abfe327e0@mail.gmail.com>
Subject: Oops in IDE probing on ppc_440 when PCI is enabled in strapping
From: Ludo Van Put <ludo.vanput@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001485f78b3669a7c0047388e9cb
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001485f78b3669a7c0047388e9cb
Content-Type: text/plain; charset=ISO-8859-1

Hi,

we're working with a PPC440GX on a board that has a.o. a compact flash slot.
We had the PCI subsystem of the ppc disabled in strapping for quite a while,
until we wanted to start using it.
However, when we enabled PCI in the strapping and in the (patched 2.6.10)
kernel configuration, we triggered an oops when probing for IDE devices (to
read out the first 512 bytes of the CF). I can see that the ioremap64 call
in the driver code for our CF returns a different address (compared to PCI
disabled in strapping), but using this address later on for accessing the CF
goes wrong.

Does someone has an idea why this might go wrong? Can I end up with
overlapping address ranges due to the PCI subsystem being enabled? Is this
easy to check? As far as I know, the HW address of the PCI controller is in
a non-overlapping range with the addresses we have setup in the EBC
registers to probe for the CF (u-boot can see the IDE device just fine and
it also has PCI turned on).

TIA, Ludo

--001485f78b3669a7c0047388e9cb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>we&#39;re working with a PPC440GX on a board that has a.o. a com=
pact flash slot. We had the PCI subsystem of the ppc disabled in strapping =
for quite a while, until we wanted to start using it.<br>However, when we e=
nabled PCI in the strapping and in the (patched 2.6.10) kernel configuratio=
n, we triggered an oops when probing for IDE devices (to read out the first=
 512 bytes of the CF). I can see that the ioremap64 call in the driver code=
 for our CF returns a different address (compared to PCI disabled in strapp=
ing), but using this address later on for accessing the CF goes wrong.<br>
<br>Does someone has an idea why this might go wrong? Can I end up with ove=
rlapping address ranges due to the PCI subsystem being enabled? Is this eas=
y to check? As far as I know, the HW address of the PCI controller is in a =
non-overlapping range with the addresses we have setup in the EBC registers=
 to probe for the CF (u-boot can see the IDE device just fine and it also h=
as PCI turned on).<br>
<br>TIA, Ludo<br><br><br>

--001485f78b3669a7c0047388e9cb--
