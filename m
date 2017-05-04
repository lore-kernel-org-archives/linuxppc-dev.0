Return-Path: <schindele@nentec.de>
Received: from dmz-mail.nentec.de (gate.nentec.de [213.218.23.37])
 by lists.ozlabs.org (Postfix) with SMTP id 3wJdfS0hGmzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 01:06:54 +1000 (AEST)
From: Juergen Schindele <schindele@nentec.de>
To: Scott Wood <oss@buserror.net>
Reply-To: schindele@nentec.de
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Freescale mpc8315 IRQ0 setup
Date: Thu, 04 May 2017 17:06:37 +0200
Message-ID: <41499955.CTp69um5pn@sherry>
In-Reply-To: <1493782174.25397.31.camel@buserror.net>
References: <2666241.ms6yMRjznt@sherry> <1715435.xdU3769208@sherry>
 <1493782174.25397.31.camel@buserror.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1512970.igoxXhXBEB"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--nextPart1512970.igoxXhXBEB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Dienstag, 2. Mai 2017, 22:29:34 schrieb Scott Wood:
> On Tue, 2017-05-02 at 14:43 +0200, Juergen Schindele wrote:
> > Dear Scott,
> > sorry for the delay but i am not very familiar with the formating.
> > I passed the patch trough checkpatch.pl and there was no more error=
.
> > pease find patch in attached file.
> > Thanks
>=20
> Documentation/process/submitting-patches.rst explains the way to form=
at and
> submit kernel patches.
>=20
> Also, why the unrelated change to a print statement in ipic_set_irq_t=
ype()?
>=20
> -Scott
The second diff is not completely unrelated because when i was investig=
ating=20
the problem i saw only a message "edge sense not supported" but you don=
t
know on which interrupt he is complaining about. So i added this to fin=
d out=20
who the suspect is.

Corrected patch
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

Diese E-Mail enth=E4lt vertrauliche oder rechtlich gesch=FCtzte Informa=
tionen.=20
Wenn Sie nicht der vorgesehene Empf=E4nger sind, informieren Sie bitte =
sofort=20
den Absender und l=F6schen Sie diese E-Mail. Das unbefugte Kopieren die=
ser E-
Mail oder die unbefugte Weitergabe der enthaltenen Informationen ist ni=
cht=20
gestattet.

The information contained in this message is confidential or protected =
by law.=20
If you are not the intended recipient, please contact the sender and de=
lete=20
this message. Any unauthorised copying of this message or unauthorised=20=

distribution of the information contained herein is prohibited. 
--nextPart1512970.igoxXhXBEB
Content-Disposition: attachment; filename="ipic.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="ipic.patch"

[PATCH] configure "EDGE" capabilities for IRQ0 (like IRQ1-7)
Signed-off-by: Jurgen Schindele <schindele@nentec.de>

--- a/arch/powerpc/sysdev/ipic.c	2016-12-11 20:17:54.000000000 +0100
+++ b/arch/powerpc/sysdev/ipic.c	2017-04-04 15:28:11.201308780 +0200
@@ -315,6 +315,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[48] = {
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -617,7 +618,7 @@ static int ipic_set_irq_type(struct irq_
 	/* ipic supports only edge mode on external interrupts */
 	if ((flow_type & IRQ_TYPE_EDGE_FALLING) && !ipic_info[src].ack) {
 		printk(KERN_ERR "ipic: edge sense not supported on internal "
-				"interrupts\n");
+				"interrupts %d\n", src);
 		return -EINVAL;

 	}

--nextPart1512970.igoxXhXBEB--
