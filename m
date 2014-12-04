Return-Path: <nfont@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F076D1A006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 14:07:34 +1100 (AEDT)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47DC31400A0
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 14:07:34 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 3 Dec 2014 20:07:32 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 102FA19D803F
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 19:56:09 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB437SrP35782854
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2014 20:07:28 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB437S9l007020
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2014 20:07:28 -0700
Message-ID: <547FCFEF.8090001@linux.vnet.ibm.com>
Date: Wed, 03 Dec 2014 21:07:27 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Right location in sysfs for dlpar file
References: <1417057941.5089.81.camel@kernel.crashing.org>
 <547C8C0F.5070701@linux.vnet.ibm.com> <20141202042626.GC9271@kroah.com>
In-Reply-To: <20141202042626.GC9271@kroah.com>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2014 10:26 PM, Greg KH wrote:
> On Mon, Dec 01, 2014 at 09:41:03AM -0600, Nathan Fontenot wrote:
>> On 11/26/2014 09:12 PM, Benjamin Herrenschmidt wrote:
>>> Hi Greg,
>>>
>>> So Nathan is working on a patch series to cleanup and improve our
>>> "DLPAR" infrastructure which is basically our hotplug mechanism when
>>> running under the PowerVM (aka pHyp) and KVM hypervisors.
>>
>> The cleanup to the dlpar infrastructure will move the entire operation
>> of hotplugging a device to the kernel instead of doing it partially in
>> userspace and partially in the kernel as is currently done.
>>
>>>
>>> I'll let Nathan give you a bit more details/background and answer
>>> subsequent question you might have as this is really his area of
>>> expertise.
>>>
>>> To cut a long story short, we need a sysfs file that allows our
>>> userspace tools to notify the kernel of hotplug events coming from
>>> the management console (which talks to userspace daemons using a
>>> proprietary protocol) to "initiate" the hotplug operations, which in
>>> turn get dispatched internally in the kernel to the right subsystem
>>> (memory, cpu, pci, ...) based on the resource type.
>>>
>>> On IRC, Greg suggested /sys/firmware and /sys/hypervisor which both
>>> look like a reasonable option to me, probably better than dlpar...
>>
>> For PowerVM systems we need this sysfs file to deliver what is
>> essentially a binary blob (specifically a rtas error log) to the
>> kernel. The current patch set is creating /sys/kernel/dlpar. As Ben
>> mentioned we would like your input on what would be the proper place
>> to create this file.
> 
> And what is the kernel supposed to do with such a binary blob?  Parse
> it?  Or pass it to something else?

The kernel will parse it and perform the requested hotplug operation.

> 
> Anyway, let's see the patches before I guess anything else, that will
> determine how things work out best.

I'll cc you on the next version of the patch set.

-Nathan
