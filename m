Return-Path: <linuxppc-dev+bounces-19711-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E15F34C63
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 16:35:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvY1c5Ch0z2yvT;
	Tue, 14 Apr 2026 02:35:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776098148;
	cv=none; b=U1jArohQzsY0mzJazV41D952Ci+JBbH9mL6TtuJFMD3TwJsxa4Z2yj1PiP/EatC8xUQgRbe3Paiwd2h93pZVo40novYRX+w3Yb0lkOCcu5IVrhmND2DnF4LSg861UJ4J6yPcKJ4Ma3/UlY9Dc7C0HIpsNTEktURPFIigd6mLmPMRg/neYmZL0PpITpljuFBMiJvrUJc9yVb47VxPEBFpt4cVYeY4ckdgVK1LXnRj+BBrxjJotYytbgHOmOYWGaP0t82rqpV5azYcIesI1wsj3sK8EjFl7ifaPwKd1nCZbduLNjk/Lpr8IKR4veCUJxrZnw3hoL9Wp6fkacWc3AW4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776098148; c=relaxed/relaxed;
	bh=7kag+k76MMII2rJ7lc0nPwSZz3w0zkW2ZuT/Qpx9Y1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlStCQnpsZ5XQJAyMrPPAgmWl6cfAEfAqeWfnRT7lMgxYFnfNyKC8kfLG3mAnZeZ4PqdOPo+XMjO35BT5DvUjGC+qh4td4xKCCz4lz6EA3dUxKKWq3CIoZtfUvjOSpLhOenPPOoA4CNk3FQRbPw4gjZCnMasDgIi4uQNr9HTzJbIu2HLhEG2XjpqwhoQm3bh8pNEyq85DANu4ILGAF5eVlCxlOrrElm0CvSohpuQBMBa80bE/iOfNqxeZZjQZph259/brTvPkco45RmqTpstZynB29UaGywsdUvwCviFcDTbmcxDbqSIdo2FwWnr17eqyxKbN6Jrdw8Xw4XX2tymEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Lk8ymw3M; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Lk8ymw3M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvY1b3NVmz2yth
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 02:35:47 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2DA4F40881;
	Mon, 13 Apr 2026 16:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FBCC2BCB3;
	Mon, 13 Apr 2026 16:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776098145;
	bh=YZ23nMQ/ay3QztACjeZpwAsTDk5SE/Lr+pB3V6c9Mqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lk8ymw3MMZG/o+y7+yEs9+SRa2wM7p+rrtsT8WBnSf4v+gl6sXbHWOTbbi/XV3xC4
	 Pn5g7XBWkIkq8K23OKBe16ohjIMDDnUIoslb4p0kQC3a9ulPP1tSHjaCLOf54uD2oZ
	 G7ui53icbdw2iggotHL0Vy9VNgLSVMib1U3kiMTN0uW2+GElkpA8ikUiE8h0XLfNE9
	 ImA9l7/Am6GKhLrhIsYsx1CFPePcxFQ9wp4T8PUnxtM3gUcwJQ6/+R6IdMPwZ4nbDA
	 dZDI+53aOQhehcepUJNY3OiBRpz0ea9bCWS9K13MaCoeVgSKeZOTLYKnFz8Fy56/JW
	 PoN5/0eOM46Gw==
Date: Mon, 13 Apr 2026 22:05:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>, 
	Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>, 
	"manivannan.sadhasivam@oss.qualcomm.com" <manivannan.sadhasivam@oss.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, Niklas Cassel <cassel@kernel.org>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Lukas Wunner <lukas@wunner.de>, Wilson Ding <dingwei@marvell.com>, 
	Miles Chen <minhuachen@google.com>
