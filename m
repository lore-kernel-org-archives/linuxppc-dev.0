Return-Path: <linuxppc-dev+bounces-19248-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC77CC6B3F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:17:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn16j11Thz2yk6;
	Fri, 03 Apr 2026 12:17:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775179053;
	cv=none; b=a37CLVrBjpdE5X4E39h9qwgELxmqiEXRJqy+5PteS8dOUYKMhu3+fXfuiSM5grFpsORcJyPE7SswrO9sNeI/FnmlMUAfrpml31peE9FdbbdghGcol4Q36InDS8noAkHwQ7tvImhsrYJoUXoR7mqTKebXzGck1apzuAIa6+1NpXIMh4oGX9avp+HfbZjnIgc5CNHzqxHt5KWNOVt/IMK+vbbIsvNB4OubCYa33cmKTTYJyaNVaBUqXQwihiW4mKp3laqzH7Dk1ydxPxaSWxw3otsOjdSJMtgrcrJOud8lMWkH5Y559mt0kTvRD4+17mxHtqqXASMhhN1hREwbkPvxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775179053; c=relaxed/relaxed;
	bh=f0pN8aUKmhnmAGTXsEU3mqDCvjefLUa2M7SMOn3aBe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDSrwWZ7uYmC70MhjrBeagGxIm98n4bXde8y17sF3TWxUPS4ugyEjI6YBzAUjWnP/jCLsfvN9n/jZYl8v8xsFsXIUYXCLHbQniNsr+Tq5FUTwfru3g0pD/GGXod3wT5y1FcrC5WOJRV9BlusyY9ccj6GFWncAoohWi+k/SEam7uovPD+1/wUmZs9PUnMdEgQn9vfuYfzROi2S1kghzPnNYGygPNQ8kIMR+E8P30vtS7JPFkDMYDbV3mhNmzFu32H9N4EbVDNY/zfKzVVbE0PoRV5Rk62KdQmrs6CGzgS2K/Uc72NccMsVhhjblXVVSmoq3V6wXxSO4wp4Z/S59wRvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fvBhotl1; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fvBhotl1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn16h3QDQz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 12:17:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6242160126;
	Fri,  3 Apr 2026 01:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1375CC116C6;
	Fri,  3 Apr 2026 01:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179049;
	bh=IU9zpV+fhw/AVGDmlIS+prrr3RJ46Y3yClO3R5MZOJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvBhotl1IEvyAFT2T/qEv9rf8dWP9JNEuuEOqn3jzMpIQEMFOgSoIlSrwyysbQJH6
	 4ZdUqynMTLHMzK1zM5kGAHNMAaMIVREs5KvkRHA/m7Vl1cFyB1OsaDjbKB72LGmYO8
	 NvoiXno04iCv9rJ/c/rN1K0DjJEPOWRwgkY3hOBcdws4kU5zx2P/8KdidjDb4eOd2d
	 Wkroi3b2cTFnMOunZ5dbeRfzIcwt4klfueHVLjUfXCVM+MVYSyOIhoH2RUiGKB4dxW
	 NU8QdrlH6J1+lTqPGxVX15h8OmVA+ETYG4W5EDjYM34q7HZeDAvjT/uFvWObt4pU0x
	 Mm9Aly2jvUauw==
From: Jakub Kicinski <kuba@kernel.org>
To: wei.fang@nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 net-next 04/14] net: enetc: add basic operations to the FDB table
Date: Thu,  2 Apr 2026 18:17:26 -0700
Message-ID: <20260403011727.1795379-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331113025.1566878-5-wei.fang@nxp.com>
References: <20260331113025.1566878-5-wei.fang@nxp.com>
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
---
net: enetc: add basic operations to the FDB table

This commit adds FDB table management operations (Add, Delete, Update,
Query/Search) to the enetc driver using NTMP version 2.0. FDB entries
are managed via the command BD ring.

> diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
> index 916dc4fe7de3..a9f3e6cbf422 100644
> --- a/include/linux/fsl/ntmp.h
> +++ b/include/linux/fsl/ntmp.h

[ ... ]

> @@ -116,6 +158,31 @@ static inline int ntmp_rsst_query_entry(struct ntmp_user *user,
>  	return 0;
>  }
>  
> +static inline int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
> +				      const struct fdbt_keye_data *keye,
> +				      const struct fdbt_cfge_data *data)
> +{
> +	return 0;
> +}

If CONFIG_NXP_NETC_LIB is disabled, will returning 0 here cause callers to
falsely assume the operation succeeded and proceed to use an uninitialized
entry_id pointer? Would it be safer to return an error code such as
-EOPNOTSUPP for stubs that have output parameters?

[ ... ]

> +static inline int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
> +					      u32 *resume_entry_id,
> +					      struct fdbt_entry_data *entry)
> +{
> +	return 0;
> +}

Similar to the above, does returning 0 here leave both resume_entry_id and
entry uninitialized while signaling success? Since resume_entry_id is
typically used as an iterator, could this lead to an infinite loop or other
unpredictable behavior in the caller if they interpret the 0 return as a
successful read of valid hardware configuration data?

