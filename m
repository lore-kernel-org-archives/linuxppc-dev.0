Return-Path: <minchan.kim@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40b1pp1LYTzF2QV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 23:05:05 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id i29-v6so8301836pgn.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 May 2018 06:05:05 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Tue, 1 May 2018 22:04:52 +0900
From: Minchan Kim <minchan@kernel.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
 kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
 jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 kemi.wang@intel.com, sergey.senozhatsky.work@gmail.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Rientjes <rientjes@google.com>, Jerome Glisse <jglisse@redhat.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v10 06/25] mm: make pte_unmap_same compatible with SPF
Message-ID: <20180501130452.GA118722@rodete-laptop-imager.corp.google.com>
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523975611-15978-7-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180423063157.GB114098@rodete-desktop-imager.corp.google.com>
 <dd5c4338-3cbb-c65a-f0c1-c71e2a0037ee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dd5c4338-3cbb-c65a-f0c1-c71e2a0037ee@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 30, 2018 at 04:07:30PM +0200, Laurent Dufour wrote:
> On 23/04/2018 08:31, Minchan Kim wrote:
> > On Tue, Apr 17, 2018 at 04:33:12PM +0200, Laurent Dufour wrote:
> >> pte_unmap_same() is making the assumption that the page table are still
> >> around because the mmap_sem is held.
> >> This is no more the case when running a speculative page fault and
> >> additional check must be made to ensure that the final page table are still
> >> there.
> >>
> >> This is now done by calling pte_spinlock() to check for the VMA's
> >> consistency while locking for the page tables.
> >>
> >> This is requiring passing a vm_fault structure to pte_unmap_same() which is
> >> containing all the needed parameters.
> >>
> >> As pte_spinlock() may fail in the case of a speculative page fault, if the
> >> VMA has been touched in our back, pte_unmap_same() should now return 3
> >> cases :
> >> 	1. pte are the same (0)
> >> 	2. pte are different (VM_FAULT_PTNOTSAME)
> >> 	3. a VMA's changes has been detected (VM_FAULT_RETRY)
> >>
> >> The case 2 is handled by the introduction of a new VM_FAULT flag named
> >> VM_FAULT_PTNOTSAME which is then trapped in cow_user_page().
> > 
> > I don't see such logic in this patch.
> > Maybe you introduces it later? If so, please comment on it.
> > Or just return 0 in case of 2 without introducing VM_FAULT_PTNOTSAME.
> 
> Late in the series, pte_spinlock() will check for the VMA's changes and may
> return 1. This will be then required to handle the 3 cases presented above.
> 
> I can move this handling later in the series, but I wondering if this will make
> it more easier to read.

Just nit:
During reviewing this patch, I was just curious you introduced new thing
here but I couldn't find any site where use it. It makes review hard. :(
That's why I said to you that please commet on it if you will use new thing
late in this series.
If you think as-is is better for review, it would be better to mention it
explicitly.

Thanks.
