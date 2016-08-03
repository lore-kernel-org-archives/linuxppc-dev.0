Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s483h4vX4zDqTf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 20:11:12 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y134so14357882pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 03:11:12 -0700 (PDT)
Date: Wed, 3 Aug 2016 20:11:04 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alex Williamson
 <alex.williamson@redhat.com>, Paul Mackerras <paulus@samba.org>, David
 Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel 06/15] powerpc/mm/iommu: Put pages on process exit
Message-ID: <20160803201104.0d332fab@roar.ozlabs.ibm.com>
In-Reply-To: <1470213656-1042-7-git-send-email-aik@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-7-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  3 Aug 2016 18:40:47 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> At the moment VFIO IOMMU SPAPR v2 driver pins all guest RAM pages when
> the userspace starts using VFIO. When the userspace process finishes,
> all the pinned pages need to be put; this is done as a part of
> the userspace memory context (MM) destruction which happens on
> the very last mmdrop().
> 
> This approach has a problem that a MM of the userspace process
> may live longer than the userspace process itself as kernel threads
> use userspace process MMs which was runnning on a CPU where
> the kernel thread was scheduled to. If this happened, the MM remains
> referenced until this exact kernel thread wakes up again
> and releases the very last reference to the MM, on an idle system this
> can take even hours.
> 
> This references and caches MM once per container and adds tracking
> how many times each preregistered area was registered in
> a specific container. This way we do not depend on @current pointing to
> a valid task descriptor.
> 
> This changes the userspace interface to return EBUSY if memory is
> already registered (mm_iommu_get() used to increment the counter);
> however it should not have any practical effect as the only
> userspace tool available now does register memory area once per
> container anyway.
> 
> As tce_iommu_register_pages/tce_iommu_unregister_pages are called
> under container->lock, this does not need additional locking.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
