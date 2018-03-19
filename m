Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404rbt5mywzF0nF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 09:39:54 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id p9-v6so8626174pls.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 15:39:54 -0700 (PDT)
Date: Tue, 20 Mar 2018 09:39:40 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <oss@buserror.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH  1/2] powerpc/mm: Add missing tracepoint for tlbie
Message-ID: <20180320093940.56144adf@balbir.ozlabs.ibm.com>
In-Reply-To: <4ffd3d6143f991615ffe07f43952cbc62163d319.1521452718.git.christophe.leroy@c-s.fr>
References: <4ffd3d6143f991615ffe07f43952cbc62163d319.1521452718.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 19 Mar 2018 11:32:38 +0100 (CET)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> commit 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
> added tracepoints for tlbie calls, but _tlbil_va() was forgotten
> 
> Fixes: 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/mm/mmu_decl.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index 57fbc554c785..b9991e0c61a2 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -21,6 +21,7 @@
>  #include <linux/mm.h>
>  #include <asm/tlbflush.h>
>  #include <asm/mmu.h>
> +#include <asm/trace.h>
>  
>  #ifdef CONFIG_PPC_MMU_NOHASH
>  
> @@ -56,6 +57,7 @@ static inline void _tlbil_va(unsigned long address, unsigned int pid,
>  			     unsigned int tsize, unsigned int ind)
>  {
>  	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
> +	trace_tlbie(pid, 0, address, 0, 0, 0, 0);


I did not really cover a whole lot of NOHASH, any idea why its
called tlbil_va and not _tlbie_va?

The first field is really the lpid and should be 0 for non-virtualized
systems. Can I recommend that we rs field for pid and the rb field for
address? so effectively something like

trace_tlbie(0, 0, address, pid, 0, 0, 0);

Balbir
