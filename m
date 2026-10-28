Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD8606A31A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 02:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=qYpt+RJw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDrT84BT4z2xg9;
	Wed, 28 Oct 2026 13:11:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793153500;
	cv=none; b=HWGnljlJocxlonsta0J7TsEcV9Wld4gZynetJGTVq/uBrSKagfSH/4IbRSO7mzf+vFTbtsRsTbM2hG2FkUiIBwpjRp4v1U1biis5ct3BM9RWI9HOOEvi+pubrIFbgdItclu/6nDPAIOi7Vn1UJyTOTlo5+L7nCmen+daaeCujC9H8LqNHcvOvaBf9hIUIBef2+PzUbM/tu+p+GR8pEroU2O1ZTsiXVGtF+aKZJDfXaeDUsU56cO/y+RxX7fomMmFG1wPCDBZjXoWbI8A4gI5ijXC/eWsD/Wez0RJI31C1y/RF2nxrVscC6/Lx4oMEw8I4D2EgaiDVAIx7CFHDpzW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793153500; c=relaxed/relaxed;
	bh=dRf6oI9OjFWY1cb4Veae1z+HSgCdbz4ogw7DjgHpwGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9nUECrOMJ22fc40fEGUeGouXWLfjmDjgzzFVOK9yvTPJ9IYduvrrkJRpyQXYSz8EVLQYffYDinO5EjE0IeN/S9CZmBie7/OXSyF4/1CpViSlCsMy/FmYUh5oNBc+73lCIlJsVaXYMePvN8ys70tX1py4IuoC+fKcDKQxrqS1/aei5a8vQRqGw1YIVoarBZxBvtMQVY5G6ka5nLFrL7QRHWtZCl+cYAwHDdDna0gLrspSijQq1fVAN/qyQ32kT20XoylaiGt6rlOP0vocg64Sh0Dq8dkybalHfjYG/G5+8cIFPTd3jDJl9/u+FCfotfolK2ZUvTHNBEzxaOaM7tIag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=qYpt+RJw; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=qYpt+RJw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDrT46vpxz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 13:11:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=dRf6oI9OjFWY1cb4Veae1z+HSgCdbz4ogw7DjgHpwGM=;
	b=qYpt+RJwRCF0KX/+Je23SE2RJtdg8sWfRlTJBYkgQjazqIosKZrPy7BmiKqm9R
	lMeSBT6H/smy5N567aYskw3soxO2lZEjFu6+3moV22mJgNt2lfVoA1/U+RSmdIP+
	eNPBKt+kFxH/QXb7xPiQMm1mkDGc1IgvPyHBAIFAj2h4o=
Message-ID: <9a761c42-9edd-48f4-b3a4-c275b603cc3e@163.com>
Date: Wed, 28 Oct 2026 10:10:33 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] PCI: dwc: Cache PCIe capability offset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, jingoohan1@gmail.com, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 sophgo@lists.linux.dev, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261027231534.GA520774@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20261027231534.GA520774@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD33x2jWeFqyfNqDQ--.48494S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4DJr17Xr4kCw1xZw47urg_yoW8Xr4kpF
	Wjgrs2yF4kXrn2vanF93Wj93W7AF9Iy3y3CanxG34avr90vF4IgF40vrW3GF9Fyrs29r4a
	yFWjq3s8Gas8AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4UDXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7ASSNmrhWaRq6QAA35
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/28/26 07:15, Bjorn Helgaas wrote:
> On Tue, Oct 27, 2026 at 08:28:11PM +0800, Hans Zhang wrote:
>> Hi,
>>
>> The DWC PCIe core and its platform drivers repeatedly call
>> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
>> PCI Express Capability structure, including in paths that run more than
>> once such as link polling, suspend/resume and interrupt handlers.
>>
>> Add a cached pcie_cap field to struct dw_pcie and a
>> dw_pcie_get_pcie_cap() helper that performs the lookup on first use and
>> caches the result, then convert the core and the 14 platform drivers
>> that use PCI_CAP_ID_EXP.
>>
>> After this series, dw_pcie_find_capability(..., PCI_CAP_ID_EXP) no
>> longer appears in drivers/pci/controller/dwc/ outside of the helper
>> itself.
>> ...
> 
>> base-commit: 4352b8aee98005853aa63f57d6377282de17a33f
> 
> This does indeed apply cleanly on 4352b8aee980 ("Merge tag
> 'i3c/for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux"),
> but that's pretty old and not really useful any more.
> 
> PCI topic branches are typically based on -rc1, but of course v7.4-rc1
> hasn't been tagged.  Until it is, you can use pci/main as a good base.
> It's currently 17bb0e2f6c80 ("Merge tag 'pci-v7.4-changes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci"), so
> drivers/pci/ in v7.4-rc1 will be pretty close to that.

Hello Bjorn,

Will rebase on pci/main.

Best regards,
Hans



