Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqhNd74lVzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 13:42:41 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ez1so551873pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 20:42:41 -0700 (PDT)
Date: Thu, 14 Jul 2016 13:42:27 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 03/12] powerpc/mm: use _raw variant of page table
 accessors
Message-ID: <20160714034227.GC18277@balbir.ozlabs.ibm.com>
Reply-To: bsingharora@gmail.com
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1468402531-4914-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468402531-4914-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2016 at 03:05:22PM +0530, Aneesh Kumar K.V wrote:
> This switch few of the page table accessor to use the __raw variant 
      ^^ switches                   ^^ accessors
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

Acked-by: Balbir Singh <bsingharora@gmail.com>
