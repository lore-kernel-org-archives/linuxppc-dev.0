Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592DBC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 04:19:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0272084C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 04:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="uqH5u/z3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0272084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YtBN5zW5zDq6k
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 15:19:08 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Yt6N4jYDzDqSp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 15:15:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="uqH5u/z3"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Yt6N3CKsz8thg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 15:15:40 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Yt6N24Qwz9sPF; Wed,  3 Apr 2019 15:15:40 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="uqH5u/z3"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Yt6K1y8wz9sSS
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Apr 2019 15:15:35 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Yt6B6JwYz9v0yK;
 Wed,  3 Apr 2019 06:15:30 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=uqH5u/z3; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 36Tr1UyleBHB; Wed,  3 Apr 2019 06:15:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Yt6B585xz9v0yJ;
 Wed,  3 Apr 2019 06:15:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554264930; bh=8SZUtccVTkEBgFUf3pKLzVpsJObRI/zaJINl/I3GyGY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=uqH5u/z3lPkGte1KtVx+/pimIElnsX5nGi3MoAibeVgkhpp+/ZZ8teVLlA28lpmAv
 Xxs37u4AbHLp3fYVYEZKUAcNNLpLj90N0QLNgHXQC6bkwnmtdc4B7vY3rDZaDhxk53
 7Yb3aRqtvWTb6R778vo3L3ftoPqHJzAVkUaZQ1SM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 796518B77E;
 Wed,  3 Apr 2019 06:15:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id csqiXJOPrEQM; Wed,  3 Apr 2019 06:15:31 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F4758B754;
 Wed,  3 Apr 2019 06:15:31 +0200 (CEST)
Subject: Re: [PATCH] powerpc/xmon: add read-only mode
To: Christopher M Riedl <cmr@informatik.wtf>, linuxppc-dev@ozlabs.org
References: <20190329042153.25698-1-cmr@informatik.wtf>
 <14aa7671-fc0b-1cbc-da19-004299b304a2@c-s.fr>
 <184679822.6025.1554262730223@privateemail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ee41455c-0ef8-2b5b-2f61-16bcf5f45d3f@c-s.fr>
Date: Wed, 3 Apr 2019 06:15:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <184679822.6025.1554262730223@privateemail.com>
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



Le 03/04/2019 à 05:38, Christopher M Riedl a écrit :
>> On March 29, 2019 at 3:41 AM Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>>
>>
>>
>> Le 29/03/2019 à 05:21, cmr a écrit :
>>> Operations which write to memory should be restricted on secure systems
>>> and optionally to avoid self-destructive behaviors.
>>>
>>> Add a config option, XMON_RO, to control default xmon behavior along
>>> with kernel cmdline options xmon=ro and xmon=rw for explicit control.
>>> The default is to enable read-only mode.
>>>
>>> The following xmon operations are affected:
>>> memops:
>>> 	disable memmove
>>> 	disable memset
>>> memex:
>>> 	no-op'd mwrite
>>> super_regs:
>>> 	no-op'd write_spr
>>> bpt_cmds:
>>> 	disable
>>> proc_call:
>>> 	disable
>>>
>>> Signed-off-by: cmr <cmr@informatik.wtf>
>>
>> A Fully qualified name should be used.
> 
> What do you mean by fully-qualified here? PPC_XMON_RO? (PPC_)XMON_READONLY?

I mean it should be

Signed-off-by: Christopher M Riedl <cmr@informatik.wtf>

instead of

Signed-off-by: cmr <cmr@informatik.wtf>

> 
>>
>>> ---
>>>    arch/powerpc/Kconfig.debug |  7 +++++++
>>>    arch/powerpc/xmon/xmon.c   | 24 ++++++++++++++++++++++++
>>>    2 files changed, 31 insertions(+)
>>>
>>> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
>>> index 4e00cb0a5464..33cc01adf4cb 100644
>>> --- a/arch/powerpc/Kconfig.debug
>>> +++ b/arch/powerpc/Kconfig.debug
>>> @@ -117,6 +117,13 @@ config XMON_DISASSEMBLY
>>>    	  to say Y here, unless you're building for a memory-constrained
>>>    	  system.
>>>    
>>> +config XMON_RO
>>> +	bool "Set xmon read-only mode"
>>> +	depends on XMON
>>> +	default y
>>
>> Should it really be always default y ?
>> I would set default 'y' only when some security options are also set.
>>
> 
> This is a good point, I based this on an internal Slack suggestion but giving this more thought, disabling read-only mode by default makes more sense. I'm not sure what security options could be set though?
> 

Maybe starting with CONFIG_STRICT_KERNEL_RWX

Another point that may also be addressed by your patch is the definition 
of PAGE_KERNEL_TEXT:

#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || 
defined(CONFIG_BDI_SWITCH) ||\
	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
#else
#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
#endif

The above let me think that it would be better if you add a config 
XMON_RW instead of XMON_RO, with default !STRICT_KERNEL_RWX

Christophe
