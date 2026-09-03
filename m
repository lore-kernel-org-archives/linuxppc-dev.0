Return-Path: <linuxppc-dev+bounces-26502-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A03C624D6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 23:38:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbbdc2ywqz2xfP;
	Fri, 04 Sep 2026 09:38:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788459034;
	cv=none; b=MyynUh8g6W2qIZoF/iCPMHVzjjZ9slg9gTgZxiOAUDcFOlHf5y8qnsgO2Hc4TDvSXjqZbfzI20wO0Lg6QgLkAoXLnaM04v+lhXnqrQ2tiS7ACR10m5kVnFiF0TnSy6nb2Fxv4/r5xh24S8bM9zJWZqTZ147ilR/HKp75bd8wzsM45oF+LONJeFiLzy/9l+CPHk25Gfutz5YQFnoJeQwfY6mTUbMPlk//lIM8ckT+8E0HqJ6u7FG0ln+YO07sOMiVt9/eVu9+kD9g/vJjGJYydrD0PjD2fs4tZAvgJoF/RpPBUDXt6JT/FHtW+QrMGjL8sTRs6W7XGI8mxY49LcfSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788459034; c=relaxed/relaxed;
	bh=NlRDybBs4oFnFdw0mKBg+OGXTcovPntU/gWkRhWZePI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=auDrY3C7hIiDx0lXi3p9xsgGglgKNdDc4zhPa57+ohTQAgUFtxmhVbyOt6vLAbCLaQoPTauXXlUB1ypmNeiwADz1P7NW072HpthqX/wft12dGyFVSou4kRGHzWQwgx/fgRrR693lG6tUcCj/cZwjxCd93lZ3PQEyyyLY5xaxJ5Vl2x8cFepZdClOFLyoVymVfbByz+2R9vX0hu9M6Uvol3TrDjTCMfaL+dblI3f71nlMqkqqI8KVB/HU/CvhKopm1LW2zKPQjm/BNz6LS3ajj2zsUat9CUE+JAlAinGjUqR+QqLf8AxDssp9lzWbo0n2tqZmbcz09vU/Y31RSMq5BQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+fHpkUm; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+fHpkUm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbSLx6ktLz2y2R
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 04:10:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1DF3B402DF;
	Thu,  3 Sep 2026 18:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0951F00A3D;
	Thu,  3 Sep 2026 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788459031;
	bh=NlRDybBs4oFnFdw0mKBg+OGXTcovPntU/gWkRhWZePI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V+fHpkUm+RCpDXrEErTITR2ZdmWdnnKWAZQV1V4kNjOJZtt/AhhtPdJajmKiN96tb
	 ideBysxS1OgO8MBm8CS0E2zX3QiYAX/fRV9JiJRiBTMuH5jgOM0JAwqmdWz9WTP+rB
	 JL8HAzUI40qilXNLmI+SDP/bLwQZW03aQXfzfql+cXXHoX4hL35PHEtdqskX+yPwSS
	 YS9jLqNZapNxwFK//fUuMjDiwbWr4nPYftZFXv6WzgpS0crwfVZSosQ0Lmp7gG2Zyg
	 63PPZJaNIWgylp5eqJQD+0WKIQFZhqNlyTdi672t4qVv2K6aedtETRrCC3lLkHHdTo
	 ipS6HlWF0T1fg==
Subject: Re: [net-next,v6,01/15] ibmveth: Add MQ RX hypercall wrappers and
 call definitions
From: netdev-bot+sashiko@kernel.org
To: mmc@linux.ibm.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Date: Thu, 03 Sep 2026 18:10:29 +0000
Message-ID: <178845902960.3394541.10707165174722907578@kernel.org>
In-Reply-To:
 <b87d16ce8e52934877234af6085e47a89571c9ae.1788102125.git.mmc@linux.ibm.com>
References:
 <b87d16ce8e52934877234af6085e47a89571c9ae.1788102125.git.mmc@linux.ibm.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 3

- [Low] The commit message body contains a verbatim duplicated sentence.
- [Low] kernel-doc for the three new MQ hcall wrappers added by this
  patch is inconsistent about the H_FUNCTION (unsupported-hcall) return.
- [Low] The in-tree perf hypercall decoder is not updated for the three
  opcodes added by this patch.

--

ibmveth: Add MQ RX hypercall wrappers and call definitions

This adds the PAPR 11.20.00 hcall IDs H_REG_LOGICAL_LAN_QUEUE (0x49C),
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE (0x4A0) and H_FREE_LOGICAL_LAN_QUEUE
(0x4A8), raising MAX_HCALL_OPCODE, and adds matching static inline
wrappers in ibmveth.h plus h_register_logical_lan_with_handle() so
queue 0 can capture the PHYP queue handle.

A few questions below, all on the changelog text and the kernel-doc.

>     Add ibmveth.h wrapper helpers (h_register_logical_lan_queue(),
>     h_add_logical_lan_buffers_queue(), h_free_logical_lan_queue()) with
>     argument ordering and return semantics matching the existing ibmveth
>     hcall wrappers. h_free_logical_lan_queue() uses plpar_hcall_norets()
>     like h_free_logical_lan(). Also add h_register_logical_lan_with_handle()
>     so queue 0 can capture the PHYP queue handle in MQ mode. Both new
>     registration wrappers use plpar_hcall() rather than plpar_hcall9(), so
>     they do not read unwritten stack slots. Both new
>     registration wrappers use plpar_hcall() rather than plpar_hcall9(), so
>     they do not read unwritten stack slots.

