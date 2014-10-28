Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-wg0-x22d.google.com (mail-wg0-x22d.google.com
 [IPv6:2a00:1450:400c:c00::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38B7F1A019A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 20:02:41 +1100 (AEDT)
Received: by mail-wg0-f45.google.com with SMTP id x12so256153wgg.28
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 02:02:38 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <544F5BA8.5020100@redhat.com>
Date: Tue, 28 Oct 2014 10:02:32 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: lockdep warning with 2d65a9f48fcdf7866aab6457bc707ca233e0c791
References: <87d29tkzsi.fsf@linux.vnet.ibm.com>
In-Reply-To: <87d29tkzsi.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/15/2014 07:28 PM, Aneesh Kumar K.V wrote:
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

This must come from here:

        while (vcpu->arch.state == KVMPPC_VCPU_RUNNABLE &&
               (vc->vcore_state == VCORE_RUNNING ||
                vc->vcore_state == VCORE_EXITING)) {
                spin_unlock(&vc->lock);
                kvmppc_wait_for_exec(vcpu, TASK_UNINTERRUPTIBLE);
                spin_lock(&vc->lock);
        }

        if (vcpu->arch.state == KVMPPC_VCPU_RUNNABLE) {
                kvmppc_remove_runnable(vc, vcpu);
                vcpu->stat.signal_exits++;
                kvm_run->exit_reason = KVM_EXIT_INTR;
                vcpu->arch.ret = -EINTR;
        }


if vc->vcore_state is VCORE_SLEEPING (I think it cannot be VCORE_STARTING)?

Paolo
