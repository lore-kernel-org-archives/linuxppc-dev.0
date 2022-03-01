Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC9BC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Mar 2022 12:56:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K7HLQ02ZZz3bxM
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Mar 2022 23:56:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=dlVJsWZX;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K7HKk2ZMdz2xss
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2022 23:55:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=dlVJsWZX; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7HKk1xG8z4xPt;
 Tue,  1 Mar 2022 23:55:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1646139338;
 bh=3gAUw2bljeQgo+EIP3uDFWmam1knQZu7pffpGmaV4fk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=dlVJsWZXk+G/5EIS6pOP76i9u12kyE3/AwRjYtkWQDUaSChKkxstgICysnR1WNgZi
 7CrNqGb+0B5EdXQSh+3R7DzUA3c9CiOXS0Ozj5tDNG2V/e/ikkI83Ngdq/ndgw/TZQ
 7yBJwtiN3X6oP638JzaoGKtuLi/MwoiZYogkr+9sLMKkiEL5waISY3OIbY6WdEX7QL
 YTgis/hp3vihz82rnv2XaKrdagoQDFgQbv3vmvkv33Ard89MNdONaFr9K/IeUu8cTf
 nrC6NDS5xQ1EPCapfFcHV6tZ0Zp/dsam/3TJ0jzg0BeBvZkoHuZ5gvEWWl0Wu83saW
 04qgfukwQbWQQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hangyu Hua <hbh25y@gmail.com>, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] powerpc: kernel: fix a refcount leak in format_show()
In-Reply-To: <20220228091103.39749-1-hbh25y@gmail.com>
References: <20220228091103.39749-1-hbh25y@gmail.com>
Date: Tue, 01 Mar 2022 23:55:35 +1100
Message-ID: <87o82pomrc.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Hangyu Hua <hbh25y@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hangyu Hua <hbh25y@gmail.com> writes:
> node needs to be dropped when of_property_read_string fails. So an earlier call
> to of_node_put is required here.

That's true but ...

> diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
> index a0a78aba2083..cd0fa7028d86 100644
> --- a/arch/powerpc/kernel/secvar-sysfs.c
> +++ b/arch/powerpc/kernel/secvar-sysfs.c
> @@ -30,13 +30,12 @@ static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
>  		return -ENODEV;

There's also a reference leak there ^

So if you're going to touch this code I'd like you to fix both reference
leaks in a single patch please.

Having the error cases set rc and then goto "out" which does the
of_node_put() is the obvious solution I think.

cheers

>  	rc = of_property_read_string(node, "format", &format);
> +	of_node_put(node);
>  	if (rc)
>  		return rc;
>  
>  	rc = sprintf(buf, "%s\n", format);
>  
> -	of_node_put(node);
> -
>  	return rc;
>  }
>  
> -- 
> 2.25.1
