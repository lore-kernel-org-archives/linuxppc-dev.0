Return-Path: <linuxppc-dev+bounces-29485-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CDCCC6B1D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 13:36:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4XKp2xKDz2ynZ;
	Thu, 15 Oct 2026 00:36:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791984990;
	cv=none; b=KK7K9rDpKY0ITBvsFC8yQndALxetBzRm4AtOD7ZLW7X/HqDO7nNdTm9hT29vzJ4Byt4DBgK4amrWt5FildSJUJiurb1Tx6sOHC9YL0psE5TbvV3um+XA9oPUkuYZnHPiHOzgDnj2+lR7MQRt8p5nsJWnby0NRU/e2e+/IL/Hzv3rOlW//iV0992AAtGACxBlVlprXL4evfMOQLt/TA1hg/7tezfvXB3tGJJ1yfQmn04gy8fwjZIuTBVcMHPyVJhPjCNFW974KzitcZKfnH05Qw4K7ANxNZ/y8uo3v0hDE+ypIQh0w2cfgTS7/4sMn8CLeMcL+J3PtJLD6dwzeHUBog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791984990; c=relaxed/relaxed;
	bh=/Kg+A+xrZdns/Gt1pdYxZtMAWhuUXTyI/p/XIqtBsPU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k/qV/OQDi461/nuIXwQ2XUvYk5aOdT9CQgpDK3JRF/itw2AT1JfHPY9E9qS5kQw22HZMseElk8hjkTZSLMSeSrkpGKPyJrIb8mVPMAsnOX7zw7YH4ArR8jrdwrvT5wC2L1KmZPWaRXpYBQOVYCnOmXx42pLRFSs7pFz106EYWxxfAV0tLvs8W4tAORdVD2OQ51qhD9xadrF5xZyCug/I2L4bmrjZB1YKwmwf5gpqJYHAJhEWu38/TvifFUwifG3UpzRIjqXPSH46XbUaKPtBHv0lS+Vb0J9AIMfBMb/MyxGT+F4JAupRRvTvvZoPLbvtPWngsvAFu45W7K3nEbcUkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOPD676B; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=1r9x=ie=oss.qualcomm.com=manivannan.sadhasivam@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOPD676B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=1r9x=ie=oss.qualcomm.com=manivannan.sadhasivam@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4XKn5gD1z2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 00:36:29 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5735642D84;
	Wed, 14 Oct 2026 13:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD2C1F000FF;
	Wed, 14 Oct 2026 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984987;
	bh=/Kg+A+xrZdns/Gt1pdYxZtMAWhuUXTyI/p/XIqtBsPU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IOPD676Bzqg8w3PuxzHaWtPLz4Fr1BGavAD4ZKepp+VzH02KwLCArkK2JUaJy5VYC
	 GmztHM30ObE8AOA7cr61nyWpFnePu7d8J3Pks9mbG8Tb1fkZ1FOCX+1hT+zV6IL3Wq
	 RYZcSCn7zwieXuGT55CchkP8tFFxchV6wQFcHoYf8P+NMSthRHY7V9RwETLF+mwieI
	 rqQdjhZfKPPDDnVAuRg5fS/cL+dRV/1SKhDEWvSmaRhjaT/wk1X+d0Ly1vCoG7Lu/1
	 lkS4LaGJfzGirFDwp5wMFysaLGVKAcJy5ssoszF04c6Bcp8X/x/iDClgu6PPu0XgAf
	 qEeSpJj+3eNbw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Roy Zang <roy.zang@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>
References: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>
Subject: Re: [PATCH] PCI: layerscape: async probe by default
Message-Id: <179198497640.63727.7466078377590135207.b4-ty@b4>
Date: Wed, 14 Oct 2026 19:06:16 +0530
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=303;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=bIScKkSRWfgKMp5sG5Isx9f9wVbp2+a5UTcxtA0Zz2o=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz4VV1pY342QQGnH8cFuzx4aa0fkm4cHc0AiK7
 +xJU8Y3iL6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas+FVQAKCRBVnxHm/pHO
 9XC+B/0ZHyHZhsScilHuWvjjib7MCUyNylWS37lr4ITYD4lMWo+3rdnEyjgV9vXzxi0hpamuRKq
 dquWb/DbCBlgT5aenUd7qndALvWtkTK//owK7DqOL/W4q4ElEKL7xqps5nrJghYX/vZtEId+dEl
 bRjtbwKSiuUZCh19G4f4P4rvwV1UmoBN7wYsWGkH52WEURKKAbPRTjl+Zpc2G8Dn+SLzceMOSK2
 CTlvecW3mPlO5rSLrxADHJuRiDsZatXJYqtv6wzfmS4Nzb0Q8b3l2bM77KOcBInbRzhTeiEHJo5
 WucunzBLhRoRKzKTunS3JDCh5K4sVhQ1WmsLA6CdqSodHGKU
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Mon, 28 Sep 2026 15:48:09 +0200, Vincent Jardin wrote:
> PCI: layerscape: async probe by default

Applied, thanks!

[1/1] PCI: layerscape: async probe by default
      commit: fd592bcb77f834564e787b8c809fa01f1af81731

Best regards,
-- 
மணிவண்ணன் சதாசிவம்



