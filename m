Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8BF2C1A0976
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 05:34:53 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 18 Nov 2014 11:34:50 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C17DB38C805E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 13:34:16 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAIIYkaP23199822
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 18:34:47 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAIIYk4h024747
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 13:34:46 -0500
Message-ID: <546B9144.60003@linux.vnet.ibm.com>
Date: Tue, 18 Nov 2014 12:34:44 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cyril Bur <cyril.bur@au1.ibm.com>
Subject: Re: [PATCH v2 0/6] pseries: Move memory hotplug to the kernel
References: <546A6C23.1080800@linux.vnet.ibm.com>
 <1416276023.2797.9.camel@cyril>
In-Reply-To: <1416276023.2797.9.camel@cyril>
Content-Type: text/plain; charset=utf-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/2014 08:00 PM, Cyril Bur wrote:
> Hi Nathan,
> 
> I tried to apply these to Linus' tree and Mpes tree and to stable and
> got several problems, I got stuck at the third hunk in patch 5.

I based these patches off of mpe's -next tree. I did a fresh pull of
mpe's tree and found that they do apply with some fuzz to the master branch.

Which tree were you having issue with patch 5?

-Nathan

> 
> Could you point out where I'm going wrong?
> 
> Thanks,
> 
> Cyril
> 
> On Mon, 2014-11-17 at 15:44 -0600, Nathan Fontenot wrote:
>> In order to better support device hotplug (cpu, memory, and pci) in the
>> PowerVM and PowerKVM environments, the handling of device hotplug
>> could be updated so that the act of hotplugging a device occurs entirely
>> in the kernel. This patch set begins to address this by moving
>> memory hotplug to the kernel. Patches to follow will do the same
>> for cpu and pci devices.
>>
>> To provide background, the current handling of memory hotplug is
>> handled by the drmgr command. This command is invoked when memory
>> add/remove requests are made at the HMC and conveyed to a partition
>> through the RSCT framework. The drmgr command then performs parts
>> of the hotplug in user-space and makes requests to the kernel to perform
>> other pieces. This is not really ideal, we can do everything in the
>> kernel and do it faster.
>>
>> In this patchset, hotplug events will now be communicated to the kernel
>> in the form of rtas hotplug events. For PowerKVM systems this is done
>> by qemu using the ras epow interrupt. For PowerVM systems the drmgr
>> command will be updated to create a rtas hotplug event and send it to
>> the kernel via a new /sys/kernel/dlpar interface. Both of these
>> entry points for hotplug rtas events then call a common routine
>> for handling rtas hotplug events.
>>
>> -Nathan
>>
>> Patch 1/6
>> - Add definition of hotplug rtas event sections.
>>
>> Patch 2/6
>> - Update struct of_drconf_cell to use __be64/__be32
>>  
>> Patch 3/6
>> - Export the dlpar_[acquire|release]drc() routines.
>>
>> Patch 4/6
>> - Create the new /sys/kernel/dlpar interface
>>
>> Patch 5/6
>> - Implement memory hotplug add in the kernel.
>>
>> Patch 6/6
>> - Implement memory hotplug remove in the kernel.
>>
>>  include/asm/prom.h                 |   10 
>>  include/asm/rtas.h                 |   26 ++
>>  platforms/pseries/dlpar.c          |   72 +++++
>>  platforms/pseries/hotplug-memory.c |  469 ++++++++++++++++++++++++++++++++++++-
>>  platforms/pseries/pseries.h        |   12 
>>  5 files changed, 576 insertions(+), 13 deletions(-)
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
