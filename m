Return-Path: <prsuko@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41A1A1A0666
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Nov 2015 15:24:42 +1100 (AEDT)
Received: by padfb7 with SMTP id fb7so23991819pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2015 20:24:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH v7 00/50] powerpc/powernv: PCI hotplug support
From: Pramod Sudheendra <prsuko@gmail.com>
In-Reply-To: <20151109030934.GA31009@gwshan>
Date: Sun, 8 Nov 2015 20:24:37 -0800
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 aik@ozlabs.ru, bhelgaas@google.com, grant.likely@linaro.org,
 robherring2@gmail.com, panto@antoniou-consulting.com,
 frowand.list@gmail.com
Message-Id: <EC714E5B-94E6-40B9-86B2-19FAB0E2D7E5@gmail.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20151109030934.GA31009@gwshan>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On Nov 8, 2015, at 7:09 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> =
wrote:
>=20
> On Thu, Nov 05, 2015 at 12:12:00AM +1100, Gavin Shan wrote:
>> This series of patches rebases on powerpc/next branch, plus below =
additional
>> patches:
>>=20
>>  https://patchwork.ozlabs.org/patch/534804/   (PATCH[1/1] Andrew's =
EEH fix)
>>  https://patchwork.ozlabs.org/patch/534154/   (PATCH[7/7] Richard's =
SRIOV Rework)
>>  commit 3b0e21e Merge branch 'next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux into next
>>=20
>=20
> As asked by Alexey, here is the repo on github:
>=20
> https://github.com/gwshan/pnv-pci-hotplug.git
Don=E2=80=99t see that link working.=20
>=20
>> The series of patches intend to support PCI slot for PowerPC PowerNV =
platform,
>> which is running on top of skiboot firmware. The patchset requires =
corresponding
>> changes from skiboot firmware, which is sent to =
skiboot@lists.ozlabs.org
>> for review. The PCI slots are exposed by skiboot with device node =
properties,
>> and kernel utilizes those properties to populated PCI slots =
accordingly.
>>=20
>> The original PCI infrastructure on PowerNV platform can't support =
hotplug
>> because the PE is assigned during PHB fixup time, which is called for =
once
>> during system boot time. For this, the PCI infrastructure on PowerNV =
platform
>> has been reworked for a lot. After that, the PE and its corresponding =
resources
>> (IODT, M32DT, M64 segments, DMA32 and bypass window) are assigned =
upon updating
>> PCI bridge's resources, which might decide PE# assigned to the PE =
(e.g. M64
>> resources, on P8 strictly speaking). Each PE will maintain a =
reference count,
>> which is (number of child PCI devices + 1). That indicates when last =
child PCI
>> device leaves the PE, the PE and its included resources will be =
relased and put
>> back into free pool again. With this design, the PE will be released =
when EEH PE
>> is released. PATCH[1 - 27] are related to this part.
>>=20
>>> =46rom skiboot perspective, PCI slot is providing =
(hot/fundamental/complete)
>> resets to EEH. The kernel gets to know if skiboot supports various =
reset on one
>> particular PCI slot through device-tree node. If it does, EEH will =
utilize the
>> functionality provided by skiboot. Besides, the device-tree nodes =
have to change
>> in order to support PCI hotplug. For example, when one PCI adapter =
inserted to
>> one slot, its device-tree node should be added to the system =
dynamically. Conversely,
>> the device-tree node should be removed from the system when the PCI =
adapter is going
>> to be offline. Since pci_dn and eeh_dev have same life cyle as PCI =
device nodes,
>> they should be added/removed accordingly during PCI hotplug. PATCH[28 =
- 43] are
>> doing the related work.
>>=20
>> The OF driver is changed to support unflattening FDT blob for =
sub-stree, which
>> is covered by PATCH[44 - 49].
>>=20
>> The last one, PATCH[50], is the standalone PCI hotplug driver for =
PowerPC PowerNV
>> platform.=20
>>=20
>> Changelog
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>> v7:
>>  * Reworked revision to some extent.
>>  * Rebased to powerpc/next repository.
>>  * Reorder/split/merge/drop according - Alexey.
>>  * Defined macros and use array to track IO/M32/M64/DMA32 segments - =
Alexey.
>>  * Merged 3 files to one for the hotplug driver - Alexey.
>>  * As part of OPAL API, defined macros for PCI slot power state, =
hotplug
>>    message type. Defined macros for PCI slot power confirmed state in
>>    hotplug driver.
>>  * Misc comments from Alexey.
>>  * Reworked unflatten_dt_node() to avoid recursive function calls.
>>  * Use EXPORT_SYMBOL_GPL() and document function's input/output - =
Rob/Frank.
>> v6:
>>  * Patch reorder, split, squash - Alexey.
>>  * Minor coding style - Alexey.
>>  * Better function names for pcibios_{add,remove}_pci_devices - Bjorn
>>  * Replace pr_warn() with dev_warn() in PowerNV hotplug driver - =
Bjorn
>>  * Concurrent depth as parameter passed to __unflatten_dt_node() - =
Grant / Alexey
>>  * Replace overlay with of_changeset - Grant
>> v5:
>>  * Rebased to 4.1.rc6 and some unmerged patches as below:
>>    Alexey's DDW patchset (v11);
>>    Gavin's EEH error injection support (in mpe's next branch);
>>    Richard's EEH cleanup patches (in mpe's next branch);
>>    Richard's EEH support for VF (v7);
>>    Gavin's misc EEH fixes for 4.2;
>>  * The revision bases on skiboot corresponding patches (v7):
>>    https://patchwork.ozlabs.org/patch/480437/
>>  * Utilize OF overlay to update device-tree with help of newly =
introduced
>>    OPAL API opal_get_overlay_dt().
>>  * Split patches for easy review according to aik's comments.
>>  * Fix coding style from checkpatchc.pl as pointed by aik.
>>  * Code cleanup and misc fixup according to aik's input.
>> v4:
>>  * Rebased to 4.1.RC1
>>  * Added API to unflatten FDT blob to device node sub-tree, which is =
attached
>>    the indicated parent device node. The original mechanism based on =
formatted
>>    string stream has been dropped.
>>  * The PATCH[v3 09/21] ("powerpc/eeh: Delay probing EEH device during =
hotplug")
>>    was picked up sent to linux-ppc@ separately for review as =
Richard's "VF EEH
>>    Support" depends on that.
>> v3:
>>  * Rebased to 4.1.RC0
>>  * PowerNV PCI infrasturcture is total refactored in order to support =
PCI
>>    hotplug. The PowerNV hotplug driver is also reworked a lot because =
of
>>    the changes in skiboot in order to support PCI hotplug.
>>=20
>> Gavin Shan (50):
>> PCI: Add pcibios_setup_bridge()
>> powerpc/pci: Override pcibios_setup_bridge()
>> powerpc/pci: Cleanup on struct pci_controller_ops
>> powerpc/powernv: Cleanup on pnv_pci_ioda_controller_ops
>> powerpc/powernv: Drop pnv_ioda_setup_dev_PE()
>> powerpc/powernv: Drop phb->bdfn_to_pe()
>> powerpc/powernv: Reorder fields in struct pnv_phb
>> powerpc/powernv: Rename PE# fields in struct pnv_phb
>> powerpc/powernv: Fix initial IO and M32 segmap
>> powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
>> powerpc/powernv: IO and M32 mapping based on PCI device resources
>> powerpc/powernv: Track M64 segment consumption
>> powerpc/powernv: Rename M64 related functions
>> powerpc/powernv: M64 support on P7IOC
>> powerpc/powernv: Rename pnv_pci_ioda_setup_dma_pe()
>> powerpc/powernv: Define PNV_IODA1_DMA32_SEGSIZE
>> powerpc/powernv: Avoid calculating DMA32 segments on PHB3
>> powerpc/powernv: Remove DMA32 PE list
>> powerpc/powernv: Track DMA32 segment consumption
>> powerpc/powernv: Improve DMA32 segment calculation
>> powerpc/powernv: Increase PE# capacity
>> powerpc/powernv: Introduce pnv_ioda_init_pe()
>> powerpc/powernv: Use PE instead of number during setup and release
>> powerpc/powernv: Allocate PE# in reverse order
>> powerpc/powernv: Reserve PE for root bus
>> powerpc/powernv: Create PEs at PCI hot plugging time
>> powerpc/powernv: Dynamically release PEs
>> powerpc/pci: Rename pcibios_{add,remove}_pci_devices()
>> powerpc/pci: Rename pcibios_find_pci_bus()
>> powerpc/pci: Move pci_find_bus_by_node() around
>> powerpc/pci: Export pci_add_device_node_info()
>> powerpc/pci: Introduce pci_remove_device_node_info()
>> powerpc/pci: Export pci_traverse_device_nodes()
>> powerpc/pci: Delay populating pdn
>> powerpc/pci: Don't scan empty slot
>> powerpc/pci: Update bridge windows on PCI plug
>> powerpc/powernv: Simplify pnv_eeh_reset()
>> powerpc/powernv: Exclude root bus in pnv_pci_reset_secondary_bus()
>> powerpc/powernv: Fundamental reset in pnv_pci_reset_secondary_bus()
>> powerpc/powernv: Support PCI slot ID
>> powerpc/powernv: Use firmware PCI slot reset infrastructure
>> powerpc/powernv: Functions to get/set PCI slot status
>> powerpc/powernv: Select OF_DYNAMIC
>> drivers/of: Split unflatten_dt_node()
>> drivers/of: Avoid recursively calling unflatten_dt_node()
>> drivers/of: Rename unflatten_dt_node()
>> drivers/of: Specify parent node in of_fdt_unflatten_tree()
>> drivers/of: Return allocated memory from of_fdt_unflatten_tree()
>> drivers/of: Export OF changeset functions
>> PCI/hotplug: PowerPC PowerNV PCI hotplug driver
>>=20
>> MAINTAINERS                                    |    6 +
>> arch/powerpc/include/asm/eeh.h                 |    2 +-
>> arch/powerpc/include/asm/opal-api.h            |   17 +-
>> arch/powerpc/include/asm/opal.h                |    8 +-
>> arch/powerpc/include/asm/pci-bridge.h          |   25 +-
>> arch/powerpc/include/asm/pnv-pci.h             |    7 +
>> arch/powerpc/include/asm/ppc-pci.h             |    8 +-
>> arch/powerpc/kernel/eeh_dev.c                  |   19 +-
>> arch/powerpc/kernel/eeh_driver.c               |   12 +-
>> arch/powerpc/kernel/pci-common.c               |   16 +-
>> arch/powerpc/kernel/pci-hotplug.c              |   47 +-
>> arch/powerpc/kernel/pci_dn.c                   |   85 +-
>> arch/powerpc/platforms/maple/pci.c             |   34 +-
>> arch/powerpc/platforms/pasemi/pci.c            |    3 -
>> arch/powerpc/platforms/powermac/pci.c          |   38 +-
>> arch/powerpc/platforms/powernv/Kconfig         |    1 +
>> arch/powerpc/platforms/powernv/eeh-powernv.c   |  173 ++--
>> arch/powerpc/platforms/powernv/opal-wrappers.S |    4 +
>> arch/powerpc/platforms/powernv/pci-ioda.c      | 1251 =
+++++++++++++++---------
>> arch/powerpc/platforms/powernv/pci.c           |   92 +-
>> arch/powerpc/platforms/powernv/pci.h           |   62 +-
>> arch/powerpc/platforms/pseries/msi.c           |    4 +-
>> arch/powerpc/platforms/pseries/pci_dlpar.c     |   32 -
>> arch/powerpc/platforms/pseries/setup.c         |    8 +-
>> drivers/of/dynamic.c                           |   65 +-
>> drivers/of/fdt.c                               |  378 ++++---
>> drivers/of/of_private.h                        |    2 +
>> drivers/of/overlay.c                           |    8 +-
>> drivers/of/unittest.c                          |    6 +-
>> drivers/pci/hotplug/Kconfig                    |   12 +
>> drivers/pci/hotplug/Makefile                   |    3 +
>> drivers/pci/hotplug/pnv_php.c                  |  866 =
++++++++++++++++
>> drivers/pci/hotplug/rpadlpar_core.c            |    8 +-
>> drivers/pci/hotplug/rpaphp_core.c              |    4 +-
>> drivers/pci/hotplug/rpaphp_pci.c               |    4 +-
>> drivers/pci/setup-bus.c                        |    5 +
>> include/linux/of_fdt.h                         |    5 +-
>> include/linux/pci.h                            |    1 +
>> 38 files changed, 2389 insertions(+), 932 deletions(-)
>> create mode 100644 drivers/pci/hotplug/pnv_php.c
>>=20
>> --=20
>> 2.1.0
>>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
