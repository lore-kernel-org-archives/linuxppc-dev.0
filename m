Return-Path: <SRS0=XJaO=A2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2522FC433EB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 10:19:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77982081A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 10:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77982081A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B6Czy0QM8zDqgs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 20:19:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nefkom.net (client-ip=2001:a60:0:28:0:1:25:1;
 helo=mail-out.m-online.net; envelope-from=whitebox@nefkom.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
X-Greylist: delayed 579 seconds by postgrey-1.36 at bilbo;
 Wed, 15 Jul 2020 20:18:05 AEST
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6Cy54KsGzDqby
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 20:18:04 +1000 (AEST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4B6CkV4FBpz1rtyc;
 Wed, 15 Jul 2020 12:08:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 4B6CkV314jz1qrDX;
 Wed, 15 Jul 2020 12:08:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id FGDnadHvMCHE; Wed, 15 Jul 2020 12:08:01 +0200 (CEST)
X-Auth-Info: SROASM7rfZT/tTfsxwe1kv5TsJm31oTs8VM99Ep5Tztmu2l+TlRAmnN9rOw31QxB
Received: from igel.home (ppp-46-244-186-2.dynamic.mnet-online.de
 [46.244.186.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Wed, 15 Jul 2020 12:08:01 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
 id 053902C226F; Wed, 15 Jul 2020 12:08:00 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
References: <20200715094829.252208-1-npiggin@gmail.com>
X-Yow: I Know A Joke
Date: Wed, 15 Jul 2020 12:08:00 +0200
In-Reply-To: <20200715094829.252208-1-npiggin@gmail.com> (Nicholas Piggin's
 message of "Wed, 15 Jul 2020 19:48:29 +1000")
Message-ID: <87zh816qgv.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
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
Cc: linux-arch@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Jul 15 2020, Nicholas Piggin wrote:

> diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
> index 54a98ef7d7fe..071d7ccb830f 100644
> --- a/arch/powerpc/include/asm/exception-64e.h
> +++ b/arch/powerpc/include/asm/exception-64e.h
> @@ -204,7 +204,11 @@ exc_##label##_book3e:
>  	LOAD_REG_ADDR(r3,interrupt_base_book3e);\
>  	ori	r3,r3,vector_offset@l;		\
>  	mtspr	SPRN_IVOR##vector_number,r3;
> -
> +/*
> + * powerpc relies on return from interrupt/syscall being context synchronising
> + * (which rfi is) to support ARCH_HAS_MEMBARRIER_SYNC_CORE without additional
> + * additional synchronisation instructions.

s/additonal//

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
