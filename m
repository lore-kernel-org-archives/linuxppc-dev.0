Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9ZdC5P6qzDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 16:25:35 +1000 (AEST)
Subject: Re: [PATCH] soc: fsl/qe: fix Oops on CPM1 (and likely CPM2)
To: Scott Wood <oss@buserror.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Zhao Qiang <qiang.zhao@nxp.com>, "David S.Miller" <davem@davemloft.net>
References: <20160808160858.4B9251A2452@localhost.localdomain>
 <1470958199.25630.266.camel@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0f8d1bdd-1b8a-6e5c-4616-1210016de90a@c-s.fr>
Date: Fri, 12 Aug 2016 08:25:30 +0200
MIME-Version: 1.0
In-Reply-To: <1470958199.25630.266.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 12/08/2016 à 01:29, Scott Wood a écrit :
> On Mon, 2016-08-08 at 18:08 +0200, Christophe Leroy wrote:
>> Commit 0e6e01ff694ee ("CPM/QE: use genalloc to manage CPM/QE muram")
>> has changed the way muram is managed.
>> genalloc uses kmalloc(), hence requires the SLAB to be up and running.
>>
>> On powerpc 8xx, cpm_reset() is called early during startup.
>> cpm_reset() then calls cpm_muram_init() before SLAB is available,
>> hence the following Oops.
>>
>> cpm_reset() cannot be called during initcalls because the CPM is
>> needed for console
>>
>> This patch splits cpm_muram_init() in two parts. The first part,
>> related to mappings, is kept as cpm_muram_init()
>> The second part is named cpm_muram_pool_init() and is called
>> the first time cpm_muram_alloc() is used
>
> Why do you need to split it, versus calling the full cpm_muram_init() on
> demand?
>

There are drivers like for instance de i2c-cpm driver, that for instance 
call cpm_muram_addr() before calling cpm_muram_alloc()
Therefore, we need muram_vbase and muram_pbase set.

So if we want to keep a single function, it means we also have to call 
it on demand from cpm_muram_addr(), cpm_muram_offset() and cpm_muram_dma().

Is that what you recommend ?

Christophe
