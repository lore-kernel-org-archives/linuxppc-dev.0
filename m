Return-Path: <linuxppc-dev+bounces-16522-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1C1E73158
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Feb 2026 13:00:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4RY62Nrpz309y;
	Tue, 03 Feb 2026 00:00:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770037210;
	cv=none; b=RsC1lt98ukOaRvVQIt5xKRJ/8Qal3wIJQJ9ps6SXnFt6p8loG/3mJvHVMIt0Rv+3q9Ku4noer3Jo4eANrUSJGg2N/X4/fhH2VfjYENQIA2uL2U6MB5agRIo+U18KlYIet97Mf3mrUlFpty3NXdKN6c7nVfWfGug9z2mzvsIyFkYNaBgWgFEYrES/rVss/tY4v24xSN7kHuPehdcr81OLT6mvTRdpFP3r5fh4n1+qv9g9OSc/Jd4NwsipdI1c31kzsrKYJsc3WqTnsak4/lBfcoBq0+cXgT6w8yjcnDXy/46ypap+fDHuETbhhiCl0hbv8PzwwuWyzu8i7bvOOKNr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770037210; c=relaxed/relaxed;
	bh=uEc8TvjnHa5ctWLyR7nKKcSQVtFV4OpS/QLW1YcL9eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yjoh02VAeOkfJVlaRpYJBPBw1E8UFvR2Dbk4RM2PPP5oLTGNwoyaLSYioAeq43lmdbeTKPB7ZIivMBS3i+XbgKl9yMbK57EfrtsYxmGFDTyvPWgrISx4Tih0/dc0rxIrLgtOAR0++d0XxGI2MZKWLyEJjZjsgKmTx1tyMIeWa/ogVY+auQVph3q/zxXr6J+mAMatW+sXhPTd+4ZV4oWxWK1AWF6hrspCYdRJ4p+aUoY7A2W2JsnlGkxaG2ZoZqHvrXwvmo1yPyOU3BQEF1ehDZnQMjW1A+//UsXeRoMFT8xpU9qBR0FvC/MRGntJchKSJihrZPUXMGlA2ctQhHLMFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=O0uWghrH; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=O0uWghrH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 321 seconds by postgrey-1.37 at boromir; Tue, 03 Feb 2026 00:00:08 AEDT
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4RY419h7z2xpk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 00:00:06 +1100 (AEDT)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C33974E423BA;
	Mon,  2 Feb 2026 12:54:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 887B360767;
	Mon,  2 Feb 2026 12:54:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58917119A8891;
	Mon,  2 Feb 2026 13:54:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770036879; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=uEc8TvjnHa5ctWLyR7nKKcSQVtFV4OpS/QLW1YcL9eM=;
	b=O0uWghrHWXwaACUvUJKHzbTu4QLw59L0R/2S+wlYL3pxoyfqk9f0c54BD6+7bowN2+12Ss
	awylkXRFZduyC7o/tZRzRy2Y+FvEl1fsjer/2iNtWqE/oeazmwF3OdJC12pTpFjuFmM6d+
	SYqN8LApm6ddErnuQWEuzOo1BYdvSHbo1dsSl9jtjZA5xK06bTDVCqU3aFNMMOC5oduXzS
	MeezuuwwWFo2CucaaYP2gfY8ktltTJ2J4ubZEYqcAr2ahRPaIxtr9G64JSWFY/FtIQG18m
	sr5VJPZ5L4V3rQ7mAIYfmfJxvp4PfwYEagT1VRqllmmwKQRaI87K3GNxXGD59w==
Message-ID: <825baaef-bd76-4e2c-94ef-3daddf55243b@bootlin.com>
Date: Mon, 2 Feb 2026 13:54:34 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: fsl: qbman: fix race condition in qman_destroy_fq
To: Christophe Leroy <chleroy@kernel.org>,
 Marco Crivellari <marco.crivellari@suse.com>, Kees Cook <kees@kernel.org>,
 Roy Pledge <roy.pledge@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Scott Wood <oss@buserror.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 CHAMPSEIX Thomas <thomas.champseix@alstomgroup.com>
