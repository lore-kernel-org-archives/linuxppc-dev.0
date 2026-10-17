Return-Path: <linuxppc-dev+bounces-29641-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52923CCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 19:08:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6WYK1r2Tz2yVB;
	Sun, 18 Oct 2026 06:08:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792264101;
	cv=none; b=ISca4gj4WVk565SH6MCZ8Urqj6MliOw9Fyq0aBm04Vdc/n2UI/NrlyKgzjO84wfKjqN+c0HTwgEc+M4gS8SDlvqra/sBErOkOecAjor28Pn9vmab540sNvrZ1LL7X5VKCUYbkBVPbsCQYqkFxWw0Dk2xykuFuVzOstyczBolwW3K7jr0WXQYhnQtDYGqxuS6eBW6y3nQqMhomTgnRLT3FyIwbrI0KiHcpcxEHMp0FkB3V1TCcpHIuDFp+WyoFT0C320l8kAZTfWtstDD6NaayFWKixYYnWmxu/t0muAY4bLgByr+bTTbVQt33M48EnW6NTUPisZfGsIaADlRziPGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792264101; c=relaxed/relaxed;
	bh=G/mOIqQ3KkbcwE/6BIg7vmmDag5v4XqH8R1sc966Lps=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ddgxsovKSopmEpvitaZhKbyTGA0XZAIVZLn3PhYKCGpYSa3fJP/GinGtGbc0ac/atj9MtLDMDJSrQYA52vH5QIYmMiGXmi0G3TuUFqdXuLVkyvi40FpBXMsYNupX8olMbUowP9r+I2s1EN2Wph/zufOrDhxHKe0OP/rj9xjx0PqZ4vm+yD9WnNZmP9K1REwmLzEZUBownTckvZIiax72BjylBDUm0QOLycG8OlIXjLWCCFC81O8Bu20Pkjly6nJi2pDdbfLM+BqbIIkd4kXc6uzrlHcM+u0o0pFs/SzXArQiUIjCYsTKQKXIAxyHlRUGHyd7BHkeB3zOMwn/PpwhMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkN60NM6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkN60NM6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6WYJ2ZtDz2xST
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 06:08:20 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C3C3B60D77;
	Sat, 17 Oct 2026 19:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535B61F000C5;
	Sat, 17 Oct 2026 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792264096;
	bh=G/mOIqQ3KkbcwE/6BIg7vmmDag5v4XqH8R1sc966Lps=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kkN60NM6LHUl0O+kDpN1UewsNK9q3AInYj1j6nMVzSrMU4G3OBgoFh0teHGAdNgsG
	 9C30Vf9HUOmz+sca9zzsxt0y/UchJd7ozda1rHshj5nYOOumJLTgK5waT6W9/ZNt/Z
	 Y6zezo0yKxHLorhKxwhCPPYCl/UeL5pgoBFP6agMngS0xQguYae9LDQ6AH1wzqvzka
	 92IGqVf3N/xgwL+Zn0Vz34kYRSTLlrKyBpkDcFN3m4IGLzpgVp6M+uxyKYe+i6Gt4v
	 nn7eNVySPYJjOtTfetuGf1i5d+jFGfuPTOxWV66eNwAepBkQ6i3PVjIQkIeea2zYd6
	 Mqqlvzw6aJqfA==
Subject: Re: [PATCH net-next v5 5/9] ibmveth: release the pool kobjects when
 probe fails
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 davemarq@linux.ibm.com, bjking1@linux.ibm.com, tlfalcon@linux.vnet.ibm.com,
 brking@linux.vnet.ibm.com, zdai@us.ibm.com, pradeeps@linux.vnet.ibm.com,
 ksiva@linux.vnet.ibm.com
Date: Sat, 17 Oct 2026 19:08:14 +0000
Message-ID: <179226409492.3135.9899803798328301877@kernel.org>
In-Reply-To: <20261013182926.30417-6-mmc@linux.ibm.com>
References: <20261013182926.30417-6-mmc@linux.ibm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] kobject: module unload race causing execution-after-free

--

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1890,6 +1890,40 @@ static const struct net_device_ops ibmveth_netdev_ops = {
>  	.ndo_features_check	= ibmveth_features_check,
>  };
>  
> +/**
> + * ibmveth_pool_kobj_release - Mark a pool kobject finished
> + * @kobj: kobject embedded in the pool
> + *
> + * The pool kobjects live in netdev_priv(), so the last put must wait
> + * for this before free_netdev().
> + */
> +static void ibmveth_pool_kobj_release(struct kobject *kobj)
> +{
> +	struct ibmveth_buff_pool *pool = container_of(kobj,
> +						      struct ibmveth_buff_pool,
> +						      kobj);
> +
> +	complete(&pool->released);
> +}
> +
> +/**
> + * ibmveth_put_pool_kobjs - Drop the pool kobjects and wait for release
> + * @adapter: ibmveth adapter
> + *
> + * With CONFIG_DEBUG_KOBJECT_RELEASE the cleanup, including removing the
> + * sysfs files, runs later from a work item in the kobject; wait for it
> + * so free_netdev() cannot free the pools first.
> + */
> +static void ibmveth_put_pool_kobjs(struct ibmveth_adapter *adapter)
> +{
> +	int i;
> +
> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> +		kobject_put(&adapter->rx_buff_pool[i].kobj);
> +	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> +		wait_for_completion(&adapter->rx_buff_pool[i].released);
> +}
> +
>  static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>  {
>  	int rc, i, mac_len;

[Severity: High]
With CONFIG_DEBUG_KOBJECT_RELEASE, ibmveth_pool_kobj_release() runs
from the kobject's delayed release work, not from kobject_put(). The
complete(&pool->released) here wakes ibmveth_put_pool_kobjs() in
ibmveth_remove(). Remove can then return and let
vio_unregister_driver() and the module unload finish while the worker
is still inside ibmveth_pool_kobj_release(), on its way back from
complete(). That CPU then executes freed module text. So rmmod can
oops in exactly the configuration this v2 was meant to make safe.

Signalling a completion from module code does not by itself prove the
signaller has left the module; that is why kthread_complete_and_exit()
exists.

Waiting in remove() for the final put is also not how kobject lifetime
is meant to work. release() should free the containing object rather
than hand it back to someone blocked on it.

Would it be simpler to drop the separate pool kobjects and create the
pool%d directories as named attribute groups on dev->dev.kobj? Then
nothing with its own refcount lives in netdev_priv(). The trade-off is
that veth_pool_show() and veth_pool_store() would need another way to
find the pool than container_of() on the kobject. How do you want to
handle this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013182926.30417-1-mmc%40linux.ibm.com

