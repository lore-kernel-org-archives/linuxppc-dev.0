Return-Path: <SRS0=tbgD=FI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC765C4361A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 10:58:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542E4229EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 10:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542E4229EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CnV7X3BwTzDrNk
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 21:58:48 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CnV5J3mdPzDrHg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2020 21:56:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=L74eRVt4; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CnV5G5JtCz9sWP;
 Fri,  4 Dec 2020 21:56:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1607079411;
 bh=sE981+GdvNkIMZp6vrNdrmV1a1lR1GRVRUonAPEMia8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=L74eRVt4sW7Znta5a2ABIdr+qJRbBu3DFGXznuWnC7CEm+xnK8/oJLG4NtsZPhn8Q
 J1+O35GAgkdws8ZFaSJJB1ANBCq5wT89DCiFce4YarMXKYA6znhXQZZEzTZwUcO32d
 M5THBCdbQIg6NNyB8+uOMZT4I7FmY68x+j1L4aTKxQIgi4Gkb9HuKIj4KQ9HTivUru
 NlEq1HBraTYc6PnQS+lEzvXqR5BClDM4cofr2IkFqDgZz9p0LBlBZcpkiBYErxV4UG
 HyzhYlvVdlU3tfe4labwDy4TzXTxAM9V9psVnV8hvCtODh2wf+cDL2VUHMpNza6LcH
 hJ8hl58g5wvbQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/xmon: Change printk() to pr_cont()
In-Reply-To: <c8a6ec704416ecd5ff2bd26213c9bc026bdd19de.1607077340.git.christophe.leroy@csgroup.eu>
References: <c8a6ec704416ecd5ff2bd26213c9bc026bdd19de.1607077340.git.christophe.leroy@csgroup.eu>
Date: Fri, 04 Dec 2020 21:56:49 +1100
Message-ID: <87h7p1vnym.fsf@mpe.ellerman.id.au>
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
> Since some time now, printk() adds carriage return, leading to
> unusable xmon output:
>
> [   54.288722] sysrq: Entering xmon
> [   54.292209] Vector: 0  at [cace3d2c]
> [   54.292274]     pc:
> [   54.292331] c0023650

...

> diff --git a/arch/powerpc/xmon/nonstdio.c b/arch/powerpc/xmon/nonstdio.c
> index 5c1a50912229..9b0d85bff021 100644
> --- a/arch/powerpc/xmon/nonstdio.c
> +++ b/arch/powerpc/xmon/nonstdio.c
> @@ -178,7 +178,7 @@ void xmon_printf(const char *format, ...)
>  
>  	if (n && rc == 0) {
>  		/* No udbg hooks, fallback to printk() - dangerous */
> -		printk("%s", xmon_outbuf);
> +		pr_cont("%s", xmon_outbuf);
>  	}

Ah OK, in the case where there's no udbg backend. We basically always
have a udbg backend on 64-bit, via hvc console. Which explains why we
haven't noticed it.

Will pick up the patch.

cheers
