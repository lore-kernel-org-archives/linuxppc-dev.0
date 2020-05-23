Return-Path: <SRS0=nO0J=7F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD74C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2020 11:17:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FBF206DD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2020 11:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="F5eKxJj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FBF206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49TgnZ3sYzzDr0y
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2020 21:17:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Tgld6ntszDqjl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2020 21:16:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=F5eKxJj+; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49TglX39TCz9sRK;
 Sat, 23 May 2020 21:16:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1590232573;
 bh=XdJ4GsUtyCeZgpbb9v8CA5sMkmlRwqHwNrM4xAXS61k=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=F5eKxJj+Hlk8PWkkgX8L7qfqOyREq18UpzzW44RqnKPs0k1u3h76rDnoVchsW4VM+
 MxQ+0faOCx2NxDdKdOSyGLXnN1BXavZQ4kLw+q+SzvtRFC8KDpJscsm/MZ8RXvZMli
 Uik9xq6s4cn6WDZB8RPYvlPHJT9+AX4PoHzD6RdUnV2nqz75vbevwWu8uL+pnDNM+6
 HusW3zRwShhbSgnylftW/6wvDZ1VPVzMrZC88gNUrOk09sKOUTn0KYLirLPXVJPpxe
 muBDDnC/UwyxIqgqk0NEPRmFf7T7Cj4eCZitvEX+FQehuYA+CSviqkgXAzKN7rrxc8
 ZS3RyK3piRHSw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>,
 Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v4 1/6] printk: Collapse shutdown types into a single dump
 reason
In-Reply-To: <20200515184434.8470-2-keescook@chromium.org>
References: <20200515184434.8470-1-keescook@chromium.org>
 <20200515184434.8470-2-keescook@chromium.org>
Date: Sat, 23 May 2020 21:16:30 +1000
Message-ID: <87pnaugaup.fsf@mpe.ellerman.id.au>
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
Cc: Petr Mladek <pmladek@suse.com>, Tony Luck <tony.luck@intel.com>,
 Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Anton Vorontsov <anton@enomsg.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Colin Cross <ccross@android.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 linuxppc-dev@lists.ozlabs.org, Benson Leung <bleung@chromium.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kees Cook <keescook@chromium.org> writes:
> To turn the KMSG_DUMP_* reasons into a more ordered list, collapse
> the redundant KMSG_DUMP_(RESTART|HALT|POWEROFF) reasons into
> KMSG_DUMP_SHUTDOWN. The current users already don't meaningfully
> distinguish between them, so there's no need to, as discussed here:
> https://lore.kernel.org/lkml/CA+CK2bAPv5u1ih5y9t5FUnTyximtFCtDYXJCpuyjOyHNOkRdqw@mail.gmail.com/
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/powerpc/kernel/nvram_64.c | 4 +---
>  fs/pstore/platform.c           | 8 ++------
>  include/linux/kmsg_dump.h      | 4 +---
>  kernel/reboot.c                | 6 +++---
>  4 files changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index fb4f61096613..0cd1c88bfc8b 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -655,9 +655,7 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
>  	int rc = -1;
>  
>  	switch (reason) {
> -	case KMSG_DUMP_RESTART:
> -	case KMSG_DUMP_HALT:
> -	case KMSG_DUMP_POWEROFF:
> +	case KMSG_DUMP_SHUTDOWN:
>  		/* These are almost always orderly shutdowns. */
>  		return;
>  	case KMSG_DUMP_OOPS:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
