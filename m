Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 58BEE1A0291
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 10:27:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 5 Nov 2015 09:27:03 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6C9F22BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 10:27:01 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4NQdTO36634736
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 10:26:47 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4NQR5b024818
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 10:26:29 +1100
Date: Thu, 5 Nov 2015 10:26:03 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
 Bjorn Helgaas <bhelgaas@google.com>,
 Grant Likely <grant.likely@linaro.org>,
 Pantelis Antoniou <panto@antoniou-consulting.com>,
 Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v7 45/50] drivers/of: Avoid recursively calling
 unflatten_dt_node()
Message-ID: <20151104232603.GA16994@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-46-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqJGpV-+JYyA1g0dw_nEduhmrMEouTH03kHtuCkGSOP57Q@mail.gmail.com>
 <20151104232315.GB9287@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151104232315.GB9287@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 05, 2015 at 10:23:15AM +1100, Gavin Shan wrote:
>On Wed, Nov 04, 2015 at 10:07:50AM -0600, Rob Herring wrote:
>>On Wed, Nov 4, 2015 at 7:12 AM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>>> In current implementation, unflatten_dt_node() is called recursively
>>> to unflatten device nodes in FDT blob. It's stress to limited stack
>>> capacity.
>>
>>Did you actually hit a problem?
>>
>>Now we have a max depth of 64. Seems like that should be plenty... Any
>>idea how this compares to when we run out of stack space?
>>
>
>When I rebased last revision (v6), particular below patch, to 4.3.rc6,
>the kernel won't boot in P7 and P8 boxes. On P7 boxes, the stack overruns
>according to the printed kernel messages. On P8 boxes, the /bin/init in
>initramfs image can't be loaded/executed properly and it's potentially
>caused by memory corruption. That's why I reworked it to avoid recursive
>calling to unflatten_dt_node().
>

Missed the link to the patch here:

https://patchwork.ozlabs.org/patch/504512/