[Severity: Low]
This isn't a bug, but the sentence "Both new registration wrappers use
plpar_hcall() rather than plpar_hcall9(), so they do not read unwritten
stack slots." appears twice in a row here.  Was the second copy meant to
be dropped when the v6 rationale was folded into the changelog body?

> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index dff90a7d7f70b..cb0ea53491e6c 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -362,7 +362,11 @@
>  #define H_GUEST_DELETE		0x488
>  #define H_PKS_WRAP_OBJECT	0x490
>  #define H_PKS_UNWRAP_OBJECT	0x494
> -#define MAX_HCALL_OPCODE	H_PKS_UNWRAP_OBJECT
> +/* 0x498 reserved; 0x4A4 = H_FREE_LOGICAL_LAN_BUFFER_QUEUE (unused here) */
> +#define H_REG_LOGICAL_LAN_QUEUE 0x49C
> +#define H_ADD_LOGICAL_LAN_BUFFERS_QUEUE 0x4A0
> +#define H_FREE_LOGICAL_LAN_QUEUE 0x4A8
> +#define MAX_HCALL_OPCODE	H_FREE_LOGICAL_LAN_QUEUE

[Severity: Low]
Should tools/perf/scripts/python/powerpc-hcalls.py get entries for these
three opcodes too?

Its hcall_table currently tracks hvcall.h up to the previous
MAX_HCALL_OPCODE:

	1168: 'H_PKS_WRAP_OBJECT',
	1172: 'H_PKS_UNWRAP_OBJECT',
	# Platform-specific hcalls used by the Ultravisor
	61184: 'H_SVM_PAGE_IN',

There is nothing for 1180 (0x49C), 1184 (0x4A0) or 1192 (0x4A8), so
tracing the new MQ RX path with that script prints the raw numbers rather
than the names.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
> index d87713668ed30..08504d1cafd55 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> @@ -66,6 +66,145 @@ static inline long h_add_logical_lan_buffers(unsigned long unit_address,
>  			    desc5, desc6, desc7, desc8);
>  }
>  
> +/**
> + * h_register_logical_lan_queue - Register a subordinate receive queue
> + * @unit_address: Device unit address
> + * @buffer_list: DMA address of 4KB page for tracking registered buffers
> + * @rec_queue: Buffer descriptor of receive queue
> + * @queue_handle: Output queue handle on success (may be NULL)
> + * @irq: Output hypervisor IRQ number on success (may be NULL)
> + *
> + * Registers a subordinate receive queue with the hypervisor.
> + *
> + * Return:
> + *   H_SUCCESS (0) on success
> + *   H_PARAMETER if parameters are invalid

[Severity: Low]
Should H_FUNCTION be listed here as well?

H_REG_LOGICAL_LAN_QUEUE (0x49C) is new in PAPR 11.20.00, so firmware
predating it returns H_FUNCTION, and h_register_logical_lan_queue()
passes the hypervisor status straight back.  The later commit in this
series ("ibmveth: Add RX queue register helpers for MQ") does distinguish
that case:

	if (lpar_rc == H_FUNCTION)
		netdev_err(adapter->netdev,
			   "h_register_logical_lan_queue H_FUNCTION for queue %d (firmware MQ unsupported)\n",

so a caller reading only this Return: section has no documented way to
tell "firmware has no MQ support, fall back to single queue" from a hard
error.

> +static inline long
> +h_register_logical_lan_queue(unsigned long unit_address,
> +			     unsigned long buffer_list,
> +			     unsigned long rec_queue,
> +			     unsigned long *queue_handle,
> +			     unsigned long *irq)
> +{

[ ... ]

> + * Return:
> + *   H_SUCCESS - All buffers added successfully
> + *   H_PARAMETER - Invalid parameters
> + *   H_HARDWARE - Hardware error
> + *   H_FUNCTION - Firmware does not support this hcall
> + */
> +static inline long h_add_logical_lan_buffers_queue(unsigned long unit_address,

[ ... ]

> + * Deregisters and frees all structures associated with the subordinate queue.
> + *
> + * Return:
> + *   H_SUCCESS - Queue freed successfully
> + *   H_PARAMETER - Invalid parameters
> + *   H_HARDWARE - Hardware error
> + *   H_STATE - VIOA not in valid state
> + *   H_BUSY / H_LONG_BUSY_* - Resource busy, retry
> + */
> +static inline long h_free_logical_lan_queue(unsigned long unit_address,
> +					    unsigned long queue_handle)
> +{
> +	return plpar_hcall_norets(H_FREE_LOGICAL_LAN_QUEUE,
> +				  unit_address, queue_handle);
> +}

Same question for h_free_logical_lan_queue(): 0x4A8 is equally new, and
plpar_hcall_norets() returns H_FUNCTION unchanged on firmware that lacks
it, but only h_add_logical_lan_buffers_queue() documents that status.  Was
the difference between the three Return: sections intentional?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788102125.git.mmc%40linux.ibm.com

