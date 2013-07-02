Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 2D6C42C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 01:12:31 +1000 (EST)
Message-ID: <51D2EDD7.9060205@suse.de>
Date: Tue, 02 Jul 2013 17:12:23 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 2/4] powerpc/kvm: Contiguous memory allocator based
 hash page table allocation
References: <1372743918-12293-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1372743918-12293-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1372743918-12293-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm@vger.kernel.org, mina86@mina86.com, linux-mm@kvack.org,
 paulus@samba.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 m.szyprowski@samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2013 07:45 AM, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V"<aneesh.kumar@linux.vnet.ibm.com>
>
> Powerpc architecture uses a hash based page table mechanism for mapping virtual
> addresses to physical address. The architecture require this hash page table to
> be physically contiguous. With KVM on Powerpc currently we use early reservation
> mechanism for allocating guest hash page table. This implies that we need to
> reserve a big memory region to ensure we can create large number of guest
> simultaneously with KVM on Power. Another disadvantage is that the reserved memory
> is not available to rest of the subsystems and and that implies we limit the total
> available memory in the host.
>
> This patch series switch the guest hash page table allocation to use
> contiguous memory allocator.
>
> Signed-off-by: Aneesh Kumar K.V<aneesh.kumar@linux.vnet.ibm.com>

Is CMA a mandatory option in the kernel? Or can it be optionally 
disabled? If it can be disabled, we should keep the preallocated 
fallback case around for systems that have CMA disabled.


Alex
