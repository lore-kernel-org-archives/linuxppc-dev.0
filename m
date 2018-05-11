Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40j0wc4nXKzF2Cj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 16:45:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/17] powerpc/nohash32: set GUARDED attribute in the PMD
 directly
In-Reply-To: <4e87c5bd5ffe886ca202a58e5c93358bd6a34dce.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
 <4e87c5bd5ffe886ca202a58e5c93358bd6a34dce.1525435203.git.christophe.leroy@c-s.fr>
Date: Fri, 11 May 2018 16:45:52 +1000
Message-ID: <87vabur8pr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
> index 59be5dfcb3e9..b8c347077e02 100644
> --- a/arch/powerpc/mm/ioremap.c
> +++ b/arch/powerpc/mm/ioremap.c
> @@ -132,9 +132,14 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
>  	if (slab_is_available()) {
>  		struct vm_struct *area;
>  
> -		area = __get_vm_area_caller(size, VM_IOREMAP,
> -					    ioremap_bot, IOREMAP_END,
> -					    caller);
> +		if (flags & _PAGE_GUARDED)

On 64-bit configs:

  arch/powerpc/mm/ioremap.c:135:15: error: '_PAGE_GUARDED' undeclared (first use in this function)

cheers
