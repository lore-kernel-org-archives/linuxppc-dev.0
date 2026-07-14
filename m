Return-Path: <linuxppc-dev+bounces-24220-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE092C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 13:15:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h00Ch2NLDz2yRl;
	Tue, 14 Jul 2026 23:15:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784034912;
	cv=none; b=POMU5VLacrpDGDI4sikvku9nr0cREJIdffX10ZrGrSphj9pGxYEytwLOZXegpy+cn1BPWtmu+nVP6fTqQhWW8eIehVlI9UbUcVYw7pLQItYxP4uGoCvlceJflb6/A1r4ubod34eYUM5QKzgXhloGqKxrMZOAdQfyJCIgG/wO/W8aT0YQiU8Q0Tlw7hPs5clTp1ByPWJL7N53C9CrPmpvQmbj+toSesqxGfe4oFhNjKzoCufAXBwwZ6WLhRB22Gs/iqpcmyuSOGx1281HOQjIzQheY4CrQbHHAOa+fH3N7qKp7XxKjDfepY8rhnd6Y1uMeHGMFBgeWS6rrvOvWDLZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784034912; c=relaxed/relaxed;
	bh=NBo8CYi3Y72SAdTjIf2wrjxpjS/L+HX8XmDUHz8O1ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUCKLgvpIN9deyzTQCC8uS58Ug4EDof6CleaW9Le/D5m8XDRw1sdcjEDHELbIakBVASZf5C92u+Ay9FUsLoeS6x0C0gy04KkrRuSSj8a4f7Q05GqD/nP+kp/znqZz3piI9oZjYD+1gf226XH9Utn8FzGVukK/WH0FrU1AgOmnXrzwHRBtF12aXCjwxwuf0GVJ9iVNX2sdFppfsOnMxMQ6SQfs742eU7oAyaC2rIvIaYIdOOf7wJwhVFDaRk2zMYG/nOitf+AonTDzSOYVpoHWYjC+JMTtHXcWQ4eteTh3T32KrAfSTUHrNRn+HHhCcktl+eDBHMeijDsw/qzlQi/TA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITK9trsY; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITK9trsY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h00Cg11hTz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 23:15:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D016640A89;
	Tue, 14 Jul 2026 13:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBC11F000E9;
	Tue, 14 Jul 2026 13:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784034908;
	bh=NBo8CYi3Y72SAdTjIf2wrjxpjS/L+HX8XmDUHz8O1ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ITK9trsY7zH++52/IA5fwEbrrJfbKgz8On2K5PUCSWTX5ziv09P/H3w5XrK3V6cls
	 giF2rwY1waEQSge3WHRJax2ZL/xmvMmQEqdMchuusSTVMxKYL/mMTk8VoWaWG4EGf8
	 8BSGa7kWltC/1l8i3YXSjOunWry85KucAqOxhaUNHNf6ZoN9cyvP3kdkSaHBw0bLmc
	 EoeZ2nXxQXGRs9iXfrjAasSdvD+3qePddubbOGBF/8bRc/fKqqSmW5QHej/iNSuy1F
	 MJw03vsujVu188gHxa4FX4/yj9yD2xlBCkUC8EB+q+S/lQyJ6VkdSEvEq//Vb4eJWy
	 l9JNG8IRfqmdA==
From: Simon Horman <horms@kernel.org>
To: mmc@linux.ibm.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v3 15/15] ibmveth: Fix MQ RX poll and shutdown hangs after queue resize
Date: Tue, 14 Jul 2026 14:10:54 +0100
Message-ID: <20260714131053.1844276-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706193603.8039-16-mmc@linux.ibm.com>
References: <20260706193603.8039-16-mmc@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ibmveth: Fix MQ RX poll and shutdown hangs after queue resize

This commit fixes polling hangs in the ibmveth driver after queue resize
by skipping over bad correlators instead of retrying endlessly. It also
ensures NAPI completes when the interface is down or being disabled.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 50a332ab83fd3..eb84b4e5f69fd 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -2959,8 +2978,23 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  			__sum16 iph_check = 0;
>  
>  			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
> -			if (unlikely(!skb))
> -				break;
> +			if (unlikely(!skb)) {
> +				if (net_ratelimit())
> +					netdev_err(netdev,

[Severity: High]
This isn't a bug introduced by this patch, but can the unvalidated packet
lengths and offsets from hardware descriptors trigger an skb_over_panic()
here?

Further down in ibmveth_poll(), the driver reads length and offset directly
from the hardware receive descriptor and passes them to skb_reserve() and
skb_put() on the reused SKB:

    int length = ibmveth_rxq_frame_length(adapter, queue_index);
    int offset = ibmveth_rxq_frame_offset(adapter, queue_index);
    ...
    } else {
        rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, false);
        if (unlikely(rc))
            break;
        skb_reserve(skb, offset);
    }

    skb_put(skb, length);

If a faulty hypervisor provides an abnormally large length or offset,
skb_put() will extend the tail past the end of the buffer, which triggers an
skb_over_panic() and causes a crash.

Should the driver validate that offset + length is within the known buffer
size before modifying the boundaries?

[ ... ]

> @@ -3034,8 +3068,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  
>  	ibmveth_replenish_task(adapter, queue_index);
>  
> -	if (frames_processed == budget)
> +	if (frames_processed == budget) {
> +		if (!netif_running(netdev) || napi_disable_pending(napi))
> +			napi_complete_done(napi, frames_processed);
>  		goto out;
> +	}

[Severity: High]
Does calling napi_complete_done() here conflict with the NAPI core contract?

If the polling loop exhausts its budget (frames_processed == budget), returning 
the full budget after calling napi_complete_done() might cause issues with the 
NAPI state machine. The NAPI core (__napi_poll) will operate on the instance 
assuming it still holds the NAPIF_STATE_SCHED bit. 

If napi_disable_pending() is true, the core calls napi_complete(), which will 
hit a WARN_ON_ONCE. 

If napi_disable_pending() is false but !netif_running() is true, the core will
add the NAPI instance back to the poll_list. Since the driver cleared 
NAPIF_STATE_SCHED, a subsequent interrupt can trigger another napi_schedule(), 
causing a double list_add_tail() and potentially leading to list corruption.

