Return-Path: <raul.moreno@telvent.abengoa.com>
Received: from envio.abengoa.com (envio.abengoa.com [217.15.37.68])
	by ozlabs.org (Postfix) with ESMTP id 9E3C6DE141
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jan 2008 02:56:34 +1100 (EST)
In-Reply-To: <OF9B97E7E0.352B883F-ONC12573CA.0058283E-C12573CA.005AFC5C@abengoa.com>
Subject: 2.6.22-ppc8xx fec.c bugs
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF7BC7CA29.9B371169-ONC12573CC.00553A44-C12573CC.0057BA09@abengoa.com>
Date: Thu, 10 Jan 2008 16:57:46 +0100
From: raul.moreno@telvent.abengoa.com
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello everyone,

I don't know who the maintainer of the FEC (Fast Ethernet Controller) i=
n
the ppc8xx achitecture is, so I am writing this email here.

After spending some time working withy kernel 2.6.15 for the ppc8xx
architecture, I've recently started to port to the 2.6.22. Doing so I h=
ave
found some bugs in the code managing the FEC (fec.c).

First I found (and cleared) some compilation errors due to inconsistent=

changes in function prototypes (i.e. INIT_WORK). Moreover, if the "MDIO=
 for
PHY" configuration is used (in my case for an LXT971 fec) the kernel
couldn't manage to finish booting and was caught in an infinite loop
waiting for fec intialization.

I've seen that some bugs were fixed in the latest kernel but others hav=
en't
been addressed (possibly undetected yet). The following is a diff with
corrections I made to the 2.6.22 'fec.c' file (currently seems to work
fine).

883a884

> #ifdef PHY_INTERRUPT

884a886,888

> #else

>     fep->link =3D 1;    /* If PHY_INTERRUPT is not defined, fep->link=
  must
be also put to 1 */

> #endif

1077c1082

< #endif /* CONFIG_FEC_LXT970 */

---

> #endif /* CONFIG_FEC_LXT971 */

1281c1286

<           container_of(work, struct fec_enet_private, phy_task);

---

>           container_of(work, struct fec_enet_private, phy_task2);
/* use phy_task2 -->config */

1660c1665,1666

<     cbd_base =3D (cbd_t *)dma_alloc_coherent(dev->class_dev.dev, PAGE=
_SIZE,

---

>     /* The first parameter has changed */

>     cbd_base =3D (cbd_t *)dma_alloc_coherent(&dev->dev, PAGE_SIZE,

1676,1678c1682,1684

<           ba =3D (unsigned char *)dma_alloc_coherent(dev->class_dev.d=
ev,

---

>           /* The first parameter has changed */

>           ba =3D (unsigned char *)dma_alloc_coherent(&dev->dev,

1814,1816c1821,1824

< #ifdef    CONFIG_USE_MDIO

<     INIT_WORK(&fep->phy_task, mii_relink, (void *)dev);

<     INIT_WORK(&fep->phy_task2, mii_display_config, (void *)dev);

---

> #ifdef    CONFIG_USE_MDIO         /* INIT_WORK has only two parameter=

since 2.6.20 */

>     INIT_WORK(&fep->phy_task, mii_relink);

>     INIT_WORK(&fep->phy_task2, mii_display_config);



I hope this helps.
Best regards,

Ra=FAl Moreno=
