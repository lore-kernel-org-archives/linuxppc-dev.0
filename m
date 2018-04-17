Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x22f.google.com (mail-pl0-x22f.google.com
 [IPv6:2607:f8b0:400e:c01::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Q5Rh6bqdzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 10:17:36 +1000 (AEST)
Received: by mail-pl0-x22f.google.com with SMTP id t22-v6so2338924plo.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 17:17:36 -0700 (PDT)
Date: Tue, 17 Apr 2018 10:17:19 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 5/5] KVM: PPC: Book3S HV: radix do not clear
 partition scoped page table when page fault races with other vCPUs.
Message-ID: <20180417101719.5bbd60f2@roar.ozlabs.ibm.com>
In-Reply-To: <20180416043240.8796-6-npiggin@gmail.com>
References: <20180416043240.8796-1-npiggin@gmail.com>
 <20180416043240.8796-6-npiggin@gmail.com>
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

On Mon, 16 Apr 2018 14:32:40 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> When running a SMP radix guest, KVM can get into page fault / tlbie
> storms -- hundreds of thousands to the same address from different
> threads -- due to partition scoped page faults invalidating the
> page table entry if it was found to be already set up by a racing
> CPU.
> 
> What can happen is that guest threads can hit page faults for the
> same addresses, this can happen when KSM or THP takes out a commonly
> used page. gRA zero (the interrupt vectors and important kernel text)
> was a common one. Multiple CPUs will page fault and contend on the
> same lock, when one CPU sets up the page table and releases the lock,
> the next will find the new entry and invalidate it before installing
> its own, which causes other page faults which invalidate that entry,
> etc.
> 
> The solution to this is to avoid invalidating the entry or flushing
> TLBs in case of a race. The pte may still need bits updated, but
> those are to add R/C or relax access restrictions so no flush is
> required.
> 
> This solves the page fault / tlbie storms.

Oh, I didn't notice "KVM: PPC: Book3S HV: Radix page fault handler
optimizations" does much the same thing as this one and it's been
merged upstream now.

That also adds a partition scoped PWC flush that I'll add to
powerpc/mm, so I'll rebase this series.

Thanks,
Nick
