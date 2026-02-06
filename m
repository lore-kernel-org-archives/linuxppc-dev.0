Return-Path: <linuxppc-dev+bounces-16647-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9C3EB28D1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 07:16:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6lkK711Bz30BR;
	Fri, 06 Feb 2026 18:16:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770362169;
	cv=none; b=YKsGuRhaIN3LoOiVF/z8uXIqls9epaOZ0mYLX5LJ7wJZBZVy4b9nQLJarZIHU+7BxSVHnek+aKE0QN8OrWqJEzZqH96wmJJ0RwtREcAmHpWQQcPDMT+u2vzCaGQD9tO1C0TuyzgdEoIq7j0/2TGOFherHbk+CbG7KoOmClelsGylLj3WfYKVVfWTv1R4KxNxRiXDFxhRrxpNUs8zR8wKmZQXH03UH9pIgL62hwt8frxKVjaUDSDQubqaMIdORRD8KkB4QpiBHgYr2RS5vE56eBLmKb2OENIo7FlR9E2k5Cds9biolJYLrrIUcfMkn087Z5mQJJKdUKoH1G7N8tEiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770362169; c=relaxed/relaxed;
	bh=nkMDM4rC7yGmXZE/CaMd6fZPIBX9ktS8WEKcs5QdQiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdIY1BaJl2x1bwmfGFS2ZPeoZ0Retk1Jvb3EIXjrNK2WYqVdGogPoCY6E04VWgwTyfjIFhi016FOxcmY4kjwhZ04fOGVnIMayjxyM5YZdXsgIXoM+3XMIoE/70b8T6MqzKeA3lMigbdVxV6BwqW6arDpM2JI5YPdlVQel00cPCy0F6jTQRI22YNxQeiMq6qrAAMVKrBMXqhEVDxndLuGtxptOLLpKMBzuaC5GKdy6BkNT077Arh72r9pWSEaHjZBRHa5fi9VdgFFj8oEz8tQoY2pROdBpDbxf1LvxEWUZdFlKkDXp5kViO6gsjcfbvvcMsUEZl9X8kSa4meydJGjdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ttr4vzmA; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ttr4vzmA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6lkK0Sq6z2xqk
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 18:16:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 34AA56001A;
	Fri,  6 Feb 2026 07:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E952AC116C6;
	Fri,  6 Feb 2026 07:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770362166;
	bh=EQj88U1PIguqEAI0bHvHKRFIWmNh/CHWlfiSK+CikIg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ttr4vzmAOWkSVKpkh3mIiwxnjyQYBOLTV4WPmeC6K+A4UgVq/Q6trh5HHQpzZ4sPp
	 hMpwYsrh05MItrVvB4p2pEIC/zTE9V4qIJD99iciQ1WGDAbbiHUBxkAqYKlrMV80Cp
	 JRkr8kaumkUtREeJXcZG/3A+kvu6mxSI2EbFxMo8R9PcokrV0RLJ/EqIgOvH8+UAxc
	 4iUALByznofDbaIUEyhTZJ/FW1+qUk6BeozjhHf7l2qy1rBrDqjKiMFMDFOoHiZK5s
	 bK0KITp3JQh0NpLNVp72lAosI5sZEsyfW9EIWMyHM2AJAysrba0dQUd1kKROMeFrtS
	 cxko2kfih5Jqg==
Message-ID: <f942c10a-73a7-4185-865f-c74c11f6fdcc@kernel.org>
Date: Fri, 6 Feb 2026 08:16:00 +0100
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
To: Richard GENOUD <richard.genoud@bootlin.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Kees Cook <kees@kernel.org>,
 Roy Pledge <roy.pledge@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Scott Wood <oss@buserror.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 CHAMPSEIX Thomas <thomas.champseix@alstomgroup.com>
References: <20251223072549.397625-1-richard.genoud@bootlin.com>
 <825baaef-bd76-4e2c-94ef-3daddf55243b@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <825baaef-bd76-4e2c-94ef-3daddf55243b@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 02/02/2026 à 13:54, Richard GENOUD a écrit :
