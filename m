Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f172.google.com (mail-yk0-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9A761A2C31
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 05:54:16 +1000 (AEST)
Received: by ykdu9 with SMTP id u9so56377827ykd.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 12:54:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55FC0E15.6040105@redhat.com>
References: <CAOJe8K3mu6M48wGAMMQNXPDrkzk+z4j5yzcJ7eRfex0FWcZsQA@mail.gmail.com>
 <55F94161.7000405@redhat.com>
 <CAOJe8K0yPshff4c+e8DG7OdsT3PoSDsu=_0Gx2Noc2p-ua+c9g@mail.gmail.com>
 <55FC0E15.6040105@redhat.com>
Date: Fri, 18 Sep 2015 22:54:14 +0300
Message-ID: <CAOJe8K0H2TL=Oyr4qAZpBPtHTfyJkDiQ482GFDhMBwCjcwfpEg@mail.gmail.com>
Subject: Re: suspicious RCU usage with kvm_pr
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/18/15, Thomas Huth <thuth@redhat.com> wrote:
> On 16/09/15 12:59, Denis Kirjanov wrote:
>> On 9/16/15, Thomas Huth <thuth@redhat.com> wrote:
>>> On 16/09/15 10:51, Denis Kirjanov wrote:
>>>> Hi,
>>>>
>>>> I see the following trace on qemu startup (ps700 blade):
>>>>
>>>> v4.2-11169-g64d1def
>>>>
>>>>
>>>> [  143.369638] ===============================
>>>> [  143.369640] [ INFO: suspicious RCU usage. ]
>>>> [  143.369643] 4.2.0-11169-g64d1def #10 Tainted: G S
>>>> [  143.369645] -------------------------------
>>>> [  143.369647] arch/powerpc/kvm/../../../virt/kvm/kvm_main.c:3310
>>>> suspicious rcu_dereference_check() usage!
>>>> [  143.369649]
>>>> other info that might help us debug this:
>>>>
>>>> [  143.369652]
>>>> rcu_scheduler_active = 1, debug_locks = 1
>>>> [  143.369655] 1 lock held by qemu-system-ppc/2292:
>>>> [  143.369656]  #0:  (&vcpu->mutex){+.+.+.}, at: [<d000000004225bac>]
>>>> .vcpu_load+0x2c/0xb0 [kvm]
>>>> [  143.369672]
>>>> stack backtrace:
>>>> [  143.369675] CPU: 12 PID: 2292 Comm: qemu-system-ppc Tainted: G S
>>>>           4.2.0-11169-g64d1def #10
>>>> [  143.369677] Call Trace:
>>>> [  143.369682] [c0000001d08bf200] [c000000000816dd0]
>>>> .dump_stack+0x98/0xd4 (unreliable)
>>>> [  143.369687] [c0000001d08bf280] [c0000000000f7058]
>>>> .lockdep_rcu_suspicious+0x108/0x170
>>>> [  143.369696] [c0000001d08bf310] [d0000000042296d8]
>>>> .kvm_io_bus_read+0x1d8/0x220 [kvm]
>>>> [  143.369705] [c0000001d08bf3c0] [d00000000422f980]
>>>> .kvmppc_h_logical_ci_load+0x60/0xe0 [kvm]
>>>
>>> Could it be that we need to srcu_read_lock(&vcpu->kvm->srcu) before
>>> calling the kvm_io_bus_read/write() function in the
>>> kvmppc_h_logical_ci_load/store() function?
>>
>> I haven't had time to dig into this. I'll try it.
>
> FYI, I had the same problem with kvm_hv, so I tried to come up with a
> patch:
>
> 	https://patchwork.ozlabs.org/patch/519143/
>
> Sorry, forgot to CC: you there, but it would be great if you could give
> it a try!

It fixed the issue. Thanks!

>
>  Thomas
>
>
