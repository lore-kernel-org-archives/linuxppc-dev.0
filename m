Return-Path: <a.llano@usyscom.com>
Received: from correo.ziv.es (eu31-237.clientes.euskaltel.es [212.55.31.237])
	by ozlabs.org (Postfix) with ESMTP id 496AB68480
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Oct 2005 17:42:52 +1000 (EST)
From: "Asier Llano Palacios" <a.llano@usyscom.com>
To: "Andrew Dennison" <andrewd.lists@gmail.com>
In-Reply-To: <54823def0510040011m3e2ecfe6yae0d07187d5baeee@mail.gmail.com>
References: <81A66F72DCACD511B0600002A551BFCB08D9613C@kuumex05.barco.com>
	<54823def0510032131mee19acft6250ed99ce55ef21@mail.gmail.com>
	<43421F87.2070501@246tNt.com>
	<54823def0510040011m3e2ecfe6yae0d07187d5baeee@mail.gmail.com>
Content-Type: multipart/mixed;
	boundary="=-ZRfbe6oE0g+gwIwk0n3b"
Date: Tue, 04 Oct 2005 09:30:35 +0200
Message-ID: <1128411035.5947.15.camel@localhost.localdomain>
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc5200 and pcmcia
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

--=-ZRfbe6oE0g+gwIwk0n3b
Content-Type: text/plain;
	charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

I've developed the following patch.
It is not tested against the last git revision (I have to update my tree
as soon as I have enough time) and I sent it to Sylvain so it may be
partially commited.

Sorry, but this patch solves (or tries to solve) several problems.
You will have to have a look at the patch manually to understand every
of the issues it tries to solve.


PCI bus initialization: If you boot the MPC5200 with u-boot without PCI
support you will end up with some linux initialization problems. It is
because of the reset process (which leaves the PCI bus in its previous
state, that is reset by default, unless u-boot touches it). It does also
need to initialize some configuration elements of the PCI bus.
+	tmp =3D in_be32(&pci_regs->scr);
+	tmp |=3D PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
+	out_be32(&pci_regs->scr, tmp);
and
-	out_be32(&pci_regs->gscr, tmp);
+	out_be32(&pci_regs->gscr, tmp & ~MPC52xx_PCI_GSCR_PR);


Flags for hotplug: The function mpc52xx_pci_fixup_resources is called
for every PCI device (included cardbus) so if it is called from cardbus
it cannot be __init (it caused a big problem). Removing the __init is
enough.
-static void __init mpc52xx_pci_fixup_resources(struct pci_dev *dev) {
+static void mpc52xx_pci_fixup_resources(struct pci_dev *dev) {


Introduced Delay: A udelay(1) is introduced before configuration cycles.
Otherwise it crashes for me. Sylvain told me that the PCI should wait
some time after reset before it is used. I've not tested including the
delay in other parts.


Workaround for bug of MPC5200: MPC5200 has a bug with PCI type 1
configuration frames so the workaround proposed by freescale is
splitting them. Sylvain told me that some PCI cards have problems
reading or writting operations that are not 32 bits. So this code should
be rewritten a little bit. (I think I should rewrite it near in the
future).
(This is everything else in the patch).


I would thank very much to anyone that splits this patch, introduces the
workaround for the bug of MPC5200 while using only 32 bit operation on
type 0 frames, and sends it to Sylvain. (I feel like writting my Xmas
letter to Santa. XoD).

I hope this helps.

Asier Llano


El mar, 04-10-2005 a las 17:11 +1000, Andrew Dennison escribi=F3:
> On 10/4/05, Sylvain Munaut <tnt@246tnt.com> wrote:
> >
> > IIRC, there is an errata wrt configuration cycle thru bridges.
>=20
> I've got support for this (it's in my December patch). Configuration
> cycles work but some cardbus cards / drivers cause a TEA when the
> device is enabled driver loads Netgear FA511), while with a prism
> based WLAN card (Netcomm NP5430) I can load the firmware into the card
> but it doesn't run correctly - iwconfig can cause a TEA.
>=20
> I haven't had time to work out how to debug these properly - other
> more important things to do.
>=20
> >
> > > Apparnetly it's working in 2.6 but I haven't had time to sort this =
out.
> >
> > Is it ? not sure. I remember seeing a patch about it but it removed
> > the "always 32 bit access" in all cases and not just in the needed =
case
> > iirc. Make me think I forgot to sort that out ...
>=20
> At one stange you mentioned you had a patch from someone for cardbus
> support on 2.6 - it just fixed the configuration cycle errata so I
> assumed this meant the rest "just worked". Maybe that was a bad
> assumption...
>=20
> Andrew
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
--=20
Asier Llano Palacios <a.llano@usyscom.com>=20
=20
----------------------------------------- PLEASE NOTE =
-------------------------------------------
This message, along with any attachments, may be confidential or legally =
privileged.=20
It is intended only for the named person(s), who is/are the only =
authorized recipients.
If this message has reached you in error, kindly destroy it without =
review and notify the sender immediately.
Thank you for your help.
=B5SysCom uses virus scanning software but excludes any liability for =
viruses contained in any attachment.
=20
------------------------------------ ROGAMOS LEA ESTE TEXTO =
-------------------------------
Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o =
con derecho legal.=20
Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas =
como =FAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin =
revisarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente. =
Gracias por su colaboraci=F3n. =20
=B5SysCom utiliza software antivirus, pero no se hace responsable de los =
virus contenidos en los ficheros anexos.

