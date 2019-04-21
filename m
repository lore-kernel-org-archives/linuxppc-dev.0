Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583EEC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:10:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C5121873
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C5121873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nBSr6d13zDqN3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 00:10:52 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBNm3CDCzDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:07:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBNm1Dy8z9s8m; Mon, 22 Apr 2019 00:07:20 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: eb9d7a62c38628ab0ba6e59d22d7cb7930e415d1
X-Patchwork-Hint: ignore
In-Reply-To: <20190403041233.57619-2-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [kernel,v2,1/2] powerpc/mm_iommu: Fix potential deadlock
Message-Id: <44nBNm1Dy8z9s8m@ozlabs.org>
Date: Mon, 22 Apr 2019 00:07:20 +1000 (AEST)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-04-03 at 04:12:32 UTC, Alexey Kardashevskiy wrote:
> Currently mm_iommu_do_alloc() is called in 2 cases:
> - VFIO_IOMMU_SPAPR_REGISTER_MEMORY ioctl() for normal memory:
> 	this locks &mem_list_mutex and then locks mm::mmap_sem
> 	several times when adjusting locked_vm or pinning pages;
> - vfio_pci_nvgpu_regops::mmap() for GPU memory:
> 	this is called with mm::mmap_sem held already and it locks
> 	&mem_list_mutex.
> 
> So one can craft a userspace program to do special ioctl and mmap in
> 2 threads concurrently and cause a deadlock which lockdep warns about
> (below).
> 
> We did not hit this yet because QEMU constructs the machine in a single
> thread.
> 
> This moves the overlap check next to where the new entry is added and
> reduces the amount of time spent with &mem_list_mutex held.
> 
> This moves locked_vm adjustment from under &mem_list_mutex.
> 
> This relies on mm_iommu_adjust_locked_vm() doing nothing when entries==0.
> 
> This is one of the lockdep warnings:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.1.0-rc2-le_nv2_aikATfstn1-p1 #363 Not tainted
> ------------------------------------------------------
> qemu-system-ppc/8038 is trying to acquire lock:
> 000000002ec6c453 (mem_list_mutex){+.+.}, at: mm_iommu_do_alloc+0x70/0x490
> 
> but task is already holding lock:
> 00000000fd7da97f (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0xf0/0x160
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&mm->mmap_sem){++++}:
>        lock_acquire+0xf8/0x260
>        down_write+0x44/0xa0
>        mm_iommu_adjust_locked_vm.part.1+0x4c/0x190
>        mm_iommu_do_alloc+0x310/0x490
>        tce_iommu_ioctl.part.9+0xb84/0x1150 [vfio_iommu_spapr_tce]
>        vfio_fops_unl_ioctl+0x94/0x430 [vfio]
>        do_vfs_ioctl+0xe4/0x930
>        ksys_ioctl+0xc4/0x110
>        sys_ioctl+0x28/0x80
>        system_call+0x5c/0x70
> 
> -> #0 (mem_list_mutex){+.+.}:
>        __lock_acquire+0x1484/0x1900
>        lock_acquire+0xf8/0x260
>        __mutex_lock+0x88/0xa70
>        mm_iommu_do_alloc+0x70/0x490
>        vfio_pci_nvgpu_mmap+0xc0/0x130 [vfio_pci]
>        vfio_pci_mmap+0x198/0x2a0 [vfio_pci]
>        vfio_device_fops_mmap+0x44/0x70 [vfio]
>        mmap_region+0x5d4/0x770
>        do_mmap+0x42c/0x650
>        vm_mmap_pgoff+0x124/0x160
>        ksys_mmap_pgoff+0xdc/0x2f0
>        sys_mmap+0x40/0x80
>        system_call+0x5c/0x70
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&mm->mmap_sem);
>                                lock(mem_list_mutex);
>                                lock(&mm->mmap_sem);
>   lock(mem_list_mutex);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by qemu-system-ppc/8038:
>  #0: 00000000fd7da97f (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0xf0/0x160
> 
> Fixes: c10c21efa4bc ("powerpc/vfio/iommu/kvm: Do not pin device memory", 2018-12-19)
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/eb9d7a62c38628ab0ba6e59d22d7cb79

cheers
