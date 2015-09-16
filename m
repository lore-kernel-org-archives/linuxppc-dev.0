Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f173.google.com (mail-yk0-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 976AC1A04B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 18:51:45 +1000 (AEST)
Received: by ykft14 with SMTP id t14so60339004ykf.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 01:51:42 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 16 Sep 2015 11:51:42 +0300
Message-ID: <CAOJe8K3mu6M48wGAMMQNXPDrkzk+z4j5yzcJ7eRfex0FWcZsQA@mail.gmail.com>
Subject: suspicious RCU usage with kvm_pr
From: Denis Kirjanov <kda@linux-powerpc.org>
To: kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I see the following trace on qemu startup (ps700 blade):

v4.2-11169-g64d1def


[  143.369638] ===============================
[  143.369640] [ INFO: suspicious RCU usage. ]
[  143.369643] 4.2.0-11169-g64d1def #10 Tainted: G S
[  143.369645] -------------------------------
[  143.369647] arch/powerpc/kvm/../../../virt/kvm/kvm_main.c:3310
suspicious rcu_dereference_check() usage!
[  143.369649]
other info that might help us debug this:

[  143.369652]
rcu_scheduler_active = 1, debug_locks = 1
[  143.369655] 1 lock held by qemu-system-ppc/2292:
[  143.369656]  #0:  (&vcpu->mutex){+.+.+.}, at: [<d000000004225bac>]
.vcpu_load+0x2c/0xb0 [kvm]
[  143.369672]
stack backtrace:
[  143.369675] CPU: 12 PID: 2292 Comm: qemu-system-ppc Tainted: G S
          4.2.0-11169-g64d1def #10
[  143.369677] Call Trace:
[  143.369682] [c0000001d08bf200] [c000000000816dd0]
.dump_stack+0x98/0xd4 (unreliable)
[  143.369687] [c0000001d08bf280] [c0000000000f7058]
.lockdep_rcu_suspicious+0x108/0x170
[  143.369696] [c0000001d08bf310] [d0000000042296d8]
.kvm_io_bus_read+0x1d8/0x220 [kvm]
[  143.369705] [c0000001d08bf3c0] [d00000000422f980]
.kvmppc_h_logical_ci_load+0x60/0xe0 [kvm]
[  143.369712] [c0000001d08bf450] [d0000000042d8d30]
.kvmppc_h_pr+0x4f0/0xc80 [kvm_pr]
[  143.369718] [c0000001d08bf570] [d0000000042d9a30]
.kvmppc_core_emulate_op_pr+0x270/0x720 [kvm_pr]
[  143.369723] [c0000001d08bf630] [d0000000042d0684]
.kvmppc_emulate_instruction+0xd4/0x7c0 [kvm_pr]
[  143.369728] [c0000001d08bf6f0] [d0000000042d82f8]
.kvmppc_handle_exit_pr+0xc98/0xf80 [kvm_pr]
[  143.369734] [c0000001d08bf790] [d0000000042dab2c]
after_sprg3_load+0x88/0x98 [kvm_pr]
[  143.369739] [c0000001d08bf960] [d0000000042d742c]
.kvmppc_vcpu_run_pr+0xdc/0x190 [kvm_pr]
[  143.369748] [c0000001d08bf9f0] [d00000000423114c]
.kvmppc_vcpu_run+0x2c/0x40 [kvm]
[  143.369756] [c0000001d08bfa60] [d00000000422e4b4]
.kvm_arch_vcpu_ioctl_run+0x54/0x170 [kvm]
[  143.369764] [c0000001d08bfaf0] [d000000004226298]
.kvm_vcpu_ioctl+0x5f8/0x8b0 [kvm]
[  143.369768] [c0000001d08bfcb0] [c000000000297c24] .do_vfs_ioctl+0x4d4/0x820
[  143.369771] [c0000001d08bfd90] [c000000000297fc8] .SyS_ioctl+0x58/0xb0
[  143.369775] [c0000001d08bfe30] [c00000000000916c] system_call+0x38/0xd0
