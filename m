Return-Path: <linuxppc-dev+bounces-13916-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86470CCFA18
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Nov 2025 05:40:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2nvt0gSmz3bfN;
	Fri,  7 Nov 2025 16:40:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762494026;
	cv=none; b=GQ4pYzdm0XH/dwh96cF+sisMmZutVe6F6O+lWy3seNhB4/GaZoaqIUSVTAvxjOl3sYvjz5WctYmKzTPFyqGsnKw0XazSiJU9xHoaPSEHe//B1pWYjpIUQg7ylj4gAm++h2l6523eJo8EposIjI+T8u1gFZdmCG6Rx2qnZu6wDEIpDp2XNTSbd1ydiF3VfKaamZIazC9m9UgMxoAmQxyZR+IglHfgm7WmZY1GcjXQ/K+XcLCgBEKv/H58PMFr1pd1WrBNmHFPj8656A9WZj4+eGK3VUNFRgBh9wPHIgrcY/xhZdpZPVuOIqvnAJh+he0FhbJW0vUFbm05KRoPVIXUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762494026; c=relaxed/relaxed;
	bh=lgl/h7hz9SBkOLB2n7ove3teaPruuasB/AiWhYxVZpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+34zMm3pJ9AFkokRoyz+a2h5R93q77CqZxHw1FS6Jk6VDxrwh5JpEPjLZN9tRPM6ufpZ+TInGS4gFLNs8squW+w0lrLnSMvOg0+szSAREzXQYU0xnwfTcW4Cur6EpUFks5QyCdE29GrnGhBqINBBpjzC8s14+0rC9d2aazjPMHT1m9iybCE3DPofqm8cn9+7ywsXLJkOvGKqaEkNd29UpUMu8pqciuh7Apel7ByPDGWLA6EXbch/TiCkcupWFPP+r7EHu0rl6jPjvzA6iVdQomnAnhRhRSIol19gcZXu8OjICmbRL4b8SXgMsh9Q+hbXhwiU7Vt7b0okJVGO/O+QA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TuMf+jrW; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TuMf+jrW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2nvs1ZM7z2yrF
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2025 16:40:25 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 71C0243DCE;
	Fri,  7 Nov 2025 05:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36899C4CEF8;
	Fri,  7 Nov 2025 05:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762494022;
	bh=ceGgv8K81IVqsAHEgTkbu6ASQqAG7y9+ejl8bi9wq80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuMf+jrWo2PHK9xSv9izysbZmqH9adQi6j+5C4WnVmhail9Rk8637uliSrOuoUSMs
	 w5WqkphbBsnEaPJYNJs4vVh1DdiukiUTiRW9BHB7zUAFRerR/2zh+THjnsXniWVBXP
	 IzKS4/tLjYagocanwtqYFh3VJfqFJ6GyO6cUEyQMZ5YKaBQ8DOwIuZ8kSVT2aDfoz4
	 lZ3nUvicT+9F5s8e+dkD8TNqPMllRtUnOS1fLIW0RKBlAuQcu2KrV+KUrSvzWtiZ4T
	 YzrFoHWagRwMbq1+q1Zm60IUf/5/QJlcW6a9ojM78vBVRGZGFtAMU1/5OrYad+/oxs
	 FUMqOOAiNUO/w==
Date: Fri, 7 Nov 2025 11:10:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>, 
	mad skateman <madskateman@gmail.com>, "R . T . Dickinson" <rtd2@xtra.co.nz>, 
	Darren Stevens <darren@stevens-zone.net>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Lukas Wunner <lukas@wunner.de>, luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>, 
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>, hypexed@yahoo.com.au, 
	linuxppc-dev@lists.ozlabs.org, debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI/ASPM: Allow quirks to avoid L0s and L1
Message-ID: <ahhrvcqpwd3ilti5fzakaojzlkfqil6vscrqgpqt7hia3igszl@vykbk65y73fj>
References: <20251106183643.1963801-1-helgaas@kernel.org>
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
In-Reply-To: <20251106183643.1963801-1-helgaas@kernel.org>

On Thu, Nov 06, 2025 at 12:36:37PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> We enabled ASPM too aggressively in v6.18-rc1.  f3ac2ff14834 ("PCI/ASPM:
> Enable all ClockPM and ASPM states for devicetree platforms") enabled ASPM
> L0s, L1, and (if advertised) L1 PM Substates.
> 
> L1 PM Substates and Clock PM in particular are a problem because they
> depend on CLKREQ# and sometimes device-specific configuration, and none of
> this is discoverable in a generic way.
> 
> df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> (v6.18-rc3) backed off and omitted Clock PM and L1 Substates.
> 
> L0s and L1 are generically discoverable, but some devices advertise them
> even though they don't work correctly.  This series is a way to avoid L0s
> and L1 in that case.
> 

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Manivannan Sadhasivam <mani@kernel.org> # T14s

- Mani

> Bjorn Helgaas (2):
>   PCI/ASPM: Cache Link Capabilities so quirks can override them
>   PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports
> 
>  drivers/pci/pcie/aspm.c | 42 ++++++++++++++++++++---------------------
>  drivers/pci/probe.c     |  5 ++---
>  drivers/pci/quirks.c    | 12 ++++++++++++
>  include/linux/pci.h     |  1 +
>  4 files changed, 36 insertions(+), 24 deletions(-)
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

