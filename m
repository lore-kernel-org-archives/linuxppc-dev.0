Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8xH5rXMzF2MB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:13:23 +1100 (AEDT)
In-Reply-To: <1520628358-1762-1-git-send-email-mauricfo@linux.vnet.ibm.com>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Subject: Re: powerpc/mm: Fix section mismatch warning in
 stop_machine_change_mapping()
Message-Id: <40B8xH1Mkdz9s0m@ozlabs.org>
Date: Thu, 29 Mar 2018 01:13:23 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-09 at 20:45:58 UTC, Mauricio Faria de Oliveira wrote:
> Fix the warning messages for stop_machine_change_mapping(), and a number
> of other affected functions in its call chain.
> 
> All modified functions are under CONFIG_MEMORY_HOTPLUG, so __meminit
> is okay (keeps them / does not discard them).
> 
> Boot-tested on powernv/power9/radix-mmu and pseries/power8/hash-mmu.
> 
>     $ make -j$(nproc) CONFIG_DEBUG_SECTION_MISMATCH=y vmlinux
>     ...
>       MODPOST vmlinux.o
>     WARNING: vmlinux.o(.text+0x6b130): Section mismatch in reference from the function stop_machine_change_mapping() to the function .meminit.text:create_physical_mapping()
>     The function stop_machine_change_mapping() references
>     the function __meminit create_physical_mapping().
>     This is often because stop_machine_change_mapping lacks a __meminit 
>     annotation or the annotation of create_physical_mapping is wrong.
> 
>     WARNING: vmlinux.o(.text+0x6b13c): Section mismatch in reference from the function stop_machine_change_mapping() to the function .meminit.text:create_physical_mapping()
>     The function stop_machine_change_mapping() references
>     the function __meminit create_physical_mapping().
>     This is often because stop_machine_change_mapping lacks a __meminit 
>     annotation or the annotation of create_physical_mapping is wrong.
>     ...
> 
> Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bde709a70884bfc790da6fbc4467c9

cheers
