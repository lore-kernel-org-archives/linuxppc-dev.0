Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB88C282DD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 16:35:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A1920643
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 16:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="HnqJcykP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A1920643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pTZs0TrxzDqG6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 02:35:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="HnqJcykP"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTXG0NJHzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:33:18 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44pTX91PgTz9v080;
 Tue, 23 Apr 2019 18:33:13 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=HnqJcykP; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id adja7NeA68ZW; Tue, 23 Apr 2019 18:33:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44pTX90Cwtz9v07y;
 Tue, 23 Apr 2019 18:33:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556037193; bh=VWWvplwqGGjYD3rxn2glJJtVIuqF0qMWj3HahbZMsf4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=HnqJcykPeMeNJ62Gfze29aUgLNSwFRDrBnqLuwfe3EQHWz2PLl7YedADu/Tcw1X82
 HDnW4vqvnelHDGP9O/b0I7x1kYl1OIAfoaJe1xEREq0Z7ie+NLwTcaFFddCOGwweHD
 7X/MFwSLvONNsnK5mxEV8TBOVaj7byOLtPRlQhRY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A1A558B8E9;
 Tue, 23 Apr 2019 18:33:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id T8zX1m3VTTOd; Tue, 23 Apr 2019 18:33:14 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1CC618B8C4;
 Tue, 23 Apr 2019 18:33:13 +0200 (CEST)
Subject: Re: [PATCH v2 2/5] powerpc: Fix vDSO clock_getres()
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20190416161434.32691-1-vincenzo.frascino@arm.com>
 <20190416161434.32691-3-vincenzo.frascino@arm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5f59aad9-f6d2-5622-b183-4506f13eedbd@c-s.fr>
Date: Tue, 23 Apr 2019 18:33:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416161434.32691-3-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, Greentime Hu <green.hu@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>,
 Shuah Khan <shuah@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 16/04/2019 à 18:14, Vincenzo Frascino a écrit :
> clock_getres in the vDSO library has to preserve the same behaviour
> of posix_get_hrtimer_res().
> 
> In particular, posix_get_hrtimer_res() does:
>      sec = 0;
>      ns = hrtimer_resolution;
> and hrtimer_resolution depends on the enablement of the high
> resolution timers that can happen either at compile or at run time.
> 
> Fix the powerpc vdso implementation of clock_getres keeping a copy of
> hrtimer_resolution in vdso data and using that directly.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/include/asm/vdso_datapage.h  | 2 ++
>   arch/powerpc/kernel/asm-offsets.c         | 2 +-
>   arch/powerpc/kernel/time.c                | 1 +
>   arch/powerpc/kernel/vdso32/gettimeofday.S | 7 +++++--
>   arch/powerpc/kernel/vdso64/gettimeofday.S | 7 +++++--
>   5 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
> index bbc06bd72b1f..4333b9a473dc 100644
> --- a/arch/powerpc/include/asm/vdso_datapage.h
> +++ b/arch/powerpc/include/asm/vdso_datapage.h
> @@ -86,6 +86,7 @@ struct vdso_data {
>   	__s32 wtom_clock_nsec;			/* Wall to monotonic clock nsec */
>   	__s64 wtom_clock_sec;			/* Wall to monotonic clock sec */
>   	struct timespec stamp_xtime;		/* xtime as at tb_orig_stamp */
> +	__u32 hrtimer_res;			/* hrtimer resolution */
>      	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls  */
>      	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
>   };
> @@ -107,6 +108,7 @@ struct vdso_data {
>   	__s32 wtom_clock_nsec;
>   	struct timespec stamp_xtime;	/* xtime as at tb_orig_stamp */
>   	__u32 stamp_sec_fraction;	/* fractional seconds of stamp_xtime */
> +	__u32 hrtimer_res;		/* hrtimer resolution */
>      	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
>   	__u32 dcache_block_size;	/* L1 d-cache block size     */
>   	__u32 icache_block_size;	/* L1 i-cache block size     */
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 86a61e5f8285..52e4b98a8492 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -383,6 +383,7 @@ int main(void)
>   	OFFSET(WTOM_CLOCK_NSEC, vdso_data, wtom_clock_nsec);
>   	OFFSET(STAMP_XTIME, vdso_data, stamp_xtime);
>   	OFFSET(STAMP_SEC_FRAC, vdso_data, stamp_sec_fraction);
> +	OFFSET(CLOCK_REALTIME_RES, vdso_data, hrtimer_res);
>   	OFFSET(CFG_ICACHE_BLOCKSZ, vdso_data, icache_block_size);
>   	OFFSET(CFG_DCACHE_BLOCKSZ, vdso_data, dcache_block_size);
>   	OFFSET(CFG_ICACHE_LOGBLOCKSZ, vdso_data, icache_log_block_size);
> @@ -413,7 +414,6 @@ int main(void)
>   	DEFINE(CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
>   	DEFINE(CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
>   	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
> -	DEFINE(CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
>   
>   #ifdef CONFIG_BUG
>   	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index bc0503ef9c9c..62c04a6746d8 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -955,6 +955,7 @@ void update_vsyscall(struct timekeeper *tk)
>   	vdso_data->wtom_clock_nsec = tk->wall_to_monotonic.tv_nsec;
>   	vdso_data->stamp_xtime = xt;
>   	vdso_data->stamp_sec_fraction = frac_sec;
> +	vdso_data->hrtimer_res = hrtimer_resolution;
>   	smp_wmb();
>   	++(vdso_data->tb_update_count);
>   }
> diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
> index afd516b572f8..2b5f9e83c610 100644
> --- a/arch/powerpc/kernel/vdso32/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
> @@ -160,12 +160,15 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
>   	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
>   	bne	cr0,99f
>   
> +	mflr	r12
> +  .cfi_register lr,r12
> +	bl	__get_datapage@local
> +	lwz	r5,CLOCK_REALTIME_RES(r3)
> +	mtlr	r12
>   	li	r3,0
>   	cmpli	cr0,r4,0
>   	crclr	cr0*4+so
>   	beqlr
> -	lis	r5,CLOCK_REALTIME_RES@h
> -	ori	r5,r5,CLOCK_REALTIME_RES@l
>   	stw	r3,TSPC32_TV_SEC(r4)
>   	stw	r5,TSPC32_TV_NSEC(r4)
>   	blr
> diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
> index 1f324c28705b..f07730f73d5e 100644
> --- a/arch/powerpc/kernel/vdso64/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
> @@ -190,12 +190,15 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
>   	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
>   	bne	cr0,99f
>   
> +	mflr	r12
> +  .cfi_register lr,r12
> +	bl	V_LOCAL_FUNC(__get_datapage)
> +	lwz	r5,CLOCK_REALTIME_RES(r3)
> +	mtlr	r12
>   	li	r3,0
>   	cmpldi	cr0,r4,0
>   	crclr	cr0*4+so
>   	beqlr
> -	lis	r5,CLOCK_REALTIME_RES@h
> -	ori	r5,r5,CLOCK_REALTIME_RES@l
>   	std	r3,TSPC64_TV_SEC(r4)
>   	std	r5,TSPC64_TV_NSEC(r4)
>   	blr
> 
