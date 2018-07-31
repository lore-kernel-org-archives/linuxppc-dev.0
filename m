Return-Path: <frowand.list@gmail.com>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41g5p3579vzF164
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 05:18:48 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id a26-v6so6571518pfo.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 12:18:48 -0700 (PDT)
Subject: Re: phandle_cache vs of_detach_node (was Re: [PATCH]
 powerpc/mobility: Fix node detach/rename problem)
To: Rob Herring <robh+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: mwb@linux.vnet.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 devicetree@vger.kernel.org
References: <c2fba52a-baac-25fb-c26b-c84b25c3178c@linux.vnet.ibm.com>
 <8736w1jkte.fsf@concordia.ellerman.id.au>
 <ffaa7eba-5236-e42d-c901-79b045adfb94@linux.vnet.ibm.com>
 <8736vzj4la.fsf@concordia.ellerman.id.au>
 <CAL_JsqKf1k3MM+HgQ2U=Ep7L9nbBCmmvGZoEAKxLB1TVqQdW_w@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <85014a16-cd2c-0137-72e5-54d4bcdf788a@gmail.com>
Date: Tue, 31 Jul 2018 12:18:44 -0700
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKf1k3MM+HgQ2U=Ep7L9nbBCmmvGZoEAKxLB1TVqQdW_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/31/18 07:17, Rob Herring wrote:
> On Tue, Jul 31, 2018 at 12:34 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Hi Rob/Frank,
>>
>> I think we might have a problem with the phandle_cache not interacting
>> well with of_detach_node():
> 
> Probably needs a similar fix as this commit did for overlays:
> 
> commit b9952b5218added5577e4a3443969bc20884cea9
> Author: Frank Rowand <frank.rowand@sony.com>
> Date:   Thu Jul 12 14:00:07 2018 -0700
> 
>     of: overlay: update phandle cache on overlay apply and remove
> 
>     A comment in the review of the patch adding the phandle cache said that
>     the cache would have to be updated when modules are applied and removed.
>     This patch implements the cache updates.
> 
>     Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of
> of_find_node_by_phandle()")
>     Reported-by: Alan Tull <atull@kernel.org>
>     Suggested-by: Alan Tull <atull@kernel.org>
>     Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>     Signed-off-by: Rob Herring <robh@kernel.org>

Agreed.  Sorry about missing the of_detach_node() case.


> Really what we need here is an "invalidate phandle" function rather
> than free and re-allocate the whole damn cache.

The big hammer approach was chosen to avoid the race conditions that
would otherwise occur.  OF does not have a locking strategy that
would be able to protect against the races.

We could maybe implement a slightly smaller hammer by (1) disabling
the cache, (2) invalidate a phandle entry in the cache, (3) re-enable
the cache.  That is an off the cuff thought - I would have to look
a little bit more carefully to make sure it would work.

But I don't see a need to add the complexity of the smaller hammer
or the bigger hammer of proper locking _unless_ we start seeing that
the cache is being freed and re-allocated frequently.  For overlays
I don't expect the high frequency because it happens on a per overlay
removal basis (not per node removal basis).  For of_detach_node() the
event _is_ on a per node removal basis.  Michael, do you expect node
removals to be a frequent event with low latency being important?  If
so, a rough guess on what the frequency would be?

-Frank


