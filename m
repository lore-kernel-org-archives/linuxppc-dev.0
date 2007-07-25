Return-Path: <satyakiran@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by ozlabs.org (Postfix) with ESMTP id 4562CDDEA2
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 08:16:02 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i21so264981wra
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 15:16:01 -0700 (PDT)
Message-ID: <acbcf3840707251516w301f834cj5f6a81a494d359ed@mail.gmail.com>
Date: Wed, 25 Jul 2007 17:16:01 -0500
From: Satya <satyakiran@gmail.com>
To: linuxppc-dev@ozlabs.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: pte_offset_map for ppc assumes HIGHPTE
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hello,
The implementation of pte_offset_map() for ppc assumes that PTEs are
kept in highmem (CONFIG_HIGHPTE). There is only one implmentation of
pte_offset_map() as follows (include/asm-ppc/pgtable.h):

#define pte_offset_map(dir, addr)               \
         ((pte_t *) kmap_atomic(pmd_page(*(dir)), KM_PTE0) + pte_index(addr))

Shouldn't this be made conditional according to CONFIG_HIGHPTE is
defined or not (as implemented in include/asm-i386/pgtable.h) ?

the same goes for pte_offset_map_nested and the corresponding unmap functions.

thanks,
Satya Popuri
