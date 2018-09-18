Return-Path: <s.miroshnichenko@yadro.com>
Received: from mta-01.yadro.com (mta-01.yadro.com [89.207.88.251])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42F4Ry0sGlzDrYb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 00:02:05 +1000 (AEST)
Subject: Re: [PATCH RFC 1/4] PCI: hotplug: Add parameter to put devices to
 reset during rescan
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Sam Bobroff <sbobroff@linux.ibm.com>, <linux-pci@vger.kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, <linux@yadro.com>, Russell Currey
 <ruscur@russell.cc>, <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Oliver OHalloran <oliveroh@au1.ibm.com>
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
 <20180914161404.4685-2-s.miroshnichenko@yadro.com>
 <20180917052800.GA7315@tungsten.ozlabs.ibm.com>
 <6b913e12-e8c8-30c1-5269-3029ddb00a4d@yadro.com>
 <20180917225935.GD54859@bhelgaas-glaptop.roam.corp.google.com>
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Message-ID: <b3963047-e3c1-5612-1bcf-04c9e81dacd2@yadro.com>
Date: Tue, 18 Sep 2018 17:01:48 +0300
MIME-Version: 1.0
In-Reply-To: <20180917225935.GD54859@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tlNV1XGAhwoTEPetrXOQN7aml4oaUfAi4"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--tlNV1XGAhwoTEPetrXOQN7aml4oaUfAi4
Content-Type: multipart/mixed; boundary="7Vy8payCoyDT1WiSI4w2sEwMulfFIfasz";
 protected-headers="v1"
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sam Bobroff <sbobroff@linux.ibm.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux@yadro.com,
 Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Oliver OHalloran <oliveroh@au1.ibm.com>
Message-ID: <b3963047-e3c1-5612-1bcf-04c9e81dacd2@yadro.com>
Subject: Re: [PATCH RFC 1/4] PCI: hotplug: Add parameter to put devices to
 reset during rescan
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
 <20180914161404.4685-2-s.miroshnichenko@yadro.com>
 <20180917052800.GA7315@tungsten.ozlabs.ibm.com>
 <6b913e12-e8c8-30c1-5269-3029ddb00a4d@yadro.com>
 <20180917225935.GD54859@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180917225935.GD54859@bhelgaas-glaptop.roam.corp.google.com>

