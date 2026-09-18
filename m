Return-Path: <linuxppc-dev+bounces-27659-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A3AC982D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 06:16:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmMp526DQz2yhP;
	Fri, 18 Sep 2026 16:16:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789712189;
	cv=none; b=jg1p6M+GEQgulGdwN+LmKi+CsE5EJi7vFKMDCjzZejEXULudomjTUNjcQ+TiW7hfW+c0fuSa7mFnuf61w5Aj6MeneuFFF3XzBOUZRVLYFruaKy+Y5xGbixgpvePrCCtx1MLxtXF48wrLt0yQass4WRwNJN/WgLY4pvyryfnaH2PciGjhqo36+BPQebteUS1BjuIoZlQLxE+AQn3w+BBnuPu2AcABOt2QJKFopzv9YhBKGdOah0gO3Lx2pbx02XKY9ibOOKI+JxtIfNI5q/rm/40jD0CxE57fB/EuXPud9F/HqXG3V5ZRPrGxUfuMDc6EOPPZ1Ie+jvicgg8yxi+Xwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789712189; c=relaxed/relaxed;
	bh=1UJZmtL5CaegXonvGSFA3hDJm+445zpdeAtQXn0bTg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISE8glX0kR/od+qz+iGTwmPoovAlTehR+NfpPUxIDzPIOXRAbiv3aahP1NwVkeH0kwur+lnlya7oaSTYWf8hD6y8yLObJCwedTJ0ZGJCnj2X3DFBXt8iH7i9oEHq8xIQvU/tH0qq+CCgnjyFkoivbC5ZV64oRb+ZeNOcrwRKFWQriHvK3gvL/Hr5zcquy5biCXGfpF6c6PIYFbrbG0DDcIhrp78dDAuJGgbfR6wot+BDLhNGeGw042dHE+C5EO/E1O2tyAdSsLWgflsvLKP27O2QHQfx+TkMUZRI+LJXMBKlUVtFppZcR8WBz8rR9g3dhQ/STr86zqVKx4EIte8sCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGDp9MOq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGDp9MOq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmMp42LTKz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 16:16:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C1791601EF;
	Fri, 18 Sep 2026 06:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CA71F000FF;
	Fri, 18 Sep 2026 06:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789712185;
	bh=1UJZmtL5CaegXonvGSFA3hDJm+445zpdeAtQXn0bTg0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DGDp9MOqsFg4B4mXaMYUDEqubm5sEflyzN4PeRyswj7MHIjchkbjaYKs3ql4AzhcA
	 w0HwtVc4gjHgFLUq0c5wlDCOuvqi3kD1oD5x5w8u684B8qjtZImm+1aiKX0FO1CPpM
	 /4kuScDfKAwD/XyMXlTHY57L1Q9h3xEf1AJwkKoVMItNTBw2HfswgYoVup66L8SOm2
	 C1mjmXPtiIOzyh+mZ3eZn5myq2OPHSBtgqAuGw0+qKGYBBg8Cc6YKsayRcEUKViUET
	 K/hrR+U22IaPWJmu0CIIe+s31WX0YIdZQ+s2HYjDTHoowolvOt/5OAgt9pXzHviqqj
	 bxc/tNqOGjuGA==
Message-ID: <0d91473e-4432-409b-bb95-9f400ae60d05@kernel.org>
Date: Fri, 18 Sep 2026 08:16:20 +0200
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
Subject: Re: [PATCHv2] dmaengine: bestcomm: use platform machinery to get irq
To: Rosen Penev <rosenp@gmail.com>, Frank Li <Frank.li@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:FREESCALE SOC DRIVERS" <linux-arm-kernel@lists.infradead.org>
References: <20260916224156.276511-1-rosenp@gmail.com>
 <aqtdmOzJSIawqKQq@SMW015318>
 <CAKxU2N-gitgedS9ZJQ7wNV9Dma9PUwM+0NMY5yfVk2PvXOYASQ@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAKxU2N-gitgedS9ZJQ7wNV9Dma9PUwM+0NMY5yfVk2PvXOYASQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/09/2026 à 02:16, Rosen Penev a écrit :