> Rob
> 
>>
>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>>> See below.
>>>
>>> On 07/30/2018 01:31 AM, Michael Ellerman wrote:
>>>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>>>>
>>>>> During LPAR migration, the content of the device tree/sysfs may
>>>>> be updated including deletion and replacement of nodes in the
>>>>> tree.  When nodes are added to the internal node structures, they
>>>>> are appended in FIFO order to a list of nodes maintained by the
>>>>> OF code APIs.
>>>>
>>>> That hasn't been true for several years. The data structure is an n-ary
>>>> tree. What kernel version are you working on?
>>>
>>> Sorry for an error in my description.  I oversimplified based on the
>>> name of a search iterator.  Let me try to provide a better explanation
>>> of the problem, here.
>>>
>>> This is the problem.  The PPC mobility code receives RTAS requests to
>>> delete nodes with platform-/hardware-specific attributes when restarting
>>> the kernel after a migration.  My example is for migration between a
>>> P8 Alpine and a P8 Brazos.   Nodes to be deleted may include 'ibm,random-v1',
>>> 'ibm,compression-v1', 'ibm,platform-facilities', 'ibm,sym-encryption-v1',
>>> or others.
>>>
>>> The mobility.c code calls 'of_detach_node' for the nodes and their children.
>>> This makes calls to detach the properties and to try to remove the associated
>>> sysfs/kernfs files.
>>>
>>> Then new copies of the same nodes are next provided by the PHYP, local
>>> copies are built, and a pointer to the 'struct device_node' is passed to
>>> of_attach_node.  Before the call to of_attach_node, the phandle is initialized
>>> to 0 when the data structure is alloced.  During the call to of_attach_node,
>>> it calls __of_attach_node which pulls the actual name and phandle from just
>>> created sub-properties named something like 'name' and 'ibm,phandle'.
>>>
>>> This is all fine for the first migration.  The problem occurs with the
>>> second and subsequent migrations when the PHYP on the new system wants to
>>> replace the same set of nodes again, referenced with the same names and
>>> phandle values.
>>>
>>>>
>>>>> When nodes are removed from the device tree, they
>>>>> are marked OF_DETACHED, but not actually deleted from the system
>>>>> to allow for pointers cached elsewhere in the kernel.  The order
>>>>> and content of the entries in the list of nodes is not altered,
>>>>> though.
>>>>
>>>> Something is going wrong if this is actually happening.
>>>>
>>>> When the node is detached it should be *detached* from the tree of all
>>>> nodes, so it should not be discoverable other than by having an existing
>>>> pointer to it.
>>> On the second and subsequent migrations, the PHYP tells the system
>>> to again delete the nodes 'ibm,platform-facilities', 'ibm,random-v1',
>>> 'ibm,compression-v1', 'ibm,sym-encryption-v1'.  It specifies these
>>> nodes by its known set of phandle values -- the same handles used
>>> by the PHYP on the source system are known on the target system.
>>> The mobility.c code calls of_find_node_by_phandle() with these values
>>> and ends up locating the first instance of each node that was added
>>> during the original boot, instead of the second instance of each node
>>> created after the first migration.  The detach during the second
>>> migration fails with errors like,
>>>
>>> [ 4565.030704] WARNING: CPU: 3 PID: 4787 at drivers/of/dynamic.c:252 __of_detach_node+0x8/0xa0
>>> [ 4565.030708] Modules linked in: nfsv3 nfs_acl nfs tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag lockd grace fscache sunrpc xts vmx_crypto sg pseries_rng binfmt_misc ip_tables xfs libcrc32c sd_mod ibmveth ibmvscsi scsi_transport_srp dm_mirror dm_region_hash dm_log dm_mod
>>> [ 4565.030733] CPU: 3 PID: 4787 Comm: drmgr Tainted: G        W         4.18.0-rc1-wi107836-v05-120+ #201
>>> [ 4565.030737] NIP:  c0000000007c1ea8 LR: c0000000007c1fb4 CTR: 0000000000655170
>>> [ 4565.030741] REGS: c0000003f302b690 TRAP: 0700   Tainted: G        W          (4.18.0-rc1-wi107836-v05-120+)
>>> [ 4565.030745] MSR:  800000010282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 22288822  XER: 0000000a
>>> [ 4565.030757] CFAR: c0000000007c1fb0 IRQMASK: 1
>>> [ 4565.030757] GPR00: c0000000007c1fa4 c0000003f302b910 c00000000114bf00 c0000003ffff8e68
>>> [ 4565.030757] GPR04: 0000000000000001 ffffffffffffffff 800000c008e0b4b8 ffffffffffffffff
>>> [ 4565.030757] GPR08: 0000000000000000 0000000000000001 0000000080000003 0000000000002843
>>> [ 4565.030757] GPR12: 0000000000008800 c00000001ec9ae00 0000000040000000 0000000000000000
>>> [ 4565.030757] GPR16: 0000000000000000 0000000000000008 0000000000000000 00000000f6ffffff
>>> [ 4565.030757] GPR20: 0000000000000007 0000000000000000 c0000003e9f1f034 0000000000000001
>>> [ 4565.030757] GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>> [ 4565.030757] GPR28: c000000001549d28 c000000001134828 c0000003ffff8e68 c0000003f302b930
>>> [ 4565.030804] NIP [c0000000007c1ea8] __of_detach_node+0x8/0xa0
>>> [ 4565.030808] LR [c0000000007c1fb4] of_detach_node+0x74/0xd0
>>> [ 4565.030811] Call Trace:
>>> [ 4565.030815] [c0000003f302b910] [c0000000007c1fa4] of_detach_node+0x64/0xd0 (unreliable)
>>> [ 4565.030821] [c0000003f302b980] [c0000000000c33c4] dlpar_detach_node+0xb4/0x150
>>> [ 4565.030826] [c0000003f302ba10] [c0000000000c3ffc] delete_dt_node+0x3c/0x80
>>> [ 4565.030831] [c0000003f302ba40] [c0000000000c4380] pseries_devicetree_update+0x150/0x4f0
>>> [ 4565.030836] [c0000003f302bb70] [c0000000000c479c] post_mobility_fixup+0x7c/0xf0
>>> [ 4565.030841] [c0000003f302bbe0] [c0000000000c4908] migration_store+0xf8/0x130
>>> [ 4565.030847] [c0000003f302bc70] [c000000000998160] kobj_attr_store+0x30/0x60
>>> [ 4565.030852] [c0000003f302bc90] [c000000000412f14] sysfs_kf_write+0x64/0xa0
>>> [ 4565.030857] [c0000003f302bcb0] [c000000000411cac] kernfs_fop_write+0x16c/0x240
>>> [ 4565.030862] [c0000003f302bd00] [c000000000355f20] __vfs_write+0x40/0x220
>>> [ 4565.030867] [c0000003f302bd90] [c000000000356358] vfs_write+0xc8/0x240
>>> [ 4565.030872] [c0000003f302bde0] [c0000000003566cc] ksys_write+0x5c/0x100
>>> [ 4565.030880] [c0000003f302be30] [c00000000000b288] system_call+0x5c/0x70
>>> [ 4565.030884] Instruction dump:
>>> [ 4565.030887] 38210070 38600000 e8010010 eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 ebe1fff8
>>> [ 4565.030895] 7c0803a6 4e800020 e9230098 7929f7e2 <0b090000> 2f890000 4cde0020 e9030040
>>> [ 4565.030903] ---[ end trace 5bd54cb1df9d2976 ]---
>>>
>>> The mobility.c code continues on during the second migration, accepts the
>>> definitions of the new nodes from the PHYP and ends up renaming the new
>>> properties e.g.
>>>
>>> [ 4565.827296] Duplicate name in base, renamed to "ibm,platform-facilities#1"
>>>
>>> I don't see any check like 'of_node_check_flag(np, OF_DETACHED)' within
>>> of_find_node_by_phandle to skip nodes that are detached, but still present
>>> due to caching or use count considerations.  Another possibility to consider
>>> is that of_find_node_by_phandle also uses something called 'phandle_cache'
>>> which may have outdated data as of_detach_node() does not have access to
>>> that cache for the 'OF_DETACHED' nodes.
>>
>> Yes the phandle_cache looks like it might be the problem.
>>
>> I saw of_free_phandle_cache() being called as late_initcall, but didn't
>> realise that's only if MODULES is disabled.
>>
>> So I don't see anything that invalidates the phandle_cache when a node
>> is removed.
>>
>> The right solution would be for __of_detach_node() to invalidate the
>> phandle_cache for the node being detached. That's slightly complicated
>> by the phandle_cache being static inside base.c
>>
>> To test the theory that it's the phandle_cache causing the problems can
>> you try this patch:
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 848f549164cd..60e219132e24 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -1098,6 +1098,9 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>>                 if (phandle_cache[masked_handle] &&
>>                     handle == phandle_cache[masked_handle]->phandle)
>>                         np = phandle_cache[masked_handle];
>> +
>> +               if (of_node_check_flag(np, OF_DETACHED))
>> +                       np = NULL;
>>         }
>>
>>         if (!np) {
>>
>> cheers
> 
