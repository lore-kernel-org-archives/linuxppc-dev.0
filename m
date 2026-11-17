Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1258606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMkUCbEK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jT6jc2Fg8z2xqD;
	Tue, 17 Nov 2026 12:35:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794879300;
	cv=none; b=CfdDw6TkkBXpwMuGyEJ9+ixYq44SeORuSwa9ArTeZxozURAC6LVepGn9XZW5WfdE+7RO3PKageoLt2Q/uK83E8UiaFvroZc0r7mwLa+AQA11Akuf8pokpQv/YVY+GkDTxe3GOvdYJtsX6TtpI4MpFvLK3aBp5PVoudFzZRYuZW+6GOUz2R1LsLhQqKIYxXH4CD+QBBVq/1dKrtsukO4zqb0uC/Iu5f+pGKdl5z5M1ho9yf+TmIZGt7wGHIKcCa4nzNHe5lFevs9JRq/IgLEoKQ7uLJ6LHb6qlQqWpGTWzVvLk1WnpnZc6JiI3CzQXVaWg+XVRgMF+M9E4nqFSYWhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794879300; c=relaxed/relaxed;
	bh=ysjEDt5HoKgDoYFx5rznlp/gWKwa0VyiQqK5FFOHBY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmgH5Jn+HR1dDitD8oZuqqQirmNhteQyn7ilBqEMbGLQWXpuTqxW5dbTIoq1oC2xWD4Cp5ZYCqU5l+6CQB4vkBAmzSNbcVZDO01avaaR0oBQPJ0jFNoEz8ukQzyeQi/qrn07XCQhSLxAx1cCnBpxTnKeXGWDoDkzWW3bXYrkd6ehsWKBWOYJAave1VLFfmumR68vT3WNo7oxeUGXTumDYyBQWK3PcY4366JL5GfHslW81IUr90gxbJcIGZ0hhXPLfxfJqhO3XSmhiNaCgqLAx1A8N17j52GEIFtc33eUyw9zcF7kKgZELPE8FxyKyBNWKz98UqfYF/dLMyyrhBfV6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMkUCbEK; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMkUCbEK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jT6jb1jpXz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 12:34:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B9F35447C7;
	Tue, 17 Nov 2026 01:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088BC1F000C4;
	Tue, 17 Nov 2026 01:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794879296;
	bh=ysjEDt5HoKgDoYFx5rznlp/gWKwa0VyiQqK5FFOHBY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AMkUCbEKbOS9C0CDs/i9YlEmKU7EQE547L++MYdxH8RUAV6M+fANTIHWzaJW7AFB3
	 QmJKoYZtR2AImcl5mfJW3ZCDkdz6eM3DKLDrp242r7r2QCX9DlXLtXMYX3GR31j0h0
	 G4g4sy2vF5CSh50DXDASpXv1yo5S1F17qnLmbWQSMyFbU8P2DJO3F/XVK00bzpmK+w
	 MSJHgR5mvlCjKnCPqMXbyC5mWUicYe7kxyYPKwllGC/mH+y9NtL8f02v52zMlRwPiD
	 1vhFqejEvTVyj1ZunKOj1NbKUpwSMm2ZU7X51vCI+6ThIhjdjVvZUXusubsXtFAtae
	 PdVQ53gu2jAAw==
Date: Mon, 16 Nov 2026 17:34:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, chleroy@kernel.org,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, haren@linux.ibm.com,
 ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
 shaik.abdulla1@ibm.com
Subject: Re: [PATCH net-next v8 07/15] ibmveth: Add RX queue register
 helpers for MQ
Message-ID: <20261116173455.325fbf0b@kernel.org>
In-Reply-To: <20261109235556.60604-8-mmc@linux.ibm.com>
References: <20261109235556.60604-1-mmc@linux.ibm.com>
	<20261109235556.60604-8-mmc@linux.ibm.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon,  9 Nov 2026 15:55:48 -0800 Mingming Cao wrote:
> +	rc = ibmveth_alloc_buffer_pools(adapter);
> +	if (rc) {
> +		unsigned long ua = adapter->vdev->unit_address;
> +		unsigned long lpar_rc;
>  
> -	if (lpar_rc != H_SUCCESS) {
> -		netdev_err(netdev, "h_register_logical_lan failed with %ld\n",
> -			   lpar_rc);
> -		netdev_err(netdev, "buffer TCE:0x%llx filter TCE:0x%llx rxq "
> -			   "desc:0x%llx MAC:0x%llx\n",
> -				     adapter->buffer_list_dma[0],
> -				     adapter->filter_list_dma,
> -				     rxq_desc.desc,
> -				     mac_address);
> -		rc = -ENONET;
> +		/* A kexec can leave the LAN registered by the old kernel
> +		 * (see ibmveth_register_logical_lan()); do not leave its
> +		 * buffers live in PHYP. H_PARAMETER if none is registered.
> +		 */
> +		do {
> +			lpar_rc = h_free_logical_lan(ua);
> +		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));

This loop is repeated in a number of places, you should probably factor
it out.

>  		goto out_free_queue_mem;

