Return-Path: <linuxppc-dev+bounces-18062-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E23AFD0651
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 14:19:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWCYq6s42z30hP;
	Thu, 12 Mar 2026 01:19:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773238783;
	cv=none; b=WFMDUS8SHRnUNG+gWp3eJ4EwDnX+FZN1th5m/0XCeqmU3yE46IgiBWkVTOFkeIqhe+0E91n5AQNxSjQKWSxPJYn5ilPbe+Y/kPH7X5lEx7fr0o3XIE2C9Euax6bcsc9XG8V0gcBfeEFIwD0GAjNc2V+6tjbdVvUa3AnDGgm6YLcKIHzbfzv2rxXNST9v3wXidHpo5WRMxjXii/z+W5afiThJZHo545tnT7dkHYNvjtfGxfpkcXlzD1x0XUYIMko6ZhMUPMfpcT8yDPhSX7YlaF9sZ9BDSo9cGi/KHWZuLX7VrO5A8ibPoeqmFvKoDFNAHVAWPO4MiybJFsBf0eJJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773238783; c=relaxed/relaxed;
	bh=zxwsUH5NxYcd7eAP3KCFt8MlCNMC8DPCTU47ttb2/Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd8R3Y1Q5FGm/jHdX/y2AOjGF7sl2a4g5tG11ViCOLKrwxLS0OoyH0v5Gy6YETILsH5so30S1/nWVvqAc/WGEIqXI3kx3wQd+pDOcaUoB8TsCKTSYI+/nykBd3uSANjbIsd5mKcUy9Bx2YrCBlxfIK8tUbhsVFsSFptMzxJGD1rK97CCo07bxgSUO1xS8uYoI5PhWy6EiaOoERDCIrWk9inFKWuW8fhPRtNxl9xmws02pqUQSDD9/FgFWeMHyKaiD8WgMlv9TVdWg4t/P8FC3xohdrWABK9dDgWPRKZIW9vJQjqTtQhW9jXYaafAq4JrVGSf6606F1ReQGnsY06cHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N7wEdddL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N7wEdddL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWCYp642kz303F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 01:19:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 37CA36012A;
	Wed, 11 Mar 2026 14:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B07C19424;
	Wed, 11 Mar 2026 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773238778;
	bh=4rspw70lAXPaOuNzAVTpF3DEdU6++Hs8qNZtz9nP5TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N7wEdddLJiDMDeFh9fRzF+0AA/jXYO0kBBjbzURmzLnta3Acyr9OALzeu3zxpMSGz
	 ZrjGvpciOTY4AuauFhvmS3Wy3ddEbuZETYuOSCzwcRrzzlbKYSdame0ojFrSrdvEBJ
	 vVrnwnGdPwejHqQtOF00rp1scWaAMrnV3hg8RYSkNXHwB6li0T02sarbLcTMsTlC6Y
	 IjWWtjC1KHZZmC7w1VB9Lg2H0+V6dAXzPndwp63I3ERDG8PIVGK/5eQnXaVXcglpvC
	 /MayvYHwZ7hYB9D7x0mFv4UhX1G4EdDHcCODregjf3maJAIZNh4R4ysMR3ky/ZNwNb
	 4gJZ0556zKdUw==
Date: Wed, 11 Mar 2026 19:49:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v6 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <hof7aknmmkeug6et7cj3zrwpj3cu77bofqllm25numelratbg6@pfiep2xaqlbd>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
 <aHoh1XfhR8EB_5yY@ryzen>
 <aHokdhpJUhSZ5FSp@ryzen>
 <tujurux64if24z7w7h6wjxhrnh4owkgiv33u2fftp7zr5ucv2m@2ijo5ok5jhfk>
 <aJ743hJw-T9y3waX@ryzen>
 <lakgphb7ym3cybwmpdqyipzi4tlkwbfijzhd4r6hvhho3pc7iu@6ludgw6wqkjh>
 <aLmcO8ukT-CDZMuT@ryzen>
 <mevtdhght66tds7yhmr5a6xg5a75fb667b6lyvguoxqexmc74p@mroqidhzptxk>
 <abFLGRn9TYrsycRs@fedora>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abFLGRn9TYrsycRs@fedora>

On Wed, Mar 11, 2026 at 11:59:37AM +0100, Niklas Cassel wrote:
> On Tue, Mar 10, 2026 at 07:07:39PM +0530, Manivannan Sadhasivam wrote:
> > > 
> > > I tested your patch series + your suggested change above, and after a:
> > > 
> > > ## On EP side:
> > > # echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
> > >   sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start
> > > 
> > > Instead of:
> > > 
> > > # FAILED: 1 / 16 tests passed.
> > > 
> > > I now get:
> > > # FAILED: 7 / 16 tests passed.
> > > 
> > > Test cases 1-7 now passes (the test cases related to BARs),
> > > all other test cases still fail:
> 
> (snip)
> 
> > I guess what is going wrong here is that you might be rebooting the device
> > *after* restoring the config space in 'slot_reset()' callback. So all the
> > previous config space contents would be lost and the device would've started
> > afresh.
> 
> I'm confused.
> 
> # echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
>   sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start
> 
> Will not reboot the device.
> 
> 
> > 
> > I don't think we can restore the config space after rebooting the EP device,
> > because host has no idea about it. It can only restore the content after
> > recovering the device through platform specific means.
> 
> Am I missing something, or why are we talking about rebooting the device?
> 

Sorry, I just went with reboot scenario since I remember you referring to it in
the thread. But I must admit that I didn't read your repro steps where you just
write to the 'start' parameter.

But I did test with toggling the LTSSM alone on the EP and was able to execute
the test successfully on the host. So I'm not entirely sure what is going wrong
on yours.

I need to look into it more in detail, but I do not want to block the series
from getting merged due to this.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

