Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ4wx4TgpzDqGL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 15:31:29 +1000 (AEST)
Date: Mon, 30 May 2016 15:31:06 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Aneesh Kumar K.V\"  <aneesh.kumar@linux.vnet.ibm.com>,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH V2 04/68] powerpc/mm: Use big endian page table for
 book3s 64
Message-ID: <20160530153106.7ece1ca0@kryten>
In-Reply-To: <20160530090833.4400ac83@kryten>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160529210356.66dd944e@kryten>
 <1464557231.3078.185.camel@kernel.crashing.org>
 <20160530090833.4400ac83@kryten>
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

Hi,

> I see the same issue in unmap_page_range(), __hash_page_64K(),
> handle_mm_fault().

This looks to be about 10% slower on POWER8:

#include <stdlib.h>
#include <sys/mman.h>
#include <assert.h>

#define ITERATIONS 10000000

#define MEMSIZE (128 * 1024 * 1024)

int main(void)
{
        unsigned long i = ITERATIONS;

        while (i--) {
                char *c = mmap(NULL, MEMSIZE, PROT_READ|PROT_WRITE,
                               MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
                assert(c != MAP_FAILED);
                munmap(c, MEMSIZE);
        }

        return 0;
}
