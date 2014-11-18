Return-Path: <cyril.bur@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 953C81A012E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 13:00:31 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyril.bur@au1.ibm.com>;
 Tue, 18 Nov 2014 12:00:27 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D95692CE8062
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 13:00:24 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAI22JYE14090378
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 13:02:19 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAI20Ogo004453
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 13:00:24 +1100
Message-ID: <1416276023.2797.9.camel@cyril>
Subject: Re: [PATCH v2 0/6] pseries: Move memory hotplug to the kernel
From: Cyril Bur <cyril.bur@au1.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 18 Nov 2014 13:00:23 +1100
In-Reply-To: <546A6C23.1080800@linux.vnet.ibm.com>
References: <546A6C23.1080800@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nathan,

I tried to apply these to Linus' tree and Mpes tree and to stable and
got several problems, I got stuck at the third hunk in patch 5.

Could you point out where I'm going wrong?

Thanks,

Cyril

On Mon, 2014-11-17 at 15:44 -0600, Nathan Fontenot wrote:
> In order to better support device hotplug (cpu, memory, and pci) in the
> PowerVM and PowerKVM environments, the handling of device hotplug
> could be updated so that the act of hotplugging a device occurs entirely
> in the kernel. This patch set begins to address this by moving
> memory hotplug to the kernel. Patches to follow will do the same
> for cpu and pci devices.
> 
> To provide background, the current handling of memory hotplug is
> handled by the drmgr command. This command is invoked when memory
> add/remove requests are made at the HMC and conveyed to a partition
> through the RSCT framework. The drmgr command then performs parts
> of the hotplug in user-space and makes requests to the kernel to perform
> other pieces. This is not really ideal, we can do everything in the
> kernel and do it faster.
> 
> In this patchset, hotplug events will now be communicated to the kernel
> in the form of rtas hotplug events. For PowerKVM systems this is done
> by qemu using the ras epow interrupt. For PowerVM systems the drmgr
> command will be updated to create a rtas hotplug event and send it to
> the kernel via a new /sys/kernel/dlpar interface. Both of these
> entry points for hotplug rtas events then call a common routine
> for handling rtas hotplug events.
> 
> -Nathan
> 
> Patch 1/6
> - Add definition of hotplug rtas event sections.
> 
> Patch 2/6
> - Update struct of_drconf_cell to use __be64/__be32
>  
> Patch 3/6
> - Export the dlpar_[acquire|release]drc() routines.
> 
> Patch 4/6
> - Create the new /sys/kernel/dlpar interface
> 
> Patch 5/6
> - Implement memory hotplug add in the kernel.
> 
> Patch 6/6
> - Implement memory hotplug remove in the kernel.
> 
>  include/asm/prom.h                 |   10 
>  include/asm/rtas.h                 |   26 ++
>  platforms/pseries/dlpar.c          |   72 +++++
>  platforms/pseries/hotplug-memory.c |  469 ++++++++++++++++++++++++++++++++++++-
>  platforms/pseries/pseries.h        |   12 
>  5 files changed, 576 insertions(+), 13 deletions(-)
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
