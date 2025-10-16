Return-Path: <linuxppc-dev+bounces-12941-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454A4CCD194
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Oct 2025 07:53:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnKvr2k0gz2yyx;
	Thu, 16 Oct 2025 18:53:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760601224;
	cv=none; b=AjmTjbnmiYm0c+oMRV0vdopH85x6ZrY9XTF5CkrT9HYCWSMtzH10OCd7Q+YHuUuu33xCsSB+KkjKwWhKQuTLLp7XCMgNsAOBDtNPolbikyZGSGvqisKOYLS+Jc3l+tLe7m37lgeStLWr3aPKoH5ThOiXjEG7k23wxnNUCRngsmbECOZVv9OW7qDAdRNxDGLeXR525/VyclHG1CwzPnGjWlj1J06krLYMv8EwSK4Ff4w8menLQqennq4gkKq5LOPfy+PavHLekUWjcaCOHkoJNY36WadMipiTRK2bpYcYrTcdywayOjY4l9EA7IKw36lRZ1fdVboY4Hm/LRj1WgJmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760601224; c=relaxed/relaxed;
	bh=N9vXUVvY/tt8WEhxZu/0rrC1AJfLxqkIoKGtV+d9NWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHL1UwxZg7wLusuZlP0UH9RI7K6wyPanbuwPVBhd1I/Lhu2s/6W1Wk4hBYhRsZyCTy8aH0JFRbDFDthbZcduu5kOGbRgSFp/rIvwZtE1yUiM69vkTPAdJAzmSn4PlAkQ9CQx36aQIcy2zkUFivORnQ+z8DsxTY3joNC9mhYTu+/ikw58BERf9jMhSssTZvkfTfcKuUYyXxS0zcU0AzAFR/ty21LAs9gQT1lhf/uSI7RjL9qNlelLWMlffXlNlrZiHbQKEWnZDRrA/8RchjiutiHLYoOLLj/kWKZSRlhEB62taDSNrDa9gBwp37I7cC0UcNxBY6R5gDnDNUKs7NY/cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rjK/FlTf; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rjK/FlTf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnKvq5d88z2ywC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2025 18:53:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5278D45890;
	Thu, 16 Oct 2025 07:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B175C113D0;
	Thu, 16 Oct 2025 07:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760601221;
	bh=wjntWI2HpwORrYYs/RF4PW7NcPU8Dt5MGy9i5SPIAJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjK/FlTfEWsznCIvFMtEQIQFS2ySLSXHPdSz2VzphShnoqE6oUQVK9EMqzjQsz/7f
	 VDjvB5CmZjTjYADtWoSuikbC2eYJIOXa2vFVDwTumxOLvtahAT5uKA202s3Xy/fxiK
	 wF9e6Nctpbi9V+V35n3OVle/lBEWHdaB+2e48ZlBQ8WpXaj9aRNOrssinYUlz2QE5/
	 29CxiJudPNSNgwNs/Qy3irHCj1fpGJcmpFhdkX0XtE4oWudL2yAHqlYT1tuZq9DDAg
	 PW/7G1WPL7TE490QYaaso7p81n/Otwa+s0bl/bIMt67ULBDUfdPEjnAAmMnR/+4qiO
	 f0Ef0Luf1PdSA==
Date: Thu, 16 Oct 2025 13:23:27 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, mad skateman <madskateman@gmail.com>, 
	"R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>, 
	debian-powerpc@lists.debian.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <oholvk65xtm5wlyfbx7vsi4zpmbuvih3kqblfcvt2yrw6qr5wo@zzpghtqp6cg6>
References: <A1E3F83C-3AE8-43B7-9DCB-6C38C94F8953@xenosoft.de>
 <48F07B75-2DF3-4E9A-BC22-ADF1ED96DB06@xenosoft.de>
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
In-Reply-To: <48F07B75-2DF3-4E9A-BC22-ADF1ED96DB06@xenosoft.de>

On Thu, Oct 16, 2025 at 09:36:29AM +0200, Christian Zigotzky wrote:
> Is it possible to create an option in the kernel config that enables or disables the power management for PCI and PCI Express?
> If yes, then I don’t need to revert the changes due to boot issues and less performance.
> 

Wouldn't the existing CONFIG_PCIEASPM_* Kconfig options not work for you? They
can still override this patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

