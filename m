Return-Path: <linuxppc-dev+bounces-18598-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA48CD58CDC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 07:36:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQ3C4Dnkz2yZ6;
	Mon, 23 Mar 2026 18:36:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774251399;
	cv=none; b=fSpcbEcRR4kwbwv5i9Odv/qVoWzVrLZ5sI71W6qIRnpUhpTzDORml4/HS6JKmB0idul0QLuTAW3dtEwE38UvU2dzcSFMwmMioDhNw9Kq0OrZN6NHn+vNO9FXWb/+tm9LZzGhjljKh7u7ney5MVEcfdNwEu7s4f9hkWpWWdlrit/IEl56Qc9LVhrL4zgZidEUD5rsECLe0A1gOHzT0fv4cVSkUsrvNBS0nhaQhStaEv6IIENoerLXRmY0dYPqh/0hoCgG5Oi8w9+wtkOHgNsaO0S2zx7MVhm1078DiK6VHkMSv+QM2z8IbE6QMDAdHYXTYkTNtuc5ZVGuAjbeH//JrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774251399; c=relaxed/relaxed;
	bh=BHzpl73uElREf9m/Ju9YTwY9qvwqq6KpcjOfJ01f7P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6K8RD+ARaC6i3SIdMoSwLwW0JSqdsyOiFk+h3C+Q9i7Pf70zWDFYFr5D60NbHBc4GCo9krIq4qz2NvxdJcGRrXw9dnnCi/TxwvicDkycnFHpgfVmXj8OnYhXQ81pwvx9x/y98eCK0DUP1FpIGxo62inqRoKt/6UySOf/q+PZPoBz/aE3Uq7WuCmz5OeBQ+qJINRn53pQfvOhUQlcNlVGvAYTLNl5zvfvEayUpMo7w0f24TZCBh20Z1Fkl0XbIeqCn648NzZAmWWCt2tstaP1qOo0gMgdGVIg24Dof4/bV3BatBYFXSjYN4P+48SegmcgaUZ1zJUWeqjwRezwnN8Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UTJq59o9; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=UTJq59o9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQ3B4MCQz2yYy
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 18:36:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C76934184B;
	Mon, 23 Mar 2026 07:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B8DC2BCB0;
	Mon, 23 Mar 2026 07:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774251395;
	bh=7VOKv6z3oEU5a+l36BGZyEJAjG0QWyDh946cJOuuQi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTJq59o9fveiEr6Uv0yM/nTrbUVTiD8929ACrYlzPtuYCENBduvek9Kj9jLd1r/nD
	 HFzlDX4Sli+o+fbRAhXnohAuRKda8ia545XFm4bn10RmzR7KeqB6StQjhfX2HUPknF
	 dILUah3wOYM7tpQiDm7A8xJbInLeNWCzoFqX3OTc=
Date: Mon, 23 Mar 2026 08:36:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	nathan@kernel.org, nsc@kernel.org, ojeda@kernel.org,
	masahiroy@kernel.org, linux@weissschuh.net, tamird@kernel.org,
	rostedt@goodmis.org, ihor.solodrai@linux.dev, ritesh.list@gmail.com,
	maddy@linux.ibm.com, peterz@infradead.org
Subject: Re: [PATCH] char: nvram: Remove unused nvram_mutex to fix
 -Wunused-variable warning
Message-ID: <2026032350-stardust-unselfish-ad61@gregkh>
References: <20260323072422.25730-1-venkat88@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323072422.25730-1-venkat88@linux.ibm.com>

On Mon, Mar 23, 2026 at 12:54:22PM +0530, Venkat Rao Bagalkote wrote:
> drivers/char/nvram.c defines a static mutex 'nvram_mutex' which is never
> used. This results in a compiler warning on linux-next builds:
> 
>   warning: 'nvram_mutex' defined but not used [-Wunused-variable]
> 
> Remove the unused definition to avoid the warning.
> 
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
>  drivers/char/nvram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
> index 9eff426a9286..2ce3307663ed 100644
> --- a/drivers/char/nvram.c
> +++ b/drivers/char/nvram.c
> @@ -53,7 +53,7 @@
>  #include <asm/nvram.h>
>  #endif
>  
> -static DEFINE_MUTEX(nvram_mutex);
> +static __maybe_unused DEFINE_MUTEX(nvram_mutex);

If it is never used, why not actually delete it?  This just papers over
the real issue :(

thanks,

greg k-h