References: <20251223072549.397625-1-richard.genoud@bootlin.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20251223072549.397625-1-richard.genoud@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 23/12/2025 à 08:25, Richard Genoud a écrit :
> When QMAN_FQ_FLAG_DYNAMIC_FQID is set, there's a race condition between
> fq_table[fq->idx] state and freeing/allocating from the pool and
> WARN_ON(fq_table[fq->idx]) in qman_create_fq() gets triggered.
> 
> Indeed, we can have:
>           Thread A                             Thread B
>      qman_destroy_fq()                    qman_create_fq()
>        qman_release_fqid()
>          qman_shutdown_fq()
>          gen_pool_free()
>             -- At this point, the fqid is available again --
>                                             qman_alloc_fqid()
>             -- so, we can get the just-freed fqid in thread B --
>                                             fq->fqid = fqid;
>                                             fq->idx = fqid * 2;
>                                             WARN_ON(fq_table[fq->idx]);
>                                             fq_table[fq->idx] = fq;
>       fq_table[fq->idx] = NULL;
> 
> And adding some logs between qman_release_fqid() and
> fq_table[fq->idx] = NULL makes the WARN_ON() trigger a lot more.
> 
> To prevent that, ensure that fq_table[fq->idx] is set to NULL before
> gen_pool_free() is called by using smp_wmb().
> 

Tested on a LS1046A based board.
With this patch, the warning is not triggered anymore.

Tested-by: CHAMPSEIX Thomas <thomas.champseix@alstomgroup.com>

> Fixes: c535e923bb97 ("soc/fsl: Introduce DPAA 1.x QMan device driver")
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>   drivers/soc/fsl/qbman/qman.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> NB: I'm not 100% sure of the need of a barrier here, since even without
> it, the WARN_ON() wasn't triggered any more.
> 
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index 6b392b3ad4b1..39a3e7aab6ff 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -1827,6 +1827,8 @@ EXPORT_SYMBOL(qman_create_fq);
>   
>   void qman_destroy_fq(struct qman_fq *fq)
>   {
> +	int leaked;
> +
>   	/*
>   	 * We don't need to lock the FQ as it is a pre-condition that the FQ be
>   	 * quiesced. Instead, run some checks.
> @@ -1834,11 +1836,29 @@ void qman_destroy_fq(struct qman_fq *fq)
>   	switch (fq->state) {
>   	case qman_fq_state_parked:
>   	case qman_fq_state_oos:
> -		if (fq_isset(fq, QMAN_FQ_FLAG_DYNAMIC_FQID))
> -			qman_release_fqid(fq->fqid);
> +		/*
> +		 * There's a race condition here on releasing the fqid,
> +		 * setting the fq_table to NULL, and freeing the fqid.
> +		 * To prevent it, this order should be respected:
> +		 */
> +		if (fq_isset(fq, QMAN_FQ_FLAG_DYNAMIC_FQID)) {
> +			leaked = qman_shutdown_fq(fq->fqid);
> +			if (leaked)
> +				pr_debug("FQID %d leaked\n", fq->fqid);
> +		}
>   
>   		DPAA_ASSERT(fq_table[fq->idx]);
>   		fq_table[fq->idx] = NULL;
> +
> +		if (fq_isset(fq, QMAN_FQ_FLAG_DYNAMIC_FQID) && !leaked) {
> +			/*
> +			 * fq_table[fq->idx] should be set to null before
> +			 * freeing fq->fqid otherwise it could by allocated by
> +			 * qman_alloc_fqid() while still being !NULL
> +			 */
> +			smp_wmb();
> +			gen_pool_free(qm_fqalloc, fq->fqid | DPAA_GENALLOC_OFF, 1);
> +		}
>   		return;
>   	default:
>   		break;
> 
> base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

