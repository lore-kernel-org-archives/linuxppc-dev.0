Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Y1B5XMWzDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 02:58:53 +1000 (AEST)
Subject: Re: [PATCH v13 3/6] CPM/QE: use genalloc to manage CPM/QE muram
To: Zhao Qiang <qiang.zhao@freescale.com>, lauraa@codeaurora.org
References: <1448851737-33125-1-git-send-email-qiang.zhao@freescale.com>
 <1448851737-33125-3-git-send-email-qiang.zhao@freescale.com>
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, olof@lixom.net, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, X.xie@freescale.com
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <7730792c-db7f-c644-55dc-0cea5ee65c0b@c-s.fr>
Date: Fri, 5 Aug 2016 18:58:48 +0200
MIME-Version: 1.0
In-Reply-To: <1448851737-33125-3-git-send-email-qiang.zhao@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 30/11/2015 à 03:48, Zhao Qiang a écrit :
> Use genalloc to manage CPM/QE muram instead of rheap.
>
> Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
> ---
> Changes for v9:
> 	- splitted from patch 3/5, modify cpm muram management functions.
> Changes for v10:
> 	- modify cpm muram first, then move to qe_common
> 	- modify commit.
> Changes for v11:
> 	- factor out the common alloc code
> 	- modify min_alloc_order to zero for cpm_muram_alloc_fixed.
> Changes for v12:
> 	- Nil
> Changes for v13:
> 	- rebase
>
>  arch/powerpc/include/asm/cpm.h   |   3 +
>  arch/powerpc/platforms/Kconfig   |   4 +-
>  arch/powerpc/sysdev/cpm_common.c | 126 +++++++++++++++++++++++++++------------
>  lib/genalloc.c                   |   2 +-
>  4 files changed, 94 insertions(+), 41 deletions(-)
>

With that patch applied, I get the following Oops on a 8xx (Which has a 
CPM1).

cpm_muram_init() is called from setup_arch()

It seems that gen_pool_add() tries to kmalloc() memory but the SLAB is 
not available yet.

[    0.000000] Unable to handle kernel paging request for data at 
address 0x00000008
[    0.000000] Faulting instruction address: 0xc01acce0
[    0.000000] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.000000] PREEMPT CMPC885
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 
4.4.14-s3k-dev-g0886ed8-svn #5
[    0.000000] task: c05183e0 ti: c0536000 task.ti: c0536000
[    0.000000] NIP: c01acce0 LR: c0011068 CTR: 00000000
[    0.000000] REGS: c0537e50 TRAP: 0300   Not tainted 
(4.4.14-s3k-dev-g0886ed8-svn)
[    0.000000] MSR: 00001032 <ME,IR,DR,RI>  CR: 28044428  XER: 00000000
[    0.000000] DAR: 00000008 DSISR: c0000000
GPR00: c0011068 c0537f00 c05183e0 00000000 00009000 ffffffff 00000bc0 
ffffffff
GPR08: ff003000 ff00b000 ff003bbf 00000000 22044422 100d43a8 00000000 
07ff94e8
GPR16: 00000000 07bb5d70 00000000 07ff81f4 07ff81f4 07ff81f4 00000000 
00000000
GPR24: 07ffb3a0 07fe7628 c0550000 c7ffa190 c0540000 ff003bbf 00000000 
00000001
[    0.000000] NIP [c01acce0] gen_pool_add_virt+0x14/0xdc
[    0.000000] LR [c0011068] cpm_muram_init+0xd4/0x18c
[    0.000000] Call Trace:
[    0.000000] [c0537f00] [00000200] 0x200 (unreliable)
[    0.000000] [c0537f20] [c0011068] cpm_muram_init+0xd4/0x18c
[    0.000000] [c0537f70] [c0494684] cpm_reset+0xb4/0xc8
[    0.000000] [c0537f90] [c0494c64] cmpc885_setup_arch+0x10/0x30
[    0.000000] [c0537fa0] [c0493cd4] setup_arch+0x130/0x168
[    0.000000] [c0537fb0] [c04906bc] start_kernel+0x88/0x380
[    0.000000] [c0537ff0] [c0002224] start_here+0x38/0x98
[    0.000000] Instruction dump:
[    0.000000] 91430010 91430014 80010014 83e1000c 7c0803a6 38210010 
4e800020 7c0802a6
[    0.000000] 9421ffe0 bf61000c 90010024 7c7e1b78 <80630008> 7c9c2378 
7cc31c30 3863001f
[    0.000000] ---[ end trace dc8fa200cb88537f ]---
