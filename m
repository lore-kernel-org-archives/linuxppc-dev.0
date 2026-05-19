Return-Path: <linuxppc-dev+bounces-21180-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE92CD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 17:20:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKhJ30lZQz2xqv;
	Wed, 20 May 2026 03:20:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779211203;
	cv=none; b=XBaMD8cht74zD37dKB6mNOP3Opz0JOzyuUGdrz/RvVJSEhP/SA9sh8COvm5jgEWtV2BVCDA/U+nDYRAZh8Rk7VsYR6cAa4uAYclvRRp1QyxNO5xPYDD0+tz2D50BHGooUpsU35ogHxVgzm8Nfz1qMXNxTP2eYyvYhfGtABmDMAxMHycGJR6fOScF2xcorqSbI1aRVapg8HFG7sU1WdJxXKc0Ed9Gzkwb0jOj23JBDV8WQgx0YUn0NdyWbEajvpB2XcccIdJo9pnMv+B43HYWzovfFWo1H91EalMsywAGYNYBAvUjjiPPbg5d9dQSuc/mpkk8a93NOzgGWN/kwLuvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779211203; c=relaxed/relaxed;
	bh=rhhqEnu8La1VhGsX5KPnVeC0WvP0XJ8PE7da3JMkWtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3QKzUiVCv02oaOl09+94PNJl1hcQAZva1+RyRed6A0g1SUbAl1IOe5aYgS34eauRaG4edyzM+9Ge3NYPhTCXrfyiquACHFxgnzII9dF9T0DFNARXN6NmganHAwdL6DfL+fMUM53niM1tfiQYDdDnfuheo3OexbFLAOGt4hk+q/XGkBfPvU7dEd51qKq6hM3vGSe54hEin7Gv31yfNjvBGatNmc3zryc9q2JugsPxQQ0t6jQaBkm8VGUB4dsRnt+AndMCij1mkmJcO9NCfPdbNeLyNLF10YWQDHWhGbZfclnintTZisDcINk2/LluGwIms23McdZBKmnY236IsAdww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XbBBzI6B; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XbBBzI6B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKhJ20w7xz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 03:20:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E531442DD5;
	Tue, 19 May 2026 17:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE02BC2BCB3;
	Tue, 19 May 2026 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779211198;
	bh=PcQgZeciD6zTFbc/Al2Qw1LpZV+52E8Gj2OSIzC9Qss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbBBzI6BMmc2qi3CO/PJ03L/0BLjVUWyHeawfD9cL5/Zzfr6WScpP28XVy2zTPt2a
	 ljZxJD6N9ASkopYjKp67ifLM3nvk+x3bNgJjQ3DEk+H1XdQoY5pVyxFITJh/YqBggM
	 /7KGybNccUvfeB0gUVw/ZKhWVoQwjtBHNrtclXL7HSsCBMRekKdsE56dzcCpTohR21
	 p+DQfqk6jZLV2LDjGtesHbn1XRL0vzBGFqNoE6wXGIwVw8slCzZUQsO1BZgApb5mii
	 Cb0kl7/79jR/btL5zrqnIi3y47jE3yZzzRC0fdAju6hYf6U5Zf98CCl3/IBjZZJ0ex
	 NqYjdckOwMG0w==
Date: Tue, 19 May 2026 19:19:51 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>, Richard Zhu <hongxing.zhu@nxp.com>,
	Brian Norris <briannorris@chromium.org>,
	Wilson Ding <dingwei@marvell.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <agybt3onTAJO2Dl9@ryzen>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
 <abFMa6DCGGLUHddA@fedora>
 <dp2rem4gj7zhfgykvekmcrhq4ticm6m6ido6tbgflwzfcuuwkl@4wuxgle27eyx>
 <srdn3bspgwff7f7tnst7wzg4us4buifrv7o3ylo527hmuciyl3@6ioyrl6rfhaz>
 <abk3rU2EDKjkefUD@ryzen>
 <tgsh3cum6qxrqjzbdeqjsp6bf7cqedj7il77hww3oxecadndin@idjnwib7cz4z>
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
In-Reply-To: <tgsh3cum6qxrqjzbdeqjsp6bf7cqedj7il77hww3oxecadndin@idjnwib7cz4z>

