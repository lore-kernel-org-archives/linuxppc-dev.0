Return-Path: <linuxppc-dev+bounces-14992-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF3DE7544E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Dec 2025 11:08:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbpy84Ltyz2yFk;
	Wed, 24 Dec 2025 22:08:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766574480;
	cv=none; b=PSwZaJ3AEAKDbIfjntTnCLB7tqmjDPvCubN9KMsivsnvnPWGt8tgHzxfjTgXyNW7zvkcfHSyls6/xs77Xvqq2aKK8cP/r13rpkHCy2MqFm03BEcovhMqTRiLmpn/b7U4Y7tx0ZrxOazgRiG1RxDRu1U+IL9tpJUgDExcPRvnooUsvq5YiEmBMgKXaUWek7VrKncfUGxaroJPEWK7vxX1QypN+lieT08SfpjOqYecURb0T34CcIhgOWageLCmQFnidhiVo3NIOUFXO5VlywGH3XnqFJ7UqEtYUTGX0exjnANLPKb3QS2shJlhPNs83LYEG5OrAXcQYQ/72DGVk2W+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766574480; c=relaxed/relaxed;
	bh=JTUIy7g6MUV+plhHQ8RqOAjvz5ogPcYpiHYX4VgwDp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKWO4Cw3Np0lbuN4Omu0t9E8z6+VHUip8BUYuu7JqgeVWwRd272v3FlDvz0CnCzNCmmM+/zE/o9Tw2xCa5uI9aYrvCM0gltCrbZBz5dr4/flfnXQMrxGrkfViqYa6ah/76NOcDvf/MG5z784H1R9Qt8fPR68nCk/7+wwWzbWycfqlKkG+/MvBe+n16wsqguwb2KEmKv4DSSWOEfdyP3ymazIswy60eBbO6vEsEVMm6Je6xRUHchBbC9sCUvXGF7Zyad/tWjTPRhT3H+rpcps+09rRFymhpgxlFTXYsDsjfLkzDrIYT9HlX/uOl97SwFZCaq0pSTANCq/+hZAm1Dg7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pdvfZ7iG; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pdvfZ7iG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbpy75KwXz2yFd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Dec 2025 22:07:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DCDB060156;
	Wed, 24 Dec 2025 11:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37593C4CEFB;
	Wed, 24 Dec 2025 11:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766574446;
	bh=U0pJLDYpdoyfRuX5bQi2tjWSMSkAm6l36+A48xMAHWk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pdvfZ7iGYSicTsPNzDo1jo03WIoQkI1odWyCOyC6bweEPIHVjk7GSdhMtnfP06xxf
	 noDIdvaZRqCanxes4oeLqVeeUwvPDYF24eG4QL1ZBGexos9YWw1Nzke0FJC8pqsXHQ
	 zESGmLjGh4zmVatmDStRkLqB34zeb2m1sEfBvYHQ71bKJCktJXvjcnJuWt1Ic5uDfG
	 TYCx7IPRAbAXc068IDoTAsFSZQL6qm+rDD41x4VSxIhcpq37YuFMBenrFppHDv/o40
	 4EKIa7jiiY+33fem7R02qkel+2vHO99IP+W8WbZ9GI6QJ4CsyBoS/ZJpVutHOZc6cZ
	 02vNqehW3mYvA==
Message-ID: <b7f7e968-a683-4e1e-8ccc-5dd19f0f15c5@kernel.org>
Date: Wed, 24 Dec 2025 12:07:22 +0100
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
Subject: Re: [PATCH] bus: fsl-mc: fix an error handling in fsl_mc_device_add()
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: dan.carpenter@linaro.org, ioana.ciornei@nxp.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 suhui@nfschina.com
References: <ad465fd1-4b5a-4fa1-b4fc-1ca7bd6fe5b4@kernel.org>
 <20251224105240.1588158-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20251224105240.1588158-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 24/12/2025 à 11:52, Haoxiang Li a écrit :
> On Wed, 24 Dec 2025 10:57:52 +0100, Christophe Leroy wrote:
>> Ok, then this needs to be said in the commit message.
> 
> I will add it in the patch v2.
> 
>> By the way I'm a bit puzzled by the device_add() doc versus the
>> put_device(), because it looks like device_add() already calls
>> put_device() in its error path, see
>> https://elixir.bootlin.com/linux/v6.19-rc2/source/drivers/base/core.c#L3716
> 
> I think this is because device_add() increment the reference in the
> beginning, see
> https://elixir.bootlin.com/linux/v6.19-rc2/source/drivers/base/core.c#L3580
> and if device_add() fails, another put_device() should be called to decrement
> the reference which is obtained by device_initialize().

Ah yes, I see.

But then all exit paths in fsl_mc_device_add() after device_initialize() 
should call put_device() ?

Then in fact the fix should instead be the following, shouldn't it ?

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c 
b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 25845c04e562..6d132144ce25 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -905,11 +905,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
  	return 0;

  error_cleanup_dev:
-	kfree(mc_dev->regions);
-	if (mc_bus)
-		kfree(mc_bus);
-	else
-		kfree(mc_dev);
+	put_device(&mc_dev->dev);

  	return error;
  }


