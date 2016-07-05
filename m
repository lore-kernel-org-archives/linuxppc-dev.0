Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0065.outbound.protection.outlook.com [104.47.2.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkN506ZDzzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 22:10:44 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Jason Cooper <jason@lakedaemon.net>
CC: "oss@buserror.net" <oss@buserror.net>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaobo Xie
 <xiaobo.xie@nxp.com>
Subject: RE: [PATCH 2/2] qe/ic: refactor qe_ic to simplify
Date: Tue, 5 Jul 2016 07:38:49 +0000
Message-ID: <AM3PR04MB1185882FDBB659CD433F9EBB91390@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1467683219-29326-1-git-send-email-qiang.zhao@nxp.com>
 <1467683219-29326-2-git-send-email-qiang.zhao@nxp.com>
 <20160705035100.GB3348@io.lakedaemon.net>
In-Reply-To: <20160705035100.GB3348@io.lakedaemon.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2016 11:51 AM, Jason Cooper <jason@lakedaemon.net> wrote:

> -----Original Message-----
> From: Jason Cooper [mailto:jason@lakedaemon.net]
> Sent: Tuesday, July 05, 2016 11:51 AM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: oss@buserror.net; tglx@linutronix.de; marc.zyngier@arm.com; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Xiaobo Xie
> <xiaobo.xie@nxp.com>
> Subject: Re: [PATCH 2/2] qe/ic: refactor qe_ic to simplify
>=20
> Hi Zhao Qiang,
>=20
> Same comment as previous patch regarding the subject line.
>=20
> On Tue, Jul 05, 2016 at 09:46:59AM +0800, Zhao Qiang wrote:
> > there are init_qe_ic_sysfs and qeic_of_init, refactor them.
>=20
> Same comment from previous patch about commit log.
>=20
> >
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > ---
> >  drivers/irqchip/qe_ic.c    | 83 +++++++++++++++++++++++++-------------=
-----
> ---
> >  include/soc/fsl/qe/qe_ic.h |  7 ----
> >  2 files changed, 45 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/irqchip/qe_ic.c b/drivers/irqchip/qe_ic.c index
> > f7f9a81..46652c0 100644
> > --- a/drivers/irqchip/qe_ic.c
> > +++ b/drivers/irqchip/qe_ic.c
> > @@ -317,27 +317,35 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_=
ic)
> >  	return irq_linear_revmap(qe_ic->irqhost, irq);  }
> >
> > -void __init qe_ic_init(struct device_node *node, unsigned int flags,
> > -		       void (*low_handler)(struct irq_desc *desc),
> > -		       void (*high_handler)(struct irq_desc *desc))
> > +static int __init qe_ic_init(unsigned int flags)
> >  {
> > +	struct device_node *node;
> >  	struct qe_ic *qe_ic;
> >  	struct resource res;
> > -	u32 temp =3D 0, ret, high_active =3D 0;
> > +	u32 temp =3D 0, high_active =3D 0;
> > +	int ret =3D 0;
> > +
> > +	node =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> > +	if (!node)
> > +		return -ENODEV;
> >
> >  	ret =3D of_address_to_resource(node, 0, &res);
> > -	if (ret)
> > -		return;
> > +	if (ret) {
> > +		ret =3D -ENODEV;
> > +		goto err_put_node;
> > +	}
> >
> >  	qe_ic =3D kzalloc(sizeof(*qe_ic), GFP_KERNEL);
> > -	if (qe_ic =3D=3D NULL)
> > -		return;
> > +	if (qe_ic =3D=3D NULL) {
> > +		ret =3D -ENOMEM;
> > +		goto err_put_node;
> > +	}
> >
> >  	qe_ic->irqhost =3D irq_domain_add_linear(node, NR_QE_IC_INTS,
> >  					       &qe_ic_host_ops, qe_ic);
> >  	if (qe_ic->irqhost =3D=3D NULL) {
> > -		kfree(qe_ic);
> > -		return;
> > +		ret =3D -ENOMEM;
> > +		goto err_free_qe_ic;
> >  	}
> >
> >  	qe_ic->regs =3D ioremap(res.start, resource_size(&res)); @@ -348,9
> > +356,9 @@ void __init qe_ic_init(struct device_node *node, unsigned int
> flags,
> >  	qe_ic->virq_low =3D irq_of_parse_and_map(node, 1);
> >
> >  	if (qe_ic->virq_low =3D=3D NO_IRQ) {
> > -		printk(KERN_ERR "Failed to map QE_IC low IRQ\n");
> > -		kfree(qe_ic);
> > -		return;
> > +		pr_err("Failed to map QE_IC low IRQ\n");
> > +		ret =3D -ENOMEM;
> > +		goto err_domain_remove;
> >  	}
> >
> >  	/* default priority scheme is grouped. If spread mode is    */
> > @@ -377,13 +385,23 @@ void __init qe_ic_init(struct device_node *node,
> unsigned int flags,
> >  	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
> >
> >  	irq_set_handler_data(qe_ic->virq_low, qe_ic);
> > -	irq_set_chained_handler(qe_ic->virq_low, low_handler);
> > +	irq_set_chained_handler(qe_ic->virq_low, qe_ic_cascade_low_mpic);
> >
> >  	if (qe_ic->virq_high !=3D NO_IRQ &&
> >  			qe_ic->virq_high !=3D qe_ic->virq_low) {
> >  		irq_set_handler_data(qe_ic->virq_high, qe_ic);
> > -		irq_set_chained_handler(qe_ic->virq_high, high_handler);
> > +		irq_set_chained_handler(qe_ic->virq_high,
> > +					qe_ic_cascade_high_mpic);
> >  	}
> > +	return ret;
>=20
> of_node_put(node)?  Explicitly return success?

Yes, thank you very much!

>=20
> > +
> > +err_domain_remove:
> > +	irq_domain_remove(qe_ic->irqhost);
> > +err_free_qe_ic:
> > +	kfree(qe_ic);
> > +err_put_node:
> > +	of_node_put(node);
> > +	return ret;
> >  }
> >
> >  void qe_ic_set_highest_priority(unsigned int virq, int high) @@
> > -490,37 +508,26 @@ static struct device device_qe_ic =3D {
> >  	.bus =3D &qe_ic_subsys,
> >  };
> >
> > -static int __init init_qe_ic_sysfs(void)
> > +static int __init init_qe_ic(void)
> >  {
> > -	int rc;
> > +	int ret;
> >
> > -	printk(KERN_DEBUG "Registering qe_ic with sysfs...\n");
> > +	ret =3D qe_ic_init(0);
>=20
> Sorry, build machine is down atm.  How was qe_ic_init() called previously=
?  Is
> that removed?

Sorry, I don't understand, could you please explain?

>=20
> > +	if (ret)
> > +		return ret;
> >
> > -	rc =3D subsys_system_register(&qe_ic_subsys, NULL);
> > -	if (rc) {
> > -		printk(KERN_ERR "Failed registering qe_ic sys class\n");
> > +	ret =3D subsys_system_register(&qe_ic_subsys, NULL);
> > +	if (ret) {
> > +		pr_err("Failed registering qe_ic sys class\n");
> >  		return -ENODEV;
> >  	}
> > -	rc =3D device_register(&device_qe_ic);
> > -	if (rc) {
> > -		printk(KERN_ERR "Failed registering qe_ic sys device\n");
> > +	ret =3D device_register(&device_qe_ic);
> > +	if (ret) {
> > +		pr_err("Failed registering qe_ic sys device\n");
> >  		return -ENODEV;
> >  	}
> > -	return 0;
> > -}
> >
> > -static int __init qeic_of_init(void)
> > -{
> > -	struct device_node *np;
> > -
> > -	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> > -	if (np) {
> > -		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> > -			   qe_ic_cascade_high_mpic);
> > -		of_node_put(np);
> > -	}
> >  	return 0;
> >  }
> >
> > -subsys_initcall(qeic_of_init);
> > -subsys_initcall(init_qe_ic_sysfs);
> > +subsys_initcall(init_qe_ic);
> > diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
> > index 1e155ca..6113699 100644
> > --- a/include/soc/fsl/qe/qe_ic.h
> > +++ b/include/soc/fsl/qe/qe_ic.h
> > @@ -58,16 +58,9 @@ enum qe_ic_grp_id {  };
> >
> >  #ifdef CONFIG_QUICC_ENGINE
> > -void qe_ic_init(struct device_node *node, unsigned int flags,
> > -		void (*low_handler)(struct irq_desc *desc),
> > -		void (*high_handler)(struct irq_desc *desc));
> >  unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic);  unsigned int
> > qe_ic_get_high_irq(struct qe_ic *qe_ic);  #else -static inline void
> > qe_ic_init(struct device_node *node, unsigned int flags,
> > -		void (*low_handler)(struct irq_desc *desc),
> > -		void (*high_handler)(struct irq_desc *desc))
> > -{}
> >  static inline unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)  {
> > return 0; }  static inline unsigned int qe_ic_get_high_irq(struct
> > qe_ic *qe_ic)

-Zhao Qiang
BR
