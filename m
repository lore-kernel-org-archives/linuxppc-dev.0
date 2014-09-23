Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7C521A019D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 00:43:21 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 23 Sep 2014 08:43:18 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D86CD19D803D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 08:32:00 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8NEhExd40829086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 16:43:15 +0200
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8NEhDjM027643
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 08:43:14 -0600
Message-ID: <54218701.8080105@linux.vnet.ibm.com>
Date: Tue, 23 Sep 2014 09:43:13 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [3/5] pseries: Create device hotplug entry point
References: <54174CB7.2080704@linux.vnet.ibm.com>
 <1410937632.27681.11.camel@concordia> <5419DDB8.1070001@linux.vnet.ibm.com>
 <5420C995.9050104@linux.vnet.ibm.com>
In-Reply-To: <5420C995.9050104@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/22/2014 08:15 PM, Tyrel Datwyler wrote:
> On 09/17/2014 12:15 PM, Nathan Fontenot wrote:
>> On 09/17/2014 02:07 AM, Michael Ellerman wrote:
>>>
>>> On Mon, 2014-09-15 at 15:31 -0500, Nathan Fontenot wrote:
>>>> For pseries system the kernel will be notified of hotplug requests in
>>>> the form of rtas hotplug events. 
>>>
>>> Can you flesh that design out a bit for me, I don't entirely get how it's going
>>> to work.
>>>
>>> The kernel gets the rtas hotplug events (in rtasd.c) and spits them out to
>>> userspace, which then writes them back in ?
>>>
>>>> This patch creates a common routine that can handle these requests in both
>>>> the PowerVM anbd PowerKVM environments, handle_dlpar_errorlog(). This also
>>>                 ^
>>>> creates the initial memory hotplug request handling stub.
>>>>
>>>> For PowerVM this patch also creates a new /proc file that the drmgr
>>>> command will use to write rtas hotplug events to.
>>>
>>> Why is this different between phyp and KVM?
>>>
>>>> For future PowerKVM handling the rtas check-exception code can pass
>>>> any rtas hotplug events received to handle_dlpar_errorlog().
>>>
>>> Internally to the kernel you mean?
>>>
>>
>> Perhaps a better explanation of how things work today and where I see
>> them going is needed. I was trying to avoid a long explanation and I
>> don't think my shortened explanation worked. I'll include this in v2
>> of the patchset too.
>>
>> The current hotplug (or dlpar) of devices (the process is generally the
>> same for memory, cpu, and pci) on PowerVM systems is initiated
>> from the HMC, which communicates the request to the partitions through
>> the RSCT framework. The RSCT framework then invokes the drmgr command.
>> The drmgr command performs the hotplug operation by doing some pieces,
>> such as most of the rtas calls and device tree parsing, in userspace
>> and make requests to the kernel to online/offline the device, update the
>> device tree and add/remove the device.
>>
>> For PowerKVM the approach is to follow what is currently being done for
>> pci hotplug. A hotplug request is initiated from the host. QEMU then
>> sends an EPOW interrupt to the guest which causes the guest to make the
>> rtas,check-exception call. In QEMU, the rtas,check-exception call
>> returns a rtas hotplug event to the guest. I was using this same framework
>> to also enable memory (and next cpu) hotplug.
>>
>> You are correct that the current pci hotplug path for PowerKVM involves
>> the kernel receiving the rtas event, passing it to rtas_errd in userspace,
>> and having rtas_errd invoke drmgr. The drmgr command then handles the request
>> as described above for PowerVM systems.
>>
>> There is no need for this circuitous route, we should just handle the entire
>> hotplug of devices in the kernel. What I am hoping to do is to enable this
>> by moving the code to handle hotplug from drmgr into the kernel and 
>> provide a single path for handling hotplug for PowerVM and PowerKVM. To
>> make this work for PowerKVM we will update the kernel rtas code to
>> recognize rtas hotplug events returned from rtas,check-exception calls
>> and call handle_dlpar_errorlog(). The hotplug rtas event is never sent out
>> to userspace.
> 
> Wouldn't we still want the event surfaced to userspace so that it can at
> least be logged?
> 

The only logging of hotplug/dlpar events we do is putting a notification
iv /var/log/messages. This is done today by the drmgr command.

I can add a pr_info message to log the hotplug/dlpar request and it's
success/failure.

Also, I believe one of the longer term goals is to not require the rtas_errd
daemon for PowerKVM.

-Nathan
