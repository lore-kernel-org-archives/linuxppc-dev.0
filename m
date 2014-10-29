Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB0E11A006B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 15:21:12 +1100 (AEDT)
Date: Wed, 29 Oct 2014 15:20:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: lockdep warning with 2d65a9f48fcdf7866aab6457bc707ca233e0c791
Message-ID: <20141029042057.GA24657@drongo>
References: <87d29tkzsi.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87d29tkzsi.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 15, 2014 at 10:58:45PM +0530, Aneesh Kumar K.V wrote:
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> 3.17.0+ #31 Not tainted
> ---------------------------------------------
> qemu-system-ppc/9112 is trying to acquire lock:
>  (&(&vcpu->arch.tbacct_lock)->rlock){......}, at: [<d000000011591f84>] .vcore_stolen_time+0x44/0xb0 [kvm_hv]
> 
> but task is already holding lock:
>  (&(&vcpu->arch.tbacct_lock)->rlock){......}, at: [<d000000011592524>] .kvmppc_remove_runnable.part.2+0x34/0xd0 [kvm_hv]

This is actually harmless, because the lock taken in
vcore_stolen_time() is always a different lock from the one taken in
kvmppc_remove_runnable().  In vcore_stolen_time() we take the lock of
the runner vcpu if we are not the runner vcpu (if we are the runner,
we don't take any lock there).  Nor is there any lock ordering
problem, because we always take the runner's lock last.

This is all a bit subtle, probably a bit too subtle.  I have been
meaning to rework it but haven't had the time yet.

Paul.
