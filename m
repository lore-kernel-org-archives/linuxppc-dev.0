Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD9CC1A006C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 16:50:19 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 1 Feb 2016 11:20:16 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u115oFkq9240906
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 11:20:15 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u115oAHE018449
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 11:20:14 +0530
Message-ID: <56AEF20B.2030302@linux.vnet.ibm.com>
Date: Mon, 01 Feb 2016 11:20:03 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org
CC: aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [RFCv2 0/9] PAPR hash page table resizing (guest side)
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2016 10:53 AM, David Gibson wrote:
> Here's a second prototype of the guest side work for runtime resizing
> of the has page table in PAPR guests.
> 
> This is now feature complete.  It implements the resizing, advertises
> it with CAS, and will automatically invoke it to maintain a good HPT
> size when memory is hot-added or hot-removed.
> 
> Patches 1-5 are standalone prerequisite cleanups that I'll be pushing
> concurrently.
> 
> David Gibson (9):
>   memblock: Don't mark memblock_phys_mem_size() as __init
>   arch/powerpc: Clean up error handling for htab_remove_mapping
>   arch/powerpc: Handle removing maybe-present bolted HPTEs
>   arch/powerpc: Clean up memory hotplug failure paths
>   arch/powerpc: Split hash page table sizing heuristic into a helper

A small nit. Please start the above commit message headers as
"powerpc/mm:" instead, which sounds more clear and uniform with
patch series related to other subsystems.

Adding Nathan in the copy, may be he will have some inputs.
