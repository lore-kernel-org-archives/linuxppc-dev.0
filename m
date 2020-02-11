Return-Path: <SRS0=nxP5=37=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5783EC352A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 06:41:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034D420708
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 06:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UIz1NNOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034D420708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48GtTF5tkZzDqLt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 17:41:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=UIz1NNOU; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48GtRB4cP1zDqCY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2020 17:39:16 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 48GtR164nyz9v4jt;
 Tue, 11 Feb 2020 07:39:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=UIz1NNOU; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id NfWLAfnsQiTU; Tue, 11 Feb 2020 07:39:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 48GtR14xqNz9v4js;
 Tue, 11 Feb 2020 07:39:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1581403149; bh=6GYmNKyF2VN0X3iKM/bCSGm4v4LphVlwXsC9UkhwOr0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=UIz1NNOUB9TyLUoGJll5exw13tfAcRM2jl0WLuRHyhSUNqn7GofKu90GMkNtt++/9
 SNywV9HHtoH3sdcn6wJ7RYEVoNr/+SmOHehcbeQ6pSr5QcRa7zalO8uwqcPkpHn7Ad
 d2RHQWI1cI13mRHVcNIPQixZg5ld4JIV+gnuJiCw=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 889218B78A;
 Tue, 11 Feb 2020 07:39:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 57E1gQSttYNM; Tue, 11 Feb 2020 07:39:10 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DC2308B776;
 Tue, 11 Feb 2020 07:39:09 +0100 (CET)
Subject: Re: [PATCH v2 09/13] powerpc/xmon: Dump prefixed instructions
To: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20200211053355.21574-1-jniethe5@gmail.com>
 <20200211053355.21574-10-jniethe5@gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <52a33d2b-0dd7-1e29-564d-3ec982b36ef9@c-s.fr>
Date: Tue, 11 Feb 2020 07:39:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211053355.21574-10-jniethe5@gmail.com>
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
Cc: bala24@linux.ibm.com, alistair@popple.id.au, mpe@ellerman.id.a,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 11/02/2020 à 06:33, Jordan Niethe a écrit :
> Currently when xmon is dumping instructions it reads a word at a time
> and then prints that instruction (either as a hex number or by
> disassembling it). For prefixed instructions it would be nice to show
> its prefix and suffix as together. Use read_instr() so that if a prefix
> is encountered its suffix is loaded too. Then print these in the form:
>      prefix:suffix
> Xmon uses the disassembly routines from GNU binutils. These currently do
> not support prefixed instructions so we will not disassemble the
> prefixed instructions yet.
> 
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
> v2: Rename sufx to suffix
> ---
>   arch/powerpc/xmon/xmon.c | 50 +++++++++++++++++++++++++++++++---------
>   1 file changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 0b085642bbe7..513901ee18b0 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -2903,6 +2903,21 @@ prdump(unsigned long adrs, long ndump)
>   	}
>   }
>   
> +static bool instrs_are_equal(unsigned long insta, unsigned long suffixa,
> +			     unsigned long instb, unsigned long suffixb)
> +{
> +	if (insta != instb)
> +		return false;
> +
> +	if (!IS_PREFIX(insta) && !IS_PREFIX(instb))
> +		return true;
> +
> +	if (IS_PREFIX(insta) && IS_PREFIX(instb))
> +		return suffixa == suffixb;
> +
> +	return false;
> +}
> +
>   typedef int (*instruction_dump_func)(unsigned long inst, unsigned long addr);
>   
>   static int
> @@ -2911,12 +2926,11 @@ generic_inst_dump(unsigned long adr, long count, int praddr,
>   {
>   	int nr, dotted;
>   	unsigned long first_adr;
> -	unsigned int inst, last_inst = 0;
> -	unsigned char val[4];
> +	unsigned int inst, suffix, last_inst = 0, last_suffix = 0;
>   
>   	dotted = 0;
> -	for (first_adr = adr; count > 0; --count, adr += 4) {
> -		nr = mread(adr, val, 4);
> +	for (first_adr = adr; count > 0; --count, adr += nr) {
> +		nr = read_instr(adr, &inst, &suffix);
>   		if (nr == 0) {
>   			if (praddr) {
>   				const char *x = fault_chars[fault_type];
> @@ -2924,8 +2938,9 @@ generic_inst_dump(unsigned long adr, long count, int praddr,
>   			}
>   			break;
>   		}
> -		inst = GETWORD(val);
> -		if (adr > first_adr && inst == last_inst) {
> +		if (adr > first_adr && instrs_are_equal(inst, suffix,
> +							last_inst,
> +							last_suffix)) {
>   			if (!dotted) {
>   				printf(" ...\n");
>   				dotted = 1;
> @@ -2934,11 +2949,24 @@ generic_inst_dump(unsigned long adr, long count, int praddr,
>   		}
>   		dotted = 0;
>   		last_inst = inst;
> -		if (praddr)
> -			printf(REG"  %.8x", adr, inst);
> -		printf("\t");
> -		dump_func(inst, adr);
> -		printf("\n");
> +		last_suffix = suffix;
> +		if (IS_PREFIX(inst)) {
> +			if (praddr)
> +				printf(REG"  %.8x:%.8x", adr, inst, suffix);
> +			printf("\t");
> +			/*
> +			 * Just use this until binutils ppc disassembly
> +			 * prints prefixed instructions.
> +			 */
> +			printf("%.8x:%.8x", inst, suffix);
> +			printf("\n");
> +		} else {
> +			if (praddr)
> +				printf(REG"  %.8x", adr, inst);
> +			printf("\t");
> +			dump_func(inst, adr);
> +			printf("\n");
> +		}

What about:


		if (pr_addr) {
			printf(REG"  %.8x", adr, inst);
			if (IS_PREFIX(inst))
				printf(":%.8x", suffix);
		}
		printf("\t");
		if (IS_PREFIX(inst))
			printf("%.8x:%.8x", inst, suffix);
		else
			dump_func(inst, adr);
		printf("\n");

>   	}
>   	return adr - first_adr;
>   }
> 

Christophe
