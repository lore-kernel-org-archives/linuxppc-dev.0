Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4Yz41Mv6zDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 21:38:24 +1000 (AEST)
Date: Wed, 11 May 2016 21:38:20 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 warrier@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc/kvm: Fix build error on book3s_hv.c
Message-ID: <20160511113820.GD10249@fergus.ozlabs.ibm.com>
References: <1462929355-30681-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1462929355-30681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 11, 2016 at 11:15:55AM +1000, Gavin Shan wrote:
> When CONFIG_KVM_XICS is enabled, CPU_UP_PREPARE and other macros for
> CPU states in linux/cpu.h are needed by arch/powerpc/kvm/book3s_hv.c.
> Otherwise, build error as below is seen:
> 
>    gwshan@gwshan:~/sandbox/l$ make arch/powerpc/kvm/book3s_hv.o
>     :
>    CC      arch/powerpc/kvm/book3s_hv.o
>    arch/powerpc/kvm/book3s_hv.c: In function ‘kvmppc_cpu_notify’:
>    arch/powerpc/kvm/book3s_hv.c:3072:7: error: ‘CPU_UP_PREPARE’ \
>    undeclared (first use in this function)
> 
> This fixes the issue introduced by commit <6f3bb80944> ("KVM: PPC:
> Book3S HV: kvmppc_host_rm_ops - handle offlining CPUs").
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks, applied to my kvm-ppc-next branch (with cc:
stable@vger.kernel.org).

Paul.
