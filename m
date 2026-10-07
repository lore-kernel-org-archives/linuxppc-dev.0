Return-Path: <linuxppc-dev+bounces-28998-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2CDCA6002
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2026 17:39:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0L3G0N2gz30Bd;
	Thu, 08 Oct 2026 04:39:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0c:1:1599::15"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791394761;
	cv=none; b=T3J5Lsx8famQCK1iB+K4VbP3p1N4jOjrXSGxHKsvO5B/8+YZAUzT7i8xPeWBe7/qx5o0FnwBS/XREHigIzsYUNMf0UoZAGHY+fXPrWBkRdsev/24tjib8dn5UkfrFGHfFZ9yDUIgK+3unCJWtZtfXbpwuh+8CAqCFrp4Ue/tQhPeZAvn6M2mMoLq0xDiCrn07KG/RKnyIBufwpx70lEWMjr0Ijl99bjycgaRUdNXY2zp4r5La8b3AdKKGOVJ7KOitdOxwZbdzL7kNAsepH6emDbxabR0rSabQcrg9ELbA6g1na6UNxXj9afdtcbNDdB9TbRtuUWgQUNPKCLt3cN0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791394761; c=relaxed/relaxed;
	bh=fw9RpSrpy3LQeF0T3TLjUcAEHYl7KsfPvPvrmgasn9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6jc+3KUioRZ+R1cvav1l5x6U5zUbWm4dbCduSYvWbl9hbPB998f6DjFycWz9dywqe+MeQlJqxZaaJs9gmir90e2GO1nsD7q8dRCfwuB2qs87oUQ+MGztZzyli0J5kYyCjqAnmK44v9Ye6VVpq4D0bAN5x10Rlma6HLVjwD56JWACNia9QYrHyWPwuy76dWsFMGf5HWK+wEzLSELVDusALyX4WiSirh0v1n67zuJi1yZX49FuwIxBn4R5TGoNLyuoFZrunI3YCuxua/falqHTbKwgyC1RMIKhQ8t7TLLi1xS/FzcBt2Zt47t43PyVKm0iVLgBe8XnT2Aw4uCL2BEbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=tpizUNvP; dkim-atps=neutral; spf=pass (client-ip=2a01:e0c:1:1599::15; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org) smtp.mailfrom=free.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=tpizUNvP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=free.fr (client-ip=2a01:e0c:1:1599::15; helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=lists.ozlabs.org)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0L3C6hmbz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 04:39:19 +1100 (AEDT)
Received: from L30177.local (unknown [78.242.246.191])
	(Authenticated sender: vjardin@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 6F68C780371;
	Wed,  7 Oct 2026 19:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791394749;
	bh=O/57xv8xoLkRWnqnHdElm1MmZ+p6nyiKXa3vcY+o/wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tpizUNvPtMKaEV4wbsM4GTgWFqsNqaTVu7N5L0esAWkEb+e5ReUKaWyb8H8YEr2cV
	 4zX97LdIRqgeQHy6I9etOl51HQDAz8g4F7Il8vnMlCqrwG2OLM/d4jNsxDJoDawAf9
	 vhBK+WmzR8lVlnjPHPrVR1/QX9UNnbT+Tqp5JfBmuHQ0oBVfQ39EkuxMZsnGPx+lc0
	 stFItnG0QDdJ2KYEoILf+D/8gyHD5co0NlQ74FZaWpcFf+xrGsVJpMwu2p73UjCTSj
	 uouTZgPP35jlREN1vVa+jQxJgUt8R1HiKEtRhqasJH59er3DPJnd4jKJofY0KQ/t3Q
	 pWq9tXUyZBiZQ==
Date: Wed, 7 Oct 2026 19:38:47 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>, Rob Herring <robh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: layerscape: async probe by default
Message-ID: <asaDp512mFdyCvXs@L30177.local>
References: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>
 <arqSa0OwMd1Bx_Ex@SMW015318>
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
In-Reply-To: <arqSa0OwMd1Bx_Ex@SMW015318>

Hi,

A gentle ping on this one lin paatch: is there anything else you'd need from me
to have it applied for v7.4 ?

It has the Frank Li's Reviewed-by, Sashiko found no issue, and it still
applies cleanly on the current pci/next from today.

  https://patchwork.kernel.org/project/linux-pci/patch/20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr/

Best regards,
  Vincent