--=-ZRfbe6oE0g+gwIwk0n3b
Content-Disposition: attachment;
	filename="mpc5200_pci.patch"
Content-Type: text/x-patch;
	charset="ISO-8859-15";
	name="mpc5200_pci.patch"
Content-Transfer-Encoding: 7bit

diff -urP linux-2.6.10-mpc5200/arch/ppc/syslib/mpc52xx_pci.c linux-2.6.10-mpc5200-pci/arch/ppc/syslib/mpc52xx_pci.c
--- linux-2.6.10-mpc5200/arch/ppc/syslib/mpc52xx_pci.c	2005-01-14 18:44:43.000000000 +0100
+++ linux-2.6.10-mpc5200-pci/arch/ppc/syslib/mpc52xx_pci.c	2005-02-10 09:50:23.000000000 +0100
@@ -22,6 +22,10 @@
 
 #include <asm/delay.h>
 
+/* This macro is defined to activate the workaround for the bug
+   435 of the MPC5200 (L25R) */
+#define MPC5200_BUG_435_WORKAROUND
+
 
 static int mpc52xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
                                    int offset, int len, u32 *val)
@@ -39,11 +43,24 @@
 		(devfn << 8) |
 		(offset & 0xfc));
 
-	value = in_le32((u32*)hose->cfg_data);
+	udelay( 1 );
 
-	if (len != 4) {
-		value >>= ((offset & 0x3) << 3);
-		value &= 0xffffffff >> (32 - (len << 3));
+	switch( len )
+	{
+		case 1: 
+			value = in_8(((u8*)hose->cfg_data) + (offset&0x3));   
+			break;
+		case 2: 
+			value = in_le16(((u16*)hose->cfg_data) + ((offset>>1)&1));
+			break;
+		default:
+#ifdef MPC5200_BUG_435_WORKAROUND
+			if( bus->number != hose->bus_offset )
+				value = in_le16((u16*)hose->cfg_data) | (in_le16(((u16*)hose->cfg_data) + 1) << 16);
+			else
+#endif
+			value = in_le32((u32*)hose->cfg_data);
+			break;
 	}
 
 	*val = value;
@@ -57,7 +74,6 @@
                                     int offset, int len, u32 val)
 {
 	struct pci_controller *hose = bus->sysdata;
-	u32 value, mask;
 
 	if (ppc_md.pci_exclude_device)
 		if (ppc_md.pci_exclude_device(bus->number, devfn))
@@ -69,19 +85,27 @@
 		(devfn << 8) |
 		(offset & 0xfc));
 
-	if (len != 4) {
-		value = in_le32((u32*)hose->cfg_data);
-
-		offset = (offset & 0x3) << 3;
-		mask = (0xffffffff >> (32 - (len << 3)));
-		mask <<= offset;
-
-		value &= ~mask;
-		val = value | ((val << offset) & mask);
+	switch( len )
+	{
+		case 1: 
+			out_8(((u8*)hose->cfg_data) + (offset&0x3), val);
+			break;
+		case 2: 
+			out_le16(((u16*)hose->cfg_data) + ((offset>>1)&1), val);
+			break;
+		default:
+#ifdef MPC5200_BUG_435_WORKAROUND
+			if( bus->number != hose->bus_offset )
+			{
+				out_le16((u16*)hose->cfg_data, (u16)val);
+				out_le16(((u16*)hose->cfg_data) + 1, (u16)(val>>16));
+			}
+			else
+#endif
+			out_le32((u32*)hose->cfg_data, val);
+			break;
 	}
 
-	out_le32((u32*)hose->cfg_data, val);
-
 	out_be32(hose->cfg_addr, 0);
 
 	return PCIBIOS_SUCCESSFUL;
@@ -98,6 +122,9 @@
 	u32 tmp;
 
 	/* Setup control regs */
+	tmp = in_be32(&pci_regs->scr);
+	tmp |= PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
+	out_be32(&pci_regs->scr, tmp);
 
 	/* Setup windows */
 	out_be32(&pci_regs->iw0btar, MPC52xx_PCI_IWBTAR_TRANSLATION(
@@ -138,10 +165,10 @@
 	tmp = in_be32(&pci_regs->gscr);
 	out_be32(&pci_regs->gscr, tmp | MPC52xx_PCI_GSCR_PR);
 	udelay(50);
-	out_be32(&pci_regs->gscr, tmp);
+	out_be32(&pci_regs->gscr, tmp & ~MPC52xx_PCI_GSCR_PR);
 }
 
-static void __init mpc52xx_pci_fixup_resources(struct pci_dev *dev) {
+static void mpc52xx_pci_fixup_resources(struct pci_dev *dev) {
 	int i;
 
 	/* We don't rely on boot loader for PCI and resets all

--=-ZRfbe6oE0g+gwIwk0n3b--
