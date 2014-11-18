Return-Path: <liviu.dudau@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by lists.ozlabs.org (Postfix) with ESMTP id BE3D61A0975
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 01:48:25 +1100 (AEDT)
Date: Tue, 18 Nov 2014 14:48:19 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [RFC PATCH 07/16] PCI: Separate pci_host_bridge creation out of
 pci_create_root_bus()
Message-ID: <20141118144819.GK12037@e106497-lin.cambridge.arm.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <1416219710-26088-8-git-send-email-wangyijing@huawei.com>
 <2507218.mHliopJb05@wuerfel> <546B041A.4060403@huawei.com>
MIME-Version: 1.0
In-Reply-To: <546B041A.4060403@huawei.com>
Content-Type: text/plain; charset=UTF-8
Cc: Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "huxinwei@huawei.com" <huxinwei@huawei.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Wuyun <wuyun.wu@huawei.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 18, 2014 at 08:32:26AM +0000, Yijing Wang wrote:
>=20
> >> +LIST_HEAD(pci_host_bridge_list);
> >> +DECLARE_RWSEM(pci_host_bridge_sem);
> >=20
> > Unless the pci_host_bridge_sem is accessed thousands of times per secon=
d,
> > it's normally better to use a simple mutex instead.
>=20
> OK, I will use simple mutex instead.
>=20
> >=20
> >> +static struct resource busn_resource =3D {
> >> +=09.name=09=3D "PCI busn",
> >> +=09.start=09=3D 0,
> >> +=09.end=09=3D 255,
> >> +=09.flags=09=3D IORESOURCE_BUS,
> >> +};
> >=20
> > I think it would be better to require callers to pass the bus resource
> > down to the function.
>=20
> Hmm, I think most of caller will provide the bus resource, but some other=
s
> will not give any bus resource, extremely, no any resources :(. But we st=
ill
> need properly configure their resources for compatibility.
>=20
> >=20
> >> +struct pci_host_bridge *pci_create_host_bridge(
> >> +=09=09struct device *parent, u32 db,=20
> >> +=09=09struct pci_ops *ops, void *sysdata,=20
> >> +=09=09struct list_head *resources)
> >> +{
> >=20
> > Do we still need to pass the 'sysdata' in here? If we are guaranteed to
> > have a device pointer, we should always be able to get the driver
> > private data from dev_get_drvdata(host->dev->parent).
>=20
> We need, some platforms pass NULL pointer as host bridge parent.

Yijing,

May I suggest a different approach here? Rather than having to pass an opaq=
ue
pointer that gets converted by the host bridge driver back to the private
structure, what about promoting a new style of usage, that is similar to th=
e
way device drivers work? Lets try to promote the embedding of the generic
pci_host_bridge structure in the host bridge specific structure! Then we ca=
n
access the private data doing container_of().

Something like this:

struct pci_controller {
=09struct pci_host_bridge bridge;
=09/* private host bridge data here */
=09.....
};

#define PCI_CONTROLLER(bus)=09({
=09struct pci_host_bridge *hb =3D to_pci_host_bridge(bus->bridge); \
=09container_of(hb, struct pci_controller, bridge); })


Then we can retrieve the host bridge structure from everywhere we have a de=
vice.

Best regards,
Liviu

>=20
> >=20
> >> +=09host =3D kzalloc(sizeof(*host), GFP_KERNEL);
> >> +=09if (!host)
> >> +=09=09return NULL;
> >=20
> > devm_kzalloc maybe?
>=20
> I don't know much detail about devm_kzalloc(), but we have no pci host dr=
iver
> here, and I found no devm_kzalloc() uses in core PCI code before.
>=20
> >=20
> >> +=09if (!resources) {
> >> +=09=09/* Use default IO/MEM/BUS resources*/
> >> +=09=09pci_add_resource(&host->windows, &ioport_resource);
> >> +=09=09pci_add_resource(&host->windows, &iomem_resource);
> >> +=09=09pci_add_resource(&host->windows, &busn_resource);
> >> +=09} else {
> >> +=09=09list_for_each_entry_safe(window, n, resources, list)
> >> +=09=09=09list_move_tail(&window->list, &host->windows);
> >> +=09}
> >=20
> > I think we should assume that the correct resources are passed. You
> > could add a wrapper around this function to convert old platforms
> > though.
>=20
> OK, I will move these code out of pci_create_host_bridge, and add a wrapp=
er
> to setup the default resources.
>=20
> >=20
> >> +EXPORT_SYMBOL(pci_create_host_bridge);
> >=20
> > EXPORT_SYMBOL_GPL() maybe?
>=20
> OK, will update it.
>=20
> >=20
> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> index 8b11b38..daa7f40 100644
> >> --- a/include/linux/pci.h
> >> +++ b/include/linux/pci.h
> >> @@ -402,7 +402,12 @@ struct pci_host_bridge_window {
> >>  struct pci_host_bridge {
> >>  =09struct device dev;
> >>  =09struct pci_bus *bus;=09=09/* root bus */
> >> +=09struct list_head list;
> >>  =09struct list_head windows;=09/* pci_host_bridge_windows */
> >> +=09int busnum;
> >=20
> > The busnum should already be implied through the bus resource.
>=20
> Yes, I will consider remove it and introduce a helper function to get the=
 root bus number, thanks!
>=20
> Thanks!
> Yijing.
>=20
> >=20
> > =09Arnd
> >=20
> > .
> >=20
>=20
>=20
> --=20
> Thanks!
> Yijing
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