--7Vy8payCoyDT1WiSI4w2sEwMulfFIfasz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/18/18 1:59 AM, Bjorn Helgaas wrote:
> [+cc Russell, Ben, Oliver, linuxppc-dev]
>=20
> On Mon, Sep 17, 2018 at 11:55:43PM +0300, Sergey Miroshnichenko wrote:
>> Hello Sam,
>>
>> On 9/17/18 8:28 AM, Sam Bobroff wrote:
>>> Hi Sergey,
>>>
>>> On Fri, Sep 14, 2018 at 07:14:01PM +0300, Sergey Miroshnichenko wrote=
:
>>>> Introduce a new command line option "pci=3Dpcie_movable_bars" that i=
ndicates
>>>> support of PCIe hotplug without prior reservation of memory regions =
by
>>>> BIOS/bootloader.
>>>>
>>>> If a new PCIe device has been hot-plugged between two active ones, w=
hich
>>>> have no (or not big enough) gap between their BARs, allocating new B=
ARs
>>>> requires to move BARs of the following working devices:
>>>>
>>>> 1)                   dev 4
>>>>                        |
>>>>                        v
>>>> .. |  dev 3  |  dev 3  |  dev 5  |  dev 7  |
>>>> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
>>>>
>>>> 2)                             dev 4
>>>>                                  |
>>>>                                  v
>>>> .. |  dev 3  |  dev 3  | -->           --> |  dev 5  |  dev 7  |
>>>> .. |  BAR 0  |  BAR 1  | -->           --> |  BAR 0  |  BAR 0  |
>>>>
>>>> 3)
>>>>
>>>> .. |  dev 3  |  dev 3  |  dev 4  |  dev 4  |  dev 5  |  dev 7  |
>>>> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
>>>>
>>>> Not only BARs, but also bridge windows can be updated during a PCIe =
rescan,
>>>> threatening all memory transactions during this procedure, so the PC=
I
>>>> subsystem will instruct the drivers to pause by calling the reset_pr=
epare()
>>>> and reset_done() callbacks.
>>>>
>>>> If a device may be affected by BAR movement, the BAR changes trackin=
g must
>>>> be implemented in its driver.
>>>>
>>>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>>>> ---
>>>>  .../admin-guide/kernel-parameters.txt         |  6 +++
>>>>  drivers/pci/pci.c                             |  2 +
>>>>  drivers/pci/probe.c                           | 43 ++++++++++++++++=
+++
>>>>  include/linux/pci.h                           |  1 +
>>>>  4 files changed, 52 insertions(+)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docum=
entation/admin-guide/kernel-parameters.txt
>>>> index 64a3bf54b974..f8132a709061 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -3311,6 +3311,12 @@
>>>>  				bridges without forcing it upstream. Note:
>>>>  				this removes isolation between devices and
>>>>  				may put more devices in an IOMMU group.
>>>> +		pcie_movable_bars	Arrange a space at runtime for BARs of
>>>> +				hotplugged PCIe devices - usable if bootloader
>>>> +				doesn't reserve memory regions for them. Freeing
>>>> +				a space may require moving BARs of active devices
>>>> +				to higher addresses, so device drivers will be
>>>> +				paused during rescan.
>>>> =20
>>>>  	pcie_aspm=3D	[PCIE] Forcibly enable or disable PCIe Active State P=
ower
>>>>  			Management.
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index 1835f3a7aa8d..5f07a59b5924 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -6105,6 +6105,8 @@ static int __init pci_setup(char *str)
>>>>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>>>>  			} else if (!strncmp(str, "disable_acs_redir=3D", 18)) {
>>>>  				disable_acs_redir_param =3D str + 18;
>>>> +			} else if (!strncmp(str, "pcie_movable_bars", 17)) {
>>>> +				pci_add_flags(PCI_MOVABLE_BARS);
>>>>  			} else {
>>>>  				printk(KERN_ERR "PCI: Unknown option `%s'\n",
>>>>  						str);
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index 201f9e5ff55c..bdaafc48dc4c 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -3138,6 +3138,45 @@ unsigned int pci_rescan_bus_bridge_resize(str=
uct pci_dev *bridge)
>>>>  	return max;
>>>>  }
>>>> =20
>>>> +/*
>>>> + * Put all devices of the bus and its children to reset
>>>> + */
>>>> +static void pci_bus_reset_prepare(struct pci_bus *bus)
>>>> +{
>>>> +	struct pci_dev *dev;
>>>> +
>>>> +	list_for_each_entry(dev, &bus->devices, bus_list) {
>>>> +		struct pci_bus *child =3D dev->subordinate;
>>>> +
>>>> +		if (child) {
>>>> +			pci_bus_reset_prepare(child);
>>>> +		} else if (dev->driver &&
>>>> +			   dev->driver->err_handler &&
>>>> +			   dev->driver->err_handler->reset_prepare) {
>>>> +			dev->driver->err_handler->reset_prepare(dev);
>>>> +		}
>>>
>>> What about devices with drivers that don't have reset_prepare()?  It
>>> looks like it will just reconfigure them anyway. Is that right?
>>>
>>
>> It is possible that unprepared driver without these hooks will get BAR=
s
>> moved, I should put a warning message there. There three ways we can s=
ee
>> to make this safe:
>>  - add the reset_prepare()/reset_done() hooks to *every* PCIe driver;
>>  - refuse BAR movement if at least one unprepared driver has been
>> encountered during rescan;
>>  - reduce the number of drivers which can be affected to some
>> controllable value and prepare them on demand.
>>
>> Applying the second proposal as a major restriction seems fairly
>> reasonable, but for our particular setups and use-cases it is probably=

>> too stiff:
>>  - we've noticed that devices connected directly to the root bridge
>> don't get moved BARs, and this covers our x86_64 servers: we only
>> insert/remove devices into "second-level" and "lower" bridges there, b=
ut
>> not root;
>>  - on PowerNV we have system devices (network interfaces, USB hub, etc=
=2E)
>> grouped into dedicated domain, with all other domains ready for hotplu=
g,
>> and only these domains can be rescanned.
>>
>> With our scenarios currently reduced to these two, we can live with ju=
st
>> a few drivers "prepared" for now: NVME and few Ethernet adapters, this=

>> gives us a possibility to use this feature before "converting" *all* t=
he
>> drivers, and even have the NVidia cards running on a closed proprietar=
y
>> driver.
>>
>> Should we make this behavior adjustable with something like
>> "pcie_movable_bars=3Dsafe" and "pcie_movable_bars=3Dalways" ?
>=20
> I like the overall idea of this a lot.
>=20
>   - Why do we need a command line parameter to enable this?  Can't we
>     do it unconditionally and automatically when it's possible?  We
>     could have a chicken switch to *disable* it in case this breaks
>     something horribly, but I would like this functionality to be
>     always available without a special option.
>=20

After making this feature completely safe we could activate it with the
existing option "pci=3Drealloc".

>   - I'm not sure the existence of .reset_done() is evidence that a
>     driver is prepared for its BARs to move.  I don't see any
>     documentation that refers to BAR movement, and I doubt it's been
>     tested.  But I only see 5 implementations in the tree, so it'd be
>     easy to verify.
>    =20

You are right, and we should clarify the description:
 - drivers which have the .reset_done() already - none of them are aware
of movable BARs yet;
 - the rest of the drivers should both be able to pause and handle the
changes in BARs.

>   - I think your second proposal above sounds right: we should regard
>     any device whose driver lacks .reset_done() as immovable.  We will
>     likely be able to move some devices but not others.  Implementing
>     .reset_done() will increase flexibility but it shouldn't be a
>     requirement for all drivers.
>=20

Thanks for the advice! This is more flexible and doesn't have any
prerequisites. In this case the greater the "movable"/"immovable" ratio
of the devices that was working before the hotplug event - the higher
the probability to free some space for new BARs. But even a single
"immovable" device at an undesirable place can block the re-arrangement,
in this case all we can is just give up and print an error message.

This patchset in its current form doesn't support marking a choosen BAR
as immovable (just releasing all the resources of the root bridge and
trying to sort and re-assign them back), so I'll have to implement that.

Best regards,
Serge

>>>> +	}
>>>> +}
>>>> +
>>>> +/*
>>>> + * Complete the reset of all devices for the bus and its children
>>>> + */
>>>> +static void pci_bus_reset_done(struct pci_bus *bus)
>>>> +{
>>>> +	struct pci_dev *dev;
>>>> +
>>>> +	list_for_each_entry(dev, &bus->devices, bus_list) {
>>>> +		struct pci_bus *child =3D dev->subordinate;
>>>> +
>>>> +		if (child) {
>>>> +			pci_bus_reset_done(child);
>>>> +		} else if (dev->driver && dev->driver->err_handler &&
>>>> +			   dev->driver->err_handler->reset_done) {
>>>> +			dev->driver->err_handler->reset_done(dev);
>>>> +		}
>>>> +	}
>>>> +}
>>>> +
>>>>  /**
>>>>   * pci_rescan_bus - Scan a PCI bus for devices
>>>>   * @bus: PCI bus to scan
>>>> @@ -3151,8 +3190,12 @@ unsigned int pci_rescan_bus(struct pci_bus *b=
us)
>>>>  {
>>>>  	unsigned int max;
>>>> =20
>>>> +	if (pci_has_flag(PCI_MOVABLE_BARS))
>>>> +		pci_bus_reset_prepare(bus);
>>>>  	max =3D pci_scan_child_bus(bus);
>>>>  	pci_assign_unassigned_bus_resources(bus);
>>>> +	if (pci_has_flag(PCI_MOVABLE_BARS))
>>>> +		pci_bus_reset_done(bus);
>>>>  	pci_bus_add_devices(bus);
>>>> =20
>>>>  	return max;
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index 6925828f9f25..a8cb1a367c34 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -847,6 +847,7 @@ enum {
>>>>  	PCI_ENABLE_PROC_DOMAINS	=3D 0x00000010,	/* Enable domains in /proc=
 */
