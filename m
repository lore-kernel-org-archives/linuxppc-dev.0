Return-Path: <frowand.list@gmail.com>
Received: from mail-io0-x229.google.com (mail-io0-x229.google.com
 [IPv6:2607:f8b0:4001:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN1bG2lBBzDqpW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 04:16:10 +1000 (AEST)
Received: by mail-io0-x229.google.com with SMTP id g35so23574560ioi.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 11:16:09 -0700 (PDT)
Subject: Re: [PATCH v6 1/4] of: remove *phandle properties from expanded
 device tree
To: Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <1497996172-821-1-git-send-email-frowand.list@gmail.com>
 <1497996172-821-2-git-send-email-frowand.list@gmail.com>
 <87mv92szsw.fsf@concordia.ellerman.id.au>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <598216E5.8050907@gmail.com>
Date: Wed, 2 Aug 2017 11:16:05 -0700
MIME-Version: 1.0
In-Reply-To: <87mv92szsw.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

In Rob's reply to you email, he said:

   I'd like to move towards dropping 'linux,phandle' including changing 
   dtc to stop generating both properties by default. Perhaps we should 
   just be more explicit that we are doing that. Stop exposing it first and 
   then change how phandles are stored/managed a cycle later. Then we can 
   easily revert it if needed.

My current plan is to follow that suggestion.  So fixing my patches that
started this thread will wait for a later cycle.  But I would like to
try to address the issues with property "ibm,phandle" that you raised
below _before_ fixing my patches.  Those fixes should help me understand
"ibm,phandle" better, and hopefully when I update my patches I will not
cause further "ibm,phandle" issues.

More comments from me, embedded below.


On 06/20/17 21:57, Michael Ellerman wrote:
> Hi Frank,
> 
> frowand.list@gmail.com writes:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Remove "phandle", "linux,phandle", and "ibm,phandle" properties from
>> the internal device tree.  The phandle will still be in the struct
>> device_node phandle field and will still be displayed as if it is
>> a property in /proc/device_tree.
>>
>> This is to resolve the issue found by Stephen Boyd [1] when he changed
>> the type of struct property.value from void * to const void *.  As
>> a result of the type change, the overlay code had compile errors
>> where the resolver updates phandle values.
>>
>>   [1] http://lkml.iu.edu/hypermail/linux/kernel/1702.1/04160.html
>>
>> - Add sysfs infrastructure to report np->phandle, as if it was a property.
>> - Do not create "phandle" "ibm,phandle", and "linux,phandle" properties
>>   in the expanded device tree.
>> - Remove phandle properties in of_attach_node(), for nodes dynamically
>>   attached to the live tree.  Add the phandle sysfs entry for these nodes.
>> - When creating an overlay changeset, duplicate the node phandle in
>>   __of_node_dup().
>> - Remove no longer needed checks to exclude "phandle" and "linux,phandle"
>>   properties in several locations.
>> - A side effect of these changes is that the obsolete "linux,phandle" and
>>   "ibm,phandle" properties will no longer appear in /proc/device-tree (they
>>   will appear as "phandle").
> 
> Sorry but I don't think that can work for us.
> 
> Our DLPAR (ie. CPU/memory/device hotplug) stuff on PowerVM uses
> "ibm,phandle", and it's not the same thing as "phandle" /
> "linux,phandle".
> 
> I don't know the code well myself, but the spec (PAPR) says:
> 
>   Note: If the “ibm,phandle” property exists, there are two “phandle”
>   namespaces which must be kept separate. One is that actually used by
>   the OF client interface, the other is properties in the device tree
>   making reference to device tree nodes. These requirements are written
>   to maintain backward compatibility with older FW versions predating
>   these requirements; if the “ibm,phandle” property is not present, the
>   OS may assume that any device tree properties which refer to this node
>   will have a phandle value matching that returned by client interface
>   services.
> 
> I have systems here that still use "ibm,phandle". I also see at least
> some of the userspace code that looks for "ibm,phandle", and nothing
> else.
> 
> The note above actually implies that the current Linux code is wrong,
> when it uses "ibm,phandle" as the value of np->phandle.

This is where I get lost, and need your help and expertise.

If I do the naive search:

   git grep '"ibm,phandle"'


I find it used in three files.

(1) drivers/of/fdt.c, which is part of what my patches modified.

(2) drivers/misc/cxl/of.c reads (and optionally reports the value of)
"ibm,phandle", but does not use the value for anything else.

(3) drivers/of/dynamic.c gets and uses the value of "ibm,phandle"
only if properties "phandle" and "linux,phandle" do not exist.
If either of those two properties exist, their value is used
preferentially to the value of "ibm,phandle".  So in this case
it seems that folding the value of "ibm,phandle" into "phandle"
would work properly.

Is the "ibm,phandle" property used elsewhere in a way that my
naive search missed it?  Should it be used in a place that is
not using it?


> So sorry that's a big mess, but we can't just rip out those properties.

You provide some useful references and information above, but I do not
understand what I am reading.  :-)


> I think the minimal change would be to treat "ibm,phandle" like a normal
> property, I think that would allow our tools to keep working?

This sounds reasonable.  Since userspace is using the "ibm,phandle"
property we need to continue to expose that property to userspace.

If userspace needs to differentiate between "phandle" and "ibm,phandle"
then we will need to keep "ibm,phandle" for as long as userspace needs
it.  Otherwise, there is a possibility that we could update userspace,
wait a long time, then remove "ibm,phandle".


> The other thing that worries me is that by renaming (effectively)
> "linux,phandle" to "phandle", we lose the ability to accurately
> regenerate the device tree from /proc/device-tree. In theory it
> shouldn't matter, but I worry that in practice something will break.

Hopefully we will flush any such problem out with Rob's suggestion of doing
the easily reversible removal of generating the "linux,phandle" property
when we compile device trees.  Then wait a while before removing it from
the kernel.


> What if we just kept a single bit flag somewhere indicating if the name of
> the phandle property we found was "phandle" or "linux,phandle", and
> create the sysfs phandle using that name?
> 
> cheers
> 
