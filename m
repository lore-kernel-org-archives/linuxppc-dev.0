Return-Path: <SRS0=UfTk=46=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD70BC10DCE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2020 11:59:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141BF206FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2020 11:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="OEHtrMr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141BF206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48f44Y756kzDqPR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2020 22:59:41 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48f4241qpwzDqPR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2020 22:57:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=OEHtrMr2; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48f4231Ywkz9sNg;
 Fri, 13 Mar 2020 22:57:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1584100651;
 bh=CEjgtFwuHMrQoR4b9z3huM7fu5Z4F6jMMTqNACc1cIo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=OEHtrMr2+f9ZGSvpiD7gwHwbhJih9NT/xK/hOxj7YnfqVllRzYHtWkM96gIMkSNIU
 xit1UP6Z2M2G41hOxIdpaii+xLHPl/Io4xJkBh77s+IMT2PhwuJ25zUKbBpaPldLhx
 +i9PESwYL8b7qGTymdtDTh5N6GFGNWtsozIeK46XYdr8xJyizWmNS+L3yDPqMLovlm
 /J3tEEj7vc7YxxtOwntrZxsVAtaXmp6hTopy+IK3xzrjNU0u8kEsxOGPY2KubL1Re9
 NPPMSKy/VUGDzk0GfttSMclKZ7ldA5sXNBnLLeO1N8GukyG0SmDZmnR/BDT+a+QTeU
 7Cqz8Mjyhjc6A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel] powerpc/prom_init: Pass the "os-term" message to
 hypervisor
In-Reply-To: <20200312074404.87293-1-aik@ozlabs.ru>
References: <20200312074404.87293-1-aik@ozlabs.ru>
Date: Fri, 13 Mar 2020 22:57:26 +1100
Message-ID: <874kusxyah.fsf@mpe.ellerman.id.au>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Ram Pai <linuxram@us.ibm.com>,
 kvm-ppc@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> The "os-term" RTAS calls has one argument with a message address of
> OS termination cause. rtas_os_term() already passes it but the recently
> added prom_init's version of that missed it; it also does not fill args
> correctly.
>
> This passes the message address and initializes the number of arguments.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

I added:

Fixes: 6a9c930bd775 ("powerpc/prom_init: Add the ESM call to prom_init")

cheers


> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 577345382b23..673f13b87db1 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1773,6 +1773,9 @@ static void __init prom_rtas_os_term(char *str)
>  	if (token == 0)
>  		prom_panic("Could not get token for ibm,os-term\n");
>  	os_term_args.token = cpu_to_be32(token);
> +	os_term_args.nargs = cpu_to_be32(1);
> +	os_term_args.nret = cpu_to_be32(1);
> +	os_term_args.args[0] = cpu_to_be32(__pa(str));
>  	prom_rtas_hcall((uint64_t)&os_term_args);
>  }
>  #endif /* CONFIG_PPC_SVM */
> -- 
> 2.17.1
