Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdPDC3928zDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 22:46:03 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id m7so3773533pga.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 05:46:03 -0700 (PDT)
Date: Thu, 24 Aug 2017 22:45:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 10/14] KVM: PPC: Book3S HV: POWER9 does not require
 secondary thread management
Message-ID: <20170824224544.0d53c27c@roar.ozlabs.ibm.com>
In-Reply-To: <20170824093435.GH27401@fergus.ozlabs.ibm.com>
References: <20170811163912.28783-1-npiggin@gmail.com>
 <20170811163912.28783-11-npiggin@gmail.com>
 <20170824093435.GH27401@fergus.ozlabs.ibm.com>
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

On Thu, 24 Aug 2017 19:34:35 +1000
Paul Mackerras <paulus@ozlabs.org> wrote:

> On Sat, Aug 12, 2017 at 02:39:08AM +1000, Nicholas Piggin wrote:
> > POWER9 CPUs have independent MMU contexts per thread, so KVM does not
> > need to quiesce secondary threads, so the hwthread_req/hwthread_state
> > protocol does not have to be used. So patch it away on POWER9, and patch
> > away the branch from the Linux idle wakeup to kvm_start_guest that is
> > never used.  
> 
> If/when we add support for running HPT guests on a radix host, we will
> have to run the host in single-threaded mode (since POWER9 doesn't
> support having some threads of a core using HPT and some using radix
> simultaneously).  We'll then need some sort of thing like
> kvmppc_grab_hwthread to coordinate with the threads so that guests can
> use the secondary threads.
>
> So I think most of this code should stay.  We will still need to have
> a way to make sure that the secondaries are in real mode and not in a
> guest, because all threads will need to be in real mode when switching
> the core between radix and HPT mode.  Maybe we can optimize it a bit
> at present given that we don't yet support running HPT guests on a
> radix host, but I don't want to make it harder to do that in future.

Okay, most of the code's still there, just noped out with ARCH_300.
But yes this and then the subsequent patches do make it more
difficult to restore the KVM real mode functionality.

I'll see about restructuring them to keep that ability and make it
selectable with a minimal branchs or alt patches.

Thanks,
Nick