> On Wed, Sep 16, 2026 at 8:25 PM Frank Li <Frank.li@oss.nxp.com> wrote:
>>
>> On Wed, Sep 16, 2026 at 03:41:56PM -0700, Rosen Penev wrote:
>>> platform_get_irq() avoids having to explicitly map and dispose of an irq
>>> by having the platform_device machinery take care of it.
>>>
>>> This requires replacing the device_node with a platform_device in the
>>> bcom_eng struct so that platform_get_irq() can use it.
>>>
>>> Conveniently, this also allows getting rid of of_node_get and
>>> of_node_put as the platform_device machinery also handles that.
>>>
>>> Replace the open-coded resource lookup, request_mem_region, ioremap and
>>> the manual iounmap/release_mem_region cleanup in probe/remove with the
>>> managed devm_platform_get_and_ioremap_resource() helper. This removes the
>>
>> update commit message, no devm_platform_get_and_ioremap_resource() in patch.
>>
>>> now-unused error-unmap/release paths and simplifies the driver.
>>>
>>> Adjust the goto labels in bcom_task_alloc to match what is being freed.
>>>
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>> ---
>>>   v2: resend.
>>
>> If resend, don't pump version.
>>
>> Frank
>>>   drivers/dma/bestcomm/bestcomm.c            | 47 ++++++++--------------
>>>   include/linux/fsl/bestcomm/bestcomm_priv.h |  2 +-
>>>   2 files changed, 18 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
>>> index 241a91936fe8..1006030ff167 100644
>>> --- a/drivers/dma/bestcomm/bestcomm.c
>>> +++ b/drivers/dma/bestcomm/bestcomm.c
>>> @@ -47,6 +47,7 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
>>>   {
>>>        int i, tasknum = -1;
>>>        struct bcom_task *tsk;
>>> +     int irq;
>>>
>>>        /* Don't try to do anything if bestcomm init failed */
>>>        if (!bcom_eng)
>>> @@ -67,30 +68,32 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
>>>        if (tasknum < 0)
>>>                return NULL;
>>>
>>> +     irq = platform_get_irq(bcom_eng->pdev, tasknum);
>>> +     if (irq < 0)
>>> +             goto err1;
>>> +
>>>        /* Allocate our structure */
>>>        tsk = kzalloc(sizeof(struct bcom_task) + priv_size, GFP_KERNEL);
>>>        if (!tsk)
>>> -             goto error;
>>> +             goto err1;
>>>
>>>        tsk->tasknum = tasknum;
>>>        if (priv_size)
>>>                tsk->priv = (void*)tsk + sizeof(struct bcom_task);
>>>
>>>        /* Get IRQ of that task */
>>> -     tsk->irq = irq_of_parse_and_map(bcom_eng->ofnode, tsk->tasknum);
>>> -     if (!tsk->irq)
>>> -             goto error;
>>> +     tsk->irq = irq;
>>>
>>>        /* Init the BDs, if needed */
>>>        if (bd_count) {
>>>                tsk->cookie = kmalloc_array(bd_count, sizeof(void *),
>>>                                            GFP_KERNEL);
>>>                if (!tsk->cookie)
>>> -                     goto error;
>>> +                     goto err2;
>>>
>>>                tsk->bd = bcom_sram_alloc(bd_count * bd_size, 4, &tsk->bd_pa);
>>>                if (!tsk->bd)
>>> -                     goto error;
>>> +                     goto err3;
>>>                memset_io(tsk->bd, 0x00, bd_count * bd_size);
>>>
>>>                tsk->num_bd = bd_count;
>>> @@ -99,17 +102,12 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
>>>
>>>        return tsk;
>>>
>>> -error:
>>> -     if (tsk) {
>>> -             if (tsk->irq)
>>> -                     irq_dispose_mapping(tsk->irq);
>>> -             bcom_sram_free(tsk->bd);
>>> -             kfree(tsk->cookie);
>>> -             kfree(tsk);
>>> -     }
>>> -
>>> +err3:
>>> +     kfree(tsk->cookie);
>>> +err2:
>>> +     kfree(tsk);
>>> +err1:
>>>        bcom_eng->tdt[tasknum].stop = 0;
>>> -
>>
>> avoid unnecesary change.
> There's nothing unnecessary about this. irq_dispose_mapping goes away.
> bcom_sram_free is a mistake here. It's not reachable after
> bcom_sram_alloc. This is much clearer to look at.

The comment is about the removal of the blank line. Nothing else. I 
confirm it is unnecessary.

> 
> Moving bcom_sram_free removal to its own commit is pointless churn.
>>
>>>        return NULL;
>>>   }
>>>   EXPORT_SYMBOL_GPL(bcom_task_alloc);
>>> @@ -125,7 +123,6 @@ bcom_task_free(struct bcom_task *tsk)
>>>        bcom_eng->tdt[tsk->tasknum].stop  = 0;
>>>
>>>        /* Free everything */
>>> -     irq_dispose_mapping(tsk->irq);
>>>        bcom_sram_free(tsk->bd);
>>>        kfree(tsk->cookie);
>>>        kfree(tsk);
>>> @@ -377,16 +374,12 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>>>        if (IS_ERR(regs))
>>>                return PTR_ERR(regs);
>>>
>>> -     /* Get the bestcomm node */
>>> -     of_node_get(op->dev.of_node);
>>> -
>>>        /* Prepare SRAM */
>>>        ofn_sram = of_find_matching_node(NULL, mpc52xx_sram_ids);
>>>        if (!ofn_sram) {
>>>                printk(KERN_ERR DRIVER_NAME ": "
>>>                        "No SRAM found in device tree\n");
>>> -             rv = -ENODEV;
>>> -             goto error_ofput;
>>> +             return -ENODEV;
>>>        }
>>>        rv = bcom_sram_init(ofn_sram, DRIVER_NAME);
>>>        of_node_put(ofn_sram);
>>> @@ -394,7 +387,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>>>        if (rv) {
>>>                printk(KERN_ERR DRIVER_NAME ": "
>>>                        "Error in SRAM init\n");
>>> -             goto error_ofput;
>>> +             return rv;
>>>        }
>>>
>>>        /* Get a clean struct */
>>> @@ -405,8 +398,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>>>        }
>>>
>>>        /* Save the node */
>>> -     bcom_eng->ofnode = op->dev.of_node;
>>> -
>>> +     bcom_eng->pdev = op;
>>>        bcom_eng->regs = regs;
>>>        bcom_eng->regs_base = res_bcom->start;
>>>
>>> @@ -426,8 +418,6 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
>>>        kfree(bcom_eng);
>>>        bcom_eng = NULL;
>>>        bcom_sram_cleanup();
>>> -error_ofput:
>>> -     of_node_put(op->dev.of_node);
>>>
>>>        printk(KERN_ERR "DMA: MPC52xx BestComm init failed !\n");
>>>
>>> @@ -443,9 +433,6 @@ static void mpc52xx_bcom_remove(struct platform_device *op)
>>>        /* Cleanup SRAM */
>>>        bcom_sram_cleanup();
>>>
>>> -     /* Release the node */
>>> -     of_node_put(bcom_eng->ofnode);
>>> -
>>>        /* Release memory */
>>>        kfree(bcom_eng);
>>>        bcom_eng = NULL;
>>> diff --git a/include/linux/fsl/bestcomm/bestcomm_priv.h b/include/linux/fsl/bestcomm/bestcomm_priv.h
>>> index 3b52f3ffbdf8..cddde7c74cb5 100644
>>> --- a/include/linux/fsl/bestcomm/bestcomm_priv.h
>>> +++ b/include/linux/fsl/bestcomm/bestcomm_priv.h
>>> @@ -66,7 +66,7 @@ struct bcom_tdt {
>>>    * This holds all info needed globaly to handle the engine
>>>    */
>>>   struct bcom_engine {
>>> -     struct device_node              *ofnode;
>>> +     struct platform_device          *pdev;
>>>        struct mpc52xx_sdma __iomem     *regs;
>>>        phys_addr_t                      regs_base;
>>>
>>> --
>>> 2.55.0
>>>


