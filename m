Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0148.outbound.protection.outlook.com [65.55.169.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC5F81A051A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 05:05:07 +1100 (AEDT)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: RE: [PATCH RFC 02/11] dpaa_eth: add support for DPAA Ethernet
Date: Wed, 18 Mar 2015 18:05:00 +0000
Message-ID: <BL2PR03MB545AE3038A76B121ECA7316E6000@BL2PR03MB545.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "bhamciu1@freescale.com" <bhamciu1@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>=20
> On Mar 17, 2015, at 1:58 PM, Madalin Bucur <madalin.bucur@Freescale.com>
> wrote:
>=20
> > This introduces the Freescale Data Path Acceleration Architecture
> > (DPAA) Ethernet driver (dpaa_eth) that builds upon the DPAA QMan,
> > BMan, PAMU and FMan drivers to deliver Ethernet connectivity on
> > the Freescale DPAA QorIQ platforms.
> >
> > Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
> > ---

[snip]

> > diff --git a/drivers/net/ethernet/freescale/Makefile
> b/drivers/net/ethernet/freescale/Makefile
> > index 71debd1..b6c10ab 100644
> > --- a/drivers/net/ethernet/freescale/Makefile
> > +++ b/drivers/net/ethernet/freescale/Makefile
> > @@ -12,6 +12,7 @@ obj-$(CONFIG_FS_ENET) +=3D fs_enet/
> > obj-$(CONFIG_FSL_PQ_MDIO) +=3D fsl_pq_mdio.o
> > obj-$(CONFIG_FSL_XGMAC_MDIO) +=3D xgmac_mdio.o
> > obj-$(CONFIG_GIANFAR) +=3D gianfar_driver.o
> > +obj-$(if $(CONFIG_FSL_DPAA_ETH),y) +=3D dpaa/
>=20
> Why isn't
>=20
> obj-$(CONFIG_FSL_DPAA_ETH)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +=3D dpaa/
>=20
> enough?

It is, will fix.

> > diff --git a/drivers/net/ethernet/freescale/dpaa/Kconfig
> b/drivers/net/ethernet/freescale/dpaa/Kconfig
> > new file mode 100644
> > index 0000000..7ef703c
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/dpaa/Kconfig
> > @@ -0,0 +1,49 @@
> > +menuconfig FSL_DPAA_ETH
> > +=A0=A0=A0=A0=A0 tristate "DPAA Ethernet"
> > +=A0=A0=A0=A0=A0 depends on FSL_SOC && FSL_BMAN && FSL_QMAN && FSL_FMAN
> > +=A0=A0=A0=A0=A0 select PHYLIB
> > +=A0=A0=A0=A0=A0 select FSL_FMAN_MAC
> > +=A0=A0=A0=A0=A0 ---help---
> > +=A0=A0=A0=A0=A0 =A0 Data Path Acceleration Architecture Ethernet drive=
r,
> > +=A0=A0=A0=A0=A0 =A0 supporting the Freescale QorIQ chips.
> > +=A0=A0=A0=A0=A0 =A0 Depends on Freescale Buffer Manager and Queue Mana=
ger
> > +=A0=A0=A0=A0=A0 =A0 driver and Frame Manager Driver.
> > +
> > +if FSL_DPAA_ETH
> > +
> > +config FSL_DPAA_CS_THRESHOLD_1G
> > +=A0=A0=A0=A0=A0 hex "Egress congestion threshold on 1G ports"
> > +=A0=A0=A0=A0=A0 depends on FSL_DPAA_ETH
> > +=A0=A0=A0=A0=A0 range 0x1000 0x10000000
> > +=A0=A0=A0=A0=A0 default "0x06000000"
> > +=A0=A0=A0=A0=A0 ---help---
> > +=A0=A0=A0=A0=A0 =A0 The size in bytes of the egress Congestion State n=
otification
> threshold on 1G ports.
> > +=A0=A0=A0=A0=A0 =A0 The 1G dTSECs can quite easily be flooded by cores=
 doing Tx in a
> tight loop
> > +=A0=A0=A0=A0=A0 =A0 (e.g. by sending UDP datagrams at "while(1) speed"=
),
> > +=A0=A0=A0=A0=A0 =A0 and the larger the frame size, the more acute the =
problem.
> > +=A0=A0=A0=A0=A0 =A0 So we have to find a balance between these factors=
:
> > +=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0 - avoiding the device staying conge=
sted for a prolonged time
> (risking
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 the netdev watchdog t=
o fire - see also the tx_timeout module
> param);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - affecting performance of =
protocols such as TCP, which otherwise
> > +=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0 behave well under the congest=
ion notification mechanism;
> > +=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0 - preventing the Tx cores from tigh=
tly-looping (as if the
> congestion
> > +=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0 threshold was too low to be e=
ffective);
> > +=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0 - running out of memory if the CS t=
hreshold is set too high.
> > +
> > +config FSL_DPAA_CS_THRESHOLD_10G
> > +=A0=A0=A0=A0=A0 hex "Egress congestion threshold on 10G ports"
> > +=A0=A0=A0=A0=A0 depends on FSL_DPAA_ETH
> > +=A0=A0=A0=A0=A0 range 0x1000 0x20000000
> > +=A0=A0=A0=A0=A0 default "0x10000000"
> > +=A0=A0=A0=A0=A0 ---help ---
> > +=A0=A0=A0=A0=A0 =A0 The size in bytes of the egress Congestion State n=
otification
> threshold on 10G ports.
> > +
> > +config FSL_DPAA_INGRESS_CS_THRESHOLD
> > +=A0=A0=A0=A0=A0 hex "Ingress congestion threshold on FMan ports"
> > +=A0=A0=A0=A0=A0 depends on FSL_DPAA_ETH
> > +=A0=A0=A0=A0=A0 default "0x10000000"
> > +=A0=A0=A0=A0=A0 ---help---
> > +=A0=A0=A0=A0=A0 =A0 The size in bytes of the ingress tail-drop thresho=
ld on FMan ports.
> > +=A0=A0=A0=A0=A0 =A0 Traffic piling up above this value will be rejecte=
d by QMan and
> discarded by FMan.
> > +
>=20
> Do these thresholds really need to be kconfig options?=A0 Are they not
> changeable at runtime?

Probably Bogdan thought it was an easy way to provide basic means to tweak =
them
and also provide some explanation for them. The current setting is chosen t=
o keep
them mostly out of the way but still address a corner case a customer repor=
ted, if
I remember correctly. No runtime change is supported.

> > diff --git a/drivers/net/ethernet/freescale/dpaa/Makefile
> b/drivers/net/ethernet/freescale/dpaa/Makefile
> > new file mode 100644
> > index 0000000..bdeb04e
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/dpaa/Makefile
> > @@ -0,0 +1,14 @@
> > +#
> > +# Makefile for the Freescale DPAA Ethernet controllers
> > +#
> > +ccflags-y +=3D -DVERSION=3D\"\"
>=20
> Is this really needed, if so we need to fix that.

Unused, will remove.

[snip]
> > +
> > +#define DPA_DESCRIPTION "FSL DPAA Ethernet driver"
> > +
> > +MODULE_LICENSE("Dual BSD/GPL");
> > +
> > +MODULE_AUTHOR("Andy Fleming <afleming@freescale.com>");
> > +
> > +MODULE_DESCRIPTION(DPA_DESCRIPTION);
>=20
> These are typically at the end of the file, and kept together (ie no blan=
k lines
> between them)

Will move them.

[snip]
> > +
> > +static struct platform_device_id dpa_devtype[] =3D {
> > +=A0=A0=A0=A0=A0 {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =
=3D "dpaa-ethernet",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .drive=
r_data =3D 0,
> > +=A0=A0=A0=A0=A0 }, {
> > +=A0=A0=A0=A0=A0 }
> > +};
> > +MODULE_DEVICE_TABLE(platform, dpa_devtype);
> > +
> > +static struct platform_driver dpa_driver =3D {
> > +=A0=A0=A0=A0=A0 .driver =3D {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D KBUILD_MODNAME,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .owner=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D THIS_MODULE,
> > +=A0=A0=A0=A0=A0 },
> > +=A0=A0=A0=A0=A0 .id_table=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D d=
pa_devtype,
> > +=A0=A0=A0=A0=A0 .probe=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D dpaa_eth_priv_probe,
> > +=A0=A0=A0=A0=A0 .remove=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D dpa_remove
> > +};
> > +
> > +static int __init __cold dpa_load(void)
> > +{
> > +=A0=A0=A0=A0=A0 int=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _errno;
> > +
> > +=A0=A0=A0=A0=A0 pr_info(DPA_DESCRIPTION " (" VERSION ")\n");
> > +
> > +=A0=A0=A0=A0=A0 /* initialise dpaa_eth mirror values */
> > +=A0=A0=A0=A0=A0 dpa_rx_extra_headroom =3D fm_get_rx_extra_headroom();
> > +=A0=A0=A0=A0=A0 dpa_max_frm =3D fm_get_max_frm();
> > +
> > +=A0=A0=A0=A0=A0 _errno =3D platform_driver_register(&dpa_driver);
> > +=A0=A0=A0=A0=A0 if (unlikely(_errno < 0)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err=
(KBUILD_MODNAME
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ": %s:%hu:%s(): platform_driver_=
register() =3D %d\n",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 KBUILD_BASENAME ".c", __LINE__, =
__func__,
> _errno);
> > +=A0=A0=A0=A0=A0 }
> > +
> > +=A0=A0=A0=A0=A0 pr_debug(KBUILD_MODNAME ": %s:%s() ->\n",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 KBUILD=
_BASENAME ".c", __func__);
> > +
> > +=A0=A0=A0=A0=A0 return _errno;
> > +}
> > +module_init(dpa_load);
> > +
> > +static void __exit __cold dpa_unload(void)
> > +{
> > +=A0=A0=A0=A0=A0 pr_debug(KBUILD_MODNAME ": -> %s:%s()\n",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 KBUILD=
_BASENAME ".c", __func__);
> > +
> > +=A0=A0=A0=A0=A0 platform_driver_unregister(&dpa_driver);
> > +
> > +=A0=A0=A0=A0=A0 /* Only one channel is used and needs to be relased af=
ter all
> > +=A0=A0=A0=A0=A0 * interfaces are removed
> > +=A0=A0=A0=A0=A0 */
> > +=A0=A0=A0=A0=A0 dpa_release_channel();
> > +
> > +=A0=A0=A0=A0=A0 pr_debug(KBUILD_MODNAME ": %s:%s() ->\n",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 KBUILD=
_BASENAME ".c", __func__);
> > +}
> > +module_exit(dpa_unload);
>=20
> What's the point of this dpa platform driver?
>=20

It replaces the device tree node probing, based on the feedback [1] receive=
d from Scott.
The FMan MAC driver creates a device for the Ethernet driver to probe again=
st in
dpaa_eth_add_device(), see [2]. This replaces the rejected model where a co=
nfiguration
node for Ethernet was added to the device tree with a reference to the FMan=
 MAC node.
The platform device provides the Ethernet driver with FMan MAC identificati=
on and the
MAC dev needed back in the adjust_link() call:
...
struct dpaa_eth_data {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct device_node *mac_node;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct mac_device *mac_dev;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int mac_hw_id;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int fman_hw_id;
};
...
static void adjust_link(struct net_device *net_dev)
{
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct device *dev =3D net_de=
v->dev.parent;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct dpaa_eth_data *eth_dat=
a =3D dev->platform_data;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct mac_device *mac_dev =
=3D eth_data->mac_dev;
...

[snip]
> > +static inline int __hot dpa_xmit(struct dpa_priv_s *priv,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 struct rtnl_link_stats64 *percpu_stats,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 int queue,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 struct qm_fd *fd)
>=20
> Is there a reason this isnt just in the .c file?

It's also used by the un-submitted advanced drivers that compile against th=
e
submitted code (there are a few other things used in common - such as the c=
ode
extracted in the dpaa_eth_common.c file).

> > +EXPORT_SYMBOL(dpa_mac_dev_get);
>=20
> why is this exported?
>=20

Same reason as above.

[snip]

Thank you for your time,
Madalin

[1] https://patchwork.ozlabs.org/patch/415831/
[2] https://patchwork.ozlabs.org/patch/448874/
