Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xh8S40jKHzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 10:20:52 +1000 (AEST)
Date: Tue, 29 Aug 2017 10:13:19 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v3 1/4] KVM: PPC: Book3S HV: POWER9 does not require
 secondary thread management
Message-ID: <20170829001319.GE12629@fergus.ozlabs.ibm.com>
References: <20170825043036.18236-1-npiggin@gmail.com>
 <20170825043036.18236-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170825043036.18236-2-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 25, 2017 at 02:30:33PM +1000, Nicholas Piggin wrote:
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

Some of the feature sections seem a little unnecessary except for
documentation purposes (e.g. the second one added after the
kvm_no_guest label), but they won't actually hurt, so:

Acked-by: Paul Mackerras <paulus@ozlabs.org>
