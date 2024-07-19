Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1448C3DA49
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2024 01:26:30 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=AlbyxxwW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WQBpY4H29z3dTJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2024 11:26:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=AlbyxxwW;
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WQBnp16GHz3cZ6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2024 11:25:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721352350;
	bh=2GYiCu+lLOgWZgNTWvMezkWlfvj1uXjtSXatUQwpMbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AlbyxxwWJYV1b5fmCOBwJ5m6/L+oPgLmD06ClBZG8xDSPfjD7+9k31UoEfysJTayy
	 mVoL8e8M4jOsm7hHTOoj7JCaNLa8vpgnSxfNXb2bpJoqRp/Af9JYmldIk3qT9Strwz
	 081ltjvXKlzIDOVlrsJIpI/RbZuuCsnzqWGV+Nm5O2FjWvsGrwjhCoFYvgTNBmkXTA
	 ZD+OJ5g30B0yNGJU3CbI1N8YYBVfNonTgcxuM4J32WRzfaEnDhlJsNTIrnJPGUjJK8
	 f9EaWerVxiJ60vyqG1wt8+sWM7NDfSKuyMXsn5SUAGPtqhCr2+tTqEQflBX8/x/9EN
	 jWKyH7xW60udA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WQBnn6ZBTz4w2K;
	Fri, 19 Jul 2024 11:25:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ma Ke <make24@iscas.ac.cn>, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
 arnd@arndb.de, gregkh@linuxfoundation.org, manoj@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, clombard@linux.vnet.ibm.com
Subject: Re: [PATCH v4] cxl: Fix possible null pointer dereference in
 read_handle()
In-Reply-To: <20240715025442.3229209-1-make24@iscas.ac.cn>
References: <20240715025442.3229209-1-make24@iscas.ac.cn>
Date: Fri, 19 Jul 2024 11:25:49 +1000
Message-ID: <87jzhiw4te.fsf@mail.lhotse>
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
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ma Ke <make24@iscas.ac.cn>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ma Ke <make24@iscas.ac.cn> writes:
> In read_handle(), of_get_address() may return NULL if getting address and
> size of the node failed. When of_read_number() uses prop to handle
> conversions between different byte orders, it could lead to a null pointer
> dereference. Add NULL check to fix potential issue.
>
> Found by static analysis.
>
> Cc: stable@vger.kernel.org
> Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
 
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

In practice I don't this bug is triggerable, because the device tree
that's being parsed comes from a single source (IBM hypervisor), and if
this property was malformed that would simply be considered a bug in the
hypervisor.

cheers

> Changes in v4:
> - modified vulnerability description according to suggestions, making the 
> process of static analysis of vulnerabilities clearer. No active research 
> on developer behavior.
> Changes in v3:
> - fixed up the changelog text as suggestions.
> Changes in v2:
> - added an explanation of how the potential vulnerability was discovered,
> but not meet the description specification requirements.
> ---
>  drivers/misc/cxl/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
> index bcc005dff1c0..d8dbb3723951 100644
> --- a/drivers/misc/cxl/of.c
> +++ b/drivers/misc/cxl/of.c
> @@ -58,7 +58,7 @@ static int read_handle(struct device_node *np, u64 *handle)
>  
>  	/* Get address and size of the node */
>  	prop = of_get_address(np, 0, &size, NULL);
> -	if (size)
> +	if (!prop || size)
>  		return -EINVAL;
>  
>  	/* Helper to read a big number; size is in cells (not bytes) */
> -- 
> 2.25.1
