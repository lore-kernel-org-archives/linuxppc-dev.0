Return-Path: <SRS0=OS5J=KH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5410FC433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 May 2021 23:44:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49C661404
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 May 2021 23:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49C661404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FgWbC2YfTz300K
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 09:44:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MBV9DlCY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=mhiramat@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MBV9DlCY; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FgWZd5xKXz2xgN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 May 2021 09:43:37 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5283D61408;
 Wed, 12 May 2021 23:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620863014;
 bh=QY+pbOK5m88B0wwDucAl3MHLjY2YDe0sMglYS33VW4w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MBV9DlCYPIwfoAopNUE5fFRU5/aj85+myoONJ9W05PNrEipcHor2Mdsb1wzVSIhgr
 sqe8pxoXYZdgzY0Mwif4fgMncxgVfIE7h/YzHYtqsIPEzLH/7FW0yCfNEUNn7l6OHQ
 m/Vi/GAyHCKUc8s8R3fY2inGj1KDeklr4mpItsXw4SHXBaJ3OCfX75WeEXldqqbBDw
 IJ2wxg2s6VG/GHthLbhFMQ4g4e0XcnUePyJ68gnrgEwHVmWHcSOCBgRepLAXC3aaGr
 /cRdODnVM3vRot9xzSqSHkTqYB4CFzklP9BgCu4yGIdmco0vJGhQHvHFmJP2PRTlfQ
 wo6rIge0YvdQw==
Date: Thu, 13 May 2021 08:43:31 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] kprobes: Allow architectures to override optinsn
 page allocation
Message-Id: <20210513084331.58371b520af4aae914518552@kernel.org>
In-Reply-To: <472c597cc8cc8f74f037acf971f7799fb381a647.1620829724.git.christophe.leroy@csgroup.eu>
References: <472c597cc8cc8f74f037acf971f7799fb381a647.1620829724.git.christophe.leroy@csgroup.eu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com,
 clang-built-linux@googlegroups.com, Paul Mackerras <paulus@samba.org>,
 mhiramat@kernel.org, naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 12 May 2021 14:29:26 +0000 (UTC)
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Some architectures like powerpc require a non standard
> allocation of optinsn page, because module pages are
> too far from the kernel for direct branches.
> 
> Define weak alloc_optinsn_page() and free_optinsn_page(), that
> fall back on alloc_insn_page() and free_insn_page() when not
> overriden by the architecture.
> 

Looks good to me :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  kernel/kprobes.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 745f08fdd7a6..8c0a6fdef771 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -321,11 +321,21 @@ int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
>  }
>  
>  #ifdef CONFIG_OPTPROBES
> +void __weak *alloc_optinsn_page(void)
> +{
> +	return alloc_insn_page();
> +}
> +
> +void __weak free_optinsn_page(void *page)
> +{
> +	free_insn_page(page);
> +}
> +
>  /* For optimized_kprobe buffer */
>  struct kprobe_insn_cache kprobe_optinsn_slots = {
>  	.mutex = __MUTEX_INITIALIZER(kprobe_optinsn_slots.mutex),
> -	.alloc = alloc_insn_page,
> -	.free = free_insn_page,
> +	.alloc = alloc_optinsn_page,
> +	.free = free_optinsn_page,
>  	.sym = KPROBE_OPTINSN_PAGE_SYM,
>  	.pages = LIST_HEAD_INIT(kprobe_optinsn_slots.pages),
>  	/* .insn_size is initialized later */
> -- 
> 2.25.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
