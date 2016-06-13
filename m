Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rT4WV34JpzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 06:44:06 +1000 (AEST)
Date: Mon, 13 Jun 2016 14:43:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Topi Miettinen <toiwoton@gmail.com>
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua
 Yu <fenghua.yu@intel.com>, Alexander Graf <agraf@suse.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Doug Ledford
 <dledford@redhat.com>, Sean Hefty <sean.hefty@intel.com>, Hal Rosenstock
 <hal.rosenstock@gmail.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>, Christian Benvenuti
 <benve@cisco.com>, Dave Goodell <dgoodell@cisco.com>, Sudeep Dutt
 <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Alexei
 Starovoitov <ast@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Konstantin Khlebnikov <koct9i@gmail.com>, Jiri
 Slaby <jslaby@suse.cz>, Cyrill Gorcunov <gorcunov@openvz.org>, Thomas
 Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter
 <dan.carpenter@oracle.com>, Nikhil Rao <nikhil.rao@intel.com>, Vlastimil
 Babka <vbabka@suse.cz>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Eric B
 Munson <emunson@akamai.com>, Alexey Klimov <klimov.linux@gmail.com>, Andrea
 Arcangeli <aarcange@redhat.com>, Alexander Kuleshov
 <kuleshovmail@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Chen Gang
 <gang.chen.5i5j@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 David Rientjes <rientjes@google.com>, Hugh Dickins <hughd@google.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linux-ia64@vger.kernel.org (open list:IA64 (Itanium) PLATFORM),
 kvm-ppc@vger.kernel.org (open
 list:KERNEL VIRTUAL MACHINE (KVM) FOR POWERPC), kvm@vger.kernel.org (open
 list:KERNEL VIRTUAL MACHINE (KVM)), linuxppc-dev@lists.ozlabs.org (open
 list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
 linux-rdma@vger.kernel.org (open list:INFINIBAND SUBSYSTEM),
 netdev@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
 linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: Re: [RFC 12/18] limits: track RLIMIT_MEMLOCK actual max
Message-ID: <20160613144359.677edee4@ul30vt.home>
In-Reply-To: <1465847065-3577-13-git-send-email-toiwoton@gmail.com>
References: <1465847065-3577-1-git-send-email-toiwoton@gmail.com>
 <1465847065-3577-13-git-send-email-toiwoton@gmail.com>
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

On Mon, 13 Jun 2016 22:44:19 +0300
Topi Miettinen <toiwoton@gmail.com> wrote:

> Track maximum size of locked memory, presented in /proc/self/limits.
> 
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  arch/ia64/kernel/perfmon.c                 |  1 +
>  arch/powerpc/kvm/book3s_64_vio.c           |  1 +
>  arch/powerpc/mm/mmu_context_iommu.c        |  1 +
>  drivers/infiniband/core/umem.c             |  1 +
>  drivers/infiniband/hw/hfi1/user_pages.c    |  1 +
>  drivers/infiniband/hw/qib/qib_user_pages.c |  1 +
>  drivers/infiniband/hw/usnic/usnic_uiom.c   |  2 ++
>  drivers/misc/mic/scif/scif_rma.c           |  1 +
>  drivers/vfio/vfio_iommu_spapr_tce.c        |  2 ++
>  drivers/vfio/vfio_iommu_type1.c            |  2 ++
>  include/linux/sched.h                      | 10 ++++++++--
>  kernel/bpf/syscall.c                       |  6 ++++++
>  kernel/events/core.c                       |  1 +
>  mm/mlock.c                                 |  7 +++++++
>  mm/mmap.c                                  |  3 +++
>  mm/mremap.c                                |  3 +++
>  16 files changed, 41 insertions(+), 2 deletions(-)
...  
>
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 2ba1942..4c6e7a3 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -312,6 +312,8 @@ static long vfio_pin_pages(unsigned long vaddr, long npage,
>  		}
>  	}
>  
> +	bump_rlimit(RLIMIT_MEMLOCK, (current->mm->locked_vm + i) << PAGE_SHIFT);
> +
>  	if (!rsvd)
>  		vfio_lock_acct(i);
>  


Not all cases passing through here bump rlimit (see: rsvd), there's an
entire case above the other end of this closing bracket that does bump
rlimit but returns before here, and I wonder why we wouldn't just do
this in our vfio_lock_acct() accounting function anyway.  Thanks,

Alex
