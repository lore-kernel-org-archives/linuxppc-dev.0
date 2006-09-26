Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 03A8C67B72
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 20:19:28 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k8QAJR4u021092 for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 03:19:27 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k8QAJPmg002078
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 05:19:27 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: local_irq_save not masking interrupts
Date: Tue, 26 Sep 2006 18:19:24 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263516C42D@zch01exm21.fsl.freescale.net>
In-Reply-To: <4518FA21.8050801@cambridgebroadband.com>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Alex Zeffertt" <ajz@cambridgebroadband.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

<snip>
> I'm having a strange problem with interrupts.  My platform is=20
> the MPC832xEMDS and the BSP I'm using (from Freescale) uses=20
> Linux-2.6.11.
>=20
> In the code below I enter a critical section with=20
> local_irq_save(), call request_irq() (from=20
> mpc832xemds_phy_interrupt_enable) 4 times, then exit the=20
> critical section using local_irq_restore.
>=20
>      /* Enable interrupts from PHYs */
>      local_irq_save(flags);
>      for (i =3D 0; i < driver_data->num_phys; i++) {
>          struct atm_dev *dev =3D driver_data->dev_data[i]->dev;
>          printk("%s/%d\n",__FUNCTION__,__LINE__);
>          RETURN_ON_ERROR(mpc832xemds_phy_interrupt_enable(dev));
>      }
>      local_irq_restore(flags);
>=20
> The problem is that I get an interrupt *before* exiting the=20
> critical section.  This causes a problem for me, because the=20
> interrupts are shared and the correct handler has not yet=20
> been registered, so the interrupt never gets deasserted.
>=20
> My question is: why is local_irq_save()/local_irq_restore()=20
> not working?

Really? local_irq_save not working?
I don't believe it.=20
Please check if exist any re-enable the interrupt in the critical
section.

-DAve
