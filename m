Return-Path: <linuxppc-dev+bounces-17830-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C088FCB61B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 15:59:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSB0x0lHMz2ySS;
	Sat, 07 Mar 2026 02:59:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772812753;
	cv=none; b=jD11TiWaPbO4a0KjCy9AufKpbRy9vvcsZLKPMaMuTSVQq52SZP018yYsoK8uKOID/xbhh1p46eHDeidxz4xIpGpkai5ZcRr2FV9rcdDfp6jK0QlJrHC3U3OBEseCVaK+wy3arz1FPQ+gsQeln1XlL3oDhDqZ+X9sX7Rc+U1k5ZRMULsznUTsflfBuztz9erLpjpZiLiQTTyCTiHFUvgBuJZ04IdH45f+cCqy+UpWON5dokbD40JOIRPxE+T/Mu561+FftnwzIEAas9TEhE5WMcktxJVhq2cnQw1zwOxRciGR0KxD3zaU5qji7RxCFYYrRpwKr6kXSjf/JbhTrjYk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772812753; c=relaxed/relaxed;
	bh=z1piXpiFHso3GGftRgQQooHaij0dQTWZjfWoc2FOYuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eu0fT2GXgzQH69fZG+X4xXszwb90loGcxGP7gF7Pu/8d7veMU6h2fiQcAxjgmFxaPGIj9n2MSL7RYQFjR7anaREtViaXKJtfy+aJnH1nLpTfkbL3f6Rp/BQNF6trefMcyBN3AQ3UxKuaBKP+mjaziucXi+lCUgaeow/v9wEi9RTmofWcnCn6CPr2qvAKKoq8PuUVWMBO9Ihz0mN1TI6VYrVv496TeqZMZKhFc94vBVYxdlLvgarZajHm7Th5c9KOLCpdnBVGjckkpAqTcr2s4/ueLZgAtHxGJwNY9E4jzMZE8sbEb7kEb9/DXv+yqbtFwh0W+T+sClhbadeLcL9isQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HA6DQXeb; dkim-atps=neutral; spf=pass (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HA6DQXeb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 454 seconds by postgrey-1.37 at boromir; Sat, 07 Mar 2026 02:59:09 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fSB0s3PRMz2xqm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2026 02:59:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=z1piXpiFHso3GGftRgQQooHaij0dQTWZjfWoc2FOYuc=;
	b=HA6DQXebmX82AC26V79kzT/UzLhiHVpv6hhXf/0TSWZCZJ2+y2Pm/AxFJqex8V
	1hKPWb7Xp931ZhM9K+8K0XGQesgS0bVet7fUyZGXTqkXonSJWpnfEoTx33fUCc2t
	KP5/MhnOrsm3ntlOXGRM/23buw0s2bS9TP121wvjnTTIE=
Received: from [IPV6:240e:b8f:927e:1000:3542:2c51:dbe0:7121] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAXltTi96ppp8cyQg--.6084S2;
	Fri, 06 Mar 2026 23:50:59 +0800 (CST)
Message-ID: <142343c7-2be5-4deb-8d47-42876a6df7f4@163.com>
Date: Fri, 6 Mar 2026 23:50:58 +0800
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
Subject: Re: [RESEND PATCH v4 0/2] PCI: Introduce pci_clear/set_config_dword()
To: mahesh@linux.ibm.com, bhelgaas@google.com
Cc: oohall@gmail.com, mani@kernel.org, lukas@wunner.de,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251101162219.12016-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20251101162219.12016-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PCgvCgAXltTi96ppp8cyQg--.6084S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4UJr45XryxJr1ftr1DJrb_yoW8Wry5pr
	Z3Ary3JrW7GFya9FW7GFy2ya45Wa1kJFWrJr17Kwn5Zw13Zry8ZF9agry5AF9rJrWrXw42
	grs2gFy8uw1qkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRDrckUUUUU=
X-Originating-IP: [240e:b8f:927e:1000:3542:2c51:dbe0:7121]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwQ832mq9+QQ7gAA3K

Hi,

Gentle ping.

Best regards,
Hans

On 2025/11/2 00:22, Hans Zhang wrote:
> This series introduces auxiliary functions for the PCI configuration space
> and simplifies the read and write operations of the AER driver, reducing a
> lot of repetitive code.
> 
> Patch 1 adds pci_clear_config_dword() and pci_set_config_dword() helpers
> to reduce repetitive read-modify-write sequences when modifying PCI config
> space. These helpers improve code readability and maintainability.
> 
> Patch 2 refactors the PCIe AER driver to use these new helpers,
> eliminating manual read-modify-write patterns and intermediate variable
> in several functions. This results in cleaner and more concise code.
> 
> ---
> Changes for v4:
> - Introduce pci_clear/set_config_dword()
> 
> Changes for v3:
> https://patchwork.kernel.org/project/linux-pci/patch/20250816161743.340684-1-18255117159@163.com/
> 
> - Rebase to v6.17-rc1.
> - The patch commit message were modified.
> - Add Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Changes for v2:
> - The patch commit message were modified.
> - New optimizations for the functions disable_ecrc_checking, aer_enable_irq, and aer_disable_irq have been added.
> ---
> 
> Hans Zhang (2):
>    PCI: Introduce pci_clear/set_config_dword()
>    PCI/AER: Use pci_clear/set_config_dword to simplify code
> 
>   drivers/pci/pcie/aer.c | 29 ++++++++++-------------------
>   include/linux/pci.h    | 12 ++++++++++++
>   2 files changed, 22 insertions(+), 19 deletions(-)
> 
> 
> base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58


