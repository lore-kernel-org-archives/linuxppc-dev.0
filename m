Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4P9S4gQBzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 15:01:48 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id r187so3399144pfr.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 22:01:48 -0700 (PDT)
Subject: Re: [PATCH] powerpc/kvm: Fix build error on book3s_hv.c
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1462929355-30681-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: kvm-ppc@vger.kernel.org, warrier@linux.vnet.ibm.com, mpe@ellerman.id.au
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <73cbb393-f48f-735e-6d23-fd2366bf376a@gmail.com>
Date: Wed, 11 May 2016 15:01:40 +1000
MIME-Version: 1.0
In-Reply-To: <1462929355-30681-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/05/16 11:15, Gavin Shan wrote:
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
> ---
I ran into the same thing, fixed it, but forgot to send it out
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
