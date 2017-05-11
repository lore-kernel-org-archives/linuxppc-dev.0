Return-Path: <schindele@nentec.de>
Received: from dmz-mail.nentec.de (gate.nentec.de [213.218.23.37])
 by lists.ozlabs.org (Postfix) with SMTP id 3wNsxR3SQ3zDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 22:34:33 +1000 (AEST)
From: Juergen Schindele <schindele@nentec.de>
To: Scott Wood <oss@buserror.net>
Reply-To: schindele@nentec.de
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Freescale mpc8315 interrupt chip
Date: Thu, 11 May 2017 14:34:19 +0200
Message-ID: <3052456.ktpuaNmngy@sherry>
In-Reply-To: <1493931328.25397.35.camel@buserror.net>
References: <2666241.ms6yMRjznt@sherry> <41499955.CTp69um5pn@sherry>
 <1493931328.25397.35.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Next try to submit two patches for Freescale mpc8315.

first one
-----------------------------------------------------------------------=
------------
powerpc/ipic: Configure "EDGE" capabilities for IRQ0 too (like IRQ1-7)
Signed-off-by: Jurgen Schindele <schindele@nentec.de>

The external IRQ0 has the same capabilities as the other IRQ1-7 and is
handeled by the same register IPIC_SEPNR. When this register for "ack"
is not setup in "ipic_info" you can not configure this IRQ for
IRQ_TYPE_EDGE_FALLING. This is probably due to the non-continued number=

of IRQ0 in the Freescale hwirq number mapping.

--- linux-4.11/arch/powerpc/sysdev/ipic.c.orig  2017-05-11 13:40:43.874=
801534=20
+0200
+++ linux-4.11/arch/powerpc/sysdev/ipic.c       2017-05-11 14:05:06.336=
610289=20
+0200
@@ -315,6 +315,7 @@ static struct ipic_info ipic_info[] =3D {
                .prio_mask =3D 7,
        },
        [48] =3D {
+               .ack    =3D IPIC_SEPNR,
                .mask   =3D IPIC_SEMSR,
                .prio   =3D IPIC_SMPRR_A,
                .force  =3D IPIC_SEFCR,

second one
-----------------------------------------------------------------------=
------------------
powerpc/ipic: Precise ERR printk when "ipic_set_irq_type" fails
Signed-off-by: Jurgen Schindele <schindele@nentec.de>

When you setup an interrupt of a certain type on this interrupt-control=
er
which is not supported on this hardware you will get an error log but y=
ou
dont know which interrupt was the cause.
With this patch you are able to localize the source of failure.

--- linux-4.11/arch/powerpc/sysdev/ipic.c.orig  2017-05-11 14:08:07.098=
824986=20
+0200
+++ linux-4.11/arch/powerpc/sysdev/ipic.c       2017-05-11 14:10:51.010=
934755=20
+0200
@@ -611,14 +611,14 @@ static int ipic_set_irq_type(struct irq_
        /* ipic supports only low assertion and high-to-low change sens=
es
         */
        if (!(flow_type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))=
) {
-               printk(KERN_ERR "ipic: sense type 0x%x not supported\n"=
,
-                       flow_type);
+               printk(KERN_ERR "ipic: sense type 0x%x not supported on=
 "
+                       "interrupt %d\n", flow_type, src);
                return -EINVAL;
        }
        /* ipic supports only edge mode on external interrupts */
        if ((flow_type & IRQ_TYPE_EDGE_FALLING) && !ipic_info[src].ack)=
 {
                printk(KERN_ERR "ipic: edge sense not supported on inte=
rnal "
-                               "interrupts\n");
+                               "interrupt %d\n", src);
                return -EINVAL;

        }

I hope i respected all patch requirements ;-)
Am Donnerstag, 4. Mai 2017, 15:55:28 schrieb Scott Wood:
> On Thu, 2017-05-04 at 17:06 +0200, Juergen Schindele wrote:
> > Am Dienstag, 2. Mai 2017, 22:29:34 schrieb Scott Wood:
> > > On Tue, 2017-05-02 at 14:43 +0200, Juergen Schindele wrote:
> > > > Dear Scott,
> > > > sorry for the delay but i am not very familiar with the formati=
ng.
> > > > I passed the patch trough checkpatch.pl and there was no more e=
rror.
> > > > pease find patch in attached file.
> > > > Thanks
> > >=20
> > > Documentation/process/submitting-patches.rst explains the way to =
format
> > > and
> > > submit kernel patches.
> > >=20
> > > Also, why the unrelated change to a print statement in
> > > ipic_set_irq_type()?
> > >=20
> > > -Scott
> >=20
> > The second diff is not completely unrelated because when i was
> > investigating=20
> > the problem i saw only a message "edge sense not supported" but you=
 dont
> > know on which interrupt he is complaining about. So i added this to=
 find
> > out=20
> > who the suspect is.
>=20
> That's fine but it's still fixing a different problem than "irq0 setu=
p" and
> should be a separate patch.
>=20
> > Corrected patch
>=20
> Again, please read Documentation/process/submitting-patches.rst.  Pat=
ches
> should be inline, not attached.  The subject line should be something=
 like
> "powerpc/ipic: Configure "EDGE" capabilities for IRQ0 (like IRQ1-7)" =
and
> there should be more description in the body of the changelog.
>=20
> -Scott
Thanks for your hints
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