>The max depth "64" wasn't selected based on the stack usage. I was thinking
>the device tree is converted to friendly *.dts format and it's using TAB
>as the prefix for each line. If the device tree has 64 depth, Each line
>in *.dts for leaf nodes have to be wrapped and spanning multiple lines.
>That's why I choosed 64, maybe 32 is enough. Did you see a device-tree
>that has more than 16 depth in field? :-)
>
>>> This avoids calling the function recursively, meaning the device
>>> nodes are unflattened in one call on unflatten_dt_node(): two arrays
>>> are introduced to track the parent path size and the device node of
>>> current level of depth, which will be used by the device node on next
>>> level of depth to be unflattened. Also, the parameter "poffset" and
>>> "fpsize" are unused and dropped.
>>
>>Yay. I'm happy to see parameters removed instead of added to this function.
>>
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>  drivers/of/fdt.c | 94 +++++++++++++++++++++++++++++++++-----------------------
>>>  1 file changed, 56 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>> index 173b036..f4793d0 100644
>>> --- a/drivers/of/fdt.c
>>> +++ b/drivers/of/fdt.c
>>> @@ -355,61 +355,82 @@ static unsigned long populate_node(const void *blob,
>>>         return fpsize;
>>>  }
>>>
>>> +static void reverse_nodes(struct device_node *parent)
>>> +{
>>> +       struct device_node *child, *next;
>>> +
>>> +       /* In-depth first */
>>> +       child = parent->child;
>>> +       while (child) {
>>> +               reverse_nodes(child);
>>> +
>>> +               child = child->sibling;
>>> +       }
>>> +
>>> +       /* Reverse the nodes in the child list */
>>> +       child = parent->child;
>>> +       parent->child = NULL;
>>> +       while (child) {
>>> +               next = child->sibling;
>>> +
>>> +               child->sibling = parent->child;
>>> +               parent->child = child;
>>> +               child = next;
>>> +       }
>>> +}
>>> +
>>>  /**
>>>   * unflatten_dt_node - Alloc and populate a device_node from the flat tree
>>>   * @blob: The parent device tree blob
>>>   * @mem: Memory chunk to use for allocating device nodes and properties
>>> - * @poffset: pointer to node in flat tree
>>>   * @dad: Parent struct device_node
>>>   * @nodepp: The device_node tree created by the call
>>> - * @fpsize: Size of the node path up at the current depth.
>>>   * @dryrun: If true, do not allocate device nodes but still calculate needed
>>>   * memory size
>>>   */
>>>  static void *unflatten_dt_node(const void *blob,
>>>                                void *mem,
>>> -                              int *poffset,
>>>                                struct device_node *dad,
>>>                                struct device_node **nodepp,
>>> -                              unsigned long fpsize,
>>>                                bool dryrun)
>>
>>We can probably further simplify things by returning an int with
>>negative being errors and positive being the size. Also, dryrun can be
>>dropped and implied by mem and/or nodepp being NULL.
>>
>
>Yeah, I think it's reasonable to return "size" from this function. "dryrun"
>can be dropped and implied by NULL @mem. @nodepp can't be NULL. I perhaps
>have separate patch to address it in next revision.
>
>>>  {
>>> -       struct device_node *np;
>>> -       static int depth;
>>> -       int old_depth;
>>> -
>>> -       fpsize = populate_node(blob, *poffset, &mem, dad, fpsize, &np, dryrun);
>>> -       if (!fpsize)
>>> -               return mem;
>>> +       struct device_node *root;
>>> +       int offset = 0, depth = 0;
>>> +       unsigned long fpsizes[64];
>>> +       struct device_node *nps[64];
>>
>>Use a define here.
>>
>
>Fair enough, will do in next revision. I'm not good at naming. Would
>"FDT_MAX_DEPTH" is a good one?
>
>>>
>>> -       old_depth = depth;
>>> -       *poffset = fdt_next_node(blob, *poffset, &depth);
>>> -       if (depth < 0)
>>> -               depth = 0;
>>> -       while (*poffset > 0 && depth > old_depth)
>>> -               mem = unflatten_dt_node(blob, mem, poffset, np, NULL,
>>> -                                       fpsize, dryrun);
>>> +       if (nodepp)
>>> +               *nodepp = NULL;
>>> +
>>> +       root = dad;
>>> +       fpsizes[depth] = dad ? strlen(of_node_full_name(dad)) : 0;
>>> +       nps[depth++] = dad;
>>> +       while (offset >= 0 && depth < 64) {
>>> +               fpsizes[depth] = populate_node(blob, offset, &mem,
>>> +                                              nps[depth - 1],
>>> +                                              fpsizes[depth - 1],
>>> +                                              &nps[depth], dryrun);
>>> +               if (!fpsizes[depth])
>>> +                       return mem;
>>> +
>>> +               if (!dryrun && nodepp && !*nodepp)
>>> +                       *nodepp = nps[depth];
>>> +               if (!dryrun && !root)
>>> +                       root = nps[depth];
>>> +
>>> +               offset = fdt_next_node(blob, offset, &depth);
>>> +       }
>>>
>>> -       if (*poffset < 0 && *poffset != -FDT_ERR_NOTFOUND)
>>> -               pr_err("unflatten: error %d processing FDT\n", *poffset);
>>> +       if (offset < 0 && offset != -FDT_ERR_NOTFOUND)
>>> +               pr_err("%s: Error %d processing FDT\n",
>>> +                      __func__, offset);
>>
>>What about depth == 64 case? I think the behavior should be a WARN and
>>ignore those nodes so we at least can continue to boot and see the
>>error. Of course, if there is a phandle pointing to ignored nodes, we
>>have to handle that too.
>>
>
>Yeah, I'll have a WARN_ON(depth >= 64) in next revision. Sorry, I didn't
>get the 2nd part of your comments: When depth > 64, the system won't work.
>It might boot up. Why the phandle pointing to the ignored node has to be
>dropped? 
>
>>>
>>>         /*
>>>          * Reverse the child list. Some drivers assumes node order matches .dts
>>>          * node order
>>>          */
>>> -       if (!dryrun && np->child) {
>>> -               struct device_node *child = np->child;
>>> -               np->child = NULL;
>>> -               while (child) {
>>> -                       struct device_node *next = child->sibling;
>>> -                       child->sibling = np->child;
>>> -                       np->child = child;
>>> -                       child = next;
>>> -               }
>>> -       }
>>> -
>>> -       if (nodepp)
>>> -               *nodepp = np;
>>> +       if (!dryrun)
>>> +               reverse_nodes(root);
>>>
>>>         return mem;
>>>  }
>>> @@ -431,7 +452,6 @@ static void __unflatten_device_tree(const void *blob,
>>>                              void * (*dt_alloc)(u64 size, u64 align))
>>>  {
>>>         unsigned long size;
>>> -       int start;
>>>         void *mem;
>>>
>>>         pr_debug(" -> unflatten_device_tree()\n");
>>> @@ -452,8 +472,7 @@ static void __unflatten_device_tree(const void *blob,
>>>         }
>>>
>>>         /* First pass, scan for size */
>>> -       start = 0;
>>> -       size = (unsigned long)unflatten_dt_node(blob, NULL, &start, NULL, NULL, 0, true);
>>> +       size = (unsigned long)unflatten_dt_node(blob, NULL, NULL, NULL, true);
>>>         size = ALIGN(size, 4);
>>>
>>>         pr_debug("  size is %lx, allocating...\n", size);
>>> @@ -467,8 +486,7 @@ static void __unflatten_device_tree(const void *blob,
>>>         pr_debug("  unflattening %p...\n", mem);
>>>
>>>         /* Second pass, do actual unflattening */
>>> -       start = 0;
>>> -       unflatten_dt_node(blob, mem, &start, NULL, mynodes, 0, false);
>>> +       unflatten_dt_node(blob, mem, NULL, mynodes, false);
>>>         if (be32_to_cpup(mem + size) != 0xdeadbeef)
>>>                 pr_warning("End of tree marker overwritten: %08x\n",
>>>                            be32_to_cpup(mem + size));
>
>Thanks,
>Gavin
