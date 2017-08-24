Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdKcm5vhkzDqms
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 20:03:36 +1000 (AEST)
Date: Thu, 24 Aug 2017 19:34:35 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 10/14] KVM: PPC: Book3S HV: POWER9 does not require
 secondary thread management
Message-ID: <20170824093435.GH27401@fergus.ozlabs.ibm.com>
References: <20170811163912.28783-1-npiggin@gmail.com>
 <20170811163912.28783-11-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170811163912.28783-11-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 12, 2017 at 02:39:08AM +1000, Nicholas Piggin wrote:
> POWER9 CPUs have independent MMU contexts per thread, so KVM does not
> need to quiesce secondary threads, so the hwthread_req/hwthread_state
> protocol does not have to be used. So patch it away on POWER9, and patch
> away the branch from the Linux idle wakeup to kvm_start_guest that is
> never used.

If/when we add support for running HPT guests on a radix host, we will
have to run the host in single-threaded mode (since POWER9 doesn't
support having some threads of a core using HPT and some using radix
simultaneously).  We'll then need some sort of thing like
kvmppc_grab_hwthread to coordinate with the threads so that guests can
use the secondary threads.

So I think most of this code should stay.  We will still need to have
a way to make sure that the secondaries are in real mode and not in a
guest, because all threads will need to be in real mode when switching
the core between radix and HPT mode.  Maybe we can optimize it a bit
at present given that we don't yet support running HPT guests on a
radix host, but I don't want to make it harder to do that in future.

Paul.
