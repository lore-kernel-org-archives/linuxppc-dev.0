Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdfnD2gRHzF0W9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 15:57:32 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1A4rtYC113053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Feb 2018 23:57:30 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g1hjcq0xx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Feb 2018 23:57:30 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 21:57:29 -0700
Date: Fri, 9 Feb 2018 20:57:24 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/vas: do not set uses_vas for kernel windows
References: <20180208091838.27992-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180208091838.27992-1-npiggin@gmail.com>
Message-Id: <20180210045724.GA28183@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin [npiggin@gmail.com] wrote:
> cp_abort is only required or user windows, because kernel context
> must not be preempted between a copy/paste pair.

Yes, that is a good optimization.

> 
> Without this patch, the init task gets used_vas set when it runs
> the nx842_powernv_init initcall, which opens windows for kernel
> usage.
> 
> used_vas is then never cleared anywhere, so it gets propagated
> into all other tasks. It's a property of the address space, so it
> should really be cleared when a new mm is created (or in dup_mmap
> if the mmaps are marked as VM_DONTCOPY). For now we seem to have
> no such driver, so leave that for another patch.

If the parent process has the paste address mapped, the child inherits
those mappings - so we can't clear the ->used_vas in a process until
it has unmapped all the send windows right?

If VM_DONCOPY is set, then we can clear it.

> 
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
