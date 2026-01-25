Return-Path: <linuxppc-dev+bounces-16286-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDFFE63CAF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Jan 2026 16:55:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dzd8W1WDKz2yFm;
	Mon, 26 Jan 2026 03:55:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769360139;
	cv=none; b=aG2GA87e0w0xH58FwjQ11j+pOBAEN35fvxKV/XeKqvyS5wK8rJnhbMGUElDVDwG8SwjFa22ZtYcOjBLUznlqgCNeGcoR5RGrxO7qHDN5C0i1BWe4XGjVjZz4aqqLMk5n97P7b887Ef2dem/7g2E6Rxb/8gZ8jbmEpAyjcNZ3lu86x5EFc3bjrckzNqaNO6WSvMc8gkrFjOr/5PdoVN41VlzIWDLmh7gXSLLhZ1hNph0wJUAJ879+Kk3vwuLAXJ/SMYwAmY4jGTz0arKLDsWKekkGRG0a0T8CGxzE/6+ge66bRG498tbLJm2THVTJJwpWRpJaHeJuL61E54Plhqg8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769360139; c=relaxed/relaxed;
	bh=U21Fd29dqbokW+KS70MIPRJzDnRnrmC2syVx+T80PJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYB0Xb84SM2ZcyIIYyUvBE9K0D/8KB+m8LffFZJ3PXeYNdeba69NKJKXrP72mf+fliDaPfvz8cacU8QclsOQBR+mSatEMoSiQQIHPff14/TRrnH99GHROGcOeELw0jwx9XF3AecxF9fNcBsSw43QpNW+L7BKQwND+bWY7IARVy2uVgUWK8kerwAHQ9KXv5YdHi1VX9TVpprdpK4ek0LBRYKDW16A+w94D374gnYPUZ58uYM/HOGBUTMS7a2YTPmpfdjdY7jXqq6oLIiVka5jBr82Hi3m/DezQDrObEeIR9PlzI0kmbgMxtSI4HzBLNJyjRkknwxIsnjyS5AmYg9E2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eEZOa2Vs; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eEZOa2Vs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dzd8V2t4Yz2xqD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jan 2026 03:55:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6B740600C3;
	Sun, 25 Jan 2026 16:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494EAC4CEF1;
	Sun, 25 Jan 2026 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769360129;
	bh=e601XR9Ll0fGNQhfmDvffrnFWUouTHvrVak62rZBKlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEZOa2Vs4uilLdPA6iMJI6//97wEsCTcLBqoH0VwIzyH0OTUwt7pHxO35O2Mm9fGJ
	 u55F1AFt6NWDHM74bZUHkinvFdCWZDHdQz3fIQGSw/ppp40qvHE+YJtK6glzlKn8NK
	 Ue0fp8CbEHnOmN6+wEGSgvfTrEvPvlkwejHPVsWIW457nFF3X6hcl4PmJsnvpvE0Pd
	 RVrFc1qteJrfP5hjRkwhOORnB/bdgVtPvsRfGtk/hvz6ROatMwMj2kwU2keRZeAgNs
	 NmvE2uwPb7WgE6lhi4CJBxKcBWhTZCkw7zwSDUtnfilwBDiI3LgOHfZxCbaxq3vKkG
	 5ydaUTXb1j1PQ==
Date: Sun, 25 Jan 2026 18:55:25 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	nayna@linux.ibm.com, stefanb@linux.ibm.com, rnsastry@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] keys/trusted_keys: fix handle passed to
 tpm_buf_append_name during unseal
Message-ID: <aXZK_aamKlxqNJ3H@kernel.org>
References: <20260123165504.461607-1-ssrish@linux.ibm.com>
 <20260123165504.461607-2-ssrish@linux.ibm.com>
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
In-Reply-To: <20260123165504.461607-2-ssrish@linux.ibm.com>

On Fri, Jan 23, 2026 at 10:25:03PM +0530, Srish Srinivasan wrote:
> TPM2_Unseal[1] expects the handle of a loaded data object, and not the
> handle of the parent key. But the tpm2_unseal_cmd provides the parent
> keyhandle instead of blob_handle for the session HMAC calculation. This
> causes unseal to fail.
> 
> Fix this by passing blob_handle to tpm_buf_append_name().
> 
> Fixes: 6e9722e9a7bf ("tpm2-sessions: Fix out of range indexing in name_size")
> 
> References:
> [1] trustedcomputinggroup.org/wp-content/uploads/
>     Trusted-Platform-Module-2.0-Library-Part-3-Version-184_pub.pdf
> 
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index a7ea4a1c3bed..6340823f8b53 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -465,7 +465,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  }
>  
>  /**
> - * tpm2_unseal_cmd() - execute a TPM2_Unload command
> + * tpm2_unseal_cmd() - execute a TPM2_Unseal command
>   *
>   * @chip: TPM chip to use
>   * @payload: the key data in clear and encrypted form
> @@ -498,7 +498,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  		return rc;
>  	}
>  
> -	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
> +	rc = tpm_buf_append_name(chip, &buf, blob_handle, NULL);
>  	if (rc)
>  		goto out;
>  
> -- 
> 2.43.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

And applied. I also need to check what is wrong with my QA because
it should have catched this.

BR, Jarkko