> Le 23/12/2025 à 08:25, Richard Genoud a écrit :
>> When QMAN_FQ_FLAG_DYNAMIC_FQID is set, there's a race condition between
>> fq_table[fq->idx] state and freeing/allocating from the pool and
>> WARN_ON(fq_table[fq->idx]) in qman_create_fq() gets triggered.
>>
>> Indeed, we can have:
>>           Thread A                             Thread B
>>      qman_destroy_fq()                    qman_create_fq()
>>        qman_release_fqid()
>>          qman_shutdown_fq()
>>          gen_pool_free()
>>             -- At this point, the fqid is available again --
>>                                             qman_alloc_fqid()
>>             -- so, we can get the just-freed fqid in thread B --
>>                                             fq->fqid = fqid;
>>                                             fq->idx = fqid * 2;
>>                                             WARN_ON(fq_table[fq->idx]);
>>                                             fq_table[fq->idx] = fq;
>>       fq_table[fq->idx] = NULL;
>>
>> And adding some logs between qman_release_fqid() and
>> fq_table[fq->idx] = NULL makes the WARN_ON() trigger a lot more.
>>
>> To prevent that, ensure that fq_table[fq->idx] is set to NULL before
>> gen_pool_free() is called by using smp_wmb().
>>
> 
> Tested on a LS1046A based board.
> With this patch, the warning is not triggered anymore.
> 
> Tested-by: CHAMPSEIX Thomas <thomas.champseix@alstomgroup.com>

This fix is now in linux-next. If everything goes well I will send a 
pull request for this fix in rc2 or rc3.

> 
>> Fixes: c535e923bb97 ("soc/fsl: Introduce DPAA 1.x QMan device driver")
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   drivers/soc/fsl/qbman/qman.c | 24 ++++++++++++++++++++++--
>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> NB: I'm not 100% sure of the need of a barrier here, since even without
>> it, the WARN_ON() wasn't triggered any more.
>>
>> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
>> index 6b392b3ad4b1..39a3e7aab6ff 100644
>> --- a/drivers/soc/fsl/qbman/qman.c
>> +++ b/drivers/soc/fsl/qbman/qman.c
>> @@ -1827,6 +1827,8 @@ EXPORT_SYMBOL(qman_create_fq);
>>   void qman_destroy_fq(struct qman_fq *fq)
>>   {
>> +    int leaked;
>> +
>>       /*
>>        * We don't need to lock the FQ as it is a pre-condition that 
>> the FQ be
>>        * quiesced. Instead, run some checks.
>> @@ -1834,11 +1836,29 @@ void qman_destroy_fq(struct qman_fq *fq)
>>       switch (fq->state) {
>>       case qman_fq_state_parked:
>>       case qman_fq_state_oos:
>> -        if (fq_isset(fq, QMAN_FQ_FLAG_DYNAMIC_FQID))
>> -            qman_release_fqid(fq->fqid);
>> +        /*
>> +         * There's a race condition here on releasing the fqid,
>> +         * setting the fq_table to NULL, and freeing the fqid.
>> +         * To prevent it, this order should be respected:
>> +         */
>> +        if (fq_isset(fq, QMAN_FQ_FLAG_DYNAMIC_FQID)) {
>> +            leaked = qman_shutdown_fq(fq->fqid);
>> +            if (leaked)
>> +                pr_debug("FQID %d leaked\n", fq->fqid);
>> +        }
>>           DPAA_ASSERT(fq_table[fq->idx]);
>>           fq_table[fq->idx] = NULL;
>> +
>> +        if (fq_isset(fq, QMAN_FQ_FLAG_DYNAMIC_FQID) && !leaked) {
>> +            /*
>> +             * fq_table[fq->idx] should be set to null before
>> +             * freeing fq->fqid otherwise it could by allocated by
>> +             * qman_alloc_fqid() while still being !NULL
>> +             */
>> +            smp_wmb();
>> +            gen_pool_free(qm_fqalloc, fq->fqid | DPAA_GENALLOC_OFF, 1);
>> +        }
>>           return;
>>       default:
>>           break;
>>
>> base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
> 
> 


