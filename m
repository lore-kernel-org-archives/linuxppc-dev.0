Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLXpT2drvzDqWg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 15:34:25 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id gp3so5051862pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 22:34:25 -0700 (PDT)
Received: from balbir.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id x19sm4729593pfi.81.2016.06.02.22.34.21
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 02 Jun 2016 22:34:22 -0700 (PDT)
Subject: Re: [PATCH] powerpc/mm: use _raw variant of page table accessors
To: linuxppc-dev@lists.ozlabs.org
References: <1464692382-29698-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <7ba4cc59-351c-e990-97b4-c3429a0e7f34@gmail.com>
Date: Fri, 3 Jun 2016 15:34:19 +1000
MIME-Version: 1.0
In-Reply-To: <1464692382-29698-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 31/05/16 20:59, Aneesh Kumar K.V wrote:
> This switch few of the page table accessor to use the __raw variant
> and does the cpu to big endian conversion of constants. This helps in
> generating better code.
> 
> For ex: a pgd_none(pgd) check with and without fix is listed below
> 
> Without fix:
> ------------
>    2240:	20 00 61 eb 	ld      r27,32(r1)
> /* PGD level */
> typedef struct { __be64 pgd; } pgd_t;
> static inline unsigned long pgd_val(pgd_t x)
> {
> 	return be64_to_cpu(x.pgd);
> 
>     2244:	22 00 66 78 	rldicl  r6,r3,32,32
>     2248:	3e 40 7d 54 	rotlwi  r29,r3,8
>     224c:	0e c0 7d 50 	rlwimi  r29,r3,24,0,7
>     2250:	3e 40 c5 54 	rotlwi  r5,r6,8
>     2254:	2e c4 7d 50 	rlwimi  r29,r3,24,16,23
>     2258:	0e c0 c5 50 	rlwimi  r5,r6,24,0,7
>     225c:	2e c4 c5 50 	rlwimi  r5,r6,24,16,23
>     2260:	c6 07 bd 7b 	rldicr  r29,r29,32,31
>     2264:	78 2b bd 7f 	or      r29,r29,r5
> 		if (pgd_none(pgd))
>     2268:	00 00 bd 2f 	cmpdi   cr7,r29,0
>     226c:	54 03 9e 41 	beq     cr7,25c0 <__get_user_pages_fast+0x500>
> 
> With fix:
> ---------
>     2370:	20 00 61 eb 	ld      r27,32(r1)
> 		if (pgd_none(pgd))
>     2374:	00 00 bd 2f 	cmpdi   cr7,r29,0
>     2378:	a8 03 9e 41 	beq     cr7,2720 <__get_user_pages_fast+0x530>
> 			break;
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---


Can we just save the cpu_to_be64(_PAGE_PTE) as _BE64_PAGE_PTE constant
in big-endian (pgtable-be-types.h) and similar for other things. I know its
not the best option, but we don't really expect these bits to change often or anymore


Otherwise

Acked-by: Balbir Singh <bsingharora@gmail.com>
