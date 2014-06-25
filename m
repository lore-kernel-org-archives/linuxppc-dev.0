Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A7781A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 14:10:44 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 25 Jun 2014 09:40:41 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6F8931258055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 09:40:11 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5P4BoOO61407276
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 09:41:50 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5P4AcF3000430
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 09:40:38 +0530
Received: from localhost.localdomain (dhcp-9-111-29-31.cn.ibm.com
 [9.111.29.31])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s5P4AbS3000371
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 09:40:37 +0530
Message-ID: <53AA4BBD.3020708@linux.vnet.ibm.com>
Date: Wed, 25 Jun 2014 12:10:37 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH powerpc] Fix parameter restoring issue in commit 752a6422f
References: <1403668804.5842.11.camel@ThinkPad-T5421.cn.ibm.com>
In-Reply-To: <1403668804.5842.11.camel@ThinkPad-T5421.cn.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Zhong,

I really need this patch :)

BTW, it seems that this bug just happens in 3.16-rc1 as I reported.

Thanks
Mike

On 06/25/2014 12:00 PM, Li Zhong wrote:
> In commit 752a6422f, new stack frame is created for parameters.
>
> However, the r1 is added back a little earlier, so r3 and r4 are
> restored from a wrong place, which could cause following error during
> boot:
>
> Querying for OPAL presence...  there !
> DEFAULT CATCH!, exception-handler=fff00700
> at   %SRR0: 0000000004223058   %SRR1: 8000000000081002
> Open Firmware exception handler entered from non-OF code
>
> Client's Fix Pt Regs:
>   00 0000000004223054 0000000004223020 0000000004fbe838 0000000000000002
>   04 0000000028002024 0000000004fbe838 000000000427e838 0000000004222f20
>   08 0000000000000000 0000000000000000 0000000004222f20 0000000000001002
>   0c a000000000000001 0000000000000000 0000000001a3fd20 00000000040eb170
>   10 00000000040eb628 00000000040eb368 fffffffffffffffd 0000000001a3fd20
>   14 0000000001b37f00 000000000f340000 0000000000cc0000 000000000f340000
>   18 00000000040ebb08 0000000003580000 00000000040eb128 0000000004285920
>   1c 0000000001a3fd60 00000000040eb100 7c0802a6f8010010 f821ff914b91ebd1
> Special Regs:
>      %IV: 00000700     %CR: 28002022    %XER: 00000000  %DSISR: 42000000
>    %SRR0: 0000000004223058   %SRR1: 8000000000081002
>      %LR: 0000000004223054    %CTR: 0000000000000000
>     %DAR: 01a3fcf00020b4ac
> Virtual PID = 0
>   ok
>
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> ---
> diff --git a/arch/powerpc/platforms/powernv/opal-takeover.S b/arch/powerpc/platforms/powernv/opal-takeover.S
> index 11a3169..9093540 100644
> --- a/arch/powerpc/platforms/powernv/opal-takeover.S
> +++ b/arch/powerpc/platforms/powernv/opal-takeover.S
> @@ -5,6 +5,7 @@
>    *
>    * This program is free software; you can redistribute it and/or
>    * modify it under the terms of the GNU General Public License
> +B
>    * as published by the Free Software Foundation; either version
>    * 2 of the License, or (at your option) any later version.
>    */
> @@ -27,11 +28,11 @@ _GLOBAL(opal_query_takeover)
>   	li	r3,H_HAL_TAKEOVER
>   	li	r4,H_HAL_TAKEOVER_QUERY_MAGIC
>   	HVSC
> -	addi	r1,r1,STACKFRAMESIZE
>   	ld	r10,STK_PARAM(R3)(r1)
>   	std	r4,0(r10)
>   	ld	r10,STK_PARAM(R4)(r1)
>   	std	r5,0(r10)
> +	addi	r1,r1,STACKFRAMESIZE
>   	lwz	r0,8(r1)
>   	mtcrf	0xff,r0
>   	blr
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
