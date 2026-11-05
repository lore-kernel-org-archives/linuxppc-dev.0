Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9F606A32F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WylgLfYX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL84Z3dMbz2xSV;
	Fri, 06 Nov 2026 04:12:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793898734;
	cv=none; b=hhgnru/6WzNcLo0ddxpLdsX7R7kRz5zOXNztabkIk0trnXNnM4wxZCpczsBT0gD3SkUx+7FLvqdRKxah0PL9XKdf/UQxlD/viY22OYxwpLcQRKSH7Aio5ShFZ+SHKV48qdsD5PtNxlvBszISe0FrPwSBl/uiwTJbliDFHapcJL20Hee0s+OyZldM/GCBt8vUvD2arEc8xSYMBu//2u80ik+aNCLD3jil69Qrsi01hRCENvfbZTTZesCP1h10WuVv4o5LTmVgjmfI2W+4HL7JusU7tDce0lNXjrIhZqKgejfIv09qZ58Cjl1E57AbaJKaiTnnDcnVIR6O0zQcHq3kFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793898734; c=relaxed/relaxed;
	bh=ZqAa1Oh2nxpnn+KjGTMbK5AgLwQRuXTCVB+NqwSKOY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REn3lTsnFavRGy1Hy483kg417K55QQucMQi/NJ8ywK6DviKhJUSYERu9PIkDQzzRkfQZJtVCpPI7DGmR8YhYna2T1YmB/AtmHD5Y/GhCwSidE8j9p+M7eaLZc+zn5grzZ7gZ/HubqajcyOR7ZFl4N4orRSuqoRwY7VNi6OQrL9HNAr+idD4Nuqa8B9fo7fGWNBu+6kPuchbLoWdhubiRJKZJCeG/fX0aRxHfKwsGYTuhM2FhAfgfFsII/+f7WshwmFBs0TzZQWRQC7DV483W7jaVKcPPCBxU1/8Pkp+vZSVQVDAPn5eM/eyQrNaYDvDlx7D312PxzX220EtzK0Bprg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WylgLfYX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WylgLfYX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jL84Y6GF4z2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 04:12:13 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 0464B407D5;
	Thu,  5 Nov 2026 17:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5C57B1F000C1;
	Thu,  5 Nov 2026 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898730;
	bh=ZqAa1Oh2nxpnn+KjGTMbK5AgLwQRuXTCVB+NqwSKOY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WylgLfYXMNgfJaoCNMKKBhh9tTUVD1IuXWiKkv50IDBAEvwtmZEzuuQh2CDX4Xe//
	 LapefWfcpr2gbP7YNzvTHHQijR1O959ivXYAgVFQ8y0dtQyZ3t9XvQU/PH3O37OAXR
	 qUddCpszSLEM5xvz9I96H45q4rl0OS95mslp5AY+qONaG95d/lB27I+aQRBTZzlZXf
	 jff7iOblQq38qXSIYUxfnv6ydArA8rODzGVlq9cBX0kyidlqgYrYRejThj2iDRCd+e
	 n5R+8GRpmODQjcZNv9Drmz/snqG4rcDXH2iMTs08mzTzgdOtBxMclWCNsFi6UkcC2h
	 8/gAshC4d0rLg==
Date: Thu, 5 Nov 2026 19:12:07 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	nayna@linux.ibm.com, rnsastry@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v6 2/9] keys/trusted_keys: fix PKWM output buffer cleanup
Message-ID: <auy450SsVheY_yCz@kernel.org>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-3-ssrish@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105144320.357260-3-ssrish@linux.ibm.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 08:13:13PM +0530, Srish Srinivasan wrote:
> The PKWM seal and unseal paths unconditionally free their output buffers,
> but the PLPKS helpers can return without initializing those pointers.
> 
> Initialize the output buffer pointers to NULL to make cleanup safe on early
> failure paths.
> 
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> ---
>  security/keys/trusted-keys/trusted_pkwm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
> index 422f752598e1..97ffec0ce1b7 100644
> --- a/security/keys/trusted-keys/trusted_pkwm.c
> +++ b/security/keys/trusted-keys/trusted_pkwm.c
> @@ -82,7 +82,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
>  {
>  	struct trusted_key_options *options = NULL;
>  	struct trusted_pkwm_options *pkwm = NULL;
> -	u8 *input_buf, *output_buf;
> +	u8 *input_buf, *output_buf = NULL;
>  	u32 output_len, input_len;
>  	int rc;
>  
> @@ -129,7 +129,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
>  
>  static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
>  {
> -	u8 *input_buf, *output_buf;
> +	u8 *input_buf, *output_buf = NULL;
>  	u32 input_len, output_len;
>  	int rc;
>  
> -- 
> 2.52.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko


