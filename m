Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMBd3073KzDrk2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 19:59:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com <nfont@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] powerpc: Disabling MEMORY_HOTPLUG_DEFAULT_ONLINE
 option for PPC64 arch
In-Reply-To: <20170731181759.13839-1-danielhb@linux.vnet.ibm.com>
References: <20170731181759.13839-1-danielhb@linux.vnet.ibm.com>
Date: Tue, 01 Aug 2017 19:59:48 +1000
Message-ID: <87y3r3sj57.fsf@concordia.ellerman.id.au>
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

Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:

> Commit 943db62c316c ("powerpc/pseries: Revert 'Auto-online
> hotplugged memory'") reverted the auto-online feature for pseries due
> to problems with LMB removals not updating the device struct properly.
> Among other things, this commit made the following change in
> arch/powerpc/configs/pseries_defconfig:
>
> @@ -58,7 +58,6 @@ CONFIG_KEXEC_FILE=y
>  CONFIG_IRQ_ALL_CPUS=y
>  CONFIG_MEMORY_HOTPLUG=y
>  CONFIG_MEMORY_HOTREMOVE=y
> -CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
>  CONFIG_KSM=y
>
> The intent was to disable the option in the defconfig of pseries, since
> after that the code doesn't have this support anymore.

It's always polite to Cc the author of a commit you're referring to, so
I added Nathan.

The intention when we merged that fix was that the auto-online code
would be "fixed" to mark the device online. I say "fixed" because it
wasn't entirely clear if that was the correct behaviour, though it
definitely seemed like it should be.

I've lost track of where/if the discussion got to on whether the
auto-online code should do that or not. Did anything get resolved?

> However, this change
> alone isn't enough to prevent situations such as [1], where
> distros can enable the option unaware of the consequences of
> doing it (e.g. breaking LMB hotplug altogether).
>
> Instead of relying on all distros knowing that pseries can't handle
> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y after 943db62c316c, this patch
> changes mm/Kconfig to make the MEMORY_HOTPLUG_DEFAULT_ONLINE config
> unavailable for the PPC64 arch.
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1476380
>
> Fixes: 943db62c316c ("powerpc/pseries: Revert 'Auto-online hotplugged memory'")
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't own that file, so we at least need an Ack from the mm folks.

cheers

> diff --git a/mm/Kconfig b/mm/Kconfig
> index 48b1af4..a342c77 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -169,7 +169,7 @@ config MEMORY_HOTPLUG_SPARSE
>  config MEMORY_HOTPLUG_DEFAULT_ONLINE
>          bool "Online the newly added memory blocks by default"
>          default n
> -        depends on MEMORY_HOTPLUG
> +        depends on MEMORY_HOTPLUG && !PPC64
>          help
>  	  This option sets the default policy setting for memory hotplug
>  	  onlining policy (/sys/devices/system/memory/auto_online_blocks) which
> -- 
> 2.9.4
