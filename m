Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfWMC3XgXzDqtp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 15:24:39 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5T5NmFZ081096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 01:24:37 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23usu9xh4g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 01:24:37 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 15:24:34 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E14E83578056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 15:24:30 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5T5OUxB655620
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 15:24:30 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5T5OU7h029703
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 15:24:30 +1000
Date: Wed, 29 Jun 2016 10:54:26 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Subject: Re: linux-next: manual merge of the powerpc tree with Linus' tree
References: <20160629103507.52c60714@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160629103507.52c60714@canb.auug.org.au>
Message-Id: <20160629052426.GB14508@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/06/29 10:35AM, Stephen Rothwell wrote:
> Hi all,

Hi Stephen,

> 
> Today's linux-next merge of the powerpc tree got a conflict in:
> 
>   arch/powerpc/Kconfig
> 
> between commit:
> 
>   844e3be47693 ("powerpc/bpf/jit: Disable classic BPF JIT on ppc64le")

Ah, I see that the above commit is not part of powerpc next tree, which 
explains the conflict.

> 
> from Linus' tree and commit:
> 
>   156d0e290e96 ("powerpc/ebpf/jit: Implement JIT compiler for extended BPF")
> 
> from the powerpc tree.
> 
> I fixed it up (see below - I am not sure this entirely correct) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/powerpc/Kconfig
> index 0a9d439bcda6,ee82f9a09a85..000000000000
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@@ -128,7 -128,8 +128,8 @@@ config PP
>   	select IRQ_FORCED_THREADING
>   	select HAVE_RCU_TABLE_FREE if SMP
>   	select HAVE_SYSCALL_TRACEPOINTS
> - 	select HAVE_CBPF_JIT if CPU_BIG_ENDIAN
>  -	select HAVE_CBPF_JIT if !PPC64
> ++	select HAVE_CBPF_JIT if !PPC64 && CPU_BIG_ENDIAN

'if !PPC64' condition is sufficient, though having the BIG_ENDIAN check 
should be ok too.

Thanks,
Naveen

> + 	select HAVE_EBPF_JIT if PPC64
>   	select HAVE_ARCH_JUMP_LABEL
>   	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>   	select ARCH_HAS_GCOV_PROFILE_ALL
> 
