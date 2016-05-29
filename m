Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rHcMW75NdzDqGs
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 May 2016 21:04:23 +1000 (AEST)
Date: Sun, 29 May 2016 21:03:56 +1000
From: Anton Blanchard <anton@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH V2 04/68] powerpc/mm: Use big endian page table for
 book3s 64
Message-ID: <20160529210356.66dd944e@kryten>
In-Reply-To: <1460182444-2468-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

> This enables us to share the same page table code for
> both radix and hash. Radix use a hardware defined big endian
> page table

This is measurably worse (a little over 2% on POWER8) on a futex
microbenchmark:

#define _GNU_SOURCE
#include <unistd.h>
#include <sys/syscall.h>
#include <linux/futex.h>

#define ITERATIONS 10000000

#define futex(A, B, C, D, E, F)		syscall(__NR_futex, A, B, C, D, E, F)

int main(void)
{
	unsigned long i = ITERATIONS;

	while (i--) {
		unsigned int addr = 0;

		futex(&addr, FUTEX_WAKE, 1, NULL, NULL, 0);
	}

	return 0;
}

Is there any way to avoid the radix tax here?

Anton
