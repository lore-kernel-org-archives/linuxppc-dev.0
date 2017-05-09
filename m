Return-Path: <srs0=15w2=4p=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMXvg01hkzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 18:43:26 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wMXvf6Y6mz8tD8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 18:43:26 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wMXvf0NrVz9s3T
 for <linuxppc-dev@ozlabs.org>; Tue,  9 May 2017 18:43:26 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id v14so12965559pfd.3
 for <linuxppc-dev@ozlabs.org>; Tue, 09 May 2017 01:43:25 -0700 (PDT)
Message-ID: <1494319398.14525.3.camel@gmail.com>
Subject: Re: [PATCH] powerpc/mm/book3s/64: Rework page table geometry for
 lower memory usage
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, paulus@samba.org
Date: Tue, 09 May 2017 18:43:18 +1000
In-Reply-To: <1494317148-18554-1-git-send-email-mpe@ellerman.id.au>
References: <1494317148-18554-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-09 at 18:05 +1000, Michael Ellerman wrote:
> Recently in commit f6eedbba7a26 ("powerpc/mm/hash: Increase VA range to 128TB")
> we increased the virtual address space for user processes to 128TB by default,
> and up to 512TB if user space opts in.
> 
> This obviously required expanding the range of the Linux page tables. For Book3s
> 64-bit using hash and with PAGE_SIZE=64K, we increased the PGD to 2^15 entries.
> This meant we could cover the full address range, while still being able to
> insert a 16G hugepage at the PGD level and a 16M hugepage in the PMD.
> 
> The downside of that geometry is that it uses a lot of memory for the PGD, and
> in particular makes the PGD a 4-page allocation, which means it's much more
> likely to fail under memory pressure.
> 
> Instead we can make the PMD larger, so that a single PUD entry maps 16G,
> allowing the 16G hugepages to sit at that level in the tree. We're then able to
> split the remaining bits between the PUG and PGD. We make the PGD slightly
> larger as that results in lower memory usage for typical programs.
> 
> When THP is enabled the PMD actually doubles in size, to 2^11 entries, or 2^14
> bytes, which is large but still < PAGE_SIZE.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
