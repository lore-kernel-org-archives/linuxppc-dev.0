Return-Path: <bhelgaas@google.com>
Received: from mail-qc0-x232.google.com (mail-qc0-x232.google.com
 [IPv6:2607:f8b0:400d:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A42DC1A0AD2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 06:10:09 +1000 (EST)
Received: by mail-qc0-f178.google.com with SMTP id x13so17915871qcv.37
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Sep 2014 13:10:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140820061402.GA8381@richard>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1406182947-11302-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140820030841.GD6295@google.com> <20140820061402.GA8381@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 9 Sep 2014 14:09:46 -0600
Message-ID: <CAErSpo5ZSB-=aQtiM5OenfWWfn2b=TOwxM-BkpwxBGRnmMyAzw@mail.gmail.com>
Subject: Re: [PATCH V7 04/17] PCI: Take additional IOV BAR alignment in sizing
 and assigning
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Mike Qiu <qiudayu@linux.vnet.ibm.com>,
 Guo Chao <yan@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 20, 2014 at 12:14 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Tue, Aug 19, 2014 at 09:08:41PM -0600, Bjorn Helgaas wrote:
>>On Thu, Jul 24, 2014 at 02:22:14PM +0800, Wei Yang wrote:
>>> At resource sizing/assigning stage, resources are divided into two lists,
>>> requested list and additional list, while the alignement of the additional
>>> IOV BAR is not taken into the sizeing and assigning procedure.
>>>
>>> This is reasonable in the original implementation, since IOV BAR's alignment is
>>> mostly the size of a PF BAR alignemt. This means the alignment is already taken
>>> into consideration. While this rule may be violated on some platform.
>>>
>>> This patch take the additional IOV BAR alignment in sizing and assigning stage
>>> explicitly.
>>>
>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>> ---
>>>  drivers/pci/setup-bus.c |   68 +++++++++++++++++++++++++++++++++++++++++------
>>>  1 file changed, 60 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>>> index a5a63ec..d83681f 100644
>>> --- a/drivers/pci/setup-bus.c
>>> +++ b/drivers/pci/setup-bus.c
>>> @@ -120,6 +120,28 @@ static resource_size_t get_res_add_size(struct list_head *head,
>>>      return 0;
>>>  }
>>>
>>> +static resource_size_t get_res_add_align(struct list_head *head,
>>> +            struct resource *res)
>>> +{
>>> +    struct pci_dev_resource *dev_res;
>>> +
>>> +    list_for_each_entry(dev_res, head, list) {
>>> +            if (dev_res->res == res) {
>>> +                    int idx = res - &dev_res->dev->resource[0];
>>> +
>>> +                    dev_printk(KERN_DEBUG, &dev_res->dev->dev,
>>> +                               "res[%d]=%pR get_res_add_align min_align %llx\n",
>>> +                               idx, dev_res->res,
>>> +                               (unsigned long long)dev_res->min_align);
>>> +
>>> +                    return dev_res->min_align;
>>> +            }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>
>>I see that you copied the structure of the existing get_res_add_size()
>>here.  But I don't understand *that* function.  It looks basically like
>>this:
>>
>>  resource_size_t get_res_add_size(list, res)
>>  {
>>    list_for_each_entry(dev_res, head, list) {
>>      if (dev_res->res == res)
>>        return dev_res->add_size;
>>    }
>>    return 0;
>>  }
>>
>>and we call it like this:
>>
>>  dev_res->res->end += get_res_add_size(realloc_head, dev_res->res);
>>
>>So we start out with dev_res", pass in dev_res->res, search the
>>realloc_head list to find dev_res again, and return dev_res->add_size.
>>That looks equivalent to just:
>>
>>  dev_res->res->end += dev_res->add_size;
>>
>>It looks like get_res_add_size() merely adds a printk and some complexity.
>>Am I missing something?
>>
>
> Let me try to explain it, if not correct, please let know :-)
>
>   dev_res->res->end += get_res_add_size(realloc_head, dev_res->res);
>
> would be expanded to:
>
>   dev_res->res->end += dev_res_1->add_size;
>
> with the dev_res_1 is another one from dev_res which is stored in realloc_head.

Yep, I see now.

>>I do see that there are other callers where we don't actually start with
>>dev_res, which makes it a little more complicated.  But I think you should
>>either add something like this:
>>
>>  struct pci_dev_resource *res_to_dev_res(list, res)
>>  {
>>    list_for_each_entry(dev_res, head, list) {
>>      if (dev_res->res == res)
>>        return dev_res;
>>    }
>>    return NULL;
>>  }
>>
>
> Ok, we can extract the common part of these two functions.
>
>>which can be used to replace get_res_add_size() and get_res_add_align(), OR
>>figure out whether the dev_res of interest is always one we've just added.
>>If it is, maybe you can just make add_to_list() return the dev_res pointer
>>instead of an errno, and hang onto the pointer.  I'd like that much better
>>if that's possible.
>>
>
> Sorry, I don't get this point.

Don't worry, it didn't make sense.  I was thinking that we knew the
dev_res up front and didn't need to look it up, but that's not the
case.

Sorry it took me so long to respond to this; I'm a bit swamped dealing
with some regressions.

Bjorn

> add_to_list() is used to create the pci_dev_resource list, get_res_add_size()
> and get_res_add_align() is to retrieve the information in the list. I am not
> sure how to leverage add_to_list() in these two functions?
>
>>> +
>>> +
>>>  /* Sort resources by alignment */
>>>  static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
>>>  {
>>> @@ -368,8 +390,9 @@ static void __assign_resources_sorted(struct list_head *head,
>>>      LIST_HEAD(save_head);
>>>      LIST_HEAD(local_fail_head);
>>>      struct pci_dev_resource *save_res;
>>> -    struct pci_dev_resource *dev_res, *tmp_res;
>>> +    struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
>>>      unsigned long fail_type;
>>> +    resource_size_t add_align, align;
>>>
>>>      /* Check if optional add_size is there */
>>>      if (!realloc_head || list_empty(realloc_head))
>>> @@ -384,10 +407,31 @@ static void __assign_resources_sorted(struct list_head *head,
>>>      }
>>>
>>>      /* Update res in head list with add_size in realloc_head list */
>>> -    list_for_each_entry(dev_res, head, list)
>>> +    list_for_each_entry_safe(dev_res, tmp_res, head, list) {
>>>              dev_res->res->end += get_res_add_size(realloc_head,
>>>                                                      dev_res->res);
>>>
>>> +            if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
>>> +                    continue;
>>> +
>>> +            add_align = get_res_add_align(realloc_head, dev_res->res);
>>> +
>>> +            if (add_align > dev_res->res->start) {
>>> +                    dev_res->res->start = add_align;
>>> +                    dev_res->res->end = add_align +
>>> +                                        resource_size(dev_res->res);
>>> +
>>> +                    list_for_each_entry(dev_res2, head, list) {
>>> +                            align = pci_resource_alignment(dev_res2->dev,
>>> +                                                           dev_res2->res);
>>> +                            if (add_align > align)
>>> +                                    list_move_tail(&dev_res->list,
>>> +                                                   &dev_res2->list);
>>> +                    }
>>> +               }
>>> +
>>> +    }
>>> +
>>>      /* Try updated head list with add_size added */
>>>      assign_requested_resources_sorted(head, &local_fail_head);
>>>
>>> @@ -930,6 +974,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>>>      struct resource *b_res = find_free_bus_resource(bus,
>>>                                      mask | IORESOURCE_PREFETCH, type);
>>>      resource_size_t children_add_size = 0;
>>> +    resource_size_t children_add_align = 0;
>>> +    resource_size_t add_align = 0;
>>>
>>>      if (!b_res)
>>>              return -ENOSPC;
>>> @@ -954,6 +1000,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>>>                      /* put SRIOV requested res to the optional list */
>>>                      if (realloc_head && i >= PCI_IOV_RESOURCES &&
>>>                                      i <= PCI_IOV_RESOURCE_END) {
>>> +                            add_align = max(pci_resource_alignment(dev, r), add_align);
>>>                              r->end = r->start - 1;
>>>                              add_to_list(realloc_head, dev, r, r_size, 0/* don't care */);
>>>                              children_add_size += r_size;
>>> @@ -984,8 +1031,11 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>>>                      if (order > max_order)
>>>                              max_order = order;
>>>
>>> -                    if (realloc_head)
>>> +                    if (realloc_head) {
>>>                              children_add_size += get_res_add_size(realloc_head, r);
>>> +                            children_add_align = get_res_add_align(realloc_head, r);
>>> +                            add_align = max(add_align, children_add_align);
>>> +                    }
>>>              }
>>>      }
>>>
>>> @@ -996,7 +1046,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>>>              add_size = children_add_size;
>>>      size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
>>>              calculate_memsize(size, min_size, add_size,
>>> -                            resource_size(b_res), min_align);
>>> +                            resource_size(b_res), max(min_align, add_align));
>>>      if (!size0 && !size1) {
>>>              if (b_res->start || b_res->end)
>>>                      dev_info(&bus->self->dev, "disabling bridge window %pR to %pR (unused)\n",
>>> @@ -1008,10 +1058,12 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>>>      b_res->end = size0 + min_align - 1;
>>>      b_res->flags |= IORESOURCE_STARTALIGN;
>>>      if (size1 > size0 && realloc_head) {
>>> -            add_to_list(realloc_head, bus->self, b_res, size1-size0, min_align);
>>> -            dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window %pR to %pR add_size %llx\n",
>>> -                       b_res, &bus->busn_res,
>>> -                       (unsigned long long)size1-size0);
>>> +            add_to_list(realloc_head, bus->self, b_res, size1-size0,
>>> +                            max(min_align, add_align));
>>> +            dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "
>>> +                             "%pR to %pR add_size %llx add_align %llx\n", b_res,
>>> +                             &bus->busn_res, (unsigned long long)size1-size0,
>>> +                             max(min_align, add_align));
>>
>>Factor out this "max(min_align, add_align)" thing so we don't have to
>>change these lines.  Bonus points if you can also factor it out of the
>>calculate_memsize() call above.  That one is a pretty complicated ternary
>>expression that should probably be turned into an "if" instead anyway.
>>
>
> Ok, I get your point. Let me make it more easy to read.
>
>>>      }
>>>      return 0;
>>>  }
>>> --
>>> 1.7.9.5
>>>
>
> --
> Richard Yang
> Help you, Help me
>