>>>>  	PCI_COMPAT_DOMAIN_0	=3D 0x00000020,	/* ... except domain 0 */
>>>>  	PCI_SCAN_ALL_PCIE_DEVS	=3D 0x00000040,	/* Scan all, not just dev 0=
 */
>>>> +	PCI_MOVABLE_BARS	=3D 0x00000080,	/* Runtime BAR reassign after hot=
plug */
>>>>  };
>>>> =20
>>>>  /* These external functions are only available when PCI support is =
enabled */
>>>> --=20
>>>> 2.17.1
>>>>


--7Vy8payCoyDT1WiSI4w2sEwMulfFIfasz--

--tlNV1XGAhwoTEPetrXOQN7aml4oaUfAi4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEHW7T7ovP/cFp8+b3DHQ+aNFTs7UFAluhBUwACgkQDHQ+aNFT
s7VF9RAAqghiMGCNEAXXoxzTjbtmIcY2ZC7fVGr9XS8fAJ+ODBaMid2Szm4+vmzf
24AT7PtsNCheTaLh1TYSdodFwnCk4mVy15E5vnpI/iURJQeYB5yl2hB4AQ7ld/nb
nkKaUf1YGc+Yp+U+iEoJ0QA+wauKdXXgbn96NClBmYnzUPMIZsFFH552l2gBurLo
9GPCqPpY3d4jiGJchhSrHbsgYQ6ElBLOax+eJQKgSEp/x8Ovsfi1nFhGc9jmEF4C
bjw+jBMA2RcBJ0CYqCG4qZJsnEwCndMNqSDDAJGBuHsC169jbRgLR2Q81l1B8+yE
mUZd5l5pMXQwHM4QxD4ozquFIM4o/Cx4w0StPriazQUumgCGG6MhRJ+IdXozBgeb
+JED9iZ2ffGlz6FkQbmhMEdS1Bbi+N3cqa5JIL/6Cj9ILzx+qk9/diX54YkzKrBH
FQGhyl0vTjUNJvxcRU6kkXkmoVm6VCeQ3WxrYG6l15xDfN0s5+JpXOaO6HGO5fTe
VKkJ0KSJzFeedn0dg2oBmGPM+Py4zwcjh97Td7lvoZeZp3lY/rohxKUBGHxItlOS
SgKR40d3ZnPPdIzf8eTgoPP0hABsoKvzvylWIO8z0U/Kcuq33tLOLoG438/FVnaF
IYQvwULYIHel75qcXNflY9lsewNqs8SjlmUHh0cuGV7c6zP/jMc=
=oYBH
-----END PGP SIGNATURE-----

--tlNV1XGAhwoTEPetrXOQN7aml4oaUfAi4--
