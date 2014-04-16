Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 243EB1400B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Apr 2014 22:27:46 +1000 (EST)
Message-ID: <534E773A.2090909@suse.de>
Date: Wed, 16 Apr 2014 14:27:38 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Liu Ping Fan <pingfank@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v4] powerpc: kvm: make _PAGE_NUMA take effect
References: <1397550820-29993-1-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1397550820-29993-1-git-send-email-pingfank@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 15.04.14 10:33, Liu Ping Fan wrote:
> Numa fault is a method which help to achieve auto numa balancing.
> When such a page fault takes place, the page fault handler will check
> whether the page is placed correctly. If not, migration should be
> involved to cut down the distance between the cpu and pages.
>
> A pte with _PAGE_NUMA help to implement numa fault. It means not to
> allow the MMU to access the page directly. So a page fault is triggered
> and numa fault handler gets the opportunity to run checker.
>
> As for the access of MMU, we need special handling for the powernv's guest.
> When we mark a pte with _PAGE_NUMA, we already call mmu_notifier to
> invalidate it in guest's htab, but when we tried to re-insert them,
> we firstly try to map it in real-mode. Only after this fails, we fallback
> to virt mode, and most of important, we run numa fault handler in virt
> mode.  This patch guards the way of real-mode to ensure that if a pte is
> marked with _PAGE_NUMA, it will NOT be mapped in real mode, instead, it will
> be mapped in virt mode and have the opportunity to be checked with placement.
>
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Thanks, applied to for-3.15.


Alex
