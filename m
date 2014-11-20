Return-Path: <liviu.dudau@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by lists.ozlabs.org (Postfix) with ESMTP id 4459B1A028E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 20:47:49 +1100 (AEDT)
Date: Thu, 20 Nov 2014 09:47:41 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [RFC PATCH 07/16] PCI: Separate pci_host_bridge creation out of
 pci_create_root_bus()
Message-ID: <20141120094741.GA17214@e106497-lin.cambridge.arm.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <1416219710-26088-8-git-send-email-wangyijing@huawei.com>
 <20141118153020.GL12037@e106497-lin.cambridge.arm.com>
 <546BF59C.8060203@huawei.com>
 <20141119163726.GW12037@e106497-lin.cambridge.arm.com>
 <546D5647.8030401@huawei.com>
MIME-Version: 1.0
In-Reply-To: <546D5647.8030401@huawei.com>
Content-Type: text/plain; charset=UTF-8
Cc: Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>,
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

On Thu, Nov 20, 2014 at 02:47:35AM +0000, Yijing Wang wrote:
> >>>> +static void pci_release_host_bridge_dev(struct device *dev)
> >>>> +{
> >>>> +       struct pci_host_bridge *bridge =3D to_pci_host_bridge(dev);
> >>>> +
> >>>> +       if (bridge->release_fn)
> >>>> +               bridge->release_fn(bridge);
> >>>> +       pci_free_resource_list(&bridge->windows);
> >>>> +       kfree(bridge);
> >>>> +}
> >>>> +
> >>>> +struct pci_host_bridge *pci_create_host_bridge(
> >>>> +               struct device *parent, u32 db,
> >>>> +               struct pci_ops *ops, void *sysdata,
> >>>
> >>> I don't thinks it is worth moving the buses' pci_ops into pci_host_br=
idge. It
> >>> might be more useful to have pci_host_bridge specific ops here.
> >>
> >> Because we want to create pci_host_bridge before pci root bus creation=
,
> >> so when we scan the root bus and child buses, we use pci_host_bridge a=
s
> >> the only argument, and another pci_host_info will be addes in later pa=
tch,
> >> which one support carry the pci_host_bridge ops.
> >
> > But pci_create_root_bus() already has a pci_ops argument, I don't see t=
he reason
> > to drop that.
> >
> > pci_create_host_bridge() can get pci_host_bridge ops while pci_create_r=
oot_bus() gets
> > the bus ops. For find out the MSI controller, the domain number and any=
 other HB
> > specific stuff, you use the HB ops. For config R/W acceses you use bus =
ops.
> >
>=20
> I want to unexport pci_create_root_bus() if we have pci_create_host_bridg=
e().

That's fine, but the function signature doesn't change, right? And I think =
we should keep
pci_scan_root_bus() with the current signature as well (except change sysda=
ta into a
struct pci_host_bridge *). We create the host bridge in one step, stuff it =
with all the
data that we need for scanning the root and associated busses, and then cal=
l pci_scan_root_bus().
pci_host_bridge has the ops from pci_create_host_bridge() and the root bus =
from pci_scan_root_bus().

Hope this makes sense.

>=20
>=20
> >>>> -struct pci_bus *pci_create_root_bus(struct device *parent, u32 db,
> >>>> -               struct pci_ops *ops, void *sysdata, struct list_head=
 *resources)
> >>>> +struct pci_bus *__pci_create_root_bus(struct pci_host_bridge *bridg=
e)
> >>>>  {
> >>>>         int error;
> >>>> -       struct pci_host_bridge *bridge;
> >>>>         struct pci_bus *b, *b2;
> >>>> -       struct pci_host_bridge_window *window, *n;
> >>>> +       struct pci_host_bridge_window *window;
> >>>>         struct resource *res;
> >>>>         resource_size_t offset;
> >>>>         char bus_addr[64];
> >>>>         char *fmt;
> >>>> -       u8      bus =3D PCI_BUSNUM(db);
> >>>> +       struct device *parent =3D bridge->dev.parent;
> >>>>
> >>>>         b =3D pci_alloc_bus(NULL);
> >>>>         if (!b)
> >>>>                 return NULL;
> >>>>
> >>>> -       b->sysdata =3D sysdata;
> >>>> -       b->ops =3D ops;
> >>>> -       b->number =3D b->busn_res.start =3D bus;
> >>>> +       b->sysdata =3D bridge->sysdata;
> >>>
> >>> I think bridge should be the b->sysdata here.
> >>
> >> ? what's the meaning?
> >
> > Currently, bus->sysdata holds a pointer to the arch/driver host bridge =
structure, as passed
> > in pci_create_root_bus(). If you agree with my idea of wrapping the hos=
t bridge driver
> > structure around the pci_host_bridge, then we will always have a way of=
 retrieving that
> > information; but for backwards compatibility we could set bus->sysdata =
to be the bridge.
> > Then existing macros that convert sysdata to pci_controller can be reus=
ed after being
> > updated.
>=20
> I think wrapping the host bridge driver structure around the pci_host_bri=
dge could help
> us to find the private pci_controller, but in this case, pci_host_bridge =
is not a pointer
> so we put all pci_host_bridge init stuff in host drivers ?=20

Of course we put pci_host_bridge init *calls* in the host drivers because w=
e need to do host
driver specific initialisation there anyway.=20

> And if we still use arch spec
> macros convert ssydata to pci_controller, so what's the greatest advantag=
e ?

Agree, the macro is not useful unless we have a common pci_controller struc=
ture. Sorry about
the noise.

>=20
> If we move domain and msi_chip out of sysdata, what's other things in sys=
data still need us
> to convert in PCI core ?

I've never said we need to keep sysdata. From my discussion with Bjorn a ye=
ar ago the idea was
to put the sysdata members into pci_host_bridge structure and remove sysdat=
a member from pci_bus.
pci_scan_root_bus() can still get a parameter called sysdata if we want, bu=
t it will be a
struct pci_host_bridge * type.

Best regards,
Liviu

>=20
>=20
>=20
> >
> > Best regards,
> > Liviu
> >
> >>
> >>>
> >>>> +       b->ops =3D bridge->ops;
> >>>
> >>> See comment above why I don't think this is necessary.
> >>>
> >>>> +       b->number =3D b->busn_res.start =3D bridge->busnum;
> >>>>         pci_bus_assign_domain_nr(b, parent);
> >>>> -       b2 =3D pci_find_bus(pci_domain_nr(b), bus);
> >>>> +       bridge->domain =3D pci_domain_nr(b);
> >>>
> >>> Do you really want to overwrite the bridge's domain with the one from=
 a bus that
> >>> could possibly be rejected a couple of lines further down?
> >>>
> >>> As an asside: if we are doing the split of pci_host_bridge from root =
bus creation
> >>> it is worth in my opinion to move the domain setup in pci_create_host=
_bridge()
> >>> and stop fiddling with it here.
> >>
> >>
> >> Hi Liviu, these lines just temporary, I will remove it after all host =
drivers
> >> save its domain in pci_host_bridge.
> >>
> >>
> >>>
> >>> Otherwise it looks to me like you are heading in the right direction.
> >>
> >> Thanks!
> >> Yijing.
> >>
> >>>
> >>> Best regards,
> >>> Liviu
> >>>
> >>>> +       b2 =3D pci_find_bus(pci_domain_nr(b), bridge->busnum);
> >>>>         if (b2) {
> >>>>                 /* If we already got to this bus through a different=
 bridge, ignore it */
> >>>>                 dev_dbg(&b2->dev, "bus already known\n");
> >>>>                 goto err_out;
> >>>>         }
> >>>>
> >>>> -       bridge =3D pci_alloc_host_bridge(b);
> >>>> -       if (!bridge)
> >>>> -               goto err_out;
> >>>> -
> >>>> -       bridge->dev.parent =3D parent;
> >>>> -       bridge->dev.release =3D pci_release_host_bridge_dev;
> >>>> -       dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b),=
 bus);
