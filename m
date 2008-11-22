Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id B6AAEDDDF0
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 19:57:12 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <1227316642.11607.69.camel@nimitz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <ae36c6d2fc08b03867ccb8618370e6d5@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Nodes with no memory
Date: Sat, 22 Nov 2008 02:58:51 -0600
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Nathan Lynch <nathanl@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat Nov 22 at 12:17:22 EST in 2008 Dave Hansen wrote:
> On Fri, 2008-11-21 at 18:49 -0600, Nathan Lynch wrote:
>> Dave Hansen wrote:
>>> I was handed off a bug report about a blade not booting with a, um
>>> "newer" kernel.
>>
>> If you're unable to provide basic information such as the kernel
>> version then perhaps this isn't the best forum for discussing this. =20=

>> :)
>
> Let's just say a derivative of 2.6.27.5.  I will, of course be trying=20=

> to reproduce on mainline.  I'm just going with the kernel closest to=20=

> the bug report as I can get for now.

This reminds me.  I was asked to look at a system that had all cpus and=20=

memory on node 1.  I recently switched to 2.6.27.0, and had a similar=20
failure when I tried my latest development kernel.  However, I realized=20=

that the user was wanting to run my previously supported 2.6.24 kernel,=20=

and that did not have this issue, so I never got back to debugging this=20=

problem.  (Both kernels had similar patches applied, but very little to=20=

mm or numa selection).  I was able to fix the problem they were having=20=

and returned the machine to them without debugging the issue, but I=20
suspect the problem was introduced to mainline between 2.6.24 and=20
2.6.27.

>>> I'm thinking that we need to at least fix careful_allocation() to=20
>>> oops
>>> and not return NULL, or check to make sure all it callers check its
>>> return code.
>>
>> Well, careful_allocation() in current mainline tries pretty hard to
>> panic if it can't satisfy the request.  Why isn't that happening?
>
> I added some random debugging to careful_alloc() to find out.
>
> careful_allocation(1, 7680, 80, 0)
> careful_allocation() ret1: 00000001dffe4100
> careful_allocation() ret2: 00000001dffe4100
> careful_allocation() ret3: 00000001dffe4100
> careful_allocation() ret4: c000000000000000
> careful_allocation() ret5: 0000000000000000
>
> It looks to me like it is hitting 'the memory came from a previously
> =A0allocated node' check.  So, the __lmb_alloc_base() appears to get
> something worthwhile, but that gets overwritten later.
>
> I'm still not quite sure what this comment means.  Are we just trying=20=

> to
> get node locality from the allocation?

My memory (and a quick look) is that careful alloc is used while we are=20=

in the process of creating the memory maps for the node.  We want them=20=

to be allocated from memory on the node, but will accept memory from=20
any node to handle the case that memory is not available in the desired=20=

node.  Linux requires the maps exist for every online node.

Because we are in the process transferring the memory between=20
allocators, the check for new_nid < nid is meant to say "if the memory=20=

did not come from the preferred node, but instead came from one we=20
already transfered, then we need to obtain that memory from the new=20
allocator".  If it came from the preferred node or a later node, the=20
allocation we did is valid, and will be marked in-use when we transfer=20=

that node's memory.

> I also need to go look at how __alloc_bootmem_node() ends up returning
> c000000000000000.  It should be returning NULL, and panic'ing, in
> careful_alloc().  This probably has to do with the fact that=20
> NODE_DATA()
> isn't set up, yet, but I'll double check.

We setup NODE_DATA with the result of this alloc in nid order.  If=20
early_pfs_to_nid returns the wrong value then we would obviously be in=20=

trouble here.

>         /*
>          * If the memory came from a previously allocated node, we =
must
>          * retry with the bootmem allocator.
>          */
>         new_nid =3D early_pfn_to_nid(ret >> PAGE_SHIFT);
>         if (new_nid < nid) {
>                 ret =3D (unsigned=20
> long)__alloc_bootmem_node(NODE_DATA(new_nid),
>                                 size, align, 0);
>                 dbg("careful_allocation() ret4: %016lx\n", ret);
>
>                 if (!ret)
>                         panic("numa.c: cannot allocate %lu bytes on=20
> node %d",
>                               size, new_nid);
>
>                 ret =3D __pa(ret);
>                 dbg("careful_allocation() ret5: %016lx\n", ret);
>
>                 dbg("alloc_bootmem %lx %lx\n", ret, size);
>         }

Perhaps someone can recreate this with the fake numa stuff that was=20
added since 2.6.24?   Or edit a device tree to fake the numa=20
assignments for memory and kexec using the modified tree.

milton
