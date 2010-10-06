Return-Path: <jacob.gorelik@jpl.nasa.gov>
Received: from mail.jpl.nasa.gov (mailhost.jpl.nasa.gov [128.149.139.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.jpl.nasa.gov",
	Issuer "VeriSign Class 3 Secure Server CA - G2" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BD009B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 09:57:37 +1100 (EST)
Received: from mail.jpl.nasa.gov (altvirehtstap01.jpl.nasa.gov
	[128.149.137.72])
	by smtp.jpl.nasa.gov (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	o96MstbH002635
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128 bits) verified FAIL)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Oct 2010 15:57:28 -0700
From: "Gorelik, Jacob (335F)" <jacob.gorelik@jpl.nasa.gov>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 6 Oct 2010 15:56:51 -0700
Subject: Re: Linuxppc-dev Digest, Vol 74, Issue 31
Message-ID: <8CFC3257-A2A5-4C64-9C5F-4BF6BD9A6BCB@jpl.nasa.gov>
References: <mailman.1656.1286390250.3010.linuxppc-dev@lists.ozlabs.org>
In-Reply-To: <mailman.1656.1286390250.3010.linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

In start_kernel function, locked_initial() is called; however, it does not =
do anything. Is it not needed?

Thank you,
Jacob


On Oct 6, 2010, at 11:38 AM, "linuxppc-dev-request@lists.ozlabs.org" <linux=
ppc-dev-request@lists.ozlabs.org> wrote:

> Send Linuxppc-dev mailing list submissions to
>        linuxppc-dev@lists.ozlabs.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>        https://lists.ozlabs.org/listinfo/linuxppc-dev
> or, via email, send a message with subject or body 'help' to
>        linuxppc-dev-request@lists.ozlabs.org
>
> You can reach the person managing the list at
>        linuxppc-dev-owner@lists.ozlabs.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-dev digest..."
>
>
> Today's Topics:
>
>   1. MPC8641D PCI Endpoint incoming interrupts?
>      (david.hagood@gmail.com)
>   2. Re: powerpc, fs_enet: scanning PHY after Linux is up
>      (Grant Likely)
>   3. Re: powerpc, fs_enet: scanning PHY after Linux is up
>      (Grant Likely)
>   4. [PATCH v5 0/2] powerpc: add support for new hcall
>      H_BEST_ENERGY (Vaidyanathan Srinivasan)
>   5. [PATCH v5 1/2] powerpc: cleanup APIs for cpu/thread/core
>      mappings (Vaidyanathan Srinivasan)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Wed, 6 Oct 2010 11:20:11 -0500
> From: david.hagood@gmail.com
> To: linuxppc-dev@lists.ozlabs.org
> Subject: MPC8641D PCI Endpoint incoming interrupts?
> Message-ID: <56e21593e98493b02bcda171b200241a.squirrel@localhost>
> Content-Type: text/plain;charset=3Diso-8859-1
>
> I'm trying to use an MPC8641D as a PCIe endpoint device, and I'm trying t=
o
> work out how the host root complex CPU can interrupt the PPC core. It's
> not very clear how to do all of this, and I'd like some help fitting the
> pieces together. If there's a good how-to online I've yet to find it.
>
> As I read it, on the host side, I'd do one of:
> 1) a write to the PPC's BAR0, offset 0x41400 (MSGR0) with some message va=
lue
> 2) a write to BAR0 offset 0x41600 (MSIR0) and set a bit within it.
> 3) a write to 0x41740 (MSIIR) to set a bit in MSIR0
>
> So question #1 is "which of those should I use?" (or should I use
> something else?)
>
> Then, as I read it, I'd have to somehow convert the interrupt vector the
> PIC uses into a virtual interrupt number suitable for request_irq. I've
> seen mentions of irq_of_parse_and_map(), but I've not found a good
> description of how to use it. Does anybody have any (non-null) pointers o=
n
> this?
>
> Once I get to request_irq I'm on familiar ground.
>
>
>
>
> ------------------------------
>
> Message: 2
> Date: Wed, 6 Oct 2010 10:52:52 -0600
> From: Grant Likely <grant.likely@secretlab.ca>
> To: hs@denx.de
> Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
>        Holger Brunck <holger.brunck@keymile.com>,      Detlev Zundel
>        <dzu@denx.de>, netdev@vger.kernel.org
> Subject: Re: powerpc, fs_enet: scanning PHY after Linux is up
> Message-ID:
>        <AANLkTi=3DGkkD_-Vu-NswNedhgVuPaYePOHWa_2ytQgMf_@mail.gmail.com>
> Content-Type: text/plain; charset=3DISO-8859-1
>
> On Wed, Oct 6, 2010 at 3:53 AM, Heiko Schocher <hs@denx.de> wrote:
>> Hello Grant,
>>
>> Thanks for your answer!
>>
>> Grant Likely wrote:
>>> On Mon, Oct 4, 2010 at 1:32 AM, Heiko Schocher <hs@denx.de> wrote:
>>>> Hello all,
>>>>
>>>> we have on the mgcoge arch/powerpc/boot/dts/mgcoge.dts 3 fs_enet
>>>> devices. The first is accessible on boot, and so get correct
>>>> probed and works fine. For the other two fs_enet devices the PHYs
>>>> are on startup in reset, and gets later, through userapplikations,
>>>> out of reset ... so, on bootup, this 2 fs_enet devices could
>>>> not detect the PHY in drivers/of/of_mdio.c of_mdiobus_register(),
>>>> and if we want to use them later, we get for example:
>>>>
>>>> -bash-3.2# ifconfig eth2 172.31.31.33
>>>> net eth2: Could not attach to PHY
>>>> SIOCSIFFLAGS: No such device
>>>>
>>>> So the problem is, that we cannot rescan the PHYs, if they are
>>>> accessible. Also we could not load the fs_enet driver as a module,
>>>> because the first port is used fix.
>>>>
>>>> So, first question which comes in my mind, is:
>>>>
>>>> Is detecting the phy in drivers/of/of_mdio.c of_mdiobus_register()
>>>> the right place, or should it not better be done, when really
>>>> using the port?
>>>>
>>>> But we found another way to solve this issue:
>>>>
>>>> After the PHYs are out of reset, we just have to rescan the PHYs
>>>> with (for example PHY with addr 1)
>>>>
>>>> err =3D mdiobus_scan(bus, 1);
>>>>
>>>> and
>>>>
>>>> of_find_node_by_path("/soc@f0000000/cpm@119c0/mdio@10d40/ethernet-phy@=
1");
>>>> of_node_get(np);
>>>> dev_archdata_set_node(&err->dev.archdata, np);
>>>>
>>>> but thats just a hack ...
>>>
>>> Yeah, that's a hack. ?It really needs to be done via the of_mdio
>>> mechanisms so that dt <--> phy_device linkages remain consistent.
>>
>> Yep, I know, thats the reason why I ask ;-)
>>
>>>> So, the question is, is there a possibility to solve this problem?
>>>>
>>>> If there is no standard option, what would be with adding a
>>>> "scan_phy" file in
>>>>
>>>> /proc/device-tree/soc\@f0000000/cpm\@119c0/mdio\@10d40
>>>> (or better destination?)
>>>>
>>>> which with we could rescan a PHY with
>>>> "echo addr > /proc/device-tree/soc\@f0000000/cpm\@119c0/mdio\@10d40/sc=
an_phy"
>>>> (so there is no need for using of_find_node_by_path(), as we should
>>>> ?have the associated device node here, and can step through the child
>>>> ?nodes with "for_each_child_of_node(np, child)" and check if reg =3D=
=3D addr)
>>>>
>>>> or shouldn;t be at least, if the phy couldn;t be found when opening
>>>> the port, retrigger a scanning, if the phy now is accessible?
>>>
>>> One option would be to still register a phy_device for each phy
>>> described in the device tree, but defer binding a driver to each phy
>>> that doesn't respond. ?Then at of_phy_find_device() time, if it
>>
>> Maybe I din;t get the trick, but the problem is, that
>> you can;t register a phy_device in drivers/of/of_mdio.c
>> of_mdiobus_register(), if the phy didn;t respond with the
>> phy_id ... and of_phy_find_device() is not (yet) used in fs_enet
>
> I'm suggesting modifying the phy layer so that it is possible to
> register a phy_device that doesn't (yet) respond.
>
>>> matches with a phy_device that isn't bound to a driver yet, then
>>> re-trigger the binding operation. ?At which point the phy id can be
>>> probed and the correct driver can be chosen. ?If binding succeeds,
>>> then return the phy_device handle. ?If not, then fail as it currently
>>> does.
>>
>> Wouldn;t it be good, just if we need a PHY (on calling fs_enet_open)
>> to look if there is one?
>>
>> Something like that (not tested):
>>
>> in drivers/net/fs_enet/fs_enet-main.c in fs_init_phy()
>> called from fs_enet_open():
>>
>> Do first:
>> phydev =3D ?of_phy_find_device(fep->fpi->phy_node);
>>
>> Look if there is a driver (phy_dev->drv =3D=3D NULL ?)
>>
>> If not, call new function
>> of_mdiobus_register_phy(mii_bus, fep->fpi->phy_node)
>> see below patch for it.
>>
>> If this succeeds, all is OK, and we can use this phy,
>> else ethernet not work.
>
> I don't like this approach because it muddies the concept of which
> device is actually responsible for managing the phys on the bus.  Is
> it managed by the mdio bus device or the Ethernet device?  It also has
> a potential race condition.  Whereas triggering a late driver bind
> will be safe.
>
> Alternately, I'd also be okay with a common method to trigger a
> reprobe of a particular phy from userspace, but I fear that would be a
> significantly more complex solution.
>
>>
>> !!just no idea, how to get mii_bus pointer ...
>
> You'd have to get the parent of the phy node, and then loop over all
> the registered mdio busses looking for a bus that uses that node.
>
>>
>> here the patch for the new function of_mdiobus_register_phy():
>>
>> diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
>> index b474833..7afbb0b 100644
>> --- a/drivers/of/of_mdio.c
>> +++ b/drivers/of/of_mdio.c
>> @@ -21,6 +21,51 @@
>> ?MODULE_AUTHOR("Grant Likely <grant.likely@secretlab.ca>");
>> ?MODULE_LICENSE("GPL");
>>
>> +int of_mdiobus_register_phy(struct mii_bus *mdio, struct device_node *c=
hild)
>> +{
>> + ? ? ? struct phy_device *phy;
>> + ? ? ? const __be32 *addr;
>> + ? ? ? int len;
>> + ? ? ? int rc;
>> +
>> + ? ? ? /* A PHY must have a reg property in the range [0-31] */
>> + ? ? ? addr =3D of_get_property(child, "reg", &len);
>> + ? ? ? if (!addr || len < sizeof(*addr) || *addr >=3D 32 || *addr < 0) =
{
>> + ? ? ? ? ? ? ? dev_err(&mdio->dev, "%s has invalid PHY address\n",
>> + ? ? ? ? ? ? ? ? ? ? ? child->full_name);
>> + ? ? ? ? ? ? ? return -1;
>> + ? ? ? }
>> +
>> + ? ? ? if (mdio->irq) {
>> + ? ? ? ? ? ? ? mdio->irq[*addr] =3D irq_of_parse_and_map(child, 0);
>> + ? ? ? ? ? ? ? if (!mdio->irq[*addr])
>> + ? ? ? ? ? ? ? ? ? ? ? mdio->irq[*addr] =3D PHY_POLL;
>> + ? ? ? }
>> +
>> + ? ? ? phy =3D get_phy_device(mdio, be32_to_cpup(addr));
>> + ? ? ? if (!phy || IS_ERR(phy)) {
>> + ? ? ? ? ? ? ? dev_err(&mdio->dev, "error probing PHY at address %i\n",
>> + ? ? ? ? ? ? ? ? ? ? ? *addr);
>> + ? ? ? ? ? ? ? return -2;
>> + ? ? ? }
>> + ? ? ? phy_scan_fixups(phy);
>> + ? ? ? /* Associate the OF node with the device structure so it
>> + ? ? ? ?* can be looked up later */
>> + ? ? ? of_node_get(child);
>> + ? ? ? dev_archdata_set_node(&phy->dev.archdata, child);
>> +
>> + ? ? ? /* All data is now stored in the phy struct; register it */
>> + ? ? ? rc =3D phy_device_register(phy);
>> + ? ? ? if (rc) {
>> + ? ? ? ? ? ? ? phy_device_free(phy);
>> + ? ? ? ? ? ? ? of_node_put(child);
>> + ? ? ? ? ? ? ? return -3;
>> + ? ? ? }
>> +
>> + ? ? ? dev_dbg(&mdio->dev, "registered phy %s at address %i\n",
>> + ? ? ? ? ? ? ? child->name, *addr);
>> +}
>> +
>> ?/**
>> ?* of_mdiobus_register - Register mii_bus and create PHYs from the devic=
e tree
>> ?* @mdio: pointer to mii_bus structure
>> @@ -31,7 +76,6 @@ MODULE_LICENSE("GPL");
>> ?*/
>> ?int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
>> ?{
>> - ? ? ? struct phy_device *phy;
>> ? ? ? ?struct device_node *child;
>> ? ? ? ?int rc, i;
>>
>> @@ -51,46 +95,7 @@ int of_mdiobus_register(struct mii_bus *mdio, struct =
device_node *np)
>>
>> ? ? ? ?/* Loop over the child nodes and register a phy_device for each o=
ne */
>> ? ? ? ?for_each_child_of_node(np, child) {
>> - ? ? ? ? ? ? ? const __be32 *addr;
>> - ? ? ? ? ? ? ? int len;
>> -
>> - ? ? ? ? ? ? ? /* A PHY must have a reg property in the range [0-31] */
>> - ? ? ? ? ? ? ? addr =3D of_get_property(child, "reg", &len);
>> - ? ? ? ? ? ? ? if (!addr || len < sizeof(*addr) || *addr >=3D 32 || *ad=
dr < 0) {
>> - ? ? ? ? ? ? ? ? ? ? ? dev_err(&mdio->dev, "%s has invalid PHY address\=
n",
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? child->full_name);
>> - ? ? ? ? ? ? ? ? ? ? ? continue;
>> - ? ? ? ? ? ? ? }
>> -
>> - ? ? ? ? ? ? ? if (mdio->irq) {
>> - ? ? ? ? ? ? ? ? ? ? ? mdio->irq[*addr] =3D irq_of_parse_and_map(child,=
 0);
>> - ? ? ? ? ? ? ? ? ? ? ? if (!mdio->irq[*addr])
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? mdio->irq[*addr] =3D PHY_POLL;
>> - ? ? ? ? ? ? ? }
>> -
>> - ? ? ? ? ? ? ? phy =3D get_phy_device(mdio, be32_to_cpup(addr));
>> - ? ? ? ? ? ? ? if (!phy || IS_ERR(phy)) {
>> - ? ? ? ? ? ? ? ? ? ? ? dev_err(&mdio->dev, "error probing PHY at addres=
s %i\n",
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? *addr);
>> - ? ? ? ? ? ? ? ? ? ? ? continue;
>> - ? ? ? ? ? ? ? }
>> - ? ? ? ? ? ? ? phy_scan_fixups(phy);
>> -
>> - ? ? ? ? ? ? ? /* Associate the OF node with the device structure so it
>> - ? ? ? ? ? ? ? ?* can be looked up later */
>> - ? ? ? ? ? ? ? of_node_get(child);
>> - ? ? ? ? ? ? ? dev_archdata_set_node(&phy->dev.archdata, child);
>> -
>> - ? ? ? ? ? ? ? /* All data is now stored in the phy struct; register it=
 */
>> - ? ? ? ? ? ? ? rc =3D phy_device_register(phy);
>> - ? ? ? ? ? ? ? if (rc) {
>> - ? ? ? ? ? ? ? ? ? ? ? phy_device_free(phy);
>> - ? ? ? ? ? ? ? ? ? ? ? of_node_put(child);
>> - ? ? ? ? ? ? ? ? ? ? ? continue;
>> - ? ? ? ? ? ? ? }
>> -
>> - ? ? ? ? ? ? ? dev_dbg(&mdio->dev, "registered phy %s at address %i\n",
>> - ? ? ? ? ? ? ? ? ? ? ? child->name, *addr);
>> + ? ? ? ? ? ? ? of_mdiobus_register_phy(mdio, child);
>> ? ? ? ?}
>>
>> ? ? ? ?return 0;
>>
>> With this change, it would work on boot as actual (phy_device_register()
>> will fail for the PHYs who don;t work when booting).
>>
>> Later, when opening the ethernet device, fs_init_phy, will look, if
>> we have a valid phy with driver, if not we try to register it again.
>> If this is successfull, we can use the device, if not we will fail,
>> as now ... what do you think?
>
> As mentioned above, it has the potential for some nasty confusion
> about where exactly phy devices get registered, not to mention an
> unlikely but potential race condition between the mdio bus and the
> ethernet device trying to register the same phy since the MDIO bus
> gets registered first, and then the bus loops over the phy nodes while
> the bus is 'live'.
>
> g.
>
>
> ------------------------------
>
> Message: 3
> Date: Wed, 6 Oct 2010 11:30:19 -0600
> From: Grant Likely <grant.likely@secretlab.ca>
> To: Holger brunck <holger.brunck@keymile.com>
> Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
>        hs@denx.de,     Detlev Zundel <dzu@denx.de>, netdev@vger.kernel.or=
g
> Subject: Re: powerpc, fs_enet: scanning PHY after Linux is up
> Message-ID:
>        <AANLkTinWGw5AR8KSSdCyOWqCaMVL-wZH+2uB7zh404_i@mail.gmail.com>
> Content-Type: text/plain; charset=3DISO-8859-1
>
> On Wed, Oct 6, 2010 at 7:50 AM, Holger brunck <holger.brunck@keymile.com>=
 wrote:
>> Hello Heiko,
>>
>> On 10/06/2010 11:53 AM, Heiko Schocher wrote:
>>>>> So, the question is, is there a possibility to solve this problem?
>>>>>
>>>>> If there is no standard option, what would be with adding a
>>>>> "scan_phy" file in
>>>>>
>>>>> /proc/device-tree/soc\@f0000000/cpm\@119c0/mdio\@10d40
>>>>> (or better destination?)
>>>>>
>>>>> which with we could rescan a PHY with
>>>>> "echo addr > /proc/device-tree/soc\@f0000000/cpm\@119c0/mdio\@10d40/s=
can_phy"
>>>>> (so there is no need for using of_find_node_by_path(), as we should
>>>>> ?have the associated device node here, and can step through the child
>>>>> ?nodes with "for_each_child_of_node(np, child)" and check if reg =3D=
=3D addr)
>>>>>
>>>>> or shouldn;t be at least, if the phy couldn;t be found when opening
>>>>> the port, retrigger a scanning, if the phy now is accessible?
>>>>
>>>> One option would be to still register a phy_device for each phy
>>>> described in the device tree, but defer binding a driver to each phy
>>>> that doesn't respond. ?Then at of_phy_find_device() time, if it
>>>
>>> Maybe I din;t get the trick, but the problem is, that
>>> you can;t register a phy_device in drivers/of/of_mdio.c
>>> of_mdiobus_register(), if the phy didn;t respond with the
>>> phy_id ... and of_phy_find_device() is not (yet) used in fs_enet
>>>
>>>> matches with a phy_device that isn't bound to a driver yet, then
>>>> re-trigger the binding operation. ?At which point the phy id can be
>>>> probed and the correct driver can be chosen. ?If binding succeeds,
>>>> then return the phy_device handle. ?If not, then fail as it currently
>>>> does.
>>>
>>> Wouldn;t it be good, just if we need a PHY (on calling fs_enet_open)
>>> to look if there is one?
>>>
>>> Something like that (not tested):
>>>
>>> in drivers/net/fs_enet/fs_enet-main.c in fs_init_phy()
>>> called from fs_enet_open():
>>>
>>> Do first:
>>> phydev =3D ?of_phy_find_device(fep->fpi->phy_node);
>>>
>>> Look if there is a driver (phy_dev->drv =3D=3D NULL ?)
>>>
>>> If not, call new function
>>> of_mdiobus_register_phy(mii_bus, fep->fpi->phy_node)
>>> see below patch for it.
>>>
>>> If this succeeds, all is OK, and we can use this phy,
>>> else ethernet not work.
>>>
>>> !!just no idea, how to get mii_bus pointer ...
>>>
>>
>> in my understanding it should be posssible to get this pointer via the p=
arent of
>> the device_node you got via the private data of the fs_enet:
>> fep->fpi->phy_node->parent should point you to the device_node for the m=
dio_bus.
>
> Yes, this will give you the mdio bus node pointer.
>
>> In the next step you should be able to get the pointer of of_device for =
the
>> mdio_bus:
>> ofdevice* ofdev =3D to_of_device(fep->fpi->phy_node->parent);
>
> of_device is just an alias for platform_device now, and not all mdio
> busses will be instantiated by a platform device.  This method won't
> always work.  What is really needed is the pointer to the mii_bus
> structure.  That can be obtained by looping over the members of the
> mdio_bus_class and comparing the mii_bus->device.parent->of_node to
> the parent node from above.
>
> g.
>
>
> ------------------------------
>
> Message: 4
> Date: Thu, 07 Oct 2010 00:06:49 +0530
> From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,  Paul Mackerras
>        <paulus@samba.org>, Anton Blanchard <anton@samba.org>
> Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
> Subject: [PATCH v5 0/2] powerpc: add support for new hcall
>        H_BEST_ENERGY
> Message-ID: <20101006182948.7006.75088.stgit@drishya.in.ibm.com>
> Content-Type: text/plain; charset=3D"utf-8"
>
> Hi Ben,
>
> The following series adds a new kernel module for powerpc pseries
> platforms in order to export platform energy management capabilities.
>
> The module exports data from a new hypervisor call H_BEST_ENERGY.
>
> Comments and suggestions made on the previous iteration of the
> patch related to function naming has been incorporated.
>
> Changes in v5:
>
> * Renamed cpu_{left,right}most_thread_sibling() to
>                                cpu_{first,last}_thread_sibling()
>
> * Renamed cpu_core_of_thread() to cpu_core_index_of_thread()
>  (these function work on core index)
>
> * Rebased to 2.6.36-rc6 and tested on a supported platform
>
> Changes in v4:
>
> [4] [PATCH v4 0/2] powerpc: add support for new hcall H_BEST_ENERGY
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-July/084217.html
>
> * Added more documentation
> * Added check_for_h_best_energy() to look in ibm,hypertas-functions so
>  that sysfs entries are not created in an unsupported platform
> * Added cleaner error checks and correct of_node_put()
> * Rebased and tested on 2.6.35-rc5
>
> Changed in v3:
>
> [3] [PATCH v3 0/2] powerpc: add support for new hcall H_BEST_ENERGY
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-June/083414.html
>
> * Added more documentation in the cleanup patch
> * Removed RFC tag, rebased and tested on 2.6.35-rc3
> * Ready for inclusion in powerpc/next tree for further testing
>
> Changes in v2:
>
> [2] [RFC PATCH v2 0/2] powerpc: add support for new hcall H_BEST_ENERGY
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-May/082246.html
>
> * Cleanup cpu/thread/core APIs
> * Export APIs to module instead of threads_per_core
> * Use of_find_node_by_path() instead of of_find_node_by_name()
> * Error checking and whitespace cleanups
>
> First version:
> [1] [RFC] powerpc: add support for new hcall H_BEST_ENERGY
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-March/080796.html
>
> This patch series will apply on 2.6.36-rc6 as well as powerpc/next
> tree.  Please review and include in powerpc/next tree for further
> testing.
>
> I could incrementally reduce some of the error checks as suggested by
> Michael Neuling as next steps.  This patch series is conservative and
> has more error checking in device tree parsing and drc index matching
> code than what may be required.
>
> Thanks,
> Vaidy
> ---
>
> Vaidyanathan Srinivasan (2):
>      powerpc: cleanup APIs for cpu/thread/core mappings
>      powerpc: add support for new hcall H_BEST_ENERGY
>
>
> arch/powerpc/include/asm/cputhreads.h           |   15 +
> arch/powerpc/include/asm/hvcall.h               |    3
> arch/powerpc/kernel/smp.c                       |   19 +
> arch/powerpc/mm/mmu_context_nohash.c            |   12 -
> arch/powerpc/platforms/pseries/Kconfig          |   10 +
> arch/powerpc/platforms/pseries/Makefile         |    1
> arch/powerpc/platforms/pseries/pseries_energy.c |  326 ++++++++++++++++++=
+++++
> 7 files changed, 370 insertions(+), 16 deletions(-)
> create mode 100644 arch/powerpc/platforms/pseries/pseries_energy.c
>
>
>
> ------------------------------
>
> Message: 5
> Date: Thu, 07 Oct 2010 00:06:59 +0530
> From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,  Paul Mackerras
>        <paulus@samba.org>, Anton Blanchard <anton@samba.org>
> Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
> Subject: [PATCH v5 1/2] powerpc: cleanup APIs for cpu/thread/core
>        mappings
> Message-ID: <20101006183659.7006.76509.stgit@drishya.in.ibm.com>
> Content-Type: text/plain; charset=3D"utf-8"
>
> These APIs take logical cpu number as input
> Change cpu_first_thread_in_core() to cpu_first_thread_sibling()
> Change cpu_last_thread_in_core() to cpu_last_thread_sibling()
>
> These APIs convert core number (index) to logical cpu/thread numbers
> Add cpu_first_thread_of_core(int core)
> Changed cpu_thread_to_core() to cpu_core_index_of_thread(int cpu)
>
> The goal is to make 'threads_per_core' accessible to the
> pseries_energy module.  Instead of making an API to read
> threads_per_core, this is a higher level wrapper function to
> convert from logical cpu number to core number.
>
> The current APIs cpu_first_thread_in_core() and
> cpu_last_thread_in_core() returns logical CPU number while
> cpu_thread_to_core() returns core number or index which is
> not a logical CPU number.  The new APIs are now clearly named to
> distinguish 'core number' versus first and last 'logical cpu
> number' in that core.
>
> The new APIs cpu_{first,last}_thread_sibling() work on
> logical cpu numbers.  While cpu_first_thread_of_core() and
> cpu_core_index_of_thread() work on core index.
>
> Example usage:  (4 threads per core system)
>
> cpu_first_thread_sibling(5) =3D 4
> cpu_last_thread_sibling(5) =3D 7
> cpu_core_index_of_thread(5) =3D 1
> cpu_first_thread_of_core(1) =3D 4
>
> cpu_core_index_of_thread() is used in cpu_to_drc_index() in the
> module and cpu_first_thread_of_core() is used in
> drc_index_to_cpu() in the module.
>
> Make API changes to few callers.  Export symbols for use in modules.
>
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> ---
> arch/powerpc/include/asm/cputhreads.h |   15 +++++++++------
> arch/powerpc/kernel/smp.c             |   19 ++++++++++++++++---
> arch/powerpc/mm/mmu_context_nohash.c  |   12 ++++++------
> 3 files changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include=
/asm/cputhreads.h
> index a8e1844..f71bb4c 100644
> --- a/arch/powerpc/include/asm/cputhreads.h
> +++ b/arch/powerpc/include/asm/cputhreads.h
> @@ -61,22 +61,25 @@ static inline cpumask_t cpu_online_cores_map(void)
>        return cpu_thread_mask_to_cores(cpu_online_map);
> }
>
> -static inline int cpu_thread_to_core(int cpu)
> -{
> -       return cpu >> threads_shift;
> -}
> +#ifdef CONFIG_SMP
> +int cpu_core_index_of_thread(int cpu);
> +int cpu_first_thread_of_core(int core);
> +#else
> +static inline int cpu_core_index_of_thread(int cpu) { return cpu; }
> +static inline int cpu_first_thread_of_core(int core) { return core; }
> +#endif
>
> static inline int cpu_thread_in_core(int cpu)
> {
>        return cpu & (threads_per_core - 1);
> }
>
> -static inline int cpu_first_thread_in_core(int cpu)
> +static inline int cpu_first_thread_sibling(int cpu)
> {
>        return cpu & ~(threads_per_core - 1);
> }
>
> -static inline int cpu_last_thread_in_core(int cpu)
> +static inline int cpu_last_thread_sibling(int cpu)
> {
>        return cpu | (threads_per_core - 1);
> }
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 0008bc5..012d6e2 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -466,7 +466,20 @@ out:
>        return id;
> }
>
> -/* Must be called when no change can occur to cpu_present_mask,
> +/* Helper routines for cpu to core mapping */
> +int cpu_core_index_of_thread(int cpu)
> +{
> +       return cpu >> threads_shift;
> +}
> +EXPORT_SYMBOL_GPL(cpu_core_index_of_thread);
> +
> +int cpu_first_thread_of_core(int core)
> +{
> +       return core << threads_shift;
> +}
> +EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);
> +
> +/* Must be called when no change can occur to cpu_present_map,
>  * i.e. during cpu online or offline.
>  */
> static struct device_node *cpu_to_l2cache(int cpu)
> @@ -517,7 +530,7 @@ int __devinit start_secondary(void *unused)
>        notify_cpu_starting(cpu);
>        set_cpu_online(cpu, true);
>        /* Update sibling maps */
> -       base =3D cpu_first_thread_in_core(cpu);
> +       base =3D cpu_first_thread_sibling(cpu);
>        for (i =3D 0; i < threads_per_core; i++) {
>                if (cpu_is_offline(base + i))
>                        continue;
> @@ -596,7 +609,7 @@ int __cpu_disable(void)
>                return err;
>
>        /* Update sibling maps */
> -       base =3D cpu_first_thread_in_core(cpu);
> +       base =3D cpu_first_thread_sibling(cpu);
>        for (i =3D 0; i < threads_per_core; i++) {
>                cpumask_clear_cpu(cpu, cpu_sibling_mask(base + i));
>                cpumask_clear_cpu(base + i, cpu_sibling_mask(cpu));
> diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_c=
ontext_nohash.c
> index ddfd7ad..9aa754c 100644
> --- a/arch/powerpc/mm/mmu_context_nohash.c
> +++ b/arch/powerpc/mm/mmu_context_nohash.c
> @@ -111,8 +111,8 @@ static unsigned int steal_context_smp(unsigned int id=
)
>                 * a core map instead but this will do for now.
>                 */
>                for_each_cpu(cpu, mm_cpumask(mm)) {
> -                       for (i =3D cpu_first_thread_in_core(cpu);
> -                            i <=3D cpu_last_thread_in_core(cpu); i++)
> +                       for (i =3D cpu_first_thread_sibling(cpu);
> +                            i <=3D cpu_last_thread_sibling(cpu); i++)
>                                __set_bit(id, stale_map[i]);
>                        cpu =3D i - 1;
>                }
> @@ -264,14 +264,14 @@ void switch_mmu_context(struct mm_struct *prev, str=
uct mm_struct *next)
>         */
>        if (test_bit(id, stale_map[cpu])) {
>                pr_hardcont(" | stale flush %d [%d..%d]",
> -                           id, cpu_first_thread_in_core(cpu),
> -                           cpu_last_thread_in_core(cpu));
> +                           id, cpu_first_thread_sibling(cpu),
> +                           cpu_last_thread_sibling(cpu));
>
>                local_flush_tlb_mm(next);
>
>                /* XXX This clear should ultimately be part of local_flush=
_tlb_mm */
> -               for (i =3D cpu_first_thread_in_core(cpu);
> -                    i <=3D cpu_last_thread_in_core(cpu); i++) {
> +               for (i =3D cpu_first_thread_sibling(cpu);
> +                    i <=3D cpu_last_thread_sibling(cpu); i++) {
>                        __clear_bit(id, stale_map[i]);
>                }
>        }
>
>
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
> End of Linuxppc-dev Digest, Vol 74, Issue 31
> ********************************************
