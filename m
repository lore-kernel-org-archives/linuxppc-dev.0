Return-Path: <vkuznets@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSsbT6txbzDqJM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 20:32:37 +1100 (AEDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 mdroth@linux.vnet.ibm.com
Subject: Re: [RFC PATCH] memory-hotplug: Use dev_online for memhp_auto_offline
References: <20170221172234.8047.33382.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Date: Wed, 22 Feb 2017 10:32:34 +0100
In-Reply-To: <20170221172234.8047.33382.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 (Nathan Fontenot's message of "Tue, 21 Feb 2017 12:22:34 -0500")
Message-ID: <878toy1sgd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

s,memhp_auto_offline,memhp_auto_online, in the subject please :-)

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:

> Commit 31bc3858e "add automatic onlining policy for the newly added memory"
> provides the capability to have added memory automatically onlined
> during add, but this appears to be slightly broken.
>
> The current implementation uses walk_memory_range() to call
> online_memory_block, which uses memory_block_change_state() to online
> the memory. Instead I think we should be calling device_online()
> for the memory block in online_memory_block. This would online
> the memory (the memory bus online routine memory_subsys_online()
> called from device_online calls memory_block_change_state()) and
> properly update the device struct offline flag.
>
> As a result of the current implementation, attempting to remove
> a memory block after adding it using auto online fails.
> This is
> because doing a remove, for instance
> 'echo offline > /sys/devices/system/memory/memoryXXX/state', uses
> device_offline() which checks the dev->offline flag.

I see the issue.

>
> There is a workaround in that a user could online the memory or have
> a udev rule to online the memory by using the sysfs interface. The
> sysfs interface to online memory goes through device_online() which
> should updated the dev->offline flag. I'm not sure that having kernel
> memory hotplug rely on userspace actions is the correct way to go.

Using udev rule for memory onlining is possible when you disable
memhp_auto_online but in some cases it doesn't work well, e.g. when we
use memory hotplug to address memory pressure the loop through userspace
is really slow and memory consuming, we may hit OOM before we manage to
online newly added memory. In addition to that, systemd/udev folks
continuosly refused to add this udev rule to udev calling it stupid as
it actually is an unconditional and redundant ping-pong between kernel
and udev.

>
> I have tried reading through the email threads when the origianl patch
> was submitted and could not determine if this is the expected behavior.
> The problem with the current behavior was found when trying to update
> memory hotplug on powerpc to use auto online.
>
> -Nathan Fontenot
> ---
>  drivers/base/memory.c  |    2 +-
>  include/linux/memory.h |    3 ---
>  mm/memory_hotplug.c    |    2 +-
>  3 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 8ab8ea1..ede46f3 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -249,7 +249,7 @@ static bool pages_correctly_reserved(unsigned long start_pfn)
>  	return ret;
>  }
>
> -int memory_block_change_state(struct memory_block *mem,
> +static int memory_block_change_state(struct memory_block *mem,
>  		unsigned long to_state, unsigned long from_state_req)
>  {
>  	int ret = 0;
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 093607f..b723a68 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -109,9 +109,6 @@ static inline int memory_isolate_notify(unsigned long val, void *v)
>  extern int register_memory_isolate_notifier(struct notifier_block *nb);
>  extern void unregister_memory_isolate_notifier(struct notifier_block *nb);
>  extern int register_new_memory(int, struct mem_section *);
> -extern int memory_block_change_state(struct memory_block *mem,
> -				     unsigned long to_state,
> -				     unsigned long from_state_req);
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  extern int unregister_memory_section(struct mem_section *);
>  #endif
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e43142c1..6f7a289 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1329,7 +1329,7 @@ int zone_for_memory(int nid, u64 start, u64 size, int zone_default,
>
>  static int online_memory_block(struct memory_block *mem, void *arg)
>  {
> -	return memory_block_change_state(mem, MEM_ONLINE, MEM_OFFLINE);
> +	return device_online(&mem->dev);
>  }
>
>  /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */

Your patch looks good to me, I tested it on x86 (Hyper-V) and it seems
to work.

Thanks!

-- 
  Vitaly
