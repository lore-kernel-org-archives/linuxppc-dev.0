Return-Path: <jgross@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0Yc30rhWzDvZM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 16:08:34 +1100 (AEDT)
Subject: Re: [PATCH v5 7/9] x86, xen: support vcpu preempted check
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org,
 linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1476998874-2089-8-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, pbonzini@redhat.com,
 bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com,
 rkrcmar@redhat.com, David Vrabel <david.vrabel@citrix.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <7ebcc196-e483-097c-41c8-070b46297c9d@suse.com>
Date: Fri, 21 Oct 2016 07:08:19 +0200
MIME-Version: 1.0
In-Reply-To: <1476998874-2089-8-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Corrected xen-devel mailing list address, added other Xen maintainers

On 20/10/16 23:27, Pan Xinhui wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> Support the vcpu_is_preempted() functionality under Xen. This will
> enhance lock performance on overcommitted hosts (more runnable vcpus
> than physical cpus in the system) as doing busy waits for preempted
> vcpus will hurt system performance far worse than early yielding.
> 
> A quick test (4 vcpus on 1 physical cpu doing a parallel build job
> with "make -j 8") reduced system time by about 5% with this patch.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  arch/x86/xen/spinlock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
> index 3d6e006..74756bb 100644
> --- a/arch/x86/xen/spinlock.c
> +++ b/arch/x86/xen/spinlock.c
> @@ -114,7 +114,6 @@ void xen_uninit_lock_cpu(int cpu)
>  	per_cpu(irq_name, cpu) = NULL;
>  }
>  
> -
>  /*
>   * Our init of PV spinlocks is split in two init functions due to us
>   * using paravirt patching and jump labels patching and having to do
> @@ -137,6 +136,8 @@ void __init xen_init_spinlocks(void)
>  	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
>  	pv_lock_ops.wait = xen_qlock_wait;
>  	pv_lock_ops.kick = xen_qlock_kick;
> +
> +	pv_lock_ops.vcpu_is_preempted = xen_vcpu_stolen;
>  }
>  
>  /*
> 
