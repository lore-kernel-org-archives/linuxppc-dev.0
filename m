Return-Path: <linuxppc-dev+bounces-25902-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017FEC5B572
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 12:16:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNsJQ06btz2y1Y;
	Mon, 17 Aug 2026 22:16:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786966482;
	cv=none; b=iqIZeZr/xrkQM94pQOEc+CG6WGvk1XFGVYLWNgDSvI9StM7zmkDlQsKj+y4RWNt9gtZH7mQup56ldEmP6pBgKr4O1FfJjH4j2SCGcsBM5+8ow1eoJQ/6ZxYYKw+TuRG+cqjL2dBkPXgOqh7rSogLf3vCla51QsvMTB7/qxvmJu9fn20GTvf+mtOakFYRkc1mwVP1+dGA56wV9UgwMbxxXN0Qwrc7XCpHnv5vtIFxG2JB9oLyyZt1m+Q9Dccmg/dJQIKlrcz75NNyYXjKgMpJjdo8s6QCGNbLD/DQokAyR6GjWKzsiIELa6FDKy6jazZnEgEz3xbsUSIpouZbIZSVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786966482; c=relaxed/relaxed;
	bh=FjHlsmYEYzijKqgNs4Mx5SPcKYbT3PPdor0Bf0avHyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7c5Bb5guGGsHVZAqHrDnRDt67pzthbeTZGoOSN7pM7k0NTqsEyiFjYPtNLZoZbChnpJHMuMS56jABkSvx1vJwNZyHfuhL7Bwlt8gCuuVvonP9bu4dJ22xfek+y/x6UKy8MouPFoGn4Lp2XAGSuKvJZ3vxh4Ikmc22OA33MDTjn72HEr8kLVtooZpuC3uepJuOxvWthzcXZLPBcRwoEKeT6VnIW0hrLD/suqdUrsPWzXHkQQo0AmgEu42ApEf8ufqoqadGYWZ9o4AWnrAgTmNXlXDwXKtj6woT0+Xir85JihdHIDWM8/PlHbgmQuF5dJQ4lfx6YMY72vRtSdJujTOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cnp3ospn; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cnp3ospn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vz@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNrN207qgz2xy6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2026 21:34:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E226601E0;
	Mon, 17 Aug 2026 11:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201CD1F00A3A;
	Mon, 17 Aug 2026 11:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786966478;
	bh=FjHlsmYEYzijKqgNs4Mx5SPcKYbT3PPdor0Bf0avHyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Cnp3ospn5OkaQDkq5Itjxg8hE1vg3hKPqo3W1GsUtdWTAuWaglKlTfpS7mmzKn/RE
	 5L9LOcJFa5CKuT15jpEpNj7kWcSxhQ1OsCJuYGZFC5lmR5eosXS9tLP2Jn7lqiMFLs
	 453H6l686fx70UqrrPHtC9+BfnpTSws3cdb3olIZv5K0CRAKB6AYIHBcrMiVFelfYF
	 TyN88E+2IML5T0Mh+5enCkekscNd2AOX+GhmXU2IoQ3uRiMy9u67+tnCaFzc+W1kkm
	 oZ2xgOvlp7FHZmmLN1WdzPUbIqM/icgNPOTA4/H5yVtQ84DiIKga1pRz2u0OYXCcXY
	 CLWfYteKQ4ClA==
Message-ID: <c4047dcc-c0d4-4b53-aa89-a126d81445e0@kernel.org>
Date: Mon, 17 Aug 2026 14:34:24 +0300
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
Subject: Re: [PATCH 5/5] i2c: pnx: fix device_node refcount leak in
 i2c_pnx_probe()/i2c_pnx_remove()
To: Liu Zhenlong <dragonliu2018@gmail.com>, andi.shyti@kernel.org,
 chris.packham@alliedtelesis.co.nz, jochen@scram.de, maddy@linux.ibm.com,
 piotr.wojtaszczyk@timesys.com
Cc: mpe@ellerman.id.uk, npiggin@gmail.com, chleroy@kernel.org,
 grant.likely@secretlab.ca, neelegup@linux.vnet.ibm.com,
 benh@kernel.crashing.org, wsa@kernel.org, stigge@antcom.de,
 linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260815181204.2321-1-dragonliu2018@gmail.com>
 <20260815181204.2321-6-dragonliu2018@gmail.com>
From: Vladimir Zapolskiy <vz@kernel.org>
In-Reply-To: <20260815181204.2321-6-dragonliu2018@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/26 21:12, Liu Zhenlong wrote:
> i2c_pnx_probe() calls of_node_get() to take an extra reference on the
> platform device's of_node when assigning it to the adapter device, but
> none of the probe error paths nor i2c_pnx_remove() drops it.
> 
> device_release() does not call of_node_put() and i2c_adapter_dev_release()
> only completes a struct, so the extra reference is never released, leaking
> the device_node on every probe failure and every adapter removal.
> 
> Add the matching of_node_put() to all probe error paths (the three early
> return paths before clk_prepare_enable(), and the out_clock label which
> covers the wait_reset(), platform_get_irq(), devm_request_irq() and
> i2c_add_numbered_adapter() failure paths; dev is devm_kzalloc'ed so
> adapter.dev.of_node is NULL and of_node_put() is a no-op when CONFIG_OF
> is not set) and to i2c_pnx_remove().
> 
> In i2c_pnx_remove(), i2c_del_adapter() clears adap->dev with memset()
> at the end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
> removal")), which zeroes adap->dev.of_node before of_node_put() runs.
> Cache the pointer before calling i2c_del_adapter(), the same approach
> used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
> ("mtd: core: Fix refcount error in del_mtd_device()")).
> 
> Compile-tested with gcc on arm64 defconfig using COMPILE_TEST; no
> hardware available for runtime testing.
> 
> Fixes: b41a216dafe4 ("i2c: Add device tree support to i2c-pnx.c")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>

Reviewed-by: Vladimir Zapolskiy <vz@kernel.org>

-- 
Best wishes,
Vladimir

