Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B9D21A0BAB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 10:06:48 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 5 Nov 2015 09:06:46 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 94E4D3578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 10:06:39 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4N6PV832374870
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 10:06:33 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4N654E030555
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 10:06:07 +1100
Date: Thu, 5 Nov 2015 10:05:41 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
 Bjorn Helgaas <bhelgaas@google.com>,
 Grant Likely <grant.likely@linaro.org>,
 Pantelis Antoniou <panto@antoniou-consulting.com>,
 Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v7 44/50] drivers/of: Split unflatten_dt_node()
Message-ID: <20151104230541.GA9287@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-45-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqLp29DBdhqaaU4U7pn0juitmBBmgwaFvm+ATu+nhhwj5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqLp29DBdhqaaU4U7pn0juitmBBmgwaFvm+ATu+nhhwj5A@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 04, 2015 at 12:43:08PM -0600, Rob Herring wrote:
>On Wed, Nov 4, 2015 at 7:12 AM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> The function unflatten_dt_node() is called recursively to unflatten
>> device nodes and properties in the FDT blob. It looks complicated
>> and hard to be understood.
>>
>> This splits the function into 3 functions: populate_properties(),
>> populate_node() and unflatten_dt_node(). populate_properties(),
>> which is called by populate_node(), creates properties for the
>> indicated device node. The later one creates the device nodes
>> from FDT blob. populate_node() gets the offset in FDT blob for
>> next device nodes and then calls populate_node(). No logical
>> changes introduced.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  drivers/of/fdt.c | 275 ++++++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 160 insertions(+), 115 deletions(-)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 6e82bc42..173b036 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -160,39 +160,127 @@ static void *unflatten_dt_alloc(void **mem, unsigned long size,
>>         return res;
>>  }
>>
>> -/**
>> - * unflatten_dt_node - Alloc and populate a device_node from the flat tree
>> - * @blob: The parent device tree blob
>> - * @mem: Memory chunk to use for allocating device nodes and properties
>> - * @poffset: pointer to node in flat tree
>> - * @dad: Parent struct device_node
>> - * @nodepp: The device_node tree created by the call
>> - * @fpsize: Size of the node path up at the current depth.
>> - * @dryrun: If true, do not allocate device nodes but still calculate needed
>> - * memory size
>> - */
>> -static void * unflatten_dt_node(const void *blob,
>> -                               void *mem,
>> -                               int *poffset,
>> -                               struct device_node *dad,
>> -                               struct device_node **nodepp,
>> -                               unsigned long fpsize,
>> +static void populate_properties(const void *blob,
>> +                               int offset,
>> +                               void **mem,
>> +                               struct device_node *np,
>> +                               const char *nodename,
>>                                 bool dryrun)
>
>I'd like to make dryrun implicit. It is basically a function of NULL
>or near NULL pointers.
>


[1] The condition would be something like below:

    if ((unsigned long)(*mem) < limit)
	dryrun = true;
    else
        dryrun = false;

The question here is how to choose a sane @limit in practice. In !dryrun case,
the memory is allocated from memblock at system booting time, or slab when system
is up. memblock could assign memory in bottom-up fasion.

When @limit is too small, the condition wouldn't be comprehensive in !dryrun
case. When @limit is too large, the !dryrun cases can be regarded as dryrun case.

>>  {
>> -       const __be32 *p;
>> +       struct property *pp, **pprev = NULL;
>> +       int cur;
>> +       bool has_name = false;
>> +
>> +       pprev = &np->properties;
>> +       cur = fdt_first_property_offset(blob, offset);
>> +       while (cur >= 0) {
>
>This could be better written as a for loop to avoid the gotos:
>
>for (cur = fdt_first_property_offset(blob, offset); cur >=0; cur =
>fdt_next_property_offset(blob, cur))
>

Thanks, the changes will be included in next revision.

>> +               const __be32 *val;
>> +               const char *pname;
>> +               u32 sz;
>> +
>> +               val = fdt_getprop_by_offset(blob, cur, &pname, &sz);
>> +               if (!val) {
>> +                       pr_warn("%s: Cannot locate property at 0x%x\n",
>> +                               __func__, cur);
>> +                       goto next;
>> +               }
>> +
>> +               if (!pname) {
>> +                       pr_warn("%s: Cannot find property name at 0x%x\n",
>> +                               __func__, cur);
>> +                       goto next;
>> +               } else if (!strcmp(pname, "name")) {
>> +                       has_name = true;
>> +               }
>> +
>> +               pp = unflatten_dt_alloc(mem, sizeof(struct property),
>> +                                       __alignof__(struct property));
>> +               if (!dryrun) {
>
>Then:
>
>if (dryrun)
>  continue;
>
>to save some indentation and vertical code.
>

Good idea, it will be included in next revision.

>> +                       /* We accept flattened tree phandles either in
>> +                        * ePAPR-style "phandle" properties, or the
>> +                        * legacy "linux,phandle" properties.  If both
>> +                        * appear and have different values, things
>> +                        * will get weird. Don't do that.
>> +                        */
>> +                       if (!strcmp(pname, "phandle") ||
>> +                           !strcmp(pname, "linux,phandle")) {
>> +                               if (!np->phandle)
>> +                                       np->phandle = be32_to_cpup(val);
>> +                       }
>> +
>> +                       /* And we process the "ibm,phandle" property
>> +                        * used in pSeries dynamic device tree
>> +                        * stuff
>> +                        */
>> +                       if (!strcmp(pname, "ibm,phandle"))
>> +                               np->phandle = be32_to_cpup(val);
>> +
>> +                       pp->name   = (char *)pname;
>> +                       pp->length = sz;
>> +                       pp->value  = (__be32 *)val;
>> +                       *pprev     = pp;
>> +                       pprev      = &pp->next;
>> +               }
>> +next:
>> +               cur = fdt_next_property_offset(blob, cur);
>> +       }
>> +
>> +       /* With version 0x10 we may not have the name property,
>> +        * recreate it here from the unit name if absent
>> +        */
>> +       if (!has_name) {
>> +               const char *p = nodename, *ps = p, *pa = NULL;
>> +               int len;
>> +
>> +               while (*p) {
>> +                       if ((*p) == '@')
>> +                               pa = p;
>> +                       else if ((*p) == '/')
>> +                               ps = p + 1;
>> +                       p++;
>> +               }
>> +
>> +               if (pa < ps)
>> +                       pa = p;
>> +               len = (pa - ps) + 1;
>> +               pp = unflatten_dt_alloc(mem, sizeof(struct property) + len,
>> +                                       __alignof__(struct property));
>> +               if (!dryrun) {
>> +                       pp->name   = "name";
>> +                       pp->length = len;
>> +                       pp->value  = pp + 1;
>> +                       *pprev     = pp;
>> +                       pprev      = &pp->next;
>> +                       memcpy(pp->value, ps, len - 1);
>> +                       ((char *)pp->value)[len - 1] = 0;
>> +                       pr_debug("fixed up name for %s -> %s\n",
>> +                                nodename, (char *)pp->value);
>> +               }
>> +       }
>> +
>> +       if (!dryrun)
>> +               *pprev = NULL;
>> +}
>> +
>> +static unsigned long populate_node(const void *blob,
>> +                                  int offset,
>> +                                  void **mem,
>> +                                  struct device_node *dad,
>> +                                  unsigned long fpsize,
>> +                                  struct device_node **pnp,
>> +                                  bool dryrun)
>
>I think dryrun could be implied here too.
>

I don't think so. Please refer to the explanation at [1].

>> +{
>>         struct device_node *np;
>> -       struct property *pp, **prev_pp = NULL;
>>         const char *pathp;
>>         unsigned int l, allocl;
>> -       static int depth = 0;
>> -       int old_depth;
>> -       int offset;
>> -       int has_name = 0;
>> -       int new_format = 0;
>> +       bool new_format = false;
>> +       char *fname;
>>
>> -       pathp = fdt_get_name(blob, *poffset, &l);
>> -       if (!pathp)
>> -               return mem;
>> +       pathp = fdt_get_name(blob, offset, &l);
>> +       if (!pathp) {
>> +               *pnp = NULL;
>
>Can't pnp be NULL?
>

It can't be NULL in both dryrun and !dryrun cases.

>> +               return 0;
>> +       }
>>
>>         allocl = ++l;
>>
>> @@ -202,7 +290,7 @@ static void * unflatten_dt_node(const void *blob,
>>          * not '/'.
>>          */
>>         if ((*pathp) != '/') {
>> -               new_format = 1;
>> +               new_format = true;
>>                 if (fpsize == 0) {
>>                         /* root node: special case. fpsize accounts for path
>>                          * plus terminating zero. root node only has '/', so
>> @@ -222,112 +310,38 @@ static void * unflatten_dt_node(const void *blob,
>>                 }
>>         }
>>
>> -       np = unflatten_dt_alloc(&mem, sizeof(struct device_node) + allocl,
>> +       np = unflatten_dt_alloc(mem, sizeof(struct device_node) + allocl,
>>                                 __alignof__(struct device_node));
>>         if (!dryrun) {
>> -               char *fn;
>>                 of_node_init(np);
>> -               np->full_name = fn = ((char *)np) + sizeof(*np);
>> +               np->full_name = fname = ((char *)np) + sizeof(*np);
>
>If you kept "fn" that would cut down the diff and make it a bit easier
>to review.
>

Agree, I'll drop the rename in next revision. I perhaps have separate
patch to do the renaming after this patch. In that way, unrelated code
changes will be avoided in this one.

>>                 if (new_format) {
>> -                       /* rebuild full path for new format */
>> +                       /* Rebuild full path for new format */
>>                         if (dad && dad->parent) {
>> -                               strcpy(fn, dad->full_name);
>> +                               strcpy(fname, dad->full_name);
>>  #ifdef DEBUG
>> -                               if ((strlen(fn) + l + 1) != allocl) {
>> +                               if ((strlen(fname) + l + 1) != allocl) {
>>                                         pr_debug("%s: p: %d, l: %d, a: %d\n",
>> -                                               pathp, (int)strlen(fn),
>> -                                               l, allocl);
>> +                                                pathp, (int)strlen(fn),
>
>This won't compile if enabled (should be fname).
>

Indeed, I even didn't try to compile this piece of debugging code. Will change
accordingly in next revision.

>> +                                                l, allocl);
>>                                 }
>>  #endif
>> -                               fn += strlen(fn);
>> +                               fname += strlen(fname);
>>                         }
>> -                       *(fn++) = '/';
>> +                       *(fname++) = '/';
>>                 }
>> -               memcpy(fn, pathp, l);
>> +               memcpy(fname, pathp, l);
>>
>> -               prev_pp = &np->properties;
>> -               if (dad != NULL) {
>> +               if (dad) {
>>                         np->parent = dad;
>>                         np->sibling = dad->child;
>>                         dad->child = np;
>>                 }
>>         }
>> -       /* process properties */
>> -       for (offset = fdt_first_property_offset(blob, *poffset);
>> -            (offset >= 0);
>> -            (offset = fdt_next_property_offset(blob, offset))) {
>> -               const char *pname;
>> -               u32 sz;
>>
>> -               if (!(p = fdt_getprop_by_offset(blob, offset, &pname, &sz))) {
>> -                       offset = -FDT_ERR_INTERNAL;
>> -                       break;
>> -               }
>> -
>> -               if (pname == NULL) {
>> -                       pr_info("Can't find property name in list !\n");
>> -                       break;
>> -               }
>> -               if (strcmp(pname, "name") == 0)
>> -                       has_name = 1;
>> -               pp = unflatten_dt_alloc(&mem, sizeof(struct property),
>> -                                       __alignof__(struct property));
>> -               if (!dryrun) {
>> -                       /* We accept flattened tree phandles either in
>> -                        * ePAPR-style "phandle" properties, or the
>> -                        * legacy "linux,phandle" properties.  If both
>> -                        * appear and have different values, things
>> -                        * will get weird.  Don't do that. */
>> -                       if ((strcmp(pname, "phandle") == 0) ||
>> -                           (strcmp(pname, "linux,phandle") == 0)) {
>> -                               if (np->phandle == 0)
>> -                                       np->phandle = be32_to_cpup(p);
>> -                       }
>> -                       /* And we process the "ibm,phandle" property
>> -                        * used in pSeries dynamic device tree
>> -                        * stuff */
>> -                       if (strcmp(pname, "ibm,phandle") == 0)
>> -                               np->phandle = be32_to_cpup(p);
>> -                       pp->name = (char *)pname;
>> -                       pp->length = sz;
>> -                       pp->value = (__be32 *)p;
>> -                       *prev_pp = pp;
>> -                       prev_pp = &pp->next;
>> -               }
>> -       }
>> -       /* with version 0x10 we may not have the name property, recreate
>> -        * it here from the unit name if absent
>> -        */
>> -       if (!has_name) {
>> -               const char *p1 = pathp, *ps = pathp, *pa = NULL;
>> -               int sz;
>> -
>> -               while (*p1) {
>> -                       if ((*p1) == '@')
>> -                               pa = p1;
>> -                       if ((*p1) == '/')
>> -                               ps = p1 + 1;
>> -                       p1++;
>> -               }
>> -               if (pa < ps)
>> -                       pa = p1;
>> -               sz = (pa - ps) + 1;
>> -               pp = unflatten_dt_alloc(&mem, sizeof(struct property) + sz,
>> -                                       __alignof__(struct property));
>> -               if (!dryrun) {
>> -                       pp->name = "name";
>> -                       pp->length = sz;
>> -                       pp->value = pp + 1;
>> -                       *prev_pp = pp;
>> -                       prev_pp = &pp->next;
>> -                       memcpy(pp->value, ps, sz - 1);
>> -                       ((char *)pp->value)[sz - 1] = 0;
>> -                       pr_debug("fixed up name for %s -> %s\n", pathp,
>> -                               (char *)pp->value);
>> -               }
>> -       }
>> +       /* Populate the properties */
>
>Kind of a useless comment.
>

Agree, will drop in next revision.

>> +       populate_properties(blob, offset, mem, np, pathp, dryrun);
>>         if (!dryrun) {
>> -               *prev_pp = NULL;
>>                 np->name = of_get_property(np, "name", NULL);
>>                 np->type = of_get_property(np, "device_type", NULL);
>>
>> @@ -337,6 +351,37 @@ static void * unflatten_dt_node(const void *blob,
>>                         np->type = "<NULL>";
>>         }
>>
>> +       *pnp = np;
>> +       return fpsize;
>> +}
>> +
>> +/**
>> + * unflatten_dt_node - Alloc and populate a device_node from the flat tree
>> + * @blob: The parent device tree blob
>> + * @mem: Memory chunk to use for allocating device nodes and properties
>> + * @poffset: pointer to node in flat tree
>> + * @dad: Parent struct device_node
>> + * @nodepp: The device_node tree created by the call
>> + * @fpsize: Size of the node path up at the current depth.
>> + * @dryrun: If true, do not allocate device nodes but still calculate needed
>> + * memory size
>> + */
>> +static void *unflatten_dt_node(const void *blob,
>> +                              void *mem,
>> +                              int *poffset,
>> +                              struct device_node *dad,
>> +                              struct device_node **nodepp,
>> +                              unsigned long fpsize,
>> +                              bool dryrun)
>> +{
>> +       struct device_node *np;
>> +       static int depth;
>> +       int old_depth;
>> +
>> +       fpsize = populate_node(blob, *poffset, &mem, dad, fpsize, &np, dryrun);
>
>Doesn't this give a warning assigning a ptr to long?
>
>Looks like np can be moved internal to populate_node.
>

@fpsize and the return value of populate_node() are "unsigned long".

Nope, @np will be used in next patch in this function, which tracks the
device node unflattened in last level of depth.

>
>> +       if (!fpsize)
>> +               return mem;
>> +
>>         old_depth = depth;
>>         *poffset = fdt_next_node(blob, *poffset, &depth);
>>         if (depth < 0)

Thanks,
Gavin
