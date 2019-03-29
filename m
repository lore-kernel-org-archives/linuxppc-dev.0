Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011BEC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 07:42:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3722173C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 07:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="J7Ot12xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3722173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Vtxd3cHkzDqH6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 18:42:45 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vtvp316mzDqPW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 18:41:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="J7Ot12xA"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Vtvn3j5Sz8sw2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 18:41:09 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Vtvn2p3Fz9sQr; Fri, 29 Mar 2019 18:41:09 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="J7Ot12xA"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Vtvk3mWKz9sPx
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Mar 2019 18:41:05 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Vtvc4wcnz9v0nC;
 Fri, 29 Mar 2019 08:41:00 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=J7Ot12xA; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id eVEiUG8ReLfR; Fri, 29 Mar 2019 08:41:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Vtvc3qy4z9ttFv;
 Fri, 29 Mar 2019 08:41:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553845260; bh=7BWi43dI9onxqlZZtrq/HHT9DIhA8TrYZQnZglT837o=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=J7Ot12xArrWfdLrGnT0Ja6fdbem1bL+a2DoYViGd/9gG82Uc3ZVPCCSobRvoME3Lh
 hB/r3+cfqSejL2uhMcKzfna6kzscM79zxqlYYHycx1+IrWShn4Inv8InJYaF7uHWti
 Fc9nuI8aKs4AxF0CQrpYpVbP2JINnCg3tpa/N42Y=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 731378B78B;
 Fri, 29 Mar 2019 08:41:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id zWHueN-bDm4J; Fri, 29 Mar 2019 08:41:01 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B08A48B779;
 Fri, 29 Mar 2019 08:41:00 +0100 (CET)
Subject: Re: [PATCH] powerpc/xmon: add read-only mode
To: cmr <cmr@informatik.wtf>, linuxppc-dev@ozlabs.org
References: <20190329042153.25698-1-cmr@informatik.wtf>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <14aa7671-fc0b-1cbc-da19-004299b304a2@c-s.fr>
Date: Fri, 29 Mar 2019 08:41:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329042153.25698-1-cmr@informatik.wtf>
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
Cc: andonnel@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 29/03/2019 à 05:21, cmr a écrit :
> Operations which write to memory should be restricted on secure systems
> and optionally to avoid self-destructive behaviors.
> 
> Add a config option, XMON_RO, to control default xmon behavior along
> with kernel cmdline options xmon=ro and xmon=rw for explicit control.
> The default is to enable read-only mode.
> 
> The following xmon operations are affected:
> memops:
> 	disable memmove
> 	disable memset
> memex:
> 	no-op'd mwrite
> super_regs:
> 	no-op'd write_spr
> bpt_cmds:
> 	disable
> proc_call:
> 	disable
> 
> Signed-off-by: cmr <cmr@informatik.wtf>

A Fully qualified name should be used.

> ---
>   arch/powerpc/Kconfig.debug |  7 +++++++
>   arch/powerpc/xmon/xmon.c   | 24 ++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 4e00cb0a5464..33cc01adf4cb 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -117,6 +117,13 @@ config XMON_DISASSEMBLY
>   	  to say Y here, unless you're building for a memory-constrained
>   	  system.
>   
> +config XMON_RO
> +	bool "Set xmon read-only mode"
> +	depends on XMON
> +	default y

Should it really be always default y ?
I would set default 'y' only when some security options are also set.

> +	help
> +	  Disable state- and memory-altering write operations in xmon.
> +
>   config DEBUGGER
>   	bool
>   	depends on KGDB || XMON
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index a0f44f992360..c13ee73cdfd4 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -80,6 +80,7 @@ static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
>   #endif
>   static unsigned long in_xmon __read_mostly = 0;
>   static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
> +static int xmon_ro = IS_ENABLED(CONFIG_XMON_RO);

Would be better to use a 'bool' type and call it something like 
'xmon_is_ro' (ref Kernel Codying Style, §17)

>   
>   static unsigned long adrs;
>   static int size = 1;
> @@ -1042,6 +1043,8 @@ cmds(struct pt_regs *excp)
>   			set_lpp_cmd();
>   			break;
>   		case 'b':
> +			if (xmon_ro == 1)

if (xmon_is_ro)

[Same everywhere below]


Christophe

> +				break;
>   			bpt_cmds();
>   			break;
>   		case 'C':
> @@ -1055,6 +1058,8 @@ cmds(struct pt_regs *excp)
>   			bootcmds();
>   			break;
>   		case 'p':
> +			if (xmon_ro == 1)
> +				break;
>   			proccall();
>   			break;
>   		case 'P':
> @@ -1777,6 +1782,9 @@ read_spr(int n, unsigned long *vp)
>   static void
>   write_spr(int n, unsigned long val)
>   {
> +	if (xmon_ro == 1)
> +		return;
> +
>   	if (setjmp(bus_error_jmp) == 0) {
>   		catch_spr_faults = 1;
>   		sync();
> @@ -2016,6 +2024,10 @@ mwrite(unsigned long adrs, void *buf, int size)
>   	char *p, *q;
>   
>   	n = 0;
> +
> +	if (xmon_ro == 1)
> +		return n;
> +
>   	if (setjmp(bus_error_jmp) == 0) {
>   		catch_memory_errors = 1;
>   		sync();
> @@ -2884,9 +2896,13 @@ memops(int cmd)
>   	scanhex((void *)&mcount);
>   	switch( cmd ){
>   	case 'm':
> +		if (xmon_ro == 1)
> +			break;
>   		memmove((void *)mdest, (void *)msrc, mcount);
>   		break;
>   	case 's':
> +		if (xmon_ro == 1)
> +			break;
>   		memset((void *)mdest, mval, mcount);
>   		break;
>   	case 'd':
> @@ -3796,6 +3812,14 @@ static int __init early_parse_xmon(char *p)
>   	} else if (strncmp(p, "on", 2) == 0) {
>   		xmon_init(1);
>   		xmon_on = 1;
> +	} else if (strncmp(p, "rw", 2) == 0) {
> +		xmon_init(1);
> +		xmon_on = 1;
> +		xmon_ro = 0;
> +	} else if (strncmp(p, "ro", 2) == 0) {
> +		xmon_init(1);
> +		xmon_on = 1;
> +		xmon_ro = 1;
>   	} else if (strncmp(p, "off", 3) == 0)
>   		xmon_on = 0;
>   	else
> 
