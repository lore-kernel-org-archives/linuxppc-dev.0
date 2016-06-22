Return-Path: <cascardo@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZVwK3ptqzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 02:50:57 +1000 (AEST)
Date: Wed, 22 Jun 2016 13:50:48 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 stable@vger.kernel.org, Matt Evans <matt@ozlabs.org>,
 Denis Kirjanov <kda@linux-powerpc.org>,
 Paul Mackerras <paulus@samba.org>, Alexei Starovoitov <ast@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCHv2 1/7] ppc bpf/jit: Disable classic BPF JIT on ppc64le
Message-ID: <20160622165048.GB8660@indiana.gru.redhat.com>
References: <cover.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
 <24a2db8c1ed97008426e8093bc83165a6a237d1c.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <24a2db8c1ed97008426e8093bc83165a6a237d1c.1466612260.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 22, 2016 at 09:55:01PM +0530, Naveen N. Rao wrote:
> Classic BPF JIT was never ported completely to work on little endian
> powerpc. However, it can be enabled and will crash the system when used.
> As such, disable use of BPF JIT on ppc64le.

Thanks, Naveen.

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>

> 
> Cc: stable@vger.kernel.org
> Cc: Matt Evans <matt@ozlabs.org>
> Cc: Denis Kirjanov <kda@linux-powerpc.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Cc: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
> Reported-by: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 01f7464..0a9d439 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -128,7 +128,7 @@ config PPC
>  	select IRQ_FORCED_THREADING
>  	select HAVE_RCU_TABLE_FREE if SMP
>  	select HAVE_SYSCALL_TRACEPOINTS
> -	select HAVE_CBPF_JIT
> +	select HAVE_CBPF_JIT if CPU_BIG_ENDIAN
>  	select HAVE_ARCH_JUMP_LABEL
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> -- 
> 2.8.2
> 
