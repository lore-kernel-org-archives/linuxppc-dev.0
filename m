Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E9606A334
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRb5/iBo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL83n17fcz2xN4;
	Fri, 06 Nov 2026 04:11:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793898693;
	cv=none; b=WV2VWk1czanLMqrEfX+2k23vd2Px+WYGsZS5SR8fPApX2jobaGBgoyHppmVf0txmW2o7/Kq4eMG9kVRqErTa9gFGjNR6kQk/w1GhSBbgHR3ThEHk+vrLJLrE7sNXAB5k33BOknLmfiPP6dbes/JHENteYUtM2xczuDvAikD6RrOgTiWD89+dNZd0QfGHkd5RBNrVbVnsNMuNNPKE0Q0QZwtuoBFMlXfrf+CzfYmaCyyKYN9wDVM/1PNqAN3VLDjeyPIAuglnOfHT9lgh15EIl32FpWqq0dvcZ9hIAulGtcBJGk7WpQg3kmNeTQ7Mq9D7IdWQFrZ7+n8cmb4AAiqOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793898693; c=relaxed/relaxed;
	bh=1lAUn012SAJPv8LzmMk8AiQwRTQDqHHs/lnV55r2DN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTzemdkTtANjiWWVjZJ/EBqKpLK5/JDPV3vnDOAVcp3cYkJjkE80in0Wy6CyTMEIo47/wL9GTWU+lGhiuAKvLkZLLbRcvmNA6O5H3ODXgD67+xNSeUv2cdJp4NGSeEzyBHO28CDePgMbes2U+Gu2ICfoMdk1F2vZar2q9nBFbFJKNwufSNUV+OdLDP5r1ILWPt7rMpQml3gMaykDfU/YUEAIwYKi33KkYkXLmVRoVwt1Xm26lhQ7y3Qs8ktBA09l+/T+RA+wv22DdxR6OdLJuzdJmdxbAdKfc35j+B7lpZmMD2lK0KM2pt5z6i5FeAYVWwtrT2whUGAg6W9DGtbrow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRb5/iBo; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRb5/iBo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jL83m0RR2z2x9c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 04:11:31 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id CECF4600E4;
	Thu,  5 Nov 2026 17:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 090091F00919;
	Thu,  5 Nov 2026 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898688;
	bh=1lAUn012SAJPv8LzmMk8AiQwRTQDqHHs/lnV55r2DN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dRb5/iBoGD3GMdpCBoaOuagwLk9BSvn+YoVo5zTFnc27LRGk4YS98IPtqJkYKNlur
	 7s4xR1TumWv4s+UzeIUz7gTeL90ozi4pctzOh8h40XuIFuXs4nmXNji8p5iYXiOnZB
	 ylr5eeYa1uULnzBolzKbAeyDUxKjBYrBeOJNCdyGtCnTC3aIaa3vT6Y/1ditxwPF61
	 7xnQXxclgqs/hbtkFEG19EMkk2Hnxh6jNIoS0H2avrUbBxchHvEz1Qi9Kk9a/Ofd5L
	 jfl2WSKvQlQ1SPtDyE7JdkG38hbFZnKMf5Cn8zJCuohWm/nXAbaVTCe7BGjsivJagk
	 m1P0QqdNB+5lw==
Date: Thu, 5 Nov 2026 19:11:24 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	nayna@linux.ibm.com, rnsastry@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/9] keys/trusted_keys: propagate wrapping key
 generation errors
Message-ID: <auy4vLV8CRJB2hKt@kernel.org>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-2-ssrish@linux.ibm.com>
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
In-Reply-To: <20261105144320.357260-2-ssrish@linux.ibm.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 08:13:12PM +0530, Srish Srinivasan wrote:
> plpks_gen_wrapping_key() returns a negative errno when default wrapping key
> generation fails. However, trusted_pkwm_init() returns -EINVAL for all such
> failures, discarding the original error.
> 
> Propagate the error returned by plpks_gen_wrapping_key() unchanged.
> 
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Nit: I'd put the SOB as last.

> ---
>  security/keys/trusted-keys/trusted_pkwm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
> index bf42c6679245..422f752598e1 100644
> --- a/security/keys/trusted-keys/trusted_pkwm.c
> +++ b/security/keys/trusted-keys/trusted_pkwm.c
> @@ -170,7 +170,7 @@ static int trusted_pkwm_init(void)
>  	ret = plpks_gen_wrapping_key();
>  	if (ret) {
>  		pr_err("Failed to generate default wrapping key\n");
> -		return -EINVAL;
> +		return ret;
>  	}
>  
>  	return register_key_type(&key_type_trusted);
> -- 
> 2.52.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko

