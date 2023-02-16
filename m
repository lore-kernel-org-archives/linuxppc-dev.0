Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F93CC636CC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Feb 2023 11:11:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PHXLz5Qhrz3f31
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Feb 2023 22:11:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=xhZpkWeZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org; envelope-from=erhard_f@mailbox.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=xhZpkWeZ;
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PHXKt5QXkz3cKG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2023 22:10:23 +1100 (AEDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PHXKX1zpxz9sTL;
	Thu, 16 Feb 2023 12:10:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1676545808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cp0Jdbn8qsTqbb34HVg+YijwzLsVoOWb0viZR1J/NEg=;
	b=xhZpkWeZ/fKKIJ56LZV7DW+vtFSYAO4yGTaTSnS9icbXPXfPTJWUPXdIsWTf97M5tLtWJ/
	ZfhUzUw2L9M7NPVVX2Df/CQso1N32VXAtbKCQREKtC2kcff2QEwrqry30kyTDXdwuBhnyX
	RXlfb0Z6lG5IShP1y4TcuEwlVcjBkkbqAu53meTrjub+H65r6lM4IIYR/7PQ54EMcQSu8C
	/JIE5ORo7J35uPTuAzAViXFW51mhQN7Qz2Fe7gG0qlGxGIr22I65SCBLQAy4BzcUUGBKRP
	9EgFJZeJqo2gmeAH4434kMLNzOabqegBakU2Yg4UgS2oK47YtwqEVOdaTV+EFQ==
Date: Thu, 16 Feb 2023 12:10:05 +0100
From: "Erhard F." <erhard_f@mailbox.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: 6.2-rc7 fails building on Talos II: memory.c:(.text+0x2e14):
 undefined reference to `hash__tlb_flush'
Message-ID: <20230216121005.5033ffec@yea>
In-Reply-To: <a2b50c13-6ddc-e310-559e-ee429e96c527@csgroup.eu>
References: <20230216005535.6bff7aa6@yea>
	<a2b50c13-6ddc-e310-559e-ee429e96c527@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1eab50639c59a028a84
X-MBO-RS-META: eie6moxr4du9w8diask4c8su8orzgfn5
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 16 Feb 2023 06:29:52 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Can you try with :
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h 
> b/arch/powerpc/include/asm/book3s/64/tlbflush.h
> index d5cd16270c5d..2bbc0fcce04a 100644
> --- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
> +++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
> @@ -97,8 +97,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
>   {
>   	if (radix_enabled())
>   		radix__tlb_flush(tlb);
> -
> -	return hash__tlb_flush(tlb);
> +	else
> +		hash__tlb_flush(tlb);
>   }
> 
>   #ifdef CONFIG_SMP

With the patch applied my 6.2-rc7 .config builds. Thanks Christophe!

Regards,
Erhard
