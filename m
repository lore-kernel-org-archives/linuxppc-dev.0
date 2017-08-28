Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgqnP2hg2zDqF0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 21:49:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
Cc: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 1/4] KVM: PPC: Book3S HV: POWER9 does not require
 secondary thread management
In-Reply-To: <20170825043036.18236-2-npiggin@gmail.com>
References: <20170825043036.18236-1-npiggin@gmail.com>
 <20170825043036.18236-2-npiggin@gmail.com>
Date: Mon, 28 Aug 2017 21:49:44 +1000
Message-ID: <877exnvrmv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> POWER9 CPUs have independent MMU contexts per thread, so KVM does not
> need to quiesce secondary threads, so the hwthread_req/hwthread_state
> protocol does not have to be used. So patch it away on POWER9, and patch
> away the branch from the Linux idle wakeup to kvm_start_guest that is
> never used.
>
> Add a warning and error out of kvmppc_grab_hwthread in case it is ever
> called on POWER9.
>
> This avoids a hwsync in the idle wakeup path on POWER9.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/kvm_book3s_asm.h |  4 ++++
>  arch/powerpc/kernel/idle_book3s.S         | 35 +++++++++++++++++++++----------
>  arch/powerpc/kvm/book3s_hv.c              | 14 ++++++++++++-
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  8 +++++++
>  4 files changed, 49 insertions(+), 12 deletions(-)

Paulus do you mind acking this and I'll put it in my ppc-kvm topic
branch.

cheers
