Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg4gF6pXxzDsyf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 20:26:01 +1100 (AEDT)
Subject: Re: [PATCH 01/11] powerpc/kvm: Reserve capabilities and ioctls for
 HPT resizing
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-2-david@gibson.dropbear.id.au>
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <25bcced1-4903-2cf7-6a56-14c3ced5cd28@redhat.com>
Date: Fri, 16 Dec 2016 10:25:55 +0100
MIME-Version: 1.0
In-Reply-To: <20161215055404.29351-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15.12.2016 06:53, David Gibson wrote:
> This adds a new powerpc-specific KVM_CAP_SPAPR_RESIZE_HPT capability to
> advertise whether KVM is capable of handling the PAPR extensions for
> resizing the hashed page table during guest runtime.
> 
> At present, HPT resizing is possible with KVM PR without kernel
> modification, since the HPT is managed within qemu.  It's not possible yet
> with KVM HV, because the HPT is managed by KVM.  At present, qemu has to
> use other capabilities which (by accident) reveal whether PR or HV is in
> use to know if it can advertise HPT resizing capability to the guest.
> 
> To avoid ambiguity with existing kernels, the encoding is a bit odd.
>     0 means "unknown" since that's what previous kernels will return
>     1 means "HPT resize possible if available if and only if the HPT is allocated in
>       userspace, rather than in the kernel".  Userspace can check
>       KVM_CAP_PPC_ALLOC_HTAB to determine if that's the case.  In practice
>       this will give the same results as userspace's fallback check.
>     2 will mean "HPT resize available and implemented via ioctl()s
>       KVM_PPC_RESIZE_HPT_PREPARE and KVM_PPC_RESIZE_HPT_COMMIT"

This encoding IMHO clearly needs some proper documentation in
Documentation/virtual/kvm/api.txt ... and maybe also some dedicated
#defines in an uapi header file.

 Thomas