Hello Mani,

On Mon, May 18, 2026 at 11:51:56AM +0530, Manivannan Sadhasivam wrote:
> > 
> > With the patch above. There is zero difference before/after reset, and all
> > the BAR tests pass. However, MSI/MSI-X tests still fail with:
> > 
> > # pci_endpoint_test.c:143:MSI_TEST:Expected 0 (0) == ret (-110) 
> > # pci_endpoint_test.c:143:MSI_TEST:Test failed for MSI1
> > 
> > ETIMEDOUT.
> > 
> > This suggests that pci_endpoint_test on the host side did not receive an
> > interrupt.
> > 
> > I don't know why, but considering that lspci output is now (with the
> > save+restore) identical, I assume that the problem is not related to
> > the host. Unless somehow the host will use a new/different MSI address
> > after the root port has been reset, and we restore the old MSI address,
> > but looking at the code, dw_pcie_msi_init() is called by
> > dw_pcie_setup_rc(), so I would expect the MSI address to be the same.
> > 
> 
> Hi Niklas,
> 
> When I rebased this series on top of v7.1-rc1, I ended up seeing the issue what
> you described here (not sure why I didn't see it earlier). So after the Root
> Port reset, MSI tests fail, but BAR tests succeed. Also, I got IOMMU faults on
> the host after endpoint triggers MSI.
> 
> I investigated it and found that the MSI iATU mapping gets cleared in hw after
> LDn happens. But the host continues to use the same address/size for the
> endpoint MSI even after reset. Due to this, the existing checks in
> dw_pcie_ep_raise_msi_irq() don't pass and the stale MSI iATU mapping gets
> reused.
> 
> The fix would be to clear the mapping in dw_pcie_ep_cleanup(), which gets called
> as part of the PERST# assert/deassert sequence post LDn and also set
> msi_iatu_mapped flag to 'false'. This will force dw_pcie_ep_raise_msi_irq() to
> use fresh iATU mapping when it gets called for the first time:
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index d4dc3b24da60..4ae0e1b55f39 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1035,6 +1035,11 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
>  {
>         struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> +       if (ep->msi_iatu_mapped) {
> +               dw_pcie_ep_unmap_addr(ep->epc, 0, 0, ep->msi_mem_phys);
> +               ep->msi_iatu_mapped = false;
> +       }
> +
>         dwc_pcie_debugfs_deinit(pci);
>         dw_pcie_edma_remove(pci);
>  }
> 
> With this change, MSI works after Root Port reset without any issues on our Qcom
> endpoint/host setup.
> 
> Please test this change on your rockchip setup as well. You have to make sure
> that dw_pcie_ep_cleanup() is called during PERST# assert/deassert.
> 
> I'm going to respin the series with this fix. If you confirm it works for you,
> then we can merge your Rockchip Root Port change.

I am happy to hear that you managed to find the root cause!

Hopefully your series can finally move forward :)

While e.g. RK3588 does have a PERST# input GPIO, so it could theoretically
add a perst_deassert()/assert() function. However, when the EPC support was
added, you did not want that, since I remember that you said that you only
wanted that for drivers that required an external refclock.

Thus, for drivers that do not require an external refclock, should we
perhaps add your suggested code in dw_pcie_ep_linkdown()?

E.g. pcie-tegra194.c does not call dw_pcie_ep_linkdown(), so I'm not
sure if we can simply move it from dw_pcie_ep_cleanup() to
dw_pcie_ep_linkdown() either...

Perhaps we need the code in both functions?

(pcie-qcom-ep.c seems to be the only function that will call both
dw_pcie_ep_linkdown() and dw_pcie_ep_cleanup().)


Kind regards,
Niklas

