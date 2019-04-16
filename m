Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78295C282DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 16:31:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB32C2087C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 16:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB32C2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k9pp5HqZzDqC8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 02:30:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=catalin.marinas@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44k9gX0cxfzDq9V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 02:24:39 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F5E480D;
 Tue, 16 Apr 2019 09:24:38 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 8FB173F59C; Tue, 16 Apr 2019 09:24:35 -0700 (PDT)
Date: Tue, 16 Apr 2019 17:24:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v2 1/5] arm64: Fix vDSO clock_getres()
Message-ID: <20190416162432.GI28994@arrakis.emea.arm.com>
References: <20190416161434.32691-1-vincenzo.frascino@arm.com>
 <20190416161434.32691-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416161434.32691-2-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, Greentime Hu <green.hu@gmail.com>,
 linux-kselftest@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 16, 2019 at 05:14:30PM +0100, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 2d419006ad43..5f5759d51c33 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -245,6 +245,8 @@ void update_vsyscall(struct timekeeper *tk)
>  		vdso_data->cs_shift		= tk->tkr_mono.shift;
>  	}
>  
> +	vdso_data->hrtimer_res		= hrtimer_resolution;

This should be a WRITE_ONCE(), just in case.

> +
>  	smp_wmb();
>  	++vdso_data->tb_seq_count;
>  }
> diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
> index c39872a7b03c..e2e9dfe9ba4a 100644
> --- a/arch/arm64/kernel/vdso/gettimeofday.S
> +++ b/arch/arm64/kernel/vdso/gettimeofday.S
> @@ -296,32 +296,32 @@ ENDPROC(__kernel_clock_gettime)
>  /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
>  ENTRY(__kernel_clock_getres)
>  	.cfi_startproc
> +	adr	vdso_data, _vdso_data
>  	cmp	w0, #CLOCK_REALTIME
>  	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
>  	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
> -	b.ne	1f
> +	b.ne	2f
>  
> -	ldr	x2, 5f
> -	b	2f
> -1:
> +1:	/* Get hrtimer_res */
> +	ldr	x2, [vdso_data, #CLOCK_REALTIME_RES]

And here we need an "ldr w2, ..." since hrtimer_res is u32.

With the above (which Will can fix up):

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
