Return-Path: <linuxppc-dev+bounces-13060-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6FACCD199
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Oct 2025 13:58:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cqxq05Tf9z303B;
	Tue, 21 Oct 2025 00:58:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=176.9.242.62
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760968716;
	cv=none; b=mSMw91dV+IlZUyyi9pAauKUnAsmfvWsvkoIikzl1nEVrkDl2jP8se+XUVYUDqKnVuJJpJhhaHt612NT+uE52I6HnvNk4rNNJTbKV+ylfC5u/nptFiUlpsyQfiv0a9oDbTdVtEYrMiSUGq7lxKXEFmSlj+poAUGJlsyoPxt5YfzLqk/WXlZYDlkREJCV/f8PrOWk0zgayZKlODeiPz7L0SUaFGDOlSTHrNSsedhjH2J2gHu1w1Wf2s8o+GBQeTB7kZi9vGZlE+omYMlSp2i8zCpCPu385Pr3ehn9/XBBHYFUMMEtxLzUxJCthYR2ZuqRkhT4NZqb/4rgQnikG649/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760968716; c=relaxed/relaxed;
	bh=hhYtZI+kWuP7g5kbQAT+mXwKUUpb3pMecIy8PF4lsrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A62JFmEJABmExGdYPZ9SnMdwBRn5L5Vndn1YDLRkP9CIxcsiG1ZHoVqZNCH47OOQjznX5ufXYZHd6s/oiq4JpfQWuWJlEORcjjtb53Pbqp3LyrvKSFg5l72uscY8w68jrtgel2jnRPQsGzAiMMGZdSNEhSPC8GuEdgBkoRakSsXZBwRvODgRxMqqksWGhEbDvt3fcxOeEixbvqtiU7GfLR0wjnPMp0s4aiBRFc5lCzvpjLm7ibbLmqABIccXgiwwmi+nOsB6docKcl3vzcHutH9Ul7r8Dx5imc6e7LHZulWDCVlkQMbr8D8YwafBSlEtSf55P0dvlY3EFdbYD5LbDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=176.9.242.62; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org) smtp.helo=bmailout3.hostsharing.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=bmailout3.hostsharing.net (client-ip=176.9.242.62; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cqxq00m8jz3000
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2025 00:58:36 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id F199C2C02B96;
	Mon, 20 Oct 2025 15:58:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D719F4A12; Mon, 20 Oct 2025 15:58:24 +0200 (CEST)
Date: Mon, 20 Oct 2025 15:58:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6 4/5] PCI/ERR: Use pcie_aer_is_native() to check for
 native AER control
Message-ID: <aPZAAPEGBNk_ec36@wunner.de>
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-5-xueshuai@linux.alibaba.com>
 <aPYMO2Eu5UyeEvNu@wunner.de>
 <0fe95dbe-a7ba-4882-bfff-0197828ee6ba@linux.alibaba.com>
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
In-Reply-To: <0fe95dbe-a7ba-4882-bfff-0197828ee6ba@linux.alibaba.com>

On Mon, Oct 20, 2025 at 09:09:41PM +0800, Shuai Xue wrote:
> ??? 2025/10/20 18:17, Lukas Wunner ??????:
> > On Wed, Oct 15, 2025 at 10:41:58AM +0800, Shuai Xue wrote:
> > > Replace the manual checks for native AER control with the
> > > pcie_aer_is_native() helper, which provides a more robust way
> > > to determine if we have native control of AER.
> > 
> > Why is it more robust?
> 
> IMHO, the pcie_aer_is_native() helper is more robust because it includes
> additional safety checks that the manual approach lacks:
[...]
> Specifically, it performs a sanity check for dev->aer_cap before
> evaluating native AER control.

I'm under the impression that aer_cap must be set, otherwise the
error wouldn't have been reported and we wouldn't be in this code path?

If we can end up in this code path without aer_cap set, your patch
would regress devices which are not AER-capable because it would
now skip clearing of errors in the Device Status register via
pcie_clear_device_status().

Thanks,

Lukas

