Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m9HY5jpMzF1Q6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 20:13:13 +1000 (AEST)
Subject: Re: [PATCH 05/17] powerpc: move io mapping functions into ioremap.c
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
 <b6f1dc10a4e2be3674fb9999d5b176a5ce9787e6.1525435203.git.christophe.leroy@c-s.fr>
 <87y3gqrarj.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <63426c6c-2b89-30a8-d68a-ca9ee0530d27@c-s.fr>
Date: Wed, 16 May 2018 12:13:09 +0200
MIME-Version: 1.0
In-Reply-To: <87y3gqrarj.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 11/05/2018 à 08:01, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 

[...]

>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/types.h>
>> +#include <linux/mm.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/init.h>
>> +#include <linux/highmem.h>
>> +#include <linux/memblock.h>
>> +#include <linux/slab.h>
>> +
>> +#include <asm/pgtable.h>
>> +#include <asm/pgalloc.h>
>> +#include <asm/fixmap.h>
>> +#include <asm/io.h>
>> +#include <asm/setup.h>
>> +#include <asm/sections.h>
> 
> I needed:
> 
> +#include <asm/machdep.h>

Oops, yes it was added in the following patch. Ok I move it one patch back.

Thanks
Christophe

> 
> To fix:
> 
> ../arch/powerpc/mm/ioremap.c: In function ‘ioremap_wc’:
> ../arch/powerpc/mm/ioremap.c:290:6: error: ‘ppc_md’ undeclared (first use in this function)
>    if (ppc_md.ioremap)
>        ^~~~~~
> 
> cheers
> 
