Return-Path: <linuxppc-dev+bounces-24661-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0996CC44532
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 16:58:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h50ng0cv4z2xyj;
	Thu, 23 Jul 2026 02:58:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784739510;
	cv=none; b=V9UGpW5Cewm0nX0gjJQFz3jkzENADW6b36b9vTBkaQt2zRmLE410yxufRoFMEngcRn5uh/dFa88Qhz8GEyAFN3j+TT5InDMaAiNNd2cP5T9Ak5y/NHsPn/ydnfiZBG2M9eZfBNdGr/o0XaR7OCgGKKUCzMMdJgj5hT9ly5Nbyks1YbdMH/M/lDRoWeH6uPlQTs1LwbjV6Ip42wntwkA/dFl0mQ1v/L8cnI11YlDIPAML36KDgWv1TAqQbDnkKaM36mCpZCoCRincqA7HCSJoNXwyY5zvl5jKs/bavmnNc8bS34e/c1G6ERnCTfcmWIPASK5chIl5BLsGEOeu7C23/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784739510; c=relaxed/relaxed;
	bh=ORcTfzsf5GrCi9Q3hLpA456nnpz7dyxlllQU2fcWOxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONHdX4FoDSkEPCRkyTst6DLWYIMe7yqxUhfyHLJTd5Hin3VRy4M09JYvahivrtiFgKcdH0UpbOcpMD4KcSKGvj/L1R0F8SgcIzRPrmtjW2mvKEe7zd+oJqjl6yrYM6bj6x8H+n9kW9LfLRi5o99y4JFj6Y92DFTOjIr6T41zQjTyWvYZyMQ+wjFX+6N08MKhyok/beR2q81j+atB7lR82IHxzkhxDtVlSXTIUVZekw97QrjREoa3uARinr4eJ4LrqRQnUtbsBIrKbWl4rk+ybTlW56pdILSmqO37Ri1Gmj5Zlu3CVXEwYtgATKHT7Bt01R+Bwerpd3oOioMifaeiVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIvDOIDn; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIvDOIDn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h50nf0Whvz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 02:58:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9732D40662;
	Wed, 22 Jul 2026 16:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000221F000E9;
	Wed, 22 Jul 2026 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784739507;
	bh=ORcTfzsf5GrCi9Q3hLpA456nnpz7dyxlllQU2fcWOxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hIvDOIDnWwEP+dvo1sTONdc2eh83tQFRowa8Kpg7NO7euoaj+d3n/4IcnopONuwmr
	 ujmTxmWdRvaUguSjaBdPp2ceuz3wha+Q0l6L6tynwbYefJZtwUEYhqpMBkEQl7Wfu+
	 FASTzDhcE1euJEorHfddcUJAljZXNkpwB/wZh4dUHcARozVrJL5UDz6G+ZHWFthDAK
	 435Gu3lvtci/RS4IQ4mnCWEVt2O6W8UhZYIbBlW0XsK+YBZp1gcGb/6mQF1zQz59Db
	 aMa7HAL31X5ju2qRnCRpXOrXdNpZK+QgD0cMDKKA6w6+9w+FxaTeXpdDBef2c1sac8
	 WVC8hjPd4TDeA==
Date: Wed, 22 Jul 2026 09:58:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Woojung
 Huh <woojung.huh@microchip.com>, Nick Child <nnac123@linux.ibm.com>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Sabrina
 Dubroca <sd@queasysnail.net>, Arun Ramadoss <arun.ramadoss@microchip.com>,
 UNGLinuxDriver@microchip.com, Michael Ellerman <mpe@ellerman.id.au>, Willem
 de Bruijn <willemb@google.com>
Subject: Re: [PATCH net 0/3] net: don't read an unset MAC header on the
 raw/qdisc-bypass TX path
Message-ID: <20260722095826.1685b943@kernel.org>
In-Reply-To: <20260713194010.54642-1-doruk@0sec.ai>
References: <20260713194010.54642-1-doruk@0sec.ai>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 21:40:07 +0200 Doruk Tan Ozturk wrote:
> On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path, skb->mac_header
> is left unset when ndo_start_xmit() runs, so eth_hdr(skb) resolves ~64KB out of
> bounds. Commit f5089008f90c ("macsec: don't read an unset MAC header in
> macsec_encrypt()") fixed one instance; these three are the same class in other
> TX/.xmit paths, each reading eth_hdr(skb)->h_dest. On TX the L2 header is at
> skb->data, so use skb_eth_hdr() (a no-op on normal TX where mac_header is set).
> 
> Found by static analysis (0sec); verified against source, not runtime-reproduced.
> Confirmed by an independent cross-check that mac_header is unset on the bypass
> path (__dev_direct_xmit does not reset it). More siblings exist (sja1105 shared
> TX/RX helper, atlantic PTP path) and will follow separately.

If there's one known source of such strange packets we generally try to
fix the problem at the source rather than hardening the whole stack
against bad packets.

Can we make SOCK_RAW + PACKET_QDISC_BYPASS set the header offset
instead? (If not the relevant analysis should be part of the cover
letter).
-- 
pw-bot: cr

