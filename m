Return-Path: <linuxppc-dev+bounces-21548-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D85FCD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 23:00:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ7WZ6Q6pz2yT0;
	Wed, 27 May 2026 09:00:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a03:4000:43:185::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779829154;
	cv=none; b=DA1b0QRe58ENWTfwU9q/i6nI+jIL4GIOi2ABE4dx+Q7xfYGhmqfJQrjS02DlCf/mXhGg5c4shfpXXHNVCGx3sknfQAecxlbtToZ+H9j4qA73tCS3OOsFGTZGOLnWgJN3+Jr99WWmI1YMSHAMNh3oDWsVgG19JIrAK7KDzjo81B/aKthtTWaQNoTvH4bRshZE7cEgSEYOukAO15JSGEBDCpR/0ImWhbADFUVvzndaf2XJCW5CxTQIMrGfBRibrqcIxbwDR1SJ/yRQ8CHPec/zHHU1/KfnoWyFCQfjDV4Pnu8JjcWh5PrqMuaSHF10Ex/pDgSIsd22orMQtYG8ZrZriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779829154; c=relaxed/relaxed;
	bh=YxIv+z1i7BXKHKGu2iZTSaCZuD3KwsuMfvkF03U6b30=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=SeYzBWhS5xgUJhMxEIzXuEeBbljigekENWdimH1XznUtdmjTpYEw/hTn8VxMDa5ysXqH3cpw6GG0cK0kYy6lLcFivLpNOVAHa6Wvv4Dn3EFT1MsIZCC6KanMUVpK8RSIQMsPbGdThh3bn5X9bTup7RhbAdBLgOBUqBAX5EwHBc6dqZwRIrDDwxRaU8ZqNCvWkdyUiKEQxB9gwolMg546O4ZWU94ogPhWBvPpv3eErDBNNSbPEEMORNJ7bZ5cB4SRY5dg2X8ge/UgUloZshPMb9PcC/FAaKHTgPSdVZfosipsh/4rPmcBOu9FUzn5/O8vXgvOFQnheCPMSRAIRLsqsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; dkim=pass (2048-bit key; unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Rj0TPyz1; dkim-atps=neutral; spf=pass (client-ip=2a03:4000:43:185::1; helo=mail.tipi-net.de; envelope-from=nb@tipi-net.de; receiver=lists.ozlabs.org) smtp.mailfrom=tipi-net.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Rj0TPyz1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tipi-net.de (client-ip=2a03:4000:43:185::1; helo=mail.tipi-net.de; envelope-from=nb@tipi-net.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 518 seconds by postgrey-1.37 at boromir; Wed, 27 May 2026 06:59:10 AEST
Received: from mail.tipi-net.de (mail.tipi-net.de [IPv6:2a03:4000:43:185::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ4qf60M3z2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 06:59:10 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82ECBA4B47;
	Tue, 26 May 2026 22:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779828627; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YxIv+z1i7BXKHKGu2iZTSaCZuD3KwsuMfvkF03U6b30=;
	b=Rj0TPyz16ddOVcu6NGLZel8fDz+TRyxwiP4+JhzkJZbzWYsOSGIZ+zObP76tXE4Vs5QK29
	HS9XbmZxA973Zhq+wp7AqhnIAoYUSw5bAJcNkOPsBlrhyMdCJ4AI86DDxYL1GqiA5zhMbj
	jHtb+DsScJyyz1kBTr1vd5LjhYu1PaFDH8sRCGCSUjkSfhmsKHXAu00wAVEjOKMLvrUlrg
	gB/SssvHnFNn5m20rHtdf0W3QOrCYChbZYYPwkskWplqnKrS9k0lrXnWrW7Eazy3wwCaEa
	rReEkauXZOLjZRN1nWhfLRZd30kQPfntTyLJN4DMIT60rpErwd06e/CZ64yv0A==
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
Date: Tue, 26 May 2026 22:50:20 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Haren Myneni <haren@linux.ibm.com>, Rick Lindsley
 <ricklind@linux.ibm.com>, Nick Child <nnac123@linux.ibm.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas Falcon
 <tlfalcon@linux.vnet.ibm.com>, Desnes Augusto Nunes do Rosario
 <desnesn@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ibmvnic: fix krealloc() memory leak
In-Reply-To: <20260526184105.18962-6-grandmaster@al2klimov.de>
References: <20260526184105.18962-1-grandmaster@al2klimov.de>
 <20260526184105.18962-6-grandmaster@al2klimov.de>
Message-ID: <fc74cefb2e0167514f1c3c0c3d6133ec@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Alex

You patch is missing the prefix with the target tree. Please have
a look at [1] for more details on the workflow.

On 26.5.2026 20:41, Alexander A. Klimov wrote:
> Don't just overwrite the original pointer passed to krealloc()
> with its return value without checking latter:
> 
>     MEM = krealloc(MEM, SZ, GFP);
> 
> If krealloc() returns NULL, that erases the pointer
> to the still allocated memory, hence leaks this memory.
> Instead, use a temporary variable, check it's not NULL
> and only then assign it to the original pointer:
> 
>     TMP = krealloc(MEM, SZ, GFP);
>     if (!TMP) return;
>     MEM = TMP;
> 
> Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of Vital Product 
> Data (VPD) for the ibmvnic driver")
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c 
> b/drivers/net/ethernet/ibm/ibmvnic.c
> index 5a510eed335e..25d1d844ad19 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -1761,8 +1761,9 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter 
> *adapter)
>  	union ibmvnic_crq crq;
>  	int len = 0;
>  	int rc;
> +	unsigned char *buff = adapter->vpd->buff;

Should be reverse x-mas tree (longest to shortest).

> 
> -	if (adapter->vpd->buff)
> +	if (buff)
>  		len = adapter->vpd->len;
> 
>  	mutex_lock(&adapter->fw_lock);
> @@ -1788,17 +1789,17 @@ static int ibmvnic_get_vpd(struct 
> ibmvnic_adapter *adapter)
>  	if (!adapter->vpd->len)
>  		return -ENODATA;
> 
> -	if (!adapter->vpd->buff)
> -		adapter->vpd->buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
> +	if (!buff)
> +		buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
>  	else if (adapter->vpd->len != len)
> -		adapter->vpd->buff =
> -			krealloc(adapter->vpd->buff,
> -				 adapter->vpd->len, GFP_KERNEL);
> +		buff = krealloc(buff,
> +				adapter->vpd->len, GFP_KERNEL);

Dead branch? The only caller, init_resources(), kzalloc()s a fresh vpd
right before, and resets run release_vpd_data() first, so vpd->buff is
always NULL here and kzalloc() above always wins. The leak can't 
trigger,
which makes the Fixes tag misleading.

> 
> -	if (!adapter->vpd->buff) {
> +	if (!buff) {
>  		dev_err(dev, "Could allocate VPD buffer\n");
>  		return -ENOMEM;
>  	}
> +	adapter->vpd->buff = buff;

If you keep it anyway: on failure the old buffer stays in vpd->buff 
while
vpd->len is already the new size, a mismatch the original avoided by
NULLing. kfree() it (krealloc() does not free on failure) and NULL 
before
-ENOMEM.

> 
>  	adapter->vpd->dma_addr =
>  		dma_map_single(dev, adapter->vpd->buff, adapter->vpd->len,

[1] https://docs.kernel.org/process/maintainer-netdev.html

Thanks,
Nicolai

