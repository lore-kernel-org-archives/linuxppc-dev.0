Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C7C606A33B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwdrxRgA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJjth62vQz2xMQ;
	Tue, 03 Nov 2026 20:28:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793698124;
	cv=none; b=WjG5rfHBx45//Lxo5eJNUQTDLmMflwnPvq9Zpru1M0Zl0U5m8WtZhZezg9LVSrmAuGr+M5rt2SWGsmeA3/bBtKJzwoQ1og8jiyU3asL45IeY52irUGpmZSu9UI+V+C7fRm2nN/Ool7m09IdE1YIE91YTaX3Hjhs9mowTmYTwyMZ7kYTql+7hksxSqk93AP42M1AQ4VxLKV+cBReU2gYu0u1TS19zL29kpUTTuDw4see9r4EEDY0DoZd+zPzQE7R1P5nCfIsNODe+v1AqC5NnJeEbsd9G8z2fMI8PvbGTBhiiKChputvOxKktoktcpAYbeOyGfaxg2aWchclcRzcB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793698124; c=relaxed/relaxed;
	bh=djWeyKAmzvHumcW3vVwjMEgaKbSeFuhq5krXPWVdimM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgspxodind2rWQEqTJrzFOMR4K5ts/UIvmmHdMBvmpkSlu3wz5pDu1d5X1vxHXgxEbmQ94QBnyXBO4UOoGXYNm9KWrcbxDVvPfydzkSAcsPG8CR8FoCgDVsIiz7zY9/zhiblrVTlGCQCTmENu2qMJ950KCCnrsx81pdj/J0ee5nHXdSxH4rL97iBGmg3zrrlbaazGK3dh4yUuSCAtC0UAZYfQX72BNqs5uNV0eZ0ekjv5uq7A3k2fWS6n9PVa7/YE3bgfH0iOCFaMontF6ZVVt/ILeT1+G/mDrIAug6CApIEcghENohzhl6f/o1nNHgS8/yvdPAH5mlv5LESQu6jtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwdrxRgA; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwdrxRgA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJjth06xcz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 20:28:43 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 62F9E601EF;
	Tue,  3 Nov 2026 09:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE901F000C1;
	Tue,  3 Nov 2026 09:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698121;
	bh=djWeyKAmzvHumcW3vVwjMEgaKbSeFuhq5krXPWVdimM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MwdrxRgAc6Qd5scsbKxMGJWQ1NZsemtG9tJpvjgYmsEq8/wbKHlMLBykRB7H4Ouyj
	 SqbfRwogiBRc7VaPb+WqNrO90/Onb/upJO/YzlxXyT9gk3EYyH9d8pVOCzjy8QqwZD
	 YcWgEJ7WEUtJ9TsY4E+QCDRsA/mz9W+NJsaDOvCFggn6LPbCh3z1Af8gPgZBH592HA
	 Mz/YOxT+7HWBlFR97Scl+cQNQLJYBvXXhnwpr36k7SjQeR0YJmvLM1C4zeGQ4uKx5h
	 FN0UfvmabFK8UHqaSo0NSSIptNub5/ApF183td0afUslG+wnOvO9FjnnDZtTQiVdcs
	 5dMx1HeczN76A==
Date: Tue, 3 Nov 2026 10:28:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	maddy@linux.ibm.com, sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: vendor-prefixes: Add WatchGuard
 Technologies, Inc.
Message-ID: <20261103-rebel-vanilla-mink-e7c04b@quoll>
References: <20261030125024.612396-1-lefteris.koutrakis@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030125024.612396-1-lefteris.koutrakis@gmail.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 08:50:20AM -0400, Lefteris Koutrakis wrote:
> Add the vendor prefix for WatchGuard Technologies, Inc.
> 
> Signed-off-by: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


