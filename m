Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yDRjH06FmzDrFy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 12:25:23 +1100 (AEDT)
Date: Sat, 14 Oct 2017 12:25:20 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH kernel] KVM: PPC: Protect kvmppc_gpa_to_ua() with srcu
Message-ID: <20171014012520.GE26120@fergus.ozlabs.ibm.com>
References: <20171011050034.37872-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171011050034.37872-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 11, 2017 at 04:00:34PM +1100, Alexey Kardashevskiy wrote:
> kvmppc_gpa_to_ua() accesses KVM memory slot array via
> srcu_dereference_check() and this produces warnings from RCU like below.
> 
> This extends the existing srcu_read_lock/unlock to cover that
> kvmppc_gpa_to_ua() as well.
> 
> We did not hit this before as this lock is not needed for the realmode
> handlers and hash guests would use the realmode path all the time;
> however the radix guests are always redirected to the virtual mode
> handlers and hence the warning.
> 
> [   68.253798] ./include/linux/kvm_host.h:575 suspicious rcu_dereference_check() usage!
> [   68.253799]
>                other info that might help us debug this:
> 
> [   68.253802]
>                rcu_scheduler_active = 2, debug_locks = 1
> [   68.253804] 1 lock held by qemu-system-ppc/6413:
> [   68.253806]  #0:  (&vcpu->mutex){+.+.}, at: [<c00800000e3c22f4>] vcpu_load+0x3c/0xc0 [kvm]
> [   68.253826]
>                stack backtrace:
> [   68.253830] CPU: 92 PID: 6413 Comm: qemu-system-ppc Tainted: G        W       4.14.0-rc3-00553-g432dcba58e9c-dirty #72
> [   68.253833] Call Trace:
> [   68.253839] [c000000fd3d9f790] [c000000000b7fcc8] dump_stack+0xe8/0x160 (unreliable)
> [   68.253845] [c000000fd3d9f7d0] [c0000000001924c0] lockdep_rcu_suspicious+0x110/0x180
> [   68.253851] [c000000fd3d9f850] [c0000000000e825c] kvmppc_gpa_to_ua+0x26c/0x2b0
> [   68.253858] [c000000fd3d9f8b0] [c00800000e3e1984] kvmppc_h_put_tce+0x12c/0x2a0 [kvm]
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thanks, applied to my kvm-ppc-fixes branch.

Paul.
