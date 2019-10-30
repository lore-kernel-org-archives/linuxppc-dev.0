Return-Path: <SRS0=1fX1=YX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6C1CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 10:59:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C490620717
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 10:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="X/66W8k7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C490620717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47357f26GLzF46M
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 21:59:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="X/66W8k7"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47353T5LCRzF44L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2019 21:56:05 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 47353P44N8z9vC12;
 Wed, 30 Oct 2019 11:56:01 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=X/66W8k7; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 8ksOLoirlNZc; Wed, 30 Oct 2019 11:56:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 47353P2wNYz9vC0y;
 Wed, 30 Oct 2019 11:56:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1572432961; bh=NOsDc85kaLL3wmTkoC+345ALS2CMn66OoExIe3uJdWQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=X/66W8k7NYYmbQqEwciiXTc9kN6YBJT5WfxXA3jwGiVxzZITAZzVw3JrOwx/ZvSab
 Il0cjEFCH7JmM6k3AOs3hgFYQ1sibicqs2iz61u9SaECKgzqbeFgWCoEe3AZkpunN3
 8Fg21Pg53mFiBwyqVhuQg+JvQoCLD08AMrP/ciRA=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A8218B875;
 Wed, 30 Oct 2019 11:56:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id KnDVmLJswb7k; Wed, 30 Oct 2019 11:56:02 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F85C8B7C7;
 Wed, 30 Oct 2019 11:56:00 +0100 (CET)
Subject: Re: [PATCH v2 20/23] serial: make SERIAL_QE depend on PPC32
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-21-linux@rasmusvillemoes.dk>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <869673da-da66-8cc6-68bc-2bbdfd44b1e6@c-s.fr>
Date: Wed, 30 Oct 2019 11:56:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025124058.22580-21-linux@rasmusvillemoes.dk>
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
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>,
 linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/10/2019 à 14:40, Rasmus Villemoes a écrit :
> Currently SERIAL_QE depends on QUICC_ENGINE, which in turn depends on
> PPC32, so this doesn't add any extra dependency. However, the QUICC
> Engine IP block also exists on some arm boards, so this serves as
> preparation for removing the PPC32 dependency from QUICC_ENGINE and
> build the QE support in drivers/soc/fsl/qe, while preventing
> allmodconfig/randconfig failures due to SERIAL_QE not being supported
> yet.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>   drivers/tty/serial/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 67a9eb3f94ce..78246f535809 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1056,6 +1056,7 @@ config SERIAL_LANTIQ
>   config SERIAL_QE
>   	tristate "Freescale QUICC Engine serial port support"
>   	depends on QUICC_ENGINE
> +	depends on PPC32

Same, would be more obvious as
	depends on QUICC_ENGINE && PPC32

Christophe

>   	select SERIAL_CORE
>   	select FW_LOADER
>   	help
> 
