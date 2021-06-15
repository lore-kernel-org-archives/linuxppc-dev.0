Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374DBC2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 01:51:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D5961378
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 01:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D5961378
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G3rrY036bz3bwp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 11:51:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Ep0XF0NF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Ep0XF0NF; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G3rnz4cgzz3cZx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 11:48:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4G3rnx5X1hz9sCD;
 Tue, 15 Jun 2021 11:48:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1623721734;
 bh=Bl3XHAS0bQtI+6g13gkACgICPslVhebB4ZXpE+X695Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Ep0XF0NFMgmx7oI70j7Ccn7QSx4ln77fHPJldlNbo/qwJmwsQXkJGdFjSSYKAzKQz
 il7/UdavTO905wqZRRqzvtTn/zNF2h1WZlaOySLEbyCt+MJUel8Z+LKySzCjueJrAg
 tubenPnGVZKbyfbvs4j1njr8UxP45mNJke8msYpHAWwa50DdHqL12mHXLiuipm5ZlK
 glRriVXjb8aY/WEqIUOPnlx9sSuI50PxJj91i5noJKkRoHNLfiVRbSCuTYA8WRU915
 1jSptRsjdKJAXcICZjx5nySyznFRceANtPrYXD2CKUmSXEBi9WWl5vGIrbqDcuJCIE
 sSrSNWMPBYPOA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Subject: Re: [PATCH v1 10/12] powerpc/lib/feature-fixups: Use PPC_RAW_xxx()
 macros
In-Reply-To: <e79cd8e111ca13bf8c61a384bac365aa7e207647.1621506159.git.christophe.leroy@csgroup.eu>
References: <5d146b31b943e7ad674894421db4feef54804b9b.1621506159.git.christophe.leroy@csgroup.eu>
 <e79cd8e111ca13bf8c61a384bac365aa7e207647.1621506159.git.christophe.leroy@csgroup.eu>
Date: Tue, 15 Jun 2021 11:48:49 +1000
Message-ID: <874kdzvqwu.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
> index fe26f2fa0f3f..f0fc521b82ae 100644
> --- a/arch/powerpc/lib/feature-fixups.c
> +++ b/arch/powerpc/lib/feature-fixups.c
> @@ -180,32 +180,31 @@ static void do_stf_exit_barrier_fixups(enum stf_barrier_type types)
>  	start = PTRRELOC(&__start___stf_exit_barrier_fixup);
>  	end = PTRRELOC(&__stop___stf_exit_barrier_fixup);
>  
> -	instrs[0] = 0x60000000; /* nop */
> -	instrs[1] = 0x60000000; /* nop */
> -	instrs[2] = 0x60000000; /* nop */
> -	instrs[3] = 0x60000000; /* nop */
> -	instrs[4] = 0x60000000; /* nop */
> -	instrs[5] = 0x60000000; /* nop */
> +	instrs[0] = PPC_RAW_NOP();
> +	instrs[1] = PPC_RAW_NOP();
> +	instrs[2] = PPC_RAW_NOP();
> +	instrs[3] = PPC_RAW_NOP();
> +	instrs[4] = PPC_RAW_NOP();
> +	instrs[5] = PPC_RAW_NOP();
>  
>  	i = 0;
>  	if (types & STF_BARRIER_FALLBACK || types & STF_BARRIER_SYNC_ORI) {
>  		if (cpu_has_feature(CPU_FTR_HVMODE)) {
> -			instrs[i++] = 0x7db14ba6; /* mtspr 0x131, r13 (HSPRG1) */
> -			instrs[i++] = 0x7db04aa6; /* mfspr r13, 0x130 (HSPRG0) */
> +			instrs[i++] = PPC_RAW_MTSPR(SPRN_HSPRG1, _R13);
> +			instrs[i++] = PPC_RAW_MFSPR(_R13, SPRN_HSPRG0);
>  		} else {
> -			instrs[i++] = 0x7db243a6; /* mtsprg 2,r13	*/
> -			instrs[i++] = 0x7db142a6; /* mfsprg r13,1    */
> +			instrs[i++] = PPC_RAW_MTSPR(SPRN_SPRG2, _R13);
> +			instrs[i++] = PPC_RAW_MFSPR(_R13, SPRN_SPRG1);
>  	        }
> -		instrs[i++] = 0x7c0004ac; /* hwsync		*/
> -		instrs[i++] = 0xe9ad0000; /* ld r13,0(r13)	*/
...
> +		instrs[i++] = PPC_RAW_LD(_R10, _R13, 0);

This conversion was wrong, r13 became r10.

I fixed it up.

cheers
