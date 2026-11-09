Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709F606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=if5RIomV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNXrX5wy3z2xS2;
	Tue, 10 Nov 2026 01:55:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794236108;
	cv=none; b=K4ZIR52Wzg6jAzZfYN1ESZ6m7NqEB11sky3RJ0SawOZS5oI49HxNeoHJ1pkY1BmkObz6OUBscLHL8AfLxStZVt6GMJqGqnsBJfAPHptEWzgpKzEPwwwGkuRHFcczFuDn0AGPdPA7kiVXbriRKBGIG+zpVbsQun42GO/z0pLvdSYtZUhBtF2e9sn473VsaXJlErKmPiFmc6gR5SfnIy6gI20wJV3ewGmVNxRixEN0c78wvhNsQmO0bgFBK8XlIqz6R6KLF3Qxbb3VPemt9gRBUfHWPnIZr7ATX3vFBAMr5YSdln5tVxrTKJyICT/6OhV+02gi/GSyR99Ym4QHJt/ZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794236108; c=relaxed/relaxed;
	bh=kT8Z5Z2kEUrWcaYC02QsMolEzPrRweOdy0UnfYbn9q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGP/1WUqqfzHnMg6pKugGZr9ajc74VGWPvgbRjMsEEicnY3QL+96CWHdMxUglU3SilDcqn8w83VREB77V9ASE4PX2kNayzexW5olZqSQoDQEXtpPOqWttqDyBNlivDNGAx4m60s6VakJOOawtDqCQYODW/thXy0omWBXqci/VPCUtFfQ6elNdRd4isuUTQqMJTPeEm9EynGpOIF8gWhYESkTiXnJKDeAFQlYL+Xg5etyg/q/7qIM33uDMtuaTaTdYEnyFpRbwuHT0ZGTXwHFznPBVCoAfzChWSHTu36z2q85jR9fkIV0rfbml1IKnq2QQ/WswWIwTn+WTa00xSu7yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=if5RIomV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=if5RIomV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jarkko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jNXrW3kCkz2xRm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 01:55:07 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 13F0063343;
	Mon,  9 Nov 2026 14:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3AF0E1F0089F;
	Mon,  9 Nov 2026 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236103;
	bh=kT8Z5Z2kEUrWcaYC02QsMolEzPrRweOdy0UnfYbn9q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=if5RIomVFKJ/Q0ZjrIuubxQc5fTA4fT6J7xUoZLDmFxadcZVMAcycD72a/gWkTv97
	 pWUn/qMUzlxJhKEFfUEWqQVIoTMtcIbzIuPvESh+9pkLczuaI2RXKcHZEIcrv5T6E7
	 hejzBLWit392pSBkFx1HfIvtDfrL+mRy+4vsgAoF2ZiK2guxUITtPg5FUwAtays43v
	 jZdXtV6ZA6aIs7iqEpQJdSrLizoUw7kfePCVd2b45r3w8l2C6thzeqEuZR4DZ91xer
	 sqYRgDMpshTJDRTypF+xApaYTlApsALEzWQpm3cegJkdEKmhy6+sr9m+5RCHKTc7PH
	 xmniK/Cxf3w9Q==
Date: Mon, 9 Nov 2026 16:55:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Ashley Lai <adlai@linux.vnet.ibm.com>,
	Kent Yoder <key@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: ibmvtpm: check the response size against the
 buffer size
Message-ID: <avHexCvi3-9Z8pgU@kernel.org>
References: <au3w4NDX1Uqz-iqd@kernel.org>
 <20261109014957.2777790-1-guozh23@xiaopeng.com>
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
In-Reply-To: <20261109014957.2777790-1-guozh23@xiaopeng.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 09:49:57AM +0800, Guo Zihao wrote:
> The send path validates the transfer size against the size of the
> RTCE buffer:
> 
> 	if (count > ibmvtpm->rtce_size) {
> 		dev_err(ibmvtpm->dev,
> 			"Invalid size in send: count=%zd, rtce_size=%d\n",
> 			count, ibmvtpm->rtce_size);
> 		return -EIO;
> 	}
> 
> The receive path has no such check: the response length is whatever
> the hypervisor reported in the completion CRQ, and it is only
> compared against the size the caller asked for before being used to
> copy and clear the RTCE buffer:
> 
> 	len = ibmvtpm->res_len;
> 
> 	if (count < len) {
> 		...
> 		return -EIO;
> 	}
> 
> 	spin_lock(&ibmvtpm->rtce_lock);
> 	memcpy((void *)buf, (void *)ibmvtpm->rtce_buf, len);
> 	memset(ibmvtpm->rtce_buf, 0, len);
> 
> A response length larger than the RTCE buffer makes the memcpy read
> past the buffer and the memset clear past it.
> 
> Reject a response that does not fit in the RTCE buffer, mirroring
> the check the send path already performs.
> 
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
> ---
> 
> v2: Drop the Fixes and Cc: stable tags, as suggested by Jarkko
> Sakkinen: a hypervisor reporting an oversized response is not
> known to violate the architecture, so this is hardening rather
> than a bug fix. No code changes.
> 
>  drivers/char/tpm/tpm_ibmvtpm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 6fb4d30eb6f6..bfef4bc14767 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -121,6 +121,13 @@ static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>  		return -EIO;
>  	}
>  
> +	if (len > ibmvtpm->rtce_size) {
> +		dev_err(ibmvtpm->dev,
> +			"Invalid size in recv: res_len=%d, rtce_size=%d\n",
> +			len, ibmvtpm->rtce_size);
> +		return -EIO;
> +	}
> +
>  	spin_lock(&ibmvtpm->rtce_lock);
>  	memcpy((void *)buf, (void *)ibmvtpm->rtce_buf, len);
>  	memset(ibmvtpm->rtce_buf, 0, len);
> -- 
> 2.50.1
> 

Thank you.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko

