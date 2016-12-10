Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tbSx12x0YzDw3x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 23:25:25 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id x23so5235399pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2016 04:25:24 -0800 (PST)
Subject: Re: [PATCH] powerpc/64: pseudo-NMI/SMP watchdog
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20161209155252.31381-1-npiggin@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5f861916-f96a-484b-4d34-5253285086bd@gmail.com>
Date: Sat, 10 Dec 2016 23:24:59 +1100
MIME-Version: 1.0
In-Reply-To: <20161209155252.31381-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> @@ -1295,7 +1295,7 @@ masked_##_H##interrupt:					\
>  	lis	r10,0x7fff;				\
>  	ori	r10,r10,0xffff;				\
>  	mtspr	SPRN_DEC,r10;				\
> -	b	2f;					\
> +	b	masked_decrementer_##_H##interrupt;	\
>  1:	cmpwi	r10,PACA_IRQ_DBELL;			\
>  	beq	2f;					\
>  	cmpwi	r10,PACA_IRQ_HMI;			\
> @@ -1312,6 +1312,16 @@ masked_##_H##interrupt:					\
>  	##_H##rfid;					\
>  	b	.
>  
> +#define MASKED_NMI(_H)					\
> +masked_decrementer_##_H##interrupt:			\
> +	std	r12,PACA_EXGEN+EX_R12(r13);		\
> +	GET_SCRATCH0(r10);				\
> +	std	r10,PACA_EXGEN+EX_R13(r13);		\
> +	EXCEPTION_PROLOG_PSERIES_1(soft_nmi_common, _H)
> +

This bit a little confusing, we are already handling an exception
do a masked_##_H##interrupt check and we redo the exception prolog?

Balbir Singh