Subject: Re: [PATCH v7 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <klzq2i2ne62hdri65gz7s5pxmvely277optr2lrkvdrrahl3ca@k3hdo6o4nkjz>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
 <AS8PR04MB883389FD2A016F9E02756B048C49A@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <adcHylFjFjhHT-tP@google.com>
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
In-Reply-To: <adcHylFjFjhHT-tP@google.com>

Hi Brian,

On Wed, Apr 08, 2026 at 06:58:34PM -0700, Brian Norris wrote:
> Hi Richard and Mani,
> 
> For the record, I've been using a form of an earlier version of this
> patchset in my environment for some time now, and I've run across
> problems that *might* relate to what Richard is reporting, but I'm not
> quite sure at the moment. Details below.
> 
> On Wed, Mar 25, 2026 at 07:06:49AM +0000, Hongxing Zhu wrote:
> > Hi Mani:
> > I've accidentally encountered a new issue based on the reset root port patch-set.
> > After performing a few hot-reset operations, the PCIe link enters a continuous up/down cycling pattern.
> > 
> > I found that calling pci_reset_secondary_bus() first in pcibios_reset_secondary_bus() appears to resolve this issue.
> > Have you experienced a similar problem?
> > 
> > "
> > ...
> > [  141.897701] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000700) link up detected
> > [  142.086341] imx6q-pcie 4c300000.pcie: PCIe Gen.3 x1 link up
> > [  142.092038] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000c00) link down detected
> > ...
> > "
> > 
> > Platform: i.MX95 EVK board plus local Root Ports reset supports based on the #1 and #2 patches of v7 patch-set.
> > Notes of the logs:
> > - One Gen3 NVME device is connected.
> > - "./memtool 4c341058=0;./memtool 4c341058=1;" is used to toggle the LTSSM_EN bit to trigger the link down.
> > - Toggle BIT6 of Bridge Control Register to trigger hot reset by "./memtool 4c30003c=004001ff; ./memtool 4c30003c=000001ff;"
> > - The Root Port reset patches works correctly at first.
> > However, after several hot-reset triggers, the link enters a repeated down/up cycling state.
> > 
> > Logs:
> > [    3.553188] imx6q-pcie 4c300000.pcie: host bridge /soc/pcie@4c300000 ranges:
> > [    3.560308] imx6q-pcie 4c300000.pcie:       IO 0x006ff00000..0x006fffffff -> 0x0000000000
> > [    3.568525] imx6q-pcie 4c300000.pcie:      MEM 0x0910000000..0x091fffffff -> 0x0010000000
> > [    3.577314] imx6q-pcie 4c300000.pcie: config reg[1] 0x60100000 == cpu 0x60100000
> > [    3.796029] imx6q-pcie 4c300000.pcie: iATU: unroll T, 128 ob, 128 ib, align 4K, limit 1024G
> > [    4.003746] imx6q-pcie 4c300000.pcie: PCIe Gen.3 x1 link up
> > [    4.009553] imx6q-pcie 4c300000.pcie: PCI host bridge to bus 0000:00
> > root@imx95evk:~#
> > root@imx95evk:~#
> > root@imx95evk:~# ./memtool 4c341058=0;./memtool 4c341058=1; Writing 32-bit value 0x0 to address 0x4C341058
> > Writing 32-bit v
> > [   87.265348] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000d01) link down detected
> > alue 0x1 to adder
> > [   87.273106] imx6q-pcie 4c300000.pcie: Stop root bus and handle link down
> > ss 0x4C341058
> > [   87.281264] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> > [   87.289245] pci 0000:01:00.0: AER: can't recover (no error_detected callback)
> > root@imx95evk:~# [   87.514216] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000700) link up detected
> > [   87.702968] imx6q-pcie 4c300000.pcie: PCIe Gen.3 x1 link up
> > [   87.834983] pcieport 0000:00:00.0: Root Port has been reset
> > [   87.840714] pcieport 0000:00:00.0: AER: device recovery failed
> > [   87.846592] imx6q-pcie 4c300000.pcie: Rescan bus after link up is detected
> > [   87.855947] pcieport 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> 
> I've seen this same line ("bridge configuration invalid") before, and I
> believe that's because the saved state (pci_save_state(); more about
> this below) is invalid -- it contains 0 values in places where they
> should be non-zero. So when those values are restored
> (pci_restore_state()), we get confused.
> 
> I believe we've pinned down one reason this invalid state occurs -- it's
> because of an automatic (mis)feature in the DesignWare PCIe hardware.
> Specifically, it's because of what the controller does during a surprise
> link-down error.
> 
> From the Designware docs:
> 
>   "[...] during normal operation, the link might fail and go down. After
>   this link-down event, the controller requests the DWC_pcie_clkrst.v
>   module to hot-reset the controller. There is no difference in the
>   handling of a link-down reset or a hot reset; the controller asserts
>   the link_req_rst_not output requesting the DWC_pcie_clkrst.v module to
>   reset the controller."
> 
> In some of the adjacent documentation (and confirmed in local testing),
> it suggests that this automatic reset will also reset various DBI (i.e.,
> PCIe config space) registers. It also seems as if there's not really a
> good way to completely stop this automatic reset -- the docs mention
> some SW methods prevent the reset, but they all seem racy or incomplete.
> 
> Anyway, I think this implies that patch 1 is somewhat wrong [1]. It
> includes some code like this:
> 
> 		pci_save_state(dev);
> 		ret = host->reset_root_port(host, dev);
> 		if (ret)
> 			pci_err(dev, "Failed to reset Root Port: %d\n", ret);
> 		else
> 			/* Now restore it on success */
> 			pci_restore_state(dev);
> 
> That first line (pci_save_state()) is prone to saving invalid state,
> depending on whether the link-down event has finished flushing and
> resetting the controller yet or not. The resulting impact is a bit hard
> to judge, depending on what (mis)configuration you end up with.
> 

Thanks a lot for your investigation. I think your observation makes sense and
could be the culprit in saving the corrupted state. Even on non-DWC controllers,
there is no guarantee that the Root Port config registers state will be
preserved after LDn (before Root Port reset).

> I also noticed commit a2f1e22390ac ("PCI/ERR: Ensure error
> recoverability at all times") was merged recently. With that change, I
> believe it is now safe to perform pci_restore_state() even without
> pci_save_state() here.
> 
> So ... can we remove pci_save_state() from
> pcibios_reset_secondary_bus()? Might that help?

I think so. I will also test it locally and report back soon.

> It sounds like my above
> observations *may* match Richard's reports, but I'm not sure. And
> anyway, the documented hardware behavior is racy, so it's hard to
> propose a foolproof solution.
> 

@Richard: Can you confirm if removing 'pci_save_state(dev);' from
pcibios_reset_secondary_bus() fixes your issue?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

