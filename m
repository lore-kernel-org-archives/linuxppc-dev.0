Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DE5C10F0B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 07:09:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CB0217D7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 07:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CB0217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44l9G474qQzDq96
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 17:09:32 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44l8xv2WJPzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 16:55:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44l8xt6jzLz9s4V;
 Thu, 18 Apr 2019 16:55:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, ruscur@russell.cc
Subject: Re: [PATCH v2 10/10] powerpc/32s: Implement Kernel Userspace Access
 Protection
In-Reply-To: <a2847248a92cb1641b1740fa121c5a30593ae662.1552292207.git.christophe.leroy@c-s.fr>
References: <cover.1552292207.git.christophe.leroy@c-s.fr>
 <a2847248a92cb1641b1740fa121c5a30593ae662.1552292207.git.christophe.leroy@c-s.fr>
Date: Thu, 18 Apr 2019 16:55:30 +1000
Message-ID: <87ftqfu7j1.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
> index 5f97c742ca71..b3560b2de435 100644
> --- a/arch/powerpc/include/asm/book3s/32/kup.h
> +++ b/arch/powerpc/include/asm/book3s/32/kup.h
> @@ -37,6 +37,113 @@
...
> +
> +static inline void allow_user_access(void __user *to, const void __user *from, u32 size)
> +{
> +	u32 addr = (__force u32)to;
> +	u32 end = min(addr + size, TASK_SIZE);
> +
> +	if (!addr || addr >= TASK_SIZE || !size)
> +		return;
> +
> +	current->thread.kuap = (addr & 0xf0000000) | ((((end - 1) >> 28) + 1) & 0xf);
> +	kuap_update_sr(mfsrin(addr) & ~SR_KS, addr, end);	/* Clear Ks */
> +}

When rebasing on my v6 I changed the above to:

static inline void allow_user_access(void __user *to, const void __user *from, u32 size)
{
	u32 addr, end;

	if (__builtin_constant_p(to) && to == NULL)
		return;

	addr = (__force u32)to;

	if (!addr || addr >= TASK_SIZE || !size)
		return;

	end = min(addr + size, TASK_SIZE);
	current->thread.kuap = (addr & 0xf0000000) | ((((end - 1) >> 28) + 1) & 0xf);
	kuap_update_sr(mfsrin(addr) & ~SR_KS, addr, end);	/* Clear Ks */
}

Which I think achieves the same result. It does boot :)

> +
> +static inline void prevent_user_access(void __user *to, const void __user *from, u32 size)
> +{
> +	u32 addr = (__force u32)to;
> +	u32 end = min(addr + size, TASK_SIZE);
> +
> +	if (!addr || addr >= TASK_SIZE || !size)
> +		return;
> +
> +	current->thread.kuap = 0;
> +	kuap_update_sr(mfsrin(addr) | SR_KS, addr, end);	/* set Ks */
> +}
> +
> +static inline void allow_read_from_user(const void __user *from, unsigned long size)
> +{
> +}

And I dropped that.

cheers
