Return-Path: <nd@bplan-gmbh.de>
Date: Sat, 28 Oct 2006 15:43:29 +0200 (MEST)
Message-Id: <200610281343.k9SDhTJm020310@post.webmailer.de>
To: "Benjamin Herrenschmidt"<benh@kernel.crashing.org>,
	"Nicolas DET"<nd@bplan-gmbh.de>
From: "Nicolas DET"<nd@bplan-gmbh.de>
Subject: Re: Re: [PATCH] General CHRP/MPC5K2 platform support patch
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de,
	sha@pengutronix.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
Sent: Sat, 28 Oct 2006
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>

> On Fri, 2006-10-27 at 17:04 +0200, Nicolas DET wrote:
>=20
> > +static void mpc52xx_ic_mask(unsigned int virq)
> > +{
> > +=09u32 val;
> > +=09int irq;
> > +=09int l1irq;
> > +=09int l2irq;
> > +
> > +=09irq =3D irq_map[virq].hwirq;
> > +=09l1irq =3D (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
> > +=09l2irq =3D (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
> > +
> > +=09pr_debug("%s: irq=3D%x. l1=3D%d, l2=3D%dn", __func__, irq, l1irq, l=
2irq);
> > +
> > +=09switch (l1irq) {
> > +=09case MPC52xx_IRQ_L1_CRIT:
> > +=09=09if (l2irq !=3D 0)
> > +=09=09=09BUG();
> > +
> > +=09=09val =3D in_be32(&intr->ctrl);
> > +=09=09val &=3D ~(1 << 11);
> > +=09=09out_be32(&intr->ctrl, val);
> > +=09=09break;
> > +
> > +=09case MPC52xx_IRQ_L1_MAIN:
> > +=09=09if ( (l2irq >=3D 1) && (l2irq <=3D 3) ) {
> > +=09=09=09val =3D in_be32(&intr->ctrl);
> > +=09=09=09val &=3D ~(1 << (11 - l2irq));
> > +=09=09=09out_be32(&intr->ctrl, val);
> > +=09=09} else {
> > +=09=09=09val =3D in_be32(&intr->main_mask);
> > +=09=09=09val |=3D 1 << (16 - l2irq);
> > +=09=09=09out_be32(&intr->main_mask, val);
> > +=09=09}
> > +=09=09break;
>=20
> Any reason why you do the above instead o defining two diferent levels
> instead. Also, L1_CRIT would fit in the L1_MAIN case too...
>=20
> I don't see the point of having also XXX-l2, just put a bit number in L2
> and be done with it.
>=20
> The idea is to streamling the code, such that you can index an array
> with l1irq to get the register, and build a mask. No test, no switch
> case, etc...
>=20
> Actually... the most performant way of doing all this is to have a
> different irq_chip (with a different set of ask,mask,unmask) for each
> "L1" so that they get right to the point. But I would settle for an
> array indexed by L1.
>=20

Ok. Let's go for the most performant then. So 4 irq_chip for the for type. =
Each
 is very simple: just clear/set the approprite bit in the appropriate regis=
ter.



> > +static void mpc52xx_ic_mask_and_ack(unsigned int irq)
> > +{
> > +=09mpc52xx_ic_mask(irq);
> > +=09mpc52xx_ic_ack(irq);
> > +}
>=20
> The above is unnuecessary. The core will call mask and ack.

Ok. Removed.

> > +static struct irq_chip mpc52xx_irqchip =3D {
> > +=09.typename =3D " MPC52xx  ",
> > +=09.mask =3D mpc52xx_ic_mask,
> > +=09.unmask =3D mpc52xx_ic_unmask,
> > +=09.mask_ack =3D mpc52xx_ic_mask_and_ack,
> > +};
>=20
> In the above, you need to provide ack.

Done.

> > +static int mpc52xx_irqhost_match(struct irq_host *h, struct device_nod=
e
> *node)
> > +{
> > +=09pr_debug("%s: %p vs %pn", __func__, find_mpc52xx_picnode(), node);
> > +=09return find_mpc52xx_picnode() =3D=3D node;
> > +}
>=20
> Don't redo the whole find all the time. Put the node in your
> irq_host->host_data at init time and compare it there. That way, also,
> find_mpc53xx_picnode() thingy can just stay static to chrp/setup.c. The
> way you did it would be a problem if we had more than one platform using
> 52xx built in the same kernel.
>

done.

> > +static int mpc52xx_islevel(int num)
> > +{
> > +=09u32 ictl_req;
> > +=09int ictl_type;
> > +
> > +=09ictl_req =3D in_be32(&intr->ctrl);
> > +=09ictl_type =3D (ictl_req >> 16) & 0x3;
> > +
> > +=09switch (ictl_type) {
> > +=09case 0:
> > +=09case 3:
> > +=09=09return 1;
> > +=09}
> > +
> > +=09return 0;
> > +}
>=20
> You only have level/edge settings, not polarity ? Also, you aren't
> giving the user or device-tree the option to set the type manually....
>=20
> Ideally, you should use the bits in IRQ_TYPE_SENSE_MASK to fully
> define the irq type/polarity and provide a set_irq_type() callback.
>=20
> Also, beware that you cannot call set_irq_chip_and_handler() from within
> set_irq_type() due to a spinlock recursion issue. There is a patch
> floating on the list for IPIC fixing an issue of that sort, you may want
> to have a look.
>=20
> In general, look at what others are doing, notably mpic and ipic.

I looked in i8258.c, let's look into others ;-)

> You can also keep IRQ_LEVEL in "sync" with the other polarity bits, it's
> really only useful to display the polarity in /proc/interrupts.
>=20
> Note that your map code would always OR the bit, never clear it. It
> should have probably cleared it before the switch/case.


> > +void mpc52xx_irqhost_unmap(struct irq_host *h, unsigned int virq)
> > +{
> > +=09pr_debug("%s: v=3D%xn", __func__, virq);
> > +
> > +=09mpc52xx_ic_mask(virq);
> > +=09set_irq_chip_and_handler(virq, NULL, NULL);
> > +=09synchronize_irq(virq);
> > +}
>=20
> The common code will do all of the above. Your unmap can be empty. (Or
> just don't do an unmap).
>=20

Ok.

> > +static struct irq_host_ops mpc52xx_irqhost_ops =3D {
> > +=09.match =3D mpc52xx_irqhost_match,
> > +=09.xlate =3D mpc52xx_irqhost_xlate,
> > +=09.map =3D mpc52xx_irqhost_map,
> > +=09.unmap =3D mpc52xx_irqhost_unmap,
> > +};
> > +
> > +void __init mpc52xx_init_irq(void)
> > +{
> > +=09int i;
> > +=09u32 intr_ctrl;
> > +
> > +=09/* Remap the necessary zones */
> > +=09intr =3D ioremap(MPC52xx_PA(MPC52xx_INTR_OFFSET), MPC52xx_INTR_SIZE=
);
> > +=09sdma =3D ioremap(MPC52xx_PA(MPC52xx_SDMA_OFFSET), MPC52xx_SDMA_SIZE=
);
> > +
> > +=09if ((intr =3D=3D NULL) || (sdma =3D=3D NULL))
> > +=09=09panic("Can't ioremap PIC/SDMA register or init_irq !");
> > +
> > +=09/* Disable all interrupt sources. */
> > +=09out_be32(&sdma->IntPend, 0xffffffff);=09/* 1 means clear pending */
> > +=09out_be32(&sdma->IntMask, 0xffffffff);=09/* 1 means disabled */
> > +=09out_be32(&intr->per_mask, 0x7ffffc00);=09/* 1 means disabled */
> > +=09out_be32(&intr->main_mask, 0x00010fff);=09/* 1 means disabled */
> > +=09intr_ctrl =3D in_be32(&intr->ctrl);
> > +=09intr_ctrl &=3D 0x00ff0000;=09/* Keeps IRQ[0-3] config */
> > +=09intr_ctrl |=3D 0x0f000000 |=09/* clear IRQ 0-3 */
> > +=09    0x00001000 |=09/* MEE master external enable */
> > +=09    0x00000000 |=09/* 0 means disable IRQ 0-3 */
> > +=09    0x00000001;=09=09/* CEb route critical normally */
> > +=09out_be32(&intr->ctrl, intr_ctrl);
> > +
> > +=09/* Zero a bunch of the priority settings.  */
> > +=09out_be32(&intr->per_pri1, 0);
> > +=09out_be32(&intr->per_pri2, 0);
> > +=09out_be32(&intr->per_pri3, 0);
> > +=09out_be32(&intr->main_pri1, 0);
> > +=09out_be32(&intr->main_pri2, 0);
> > +=09/* Initialize irq_desc[i].handler's with mpc52xx_ic. */
> > +=09for (i =3D 0; i < NR_IRQS; i++) {
> > +=09=09irq_desc[i].chip =3D &mpc52xx_irqchip;
> > +=09=09irq_desc[i].status =3D IRQ_LEVEL;
> > +
> > +=09}
>=20
> The above is completely bogus and should be just removed. You should not
> touch the irq_desc array. You should only ever modify irq_desc's that
> have been assigned to you by your host->map callback.
>=20

Ok.

> > +=09/*
> > +=09 * As last step, add an irq host to translate the real
> > +=09 * hw irq information provided by the ofw to linux virq
> > +=09 */
> > +
> > +=09mpc52xx_irqhost =3D
> > +=09    irq_alloc_host(IRQ_HOST_MAP_LINEAR, NR_IRQS, &mpc52xx_irqhost_o=
ps,
> > +=09=09=09   -1);
> > +}
>=20
> As I said before, NR_IRQ is a poor choice for the size of the revmap.
> You should have a constant somewhere defining what is your max HW irq
> number. and use that +1, or a hw irq count.

Done: 64

Bye
