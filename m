Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zzWJd6H2YzDr6L
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 17:23:13 +1100 (AEDT)
Received: by mail-ua0-x242.google.com with SMTP id m43so4852051uah.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Mar 2018 22:23:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520628358-1762-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1520628358-1762-1-git-send-email-mauricfo@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Sun, 11 Mar 2018 17:23:09 +1100
Message-ID: <CAKTCnzmdNx01cx94J3mn0auDFrRuOs1PvwsxvOt9VK0AtQf7eA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: Fix section mismatch warning in
 stop_machine_change_mapping()
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 10, 2018 at 7:45 AM, Mauricio Faria de Oliveira
<mauricfo@linux.vnet.ibm.com> wrote:
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
> ---

Looks reasonable, I'd recommend trying to compile with MEMORY_HOTPLUG
and MEMORY_HOTREMOVE enabled/disabled as well

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh.
