Return-Path: <ndrs.frsn@googlemail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2E6691007D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 22:31:17 +1100 (EST)
Received: by ywp27 with SMTP id 27so1365031ywp.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 03:31:13 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 10 Nov 2011 12:31:13 +0100
Message-ID: <CAMU=cjySPDP0WFJi+07UkiQw71Ta0Uqd6n2NtKRScCxPxZsFRg@mail.gmail.com>
Subject: right way to get interrupt controller register
From: Andreas Friesen <ndrs.frsn@googlemail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello people,

I have a little problem with the isr routine. The interrupt handler
is installed and working fine, but I can not clear the interrupt flag in
ICTL-Register.

Is that right way to get interrupt controller register ?

Thanks in advance,
Andreas Friesen


Hier is my ISR-Handler and probe functions :

static irqreturn_t mess_isr (int irq, void *data)
{
struct qxcpld_drvdata *drvdata ;
drvdata =3D (struct qxcpld_drvdata *)data ;
struct mpc52xx_intr __iomem *intr;
int i ;
u32 intr_ctrl;

=A0 =A0 =A0 =A0intr =3D drvdata->intr
=A0 =A0 =A0 =A0intr_ctrl =3D intr->ctrl ;
intr_ctrl =3D in_be32(&intr->ctrl);
intr_ctrl |=3D =A00x04000000;
out_be32 (&intr->ctrl,intr_ctrl);

=A0 =A0 =A0 // set gpio
=A0 =A0 =A0 ....

return IRQ_HANDLED;
}



/* MPC5200 device tree match tables */
static struct of_device_id mpc52xx_pic_ids[] __initdata =3D {
{ .compatible =3D "fsl,mpc5200b-pic", },
{ .compatible =3D "mpc5200-pic", },
{}
};


static int __devinit qxcpld_of_probe (struct platform_device *ofdev)
{
.....
/* Remap the necessary zones */
np =3D of_find_matching_node(NULL, mpc52xx_pic_ids);
drvdata->intr =3D of_iomap(np, 0);
if (!drvdata->intr)
panic(__FILE__ =A0": find_and_map failed on 'mpc5200-pic'. "
=A0 =A0 =A0"Check node !");
of_node_put (np);
....

/* request irq */
drvdata->mess_irq =3D irq_of_parse_and_map(ofdev->dev.of_node,0);
if (drvdata->mess_irq =3D=3D NO_IRQ ) {
dev_err (&ofdev->dev, "failed to attach interrupt\n");
goto reg_unmap ;
}

....
if ( request_irq( drvdata->mess_irq,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0qxcpld_mess_isr,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF_DISABLED|IRQF_SHARED,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"qxcpld-mess-irq",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(void *)drvdata
=A0 =A0 ) ) {
dev_err(&ofdev->dev, "Can't request irq\n") ;
goto reg_unmap ;
}

...

}
