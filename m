Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744FAC531DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Aug 2023 20:00:13 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=aqZtdSbS;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRbT74nVTz3cLQ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Aug 2023 06:00:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=geoff@infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRbS41sTbz30dt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2023 05:59:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=tBpJv333rbTQBlJ6Cfx2uRqVy4TwIqy7goRRmAqDuS8=; b=aqZtdSbSjnsdYbQl0oIVDXPgNs
	ZgzrOq+TmTJgKg3vfsq9Jq8l5ukJ1ecPRkkdGGqHGdpG+eOA4wlZP2XtItPh8fSDnzIWFos7+wEvE
	N+Z1zHtB2hiARaSwTMsED0bsH+DbclH28V2ZTvnfCYomcGVl8dB+qyG2W5sBAur0L344yL3up2SQ8
	1dgE87jQJ99gA/mGVUDfH5u0SVjEZaGouk3PedDkzkgTDXif6lZhCpwfplECwpRE1asqw/4QYsGsQ
	400WtyeKf4lsgkDn8Y0eflZlOd/sevnrD5C2UGWXeEzYm3u6ZYJc19UCQGorSELLzQVNjA43EiMyE
	khf6T3ZQ==;
Received: from 108-90-42-56.lightspeed.sntcca.sbcglobal.net ([108.90.42.56] helo=[192.168.1.80])
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qWj8v-00EKHv-0o;
	Thu, 17 Aug 2023 19:58:53 +0000
Message-ID: <4ceaf4f9-ccc1-c0a6-ee3b-a570355d2131@infradead.org>
Date: Thu, 17 Aug 2023 12:58:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] powerpc/ps3: refactor strncpy usage
To: Justin Stitt <justinstitt@google.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20230816-strncpy-arch-powerpc-platforms-ps3-repository-v1-1-88283b02fb09@google.com>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <20230816-strncpy-arch-powerpc-platforms-ps3-repository-v1-1-88283b02fb09@google.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 8/16/23 14:39, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> `make_first_field()` should use similar implementation to `make_field()`
> due to memcpy having more obvious behavior here. The end result yields
> the same behavior as the previous `strncpy`-based implementation
> including the NUL-padding.

> diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
> index 205763061a2d..1abe33fbe529 100644
> --- a/arch/powerpc/platforms/ps3/repository.c
> +++ b/arch/powerpc/platforms/ps3/repository.c
> @@ -73,9 +73,9 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,

I tested this on PS3 and it seems to be working OK.

Tested-by: Geoff Levand <geoff@infradead.org>


