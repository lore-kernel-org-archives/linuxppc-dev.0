Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABDDC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 00:24:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9074C21871
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 00:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9074C21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VjDS10j5zDqRZ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 11:24:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VjBh3Zp0zDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 11:23:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44VjBh2Sv6z9sSf; Fri, 29 Mar 2019 11:23:24 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44VjBh1VJvz9sSc;
 Fri, 29 Mar 2019 11:23:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC PATCH 2/3] powernv/mce: Print correct severity for mce error.
In-Reply-To: <155324739171.7819.1095626412782166400.stgit@jupiter.in.ibm.com>
References: <155324738319.7819.17982472592795327790.stgit@jupiter.in.ibm.com>
 <155324739171.7819.1095626412782166400.stgit@jupiter.in.ibm.com>
Date: Fri, 29 Mar 2019 11:23:23 +1100
Message-ID: <878swyo7es.fsf@concordia.ellerman.id.au>
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
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
> index 8d0b1c24c636..314ed3f13d59 100644
> --- a/arch/powerpc/include/asm/mce.h
> +++ b/arch/powerpc/include/asm/mce.h
> @@ -110,17 +110,18 @@ enum MCE_LinkErrorType {
>  };
>  
>  struct machine_check_event {
> -	enum MCE_Version	version:8;	/* 0x00 */
> -	uint8_t			in_use;		/* 0x01 */
> -	enum MCE_Severity	severity:8;	/* 0x02 */
> -	enum MCE_Initiator	initiator:8;	/* 0x03 */
> -	enum MCE_ErrorType	error_type:8;	/* 0x04 */
> -	enum MCE_Disposition	disposition:8;	/* 0x05 */
> -	uint16_t		cpu;		/* 0x06 */
> -	uint64_t		gpr3;		/* 0x08 */
> -	uint64_t		srr0;		/* 0x10 */
> -	uint64_t		srr1;		/* 0x18 */
> -	union {					/* 0x20 */
> +	enum MCE_Version	version:8;
> +	uint8_t			in_use;
> +	enum MCE_Severity	severity:8;
> +	enum MCE_Initiator	initiator:8;
> +	enum MCE_ErrorType	error_type:8;
> +	enum MCE_Disposition	disposition:8;
> +	uint8_t			sync_error;
> +	uint16_t		cpu;
> +	uint64_t		gpr3;
> +	uint64_t		srr0;
> +	uint64_t		srr1;

Can you switch these to use kernel types while you're at it, ie. u8, u64 etc.

> @@ -194,6 +195,7 @@ struct mce_error_info {
>  	} u;
>  	enum MCE_Severity	severity:8;
>  	enum MCE_Initiator	initiator:8;
> +	uint8_t			sync_error;

u8 here but bool later?

> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index 6b800eec31f2..06161de19060 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -133,106 +133,107 @@ struct mce_ierror_table {
>  	unsigned int error_subtype;
>  	unsigned int initiator;
>  	unsigned int severity;
> +	bool sync_error;
>  };

ie. here it's a bool?

> @@ -539,8 +543,9 @@ static int mce_handle_derror(struct pt_regs *regs,
>  		return handled;
>  
>  	mce_err->error_type = MCE_ERROR_TYPE_UNKNOWN;
> -	mce_err->severity = MCE_SEV_ERROR_SYNC;
> +	mce_err->severity = MCE_SEV_SEVERE;
>  	mce_err->initiator = MCE_INITIATOR_CPU;
> +	mce_err->sync_error = 1;

u8 or bool?

cheers