> >>>> -       error =3D pcibios_root_bridge_prepare(bridge);
> >>>> -       if (error) {
> >>>> -               kfree(bridge);
> >>>> -               goto err_out;
> >>>> -       }
> >>>> -
> >>>> -       error =3D device_register(&bridge->dev);
> >>>> -       if (error) {
> >>>> -               put_device(&bridge->dev);
> >>>> -               goto err_out;
> >>>> -       }
> >>>>         b->bridge =3D get_device(&bridge->dev);
> >>>>         device_enable_async_suspend(b->bridge);
> >>>>         pci_set_bus_of_node(b);
> >>>> @@ -1950,7 +1899,7 @@ struct pci_bus *pci_create_root_bus(struct dev=
ice *parent, u32 db,
> >>>>
> >>>>         b->dev.class =3D &pcibus_class;
> >>>>         b->dev.parent =3D b->bridge;
> >>>> -       dev_set_name(&b->dev, "%04x:%02x", pci_domain_nr(b), bus);
> >>>> +       dev_set_name(&b->dev, "%04x:%02x", pci_domain_nr(b), b->numb=
er);
> >>>>         error =3D device_register(&b->dev);
> >>>>         if (error)
> >>>>                 goto class_dev_reg_err;
> >>>> @@ -1966,12 +1915,11 @@ struct pci_bus *pci_create_root_bus(struct d=
evice *parent, u32 db,
> >>>>                 printk(KERN_INFO "PCI host bridge to bus %s\n", dev_=
name(&b->dev));
> >>>>
> >>>>         /* Add initial resources to the bus */
> >>>> -       list_for_each_entry_safe(window, n, resources, list) {
> >>>> -               list_move_tail(&window->list, &bridge->windows);
> >>>> +       list_for_each_entry(window, &bridge->windows, list) {
> >>>>                 res =3D window->res;
> >>>>                 offset =3D window->offset;
> >>>>                 if (res->flags & IORESOURCE_BUS)
> >>>> -                       pci_bus_insert_busn_res(b, bus, res->end);
> >>>> +                       pci_bus_insert_busn_res(b, b->number, res->e=
nd);
> >>>>                 else
> >>>>                         pci_bus_add_resource(b, res, 0);
> >>>>                 if (offset) {
> >>>> @@ -2001,6 +1949,25 @@ err_out:
> >>>>         return NULL;
> >>>>  }
> >>>>
> >>>> +struct pci_bus *pci_create_root_bus(struct device *parent, u32 bus,
> >>>> +               struct pci_ops *ops, void *sysdata, struct list_head=
 *resources)
> >>>> +{
> >>>> +       struct pci_host_bridge *host;
> >>>> +
> >>>> +       host =3D pci_create_host_bridge(parent, bus, ops,
> >>>> +                       sysdata ,resources);
> >>>> +       if (!host)
> >>>> +               return NULL;
> >>>> +
> >>>> +       host->bus =3D __pci_create_root_bus(host);
> >>>> +       if (!host->bus) {
> >>>> +               pci_free_host_bridge(host);
> >>>> +               return NULL;
> >>>> +       }
> >>>> +
> >>>> +       return host->bus;
> >>>> +}
> >>>> +
> >>>>  int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max=
)
> >>>>  {
> >>>>         struct resource *res =3D &b->busn_res;
> >>>> @@ -2069,40 +2036,37 @@ struct pci_bus *pci_scan_root_bus(struct dev=
ice *parent, u32 db,
> >>>>  {
> >>>>         struct pci_host_bridge_window *window;
> >>>>         bool found =3D false;
> >>>> -       struct pci_bus *b;
> >>>> -       LIST_HEAD(default_res);
> >>>> +       struct pci_host_bridge *host;
> >>>>         int max;
> >>>>
> >>>> -       if (!resources) {
> >>>> -               pci_add_resource(&default_res, &ioport_resource);
> >>>> -               pci_add_resource(&default_res, &iomem_resource);
> >>>> -               pci_add_resource(&default_res, &busn_resource);
> >>>> -       } else {
> >>>> -               list_for_each_entry(window, resources, list)
> >>>> -                       if (window->res->flags & IORESOURCE_BUS) {
> >>>> -                               found =3D true;
> >>>> -                               break;
> >>>> -                       }
> >>>> -       }
> >>>> +       host =3D pci_create_host_bridge(parent, db, ops, sysdata, re=
sources);
> >>>> +       if (!host)
> >>>> +               return NULL;
> >>>>
> >>>> -       b =3D pci_create_root_bus(parent, db, ops, sysdata,
> >>>> -                       resources ? resources : &default_res);
> >>>> -       if (!b)
> >>>> +       list_for_each_entry(window, &host->windows, list)
> >>>> +               if (window->res->flags & IORESOURCE_BUS) {
> >>>> +                       found =3D true;
> >>>> +                       break;
> >>>> +               }
> >>>> +
> >>>> +       host->bus =3D __pci_create_root_bus(host);
> >>>> +       if (!host->bus) {
> >>>> +               pci_free_host_bridge(host);
> >>>>                 return NULL;
> >>>> +       }
> >>>>
> >>>>         if (!found) {
> >>>> -               dev_info(&b->dev,
> >>>> +               dev_info(&host->bus->dev,
> >>>>                  "No busn resource found for root bus, will use [bus=
 %02x-ff]\n",
> >>>>                         PCI_BUSNUM(db));
> >>>> -               pci_bus_insert_busn_res(b, PCI_BUSNUM(db), 255);
> >>>> +               pci_bus_insert_busn_res(host->bus, PCI_BUSNUM(db), 2=
55);
> >>>>         }
> >>>>
> >>>> -       max =3D pci_scan_child_bus(b);
> >>>> -
> >>>> +       max =3D pci_scan_child_bus(host->bus);
> >>>>         if (!found)
> >>>> -               pci_bus_update_busn_res_end(b, max);
> >>>> +               pci_bus_update_busn_res_end(host->bus, max);
> >>>>
> >>>> -       return b;
> >>>> +       return host->bus;
> >>>>  }
> >>>>  EXPORT_SYMBOL(pci_scan_root_bus);
> >>>>
> >>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >>>> index 8b11b38..daa7f40 100644
> >>>> --- a/include/linux/pci.h
> >>>> +++ b/include/linux/pci.h
> >>>> @@ -402,7 +402,12 @@ struct pci_host_bridge_window {
> >>>>  struct pci_host_bridge {
> >>>>         struct device dev;
> >>>>         struct pci_bus *bus;            /* root bus */
> >>>> +       struct list_head list;
> >>>>         struct list_head windows;       /* pci_host_bridge_windows *=
/
> >>>> +       int busnum;
> >>>> +       int domain;
> >>>> +       void *sysdata;
> >>>> +       struct pci_ops *ops;
> >>>>         void (*release_fn)(struct pci_host_bridge *);
> >>>>         void *release_data;
> >>>>  };
> >>>> @@ -413,7 +418,9 @@ void pci_set_host_bridge_release(struct pci_host=
_bridge *bridge,
> >>>>                      void *release_data);
> >>>>
> >>>>  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
> >>>> -
> >>>> +struct pci_host_bridge *pci_create_host_bridge(
> >>>> +               struct device *parent, u32 db, struct pci_ops *ops,
> >>>> +               void *sys, struct list_head *resources);
> >>>>  /*
> >>>>   * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that =
correspond
> >>>>   * to P2P or CardBus bridge windows) go in a table.  Additional one=
s (for
> >>>> @@ -770,6 +777,8 @@ void pci_bus_add_devices(const struct pci_bus *b=
us);
> >>>>  struct pci_bus *pci_create_root_bus(struct device *parent, u32 bus,
> >>>>                                     struct pci_ops *ops, void *sysda=
ta,
> >>>>                                     struct list_head *resources);
> >>>> +struct pci_bus *__pci_create_root_bus(struct pci_host_bridge *host)=
;
> >>>> +void pci_free_host_bridge(struct pci_host_bridge *host);
> >>>>  int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax)=
;
> >>>>  int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
> >>>>  void pci_bus_release_busn_res(struct pci_bus *b);
> >>>> --
> >>>> 1.7.1
> >>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe linux-pci"=
 in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>
> >>>
> >>
> >>
> >> --
> >> Thanks!
> >> Yijing
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-pci" i=
n
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
>=20
>=20
> --
> Thanks!
> Yijing
>=20
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
