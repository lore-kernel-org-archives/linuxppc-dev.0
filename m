Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E05606A31E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/Kf5141
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYnHG3f61z2yRC;
	Wed, 25 Nov 2026 02:46:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795535210;
	cv=none; b=oWRWXzvJMGwXRe1GBS33jxt/bEE+6FSddr8bfq4waujBpX80wLrst//g9W6LefRkYZVzdj0jPIrP38khzyXrRDNgr7bhklx8DyKWdM8YOgeuw5K+0XNLq2GpojgYMDzt8RiuVsi1Qsff4p9PajEAw5biXLyFMDuG9xN5FmEnBqmJoTY1QNi18oEikWl0ZPG2nrUF5ujSG5elqlmOr2aBnDEazbC15YW2B/6I+DIj60+SkO9W9Cu1rXYJPuX5zd9BQQrl/KuDmiNT00bn1CIGZnwLKqoEiyaFSI3XoKtk7g5ca/Frb0xY/eOatTplT2LC75LFrNht5dRLuG0c9BEGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795535210; c=relaxed/relaxed;
	bh=Ha8tGPAmZb3rO5O3pvMqfZTO9rJ62XTv10jR/v00g00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AupKWPnp6W5yjByaHg/KzZRVXUDG+e7UCIRcD4XGghFzlJPaXr/B3F4CfBFUhYXBaGyCiXW2U92iX8m4ewN5f3MwMsaV0iPg5WZrzeFmvV4mknvrIXFvNuhE6skJ+A7jyyVDW+4ENMp3T6MxORCfoVRqgnsDv0IluSPB4yFp2OPFiT8X/8crOXmNlOShQfWWnrLQS6cPMX/xJaUAFujHGHVRMWOf59Jrf2v+DWNMBMi+lYrS/j1pWqyDjJiXHdP15CbgydwEhE9f945JU6CjXI9ZNtLOiAnZOPL+Y+kFBKB5Yen1zTjtkrKhKXstxBaonrJbX8R02MeMEOU2cSjqEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/Kf5141; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/Kf5141;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYnHF50cbz2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 02:46:49 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1397945B50;
	Tue, 24 Nov 2026 15:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA7B1F000C0;
	Tue, 24 Nov 2026 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535206;
	bh=Ha8tGPAmZb3rO5O3pvMqfZTO9rJ62XTv10jR/v00g00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=j/Kf51418IYI24ZTR8IGGOYoAcLcHXVceLhRfgyYifawn3PW1b0DHhOnI4Pwdzqtc
	 wQSvnogaqqeyHoFoYG3msMGVUCYQ7bcDtNCOGBg/zlx6z+kuyyJiJuPXlCfflnyjKM
	 I9qdUxQ6SbF9H5uEwkNmcrwtll3gDg9x64cxRI+w83nI1HmGV7I6wVX6FbRMQeESld
	 3dMbW8haxFVRhQylwILPPuK5xIfSz5bPfi1PwN3tiAyLeCyjP7D/odmVW4D9KUDZGt
	 2AeU9HsWs1d+2iS9812+gTGnozvuY+9RhiEUtDwwnecGM0cndHMYgPuDt05ajQGtgN
	 To/60D/F6pjfg==
Message-ID: <e77c95c4-a01a-4d61-b137-509d72b8d7ed@kernel.org>
Date: Tue, 24 Nov 2026 16:46:37 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] macintosh/smu: Fix BCD encoding of the RTC month
To: Thorsten Blum <blum@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
References: <20261124132342.235824-2-blum@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261124132342.235824-2-blum@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 24/11/2026 à 14:23, Thorsten Blum a écrit :
> The SMU expects a one-based month encoded as BCD, while tm_mon is
> zero-based. Adding 1 after converting tm_mon to BCD incorrectly encodes
> October as 0x0a instead of 0x10.
> 
> Add 1 to tm_mon before converting it to BCD.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/macintosh/smu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
> index c463760710b6..fb93094ff608 100644
> --- a/drivers/macintosh/smu.c
> +++ b/drivers/macintosh/smu.c
> @@ -374,7 +374,7 @@ static inline void smu_fill_set_rtc_cmd(struct smu_cmd_buf *cmd_buf,
>   	cmd_buf->data[3] = hex2bcd(time->tm_hour);
>   	cmd_buf->data[4] = time->tm_wday;
>   	cmd_buf->data[5] = hex2bcd(time->tm_mday);
> -	cmd_buf->data[6] = hex2bcd(time->tm_mon) + 1;
> +	cmd_buf->data[6] = hex2bcd(time->tm_mon + 1);
>   	cmd_buf->data[7] = hex2bcd(time->tm_year - 100);
>   }
>   
> @@ -421,7 +421,7 @@ int smu_set_rtc_time(struct rtc_time *time, int spinwait)
>   			      hex2bcd(time->tm_hour),
>   			      time->tm_wday,
>   			      hex2bcd(time->tm_mday),
> -			      hex2bcd(time->tm_mon) + 1,
> +			      hex2bcd(time->tm_mon + 1),
>   			      hex2bcd(time->tm_year - 100));
>   	if (rc)
>   		return rc;


