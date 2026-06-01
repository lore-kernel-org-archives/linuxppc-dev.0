Return-Path: <linuxppc-dev+bounces-21824-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CCACD6E55
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 22:01:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTnx208hcz2xKh;
	Tue, 02 Jun 2026 08:01:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780351301;
	cv=none; b=GXFblv2WdxBXYUFenzPsnCAZtvJkLR/EGHSCEweUE2c71b9/ItFE5e4/1kcivuo1aXGsukkzMwdUYSEHMs/isW5eJ5dnz25B0oaHqBHifLXs8EnYJoPAVjh2rWMwb40p5JF9DJfpB8I+6xAzKtF+JiaWnSOheNE0ZDo/A6mNuQQnuw4rxu3MSnfQa3YyRMJGfdaW18b1aqPiCBqy57okIk6gZjBN/FvrvdnkZzhs7SHyn5fdq+54Zh39gSKCO8yYVqG+upGygaZxf2AZo8/6QGAyvewFEr+qbV4qHcWE/EiZdIzxDEvy3NS0cE95MsLKY3nAvhCCyhSMbm+5lCzcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780351301; c=relaxed/relaxed;
	bh=6lqJ+fUrWkQKTv1XejGOcMluJh3tC7dfDM5eIytOFBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi9Lu8AVShLPIOI5NA4vHdcMet/KT8+xL9m8Atu/nHEC4n5o5NpPiOLcWzGyddxEPqo8/xSiNTUKSyzwg0QeLlmVKE1Nr668YaU6BpioRxhy7GN7WevC8ADDGRSEAoharLzE0ubf0mPBvxW3D+8eK1ZUhJ9dB/6LDfJrKe8rbUXtO76XIsACwL9WBCHuAH8p1lPsEhdI+OCSjwtYZyljgpdHfwDZulOxKTSyPjqpCid1978rUQsjiqbrt456va6FGyRAIo8G4vT6V0srrSvKynA3sMUiP6PIYaPnUDuWg5gD/c4n7dEuLlK4PZ3rD1x9RWadc86TWpURMDZWNy1TvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTTmRlZX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTTmRlZX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTnx06kVjz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 08:01:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DC5814189E;
	Mon,  1 Jun 2026 22:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5BC1F00893;
	Mon,  1 Jun 2026 22:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780351297;
	bh=6lqJ+fUrWkQKTv1XejGOcMluJh3tC7dfDM5eIytOFBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eTTmRlZXuCRMHKe9NVIfANBMwLkaRDgS0BHyW53oIUHFrHck6S3HNXXF85vdMF68Y
	 qUlSerHqUj8pGN3BJ/SJLlvKtxy8D6ics5QgvjRYjqlcM7GNosX1oco9PNjf9nj897
	 tkEb4wlZUII6Ti/KvrYSaXcAGS18Czh8dndVijg3LrbF8MdLzrl3Ct1qkZm5B4mAhy
	 UKxjum1XrewJ6vxp1heEZcdzU72IY+zM+mR06XtXTU1Hky0ecYGmXLB67ROTeM/bnU
	 RetEs3+uWdc8P6Y7Af7rJwRLPRqLtZtt0YQis5ILVcBmrG0a2i8hgNKCz3w55YtHzp
	 lGAqwKelZ7usQ==
Date: Mon, 1 Jun 2026 17:01:37 -0500
From: Rob Herring <robh@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, saravanak@kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc/prom: fix /chosen properties read from wrong
 node
Message-ID: <20260601220137.GA54006-robh@kernel.org>
References: <20260510171353.1406018-1-ekffu200098@gmail.com>
 <20260510171353.1406018-2-ekffu200098@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510171353.1406018-2-ekffu200098@gmail.com>

On Mon, May 11, 2026 at 02:13:52AM +0900, Sang-Heon Jeon wrote:
> Commit 60f20d84dc81 ("of/fdt: Rework early_init_dt_scan_chosen() to
> call directly") changed early_init_dt_scan_chosen() to be called
> directly instead of via of_scan_flat_dt(). After this change,
> early_init_dt_scan_chosen_ppc() does not behave as intended in either
> case below:
> 
> - /chosen(or /chosen@0) exists: early_init_dt_scan_chosen() always 
>   succeeds, so early_init_dt_scan_chosen_ppc() then reads properties
>   from the root node (first iteration) instead of chosen node.
> 
> - /chosen does not exist:
>   - Until commit 064e32dc5b03 ("of: fdt: Honor CONFIG_CMDLINE* even without
>     /chosen node, take 2"), early_init_dt_scan_chosen() returns -ENOENT
>     and early_init_dt_scan_chosen_ppc() returns 0. So of_scan_flat_dt()
>     iterates over all remaining nodes. Not a bug but unnecessary.
>   - After above commit, early_init_dt_scan_chosen() returns 0 and
>     early_init_dt_scan_chosen_ppc() returns 1. So it reads properties
>     from the root node (first iteration) instead of chosen node, same as
>     the chosen node exist case above.
> 
> Instead of using of_scan_flat_dt() for chosen node handling, first call
> early_init_dt_scan_chosen() directly to handle common chosen node
> properties. Then call early_init_dt_scan_chosen_ppc(), which is updated
> to handle powerpc-specific chosen node properties.
> 
> Both now look up chosen node directly to avoid reading from the wrong node.
> 
> Fixes: 60f20d84dc81 ("of/fdt: Rework early_init_dt_scan_chosen() to call directly")
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

