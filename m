Return-Path: <linuxppc-dev+bounces-24805-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D17DC531C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 22:39:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6NFm4J0Vz2xLq;
	Sat, 25 Jul 2026 08:39:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784932748;
	cv=none; b=J1ZoVccmJkJbce4p061+wfvYxjlkTsOVkXqJTfavs8e7+21I4YrErju/LnwPpjyOjxPO/m78VsNxnuFcwJdk70yXHQFEia1MX8qAALp3oTWT0UnxZ2r5csB3FJ7sWGxQKHlHyLe3L7IZ2D7gJLj3Q8ux2SyKY5yBv5CMUt6+7lyHQhvzeSPgKMPRHvpAzcLHWcBki8FHzkyM4P/mcjjQPs45eTafx4fUYTKDSOS4mhHdUH195pPtPMWuF5krU1c8AGvmcUAXW3gcYGcBdvUEr26EKt6P1spRxgl77o5kLFy8ziDd3Nz95d0epyaPZ0uh9XLEstG5KDz57ymwH8+Jxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784932748; c=relaxed/relaxed;
	bh=vd175WF07d9T5qMoFKENrd0CE8q6aweRvb1UJK8MvvE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AmFFx2Da5VtK9wmfyGfcY/4PoR+v+etOA20Rre+IlHDexvQIULCWBmrKnaqNzWa5WOII1ijgN2yK+W4bEMF+hGYYMZ5DCD+Fc2Bg4A7woZWe8hJWd2VAUHUO1HObfhRyAUridWeQpGolNnXv2f7X+L4MR+gVBqp3NSIk2hmcdi67t7PaB8FthpgLXfk5aoUpKWy7fVx4z6l+YfOfghT36ebSyQ8Bg2Y9HYaM7Zz4GTU132/p5SfxcRTpH+fKhYTEV4HnsPLjqWoBvvSOYodmAFEvTi2oIXmNzhbNXPPRMKULRZB7JV6SVk+bAQINQfzHmqMOixlPPpW4Im4EG1tC8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTVJW/rh; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cTVJW/rh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6NFl4wPLz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 08:39:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BBDA24379C;
	Fri, 24 Jul 2026 22:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBF21F000E9;
	Fri, 24 Jul 2026 22:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784932744;
	bh=vd175WF07d9T5qMoFKENrd0CE8q6aweRvb1UJK8MvvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=cTVJW/rhxjCJVFPOgownsdU+uecYUKAX5qv8pljZp+HZ4HIVB8X6jEvh8zABoecm+
	 muk68Y9x4gmEHynyHn3qyyNqqGM7d6Ii+PAJbGp+YwzWCpFu7DBMf5PPJyL8vvpLbz
	 P36SOMqcTeYrlvVGWwMoNzqwuc+PC2NUZ2TM3AwHC9gh8T+/mVmTQU+uPTzUoW+l2p
	 ej0qht04ZUknI9H2I+ghIdEvnQ761iKHqNktxGN5H690gpEaX7UdeTmzL0BIHN9svB
	 BIUJ1L1d2AXXegYicjKGH/hButgZTVM2MSCdRqO/DhhjLyioXA36rw8hfw5TwnbH8Z
	 OOHbGsIWkgdPQ==
Date: Fri, 24 Jul 2026 17:39:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Qingshun Wang <qingshun.wang@linux.intel.com>,
	Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com,
	linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Terry Bowman <terry.bowman@amd.com>,
	". Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Arjun Govindjee <agovindjee@purestorage.com>,
	Ashish Karkare <ashishk@purestorage.com>,
	Jasjeet Rangi <jrangi@purestorage.com>,
	Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com,
	sconnor@purestorage.com, an.luo@enflame-tech.com,
	fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com,
	xin.wang@enflame-tech.com
Subject: Re: [PATCH 0/6] PCI/AER: Support Advisory Non-Fatal Errors
Message-ID: <20260724223903.GA1073029@bhelgaas>
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
In-Reply-To: <cover.1784905909.git.lukas@wunner.de>

On Fri, Jul 24, 2026 at 05:24:00PM +0200, Lukas Wunner wrote:
> PCIe r7.0 sec 6.2.4.3 specifies that certain Non-Fatal Errors may be
> signaled with ERR_COR instead of ERR_NONFATAL.  These so-called Advisory
> Non-Fatal Errors are masked by default and hence not reported by Linux.
> 
> This series seeks to change that.  The meat of it is in patch [6/6].
> There have been several previous attempts to support Advisory Non-Fatal
> Errors which are all linked in the patch.
> 
> The preceding patches contain prep work.  In particular, they ensure that
> the detecting agent and layer is reported correctly for each error (patch
> [1/6] and [2/6]), simplify logging of the error source (patch [3/6]),
> fix reporting of the TLP Prefix/Header Log (patch [4/6]) and move code
> around (patch [5/6]).
> 
> The patches have been tested internally, but further testing would be
> appreciated to raise the confidence.  Thanks!
> 
> Lukas Wunner (6):
>   PCI/AER: Fix mapping of errors to agent & layer
>   PCI/AER: Log agent & layer for each individual error
>   PCI/AER: Deduplicate logging of Error Source Identification
>   PCI/AER: Emit TLP Log only for unmasked errors
>   PCI/AER: Move retrieval of FEP and TLP Log into helper
>   PCI/AER: Support Advisory Non-Fatal Errors
> 
>  drivers/pci/pci.h      |   4 +
>  drivers/pci/pcie/aer.c | 250 ++++++++++++++++++++++++++++++++---------
>  2 files changed, 200 insertions(+), 54 deletions(-)

Applied to pci/aer with the intention of v7.3, thank you!

I noticed a sashiko comment on 6/6 but haven't had time to look at it
yet.  I left the series on pci/aer for build testing in the meantime.

