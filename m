Return-Path: <frowand.list@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsvff699CzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 16:18:34 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id y7so27878161pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 23:18:34 -0700 (PDT)
Subject: Re: [PATCH v6 1/4] of: remove *phandle properties from expanded
 device tree
To: Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <1497996172-821-1-git-send-email-frowand.list@gmail.com>
 <1497996172-821-2-git-send-email-frowand.list@gmail.com>
 <87mv92szsw.fsf@concordia.ellerman.id.au>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <594A0FB6.2000102@gmail.com>
Date: Tue, 20 Jun 2017 23:18:30 -0700
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

Hi Rob,

Michael has an issue that means this patch series is not OK in the
current form.  I will work on a v7 to see if I can resolve the
issue.

-Frank


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
> 
> So sorry that's a big mess, but we can't just rip out those properties.
> 
> I think the minimal change would be to treat "ibm,phandle" like a normal
> property, I think that would allow our tools to keep working?
> 
> 
> The other thing that worries me is that by renaming (effectively)
> "linux,phandle" to "phandle", we lose the ability to accurately
> regenerate the device tree from /proc/device-tree. In theory it
> shouldn't matter, but I worry that in practice something will break.
> 
> What if we just kept a single bit flag somewhere indicating if the name of
> the phandle property we found was "phandle" or "linux,phandle", and
> create the sysfs phandle using that name?
> 
> cheers
> 
