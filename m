Return-Path: <SRS0=jlj5=AR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E997C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 07:05:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DF0204EA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 07:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="My5b6IJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DF0204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B0c6R3ybLzDqlZ
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 17:05:51 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0c2b57fCzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2020 17:02:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=My5b6IJJ; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4B0c2b3Hddz9sSd;
 Mon,  6 Jul 2020 17:02:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1594018951;
 bh=D5gyHcvUK6lKnKYokGnD2hzn02ptO74ZJMlwC1Bnp8U=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=My5b6IJJp3FakXvtal94RoaTGuMnVFEKmgNI9KegLN80/nHa4l36fCrDBL5EJtHKF
 yXp25dgpkIlyrS1j0+cibM8kd/Sz0+7Tfo+/yWl0DGXp/JqnMpmRO7Um0+fGdbtrbI
 mYb7va8GAH3vRKqbXwq+niDqmGFRr2qn0KmDgqC+GYnDBZr/EMKlETl6AuTZAmnLmV
 Hd5pahBb0VLoytCkJ7o6Mb+61DDyifwBiamok3U3tfhqx9dBg5bc3zJ4pPiKWizJTp
 a47vz9eFifSS4Z3F89Igr0sKQq9q0pD3dLV8TJwdM4f9GrSKjF6WRc1cJjR71V7W8J
 2Hbt5zyDneTng==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 11/26] powerpc/book3s64/pkeys: Make
 initial_allocation_mask static
In-Reply-To: <20200619135850.47155-12-aneesh.kumar@linux.ibm.com>
References: <20200619135850.47155-1-aneesh.kumar@linux.ibm.com>
 <20200619135850.47155-12-aneesh.kumar@linux.ibm.com>
Date: Mon, 06 Jul 2020 17:04:46 +1000
Message-ID: <87sge55dkh.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxram@us.ibm.com,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> initial_allocation_mask is not used outside this file.

And never modified after init, so make it __ro_after_init as well?

cheers

> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 652bad7334f3..47c81d41ea9a 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -13,7 +13,6 @@
>  
>  DECLARE_STATIC_KEY_FALSE(pkey_disabled);
>  extern int max_pkey;
> -extern u32 initial_allocation_mask; /*  bits set for the initially allocated keys */
>  extern u32 reserved_allocation_mask; /* bits set for reserved keys */
>  
>  #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
> diff --git a/arch/powerpc/mm/book3s64/pkeys.c b/arch/powerpc/mm/book3s64/pkeys.c
> index a4d7287082a8..73b5ef1490c8 100644
> --- a/arch/powerpc/mm/book3s64/pkeys.c
> +++ b/arch/powerpc/mm/book3s64/pkeys.c
> @@ -15,11 +15,11 @@
>  DEFINE_STATIC_KEY_FALSE(pkey_disabled);
>  DEFINE_STATIC_KEY_FALSE(execute_pkey_disabled);
>  int  max_pkey;			/* Maximum key value supported */
> -u32  initial_allocation_mask;   /* Bits set for the initially allocated keys */
>  /*
>   *  Keys marked in the reservation list cannot be allocated by  userspace
>   */
>  u32  reserved_allocation_mask;
> +static u32  initial_allocation_mask;   /* Bits set for the initially allocated keys */
>  static u64 default_amr;
>  static u64 default_iamr;
>  /* Allow all keys to be modified by default */
> -- 
> 2.26.2
