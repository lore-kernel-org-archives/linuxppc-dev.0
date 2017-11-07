Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlz74QctzDrCZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:27 +1100 (AEDT)
In-Reply-To: <20171105123355.3014-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: KVM: PPC: Book3S HV: Handle host system reset in guest mode
Message-Id: <3yWlz51TSQz9ryT@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-11-05 at 12:33:55 UTC, Nicholas Piggin wrote:
> If the host takes a system reset interrupt while a guest is running,
> the CPU must exit the guest before processing the host exception
> handler.
> 
> After this patch, taking a sysrq+x with a CPU running in a guest
> gives a trace like this:
> 
>    cpu 0x27: Vector: 100 (System Reset) at [c000000fdf5776f0]
>        pc: c008000010158b80: kvmppc_run_core+0x16b8/0x1ad0 [kvm_hv]
>        lr: c008000010158b80: kvmppc_run_core+0x16b8/0x1ad0 [kvm_hv]
>        sp: c000000fdf577850
>       msr: 9000000002803033
>      current = 0xc000000fdf4b1e00
>      paca    = 0xc00000000fd4d680	 softe: 3	 irq_happened: 0x01
>        pid   = 6608, comm = qemu-system-ppc
>    Linux version 4.14.0-rc7-01489-g47e1893a404a-dirty #26 SMP
>    [c000000fdf577a00] c008000010159dd4 kvmppc_vcpu_run_hv+0x3dc/0x12d0 [kvm_hv]
>    [c000000fdf577b30] c0080000100a537c kvmppc_vcpu_run+0x44/0x60 [kvm]
>    [c000000fdf577b60] c0080000100a1ae0 kvm_arch_vcpu_ioctl_run+0x118/0x310 [kvm]
>    [c000000fdf577c00] c008000010093e98 kvm_vcpu_ioctl+0x530/0x7c0 [kvm]
>    [c000000fdf577d50] c000000000357bf8 do_vfs_ioctl+0xd8/0x8c0
>    [c000000fdf577df0] c000000000358448 SyS_ioctl+0x68/0x100
>    [c000000fdf577e30] c00000000000b220 system_call+0x58/0x6c
>    --- Exception: c01 (System Call) at 00007fff76868df0
>    SP (7fff7069baf0) is in userspace
> 
> Fixes: e36d0a2ed5 ("powerpc/powernv: Implement NMI IPI with OPAL_SIGNAL_SYSTEM_RESET")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6de6638b35daa0dfb7daefd78d5501

cheers
