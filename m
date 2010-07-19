Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 310CAB6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 19 Jul 2010 14:28:21 +1000 (EST)
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address via
	proc
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <1279496491.10390.1725.camel@pasglop>
Date: Sun, 18 Jul 2010 23:28:01 -0500
Message-ID: <8388D248-51F3-4F36-BBE0-CDE9E278E65E@freescale.com>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
	<1279496491.10390.1725.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Jul 18, 2010, at 6:41 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2010-07-15 at 00:21 -0600, Grant Likely wrote:
>> On Wed, Jul 14, 2010 at 9:18 AM, Matthew McClintock =
<msm@freescale.com> wrote:
>>> To build a proper flat device tree for kexec we need to know which
>>> memreserve region was used for the device tree for the currently
>>> running kernel, so we can remove it and replace it with the new
>>> memreserve for the kexec'ed kernel
>>>=20
>>> Signed-off-by: Matthew McClintock <msm@freescale.com>
>>=20
>> Hi Matthew.
>>=20
>> I don't understand.  Why does userspace need to know about the old
>> memreserve sections?  Doesn't kexec tear down all of the old
>> allocations anyway?  How are they relevant for constructing the dtb
>> for the kexec kernel?  I'll need a lot more details before I consider
>> merging this.
>>=20
>> Also, please cc: me and Ben Herrenschmidt on powerpc related device
>> tree changes.
>=20
> I admit to be the victim of a similar misunderstanding...
>=20
> Care to explain in more details ? (with examples)
>=20

Upon first examining the details of getting kexec working on our =
platform I noticed our device tree passed from u-boot contained an =
additional memreserve section for the boot page. Subsequently, I've been =
trying to preserve the ones passed in for the kexec'ed kernel thinking =
anyone could add anything they wanted for their own particular needs and =
would quite possibly need those regions preserved across reboots.

Recently, I've discovered the boot page address is given in the device =
tree as a property. So, for our platform (mpc85xx) in particular, I'm =
back to not needing the read the old memreserve sections... I can =
completely reconstruct the appropriate memreserve regions for kexec'ing =
from the information passed in the device tree.

That isn't to say there might not be more memreserve regions that are =
not there for some valid reason. I'm not sure if we need to attempt to =
address another scenario where there are other memreserve regions. So =
this would be a good time to address this issue if anyone believes it is =
a worthwhile pursuit to have a mechanism to have memreserve regions =
persistent across kexec'ing - or any other reboot.

-Matthew


> Cheers,
> Ben.
>=20
>> Cheers,
>> g.
>>=20
>>> ---
>>> V4: Fixed misspelling
>>>=20
>>> V3: Remove unneeded cast, and fixed indentation screw up
>>>=20
>>> V2: messed up changes
>>>=20
>>> arch/powerpc/kernel/prom.c |   45 =
++++++++++++++++++++++++++++++++++++++++++++
>>> 1 files changed, 45 insertions(+), 0 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>>> index fd9359a..ff3e240 100644
>>> --- a/arch/powerpc/kernel/prom.c
>>> +++ b/arch/powerpc/kernel/prom.c
>>> @@ -32,6 +32,7 @@
>>> #include <linux/debugfs.h>
>>> #include <linux/irq.h>
>>> #include <linux/lmb.h>
>>> +#include <linux/bootmem.h>
>>>=20
>>> #include <asm/prom.h>
>>> #include <asm/rtas.h>
>>> @@ -911,3 +912,47 @@ static int __init export_flat_device_tree(void)
>>> }
>>> __initcall(export_flat_device_tree);
>>> #endif
>>> +
>>> +#ifdef CONFIG_KEXEC
>>> +static phys_addr_t flat_dt_start;
>>> +static phys_addr_t flat_dt_end;
>>> +
>>> +static struct property flat_dt_start_prop =3D {
>>> +       .name =3D "linux,devicetree-start",
>>> +       .length =3D sizeof(phys_addr_t),
>>> +       .value =3D &flat_dt_start,
>>> +};
>>> +
>>> +static struct property flat_dt_end_prop =3D {
>>> +       .name =3D "linux,devicetree-end",
>>> +       .length =3D sizeof(phys_addr_t),
>>> +       .value =3D &flat_dt_end,
>>> +};
>>> +
>>> +static int __init export_flat_device_tree_phys_addr(void)
>>> +{
>>> +       struct property *prop;
>>> +       struct device_node *node;
>>> +
>>> +       node =3D of_find_node_by_path("/chosen");
>>> +       if (!node)
>>> +               return -ENOENT;
>>> +
>>> +       prop =3D of_find_property(node, "linux,devicetree-start", =
NULL);
>>> +       if (prop)
>>> +               prom_remove_property(node, prop);
>>> +
>>> +       prop =3D of_find_property(node, "linux,devicetree-end", =
NULL);
>>> +       if (prop)
>>> +               prom_remove_property(node, prop);
>>> +
>>> +       flat_dt_start =3D virt_to_phys(initial_boot_params);
>>> +       flat_dt_end =3D virt_to_phys(initial_boot_params)
>>> +                               + initial_boot_params->totalsize;
>>> +       prom_add_property(node, &flat_dt_start_prop);
>>> +       prom_add_property(node, &flat_dt_end_prop);
>>> +
>>> +       return 0;
>>> +}
>>> +__initcall(export_flat_device_tree_phys_addr);
>>> +#endif
>>> --
>>> 1.6.6.1
>>>=20
>>>=20
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>>=20
>>=20
>>=20
>>=20
>=20
>=20
>=20
