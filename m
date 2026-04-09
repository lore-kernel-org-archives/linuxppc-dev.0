Return-Path: <linuxppc-dev+bounces-19523-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AD610FC466
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2026 01:58:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frjlR74xHz2yd7;
	Thu, 09 Apr 2026 11:58:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775699923;
	cv=none; b=ba7PYqMire2wvrONiZcNUfySrNGWLnmPa+jax++4vwjnvywS9SRJtf2ZX6qv7bQxttofXL+SuR5GzNSqmjNc6zUFLWRzK8aAcDGxKZMQWAAc1BEB6Y9/wTIT+etnr8lZvkAQ69aX6GeXxRVHk3FAzZa/xj6LxqWJKSgd4EPhPLoNF3T8teb0HFrMhNRDB2juy7qO033fyRx1JSAE/hF77v7Qwn5ol3YMuxkIoRIod9yuTrqQWOY3vjl3Ab9t92B+6JZNa3UuRxObhlgf543QMpzJvzEVOJm0pQay7d9e0vrL2YOnJoWwOqdUobo+KL5/ApGvOOZAis0SBXPMYHOxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775699923; c=relaxed/relaxed;
	bh=rtu5J6mkYa7cAz+oGv/2J7Qnc58jCw+U8QvJQpdZOFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6mglyfhlGbtbj1Asr5eCX2tHcKJU2CZnjWGXf+QdWoZoh0lRqRtuaPTlZfv4txd0/5vL8sjC1O8L3QkQpG1VL5m7QMgkCX77C7rII50WAFAOL7txFFcFOCXnVzWNE99p8o/KvJNvFNzg6n5sbmPd1mlGUTmxUI60J9O5wHFM+CWs1Qpyxf0dD0wqf1D/x3YoIG9GlbYh48JISISiL57QT37sKGmFkObbOxdoengsc5O/U0GH3/rMYEOUvXHdTYCo93oR44OyncWxJ5BhMAzlV02ATa6Yea9v61oc72IGcDMs97olcloku0JVI0fEf/Kgvk1Mz6Spqfc3T3tagrsjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TwWQzFtv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=briannorris@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TwWQzFtv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=briannorris@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frjlQ1rnyz2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 11:58:40 +1000 (AEST)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-2d17b8fbedaso101482eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 18:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775699918; x=1776304718; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtu5J6mkYa7cAz+oGv/2J7Qnc58jCw+U8QvJQpdZOFw=;
        b=TwWQzFtvjOsDJKwx11i5t6/6BeJQeh/b+87BAQJiHFizF4kVvSO7rttIFfcKHjv+4q
         0nZYFel3slNegXvRFtiUCJXJhqFbQ8b9totfy454bwoif9QRiAVsGxa8K2GYAe/uuRQa
         WFdfgzSAJ8Tk24v2Uy0JjaQ62xO2xunBmh2Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775699918; x=1776304718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtu5J6mkYa7cAz+oGv/2J7Qnc58jCw+U8QvJQpdZOFw=;
        b=ll9I50FRdrbYRoG8uAT/DelfSz17/u/dwuXoQ5kv6Rv3zWTHvATFpaBlyj3d1vKyxT
         BU3sWD0Yu8rmcR3u+LLn+D/y06JZj593weK9JrKenuGb/dGD4tMBWRjYeTEQQKW2cazp
         P8z07ivGnK2z3YT8ghXe8+DCdaspzoiVfkcgTZDQ2nqFuxXUrqbR9tWIpK3RpmLTchdw
         iwgtOS7p50bCePi8iJ2ALOAQkIzKKqa37evjgvCVxz8shdzorIq01wqf+lpPpjWsviZe
         5YHHV0OR8kzyP2EXJakfgUdE92w+vduHtmUnGBgJcEAtbm2yjkiCmV0AtqR9maE5VTqR
         l4tg==
X-Forwarded-Encrypted: i=1; AJvYcCVDzdt5Dm27c6Zpc5vBWBBJ7Ae8EhzujvuwYmjDJR7G1s8UjEvsrpwY3WoaBlYzPkyGso3QREcKMZtBDRs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxXfq/vUlWi2flIn2TjXT+tn1TWpDvfdbynBWzT5RI2dqwEO5Y4
	MhHDiAjwfgkxLUDEjvxBuxBXyWoJfzv9pLFdtJ7Cj0zJ8RLLmGlhl4+2kjiBRz1CqQ==
X-Gm-Gg: AeBDiet4RG8JfjVuujoEzp8zFezcsC/WvZzflPIg1rMus5d8jPoB8ZogJnpHY1JXF/k
	2KMfSfgk2TVzdLFF0Gt6umneEvOludR5xz0aAed4sDdeHzu7V+xtW8zfP1ROCigWpGPNxXVJXZq
	xH+D9MWf9yNhtXYR2SVe7AVKmWucwsmuw2Dfwcw1DP2DPj+ZqA6LyfDg0MAveq/eTo1xdcURVEV
	5Cs9DUMSMfBV6B/8WU54CBfEh03zcc0y2tKfS62zBiEno6H3fYvo/TmPz9K95YHZQr7GeDp7WKq
	znQMN9sYNTuM8QhCGzp3CteFKLwp2X+FNQzRoP/KajY1IgKOD7+UKRsZxS2wZljZ8JErK06IbZg
	PD/Rf8xilB40a26HbrkNffBYN4qG9yYg7qzHvhT/c7d2IoD+EaYy+PfZjAgFFGkQeqmCM25/ks8
	qExkHBGTgh0Np/8XhPu7sxn8sSC9K4tm1AOapCN0o+3en7X/VvEzh8Ml7zAz7qHg==
X-Received: by 2002:a05:7301:6097:b0:2d1:a3ea:d8a5 with SMTP id 5a478bee46e88-2d40e9cace4mr857392eec.7.1775699918176;
        Wed, 08 Apr 2026 18:58:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:8419:d73b:6e27:ef7e])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2ca7c3010e9sm29435810eec.14.2026.04.08.18.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 18:58:37 -0700 (PDT)
Date: Wed, 8 Apr 2026 18:58:34 -0700
From: Brian Norris <briannorris@chromium.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "manivannan.sadhasivam@oss.qualcomm.com" <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>, Wilson Ding <dingwei@marvell.com>,
	Miles Chen <minhuachen@google.com>
Subject: Re: [PATCH v7 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <adcHylFjFjhHT-tP@google.com>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
 <AS8PR04MB883389FD2A016F9E02756B048C49A@AS8PR04MB8833.eurprd04.prod.outlook.com>
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
In-Reply-To: <AS8PR04MB883389FD2A016F9E02756B048C49A@AS8PR04MB8833.eurprd04.prod.outlook.com>

Hi Richard and Mani,

For the record, I've been using a form of an earlier version of this
patchset in my environment for some time now, and I've run across
problems that *might* relate to what Richard is reporting, but I'm not
quite sure at the moment. Details below.

On Wed, Mar 25, 2026 at 07:06:49AM +0000, Hongxing Zhu wrote:
> Hi Mani:
> I've accidentally encountered a new issue based on the reset root port patch-set.
> After performing a few hot-reset operations, the PCIe link enters a continuous up/down cycling pattern.
> 
> I found that calling pci_reset_secondary_bus() first in pcibios_reset_secondary_bus() appears to resolve this issue.
> Have you experienced a similar problem?
> 
> "
> ...
> [  141.897701] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000700) link up detected
> [  142.086341] imx6q-pcie 4c300000.pcie: PCIe Gen.3 x1 link up
> [  142.092038] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000c00) link down detected
> ...
> "
> 
> Platform: i.MX95 EVK board plus local Root Ports reset supports based on the #1 and #2 patches of v7 patch-set.
> Notes of the logs:
> - One Gen3 NVME device is connected.
> - "./memtool 4c341058=0;./memtool 4c341058=1;" is used to toggle the LTSSM_EN bit to trigger the link down.
> - Toggle BIT6 of Bridge Control Register to trigger hot reset by "./memtool 4c30003c=004001ff; ./memtool 4c30003c=000001ff;"
> - The Root Port reset patches works correctly at first.
> However, after several hot-reset triggers, the link enters a repeated down/up cycling state.
> 
> Logs:
> [    3.553188] imx6q-pcie 4c300000.pcie: host bridge /soc/pcie@4c300000 ranges:
> [    3.560308] imx6q-pcie 4c300000.pcie:       IO 0x006ff00000..0x006fffffff -> 0x0000000000
> [    3.568525] imx6q-pcie 4c300000.pcie:      MEM 0x0910000000..0x091fffffff -> 0x0010000000
> [    3.577314] imx6q-pcie 4c300000.pcie: config reg[1] 0x60100000 == cpu 0x60100000
> [    3.796029] imx6q-pcie 4c300000.pcie: iATU: unroll T, 128 ob, 128 ib, align 4K, limit 1024G
> [    4.003746] imx6q-pcie 4c300000.pcie: PCIe Gen.3 x1 link up
> [    4.009553] imx6q-pcie 4c300000.pcie: PCI host bridge to bus 0000:00
> root@imx95evk:~#
> root@imx95evk:~#
> root@imx95evk:~# ./memtool 4c341058=0;./memtool 4c341058=1; Writing 32-bit value 0x0 to address 0x4C341058
> Writing 32-bit v
> [   87.265348] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000d01) link down detected
> alue 0x1 to adder
> [   87.273106] imx6q-pcie 4c300000.pcie: Stop root bus and handle link down
> ss 0x4C341058
> [   87.281264] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> [   87.289245] pci 0000:01:00.0: AER: can't recover (no error_detected callback)
> root@imx95evk:~# [   87.514216] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000700) link up detected
> [   87.702968] imx6q-pcie 4c300000.pcie: PCIe Gen.3 x1 link up
> [   87.834983] pcieport 0000:00:00.0: Root Port has been reset
> [   87.840714] pcieport 0000:00:00.0: AER: device recovery failed
> [   87.846592] imx6q-pcie 4c300000.pcie: Rescan bus after link up is detected
> [   87.855947] pcieport 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring

I've seen this same line ("bridge configuration invalid") before, and I
believe that's because the saved state (pci_save_state(); more about
this below) is invalid -- it contains 0 values in places where they
should be non-zero. So when those values are restored
(pci_restore_state()), we get confused.

I believe we've pinned down one reason this invalid state occurs -- it's
because of an automatic (mis)feature in the DesignWare PCIe hardware.
Specifically, it's because of what the controller does during a surprise
link-down error.

From the Designware docs:

  "[...] during normal operation, the link might fail and go down. After
  this link-down event, the controller requests the DWC_pcie_clkrst.v
  module to hot-reset the controller. There is no difference in the
  handling of a link-down reset or a hot reset; the controller asserts
  the link_req_rst_not output requesting the DWC_pcie_clkrst.v module to
  reset the controller."

In some of the adjacent documentation (and confirmed in local testing),
it suggests that this automatic reset will also reset various DBI (i.e.,
PCIe config space) registers. It also seems as if there's not really a
good way to completely stop this automatic reset -- the docs mention
some SW methods prevent the reset, but they all seem racy or incomplete.

Anyway, I think this implies that patch 1 is somewhat wrong [1]. It
includes some code like this:

		pci_save_state(dev);
		ret = host->reset_root_port(host, dev);
		if (ret)
			pci_err(dev, "Failed to reset Root Port: %d\n", ret);
		else
			/* Now restore it on success */
			pci_restore_state(dev);

That first line (pci_save_state()) is prone to saving invalid state,
depending on whether the link-down event has finished flushing and
resetting the controller yet or not. The resulting impact is a bit hard
to judge, depending on what (mis)configuration you end up with.

I also noticed commit a2f1e22390ac ("PCI/ERR: Ensure error
recoverability at all times") was merged recently. With that change, I
believe it is now safe to perform pci_restore_state() even without
pci_save_state() here.

So ... can we remove pci_save_state() from
pcibios_reset_secondary_bus()? Might that help? It sounds like my above
observations *may* match Richard's reports, but I'm not sure. And
anyway, the documented hardware behavior is racy, so it's hard to
propose a foolproof solution.

Brian

[1] At least, for DesignWare controllers.

> [   87.864423] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> 
> root@imx95evk:~#
> root@imx95evk:~# cat /proc/interrupts | grep lnk;
> 273:          2          0          0          0          0          0    GICv3 342 Level     PCIe PME, lnk_notify
> root@imx95evk:~#
> root@imx95evk:~#
> root@imx95evk:~# ./memtool 4c30003c=004001ff; ./memtool 4c30003c=000001ff; Writing 32-bit va
> [  107.028086] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000d00) link down detected lue 0x4001FF to a
> [  107.037018] imx6q-pcie 4c300000.pcie: Stop root bus and handle link down ddress 0x4C30003C
> [  107.045137] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> 
> Writing 32-bit
> [  107.053332] pci 0000:01:00.0: AER: can't recover (no error_detected callback)  value 0x1FF to address 0x4C30003C root@imx95evk:~#
> [  107.282146] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000700) link up detected
> [  107.470801] imx6q-pcie 4c300000.pcie: PCIe Gen.3 x1 link up
> [  107.602823] pcieport 0000:00:00.0: Root Port has been reset
> [  107.608601] pcieport 0000:00:00.0: AER: device recovery failed
> [  107.614497] imx6q-pcie 4c300000.pcie: Rescan bus after link up is detected
> [  107.623805] pcieport 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [  107.632281] pci_bus 0000:01: busn_res: [bus 01] end is updated to 01
> 
> root@imx95evk:~#
> root@imx95evk:~# cat /proc/interrupts | grep lnk;
> 273:          4          0          0          0          0          0    GICv3 342 Level     PCIe PME, lnk_notify
> root@imx95evk:~#
> root@imx95evk:~# ./memtool 4c30003c=004001ff; ./memtool 4c30003c=000001ff; Writing 32-bit va
> [  133.424041] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000d00) link down detected lue 0x4001FF to a
> [  133.432954] imx6q-pcie 4c300000.pcie: Stop root bus and handle link down ddress 0x4C30003C
> [  133.441106] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> 
> Writing 32-bit
> [  133.449309] pci 0000:01:00.0: AER: can't recover (no error_detected callback)  value 0x1FF to address 0x4C30003C root@imx95evk:~#
> [  133.677824] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000700) link up detected
> [  133.870414] imx6q-pcie 4c300000.pcie: PCIe Gen.3 x1 link up
> [  134.002534] pcieport 0000:00:00.0: Root Port has been reset
> [  134.008307] pcieport 0000:00:00.0: AER: device recovery failed
> [  134.014193] imx6q-pcie 4c300000.pcie: Rescan bus after link up is detected
> [  134.023418] pcieport 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [  134.031881] pci_bus 0000:01: busn_res: [bus 01] end is updated to 01
> 
> root@imx95evk:~# ./memtool 4c30003c=004001ff; ./memtool 4c30003c=000001ff; Writing 32-bit va
> [  140.149713] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000d00) link down detected lue 0x4001FF to a
> [  140.158614] imx6q-pcie 4c300000.pcie: Stop root bus and handle link down ddress 0x4C30003C
> [  140.166779] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> [  140.174981] pci 0000:01:00.0: AER: can't recover (no error_detected callback) Writing 32-bit value 0x1FF to address 0x4C30003C root@imx95evk:~#
> [  140.401605] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000700) link up detected
> [  140.590491] imx6q-pcie 4c300000.pcie: PCIe Gen.3 x1 link up
> [  140.596206] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000c00) link down detected
> 
> root@imx95evk:~#
> [  141.630311] pcieport 0000:00:00.0: Data Link Layer Link Active not set in 100 msec
> [  141.637950] pcieport 0000:00:00.0: Failed to reset Root Port: -25
> [  141.644095] pcieport 0000:00:00.0: AER: subordinate device reset failed
> [  141.650883] pcieport 0000:00:00.0: AER: device recovery failed
> [  141.656784] imx6q-pcie 4c300000.pcie: Stop root bus and handle link down
> [  141.663520] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> [  141.670271] pci 0000:01:00.0: AER: can't recover (no error_detected callback)
> [  141.897701] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000700) link up detected
> [  142.086341] imx6q-pcie 4c300000.pcie: PCIe Gen.3 x1 link up
> [  142.092038] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000c00) link down detected
> [  143.126273] pcieport 0000:00:00.0: Data Link Layer Link Active not set in 100 msec
> [  143.133919] pcieport 0000:00:00.0: Failed to reset Root Port: -25
> [  143.140052] pcieport 0000:00:00.0: AER: subordinate device reset failed
> [  143.146747] pcieport 0000:00:00.0: AER: device recovery failed
> [  143.152604] imx6q-pcie 4c300000.pcie: Stop root bus and handle link down
> [  143.159314] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> [  143.166022] pci 0000:01:00.0: AER: can't recover (no error_detected callback)
> [  143.389723] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000700) link up detected
> [  143.582294] imx6q-pcie 4c300000.pcie: PCIe Gen.3 x1 link up
> [  143.587996] imx6q-pcie 4c300000.pcie: PCIe(LNK_STS:0x00000c00) link down detected
> 
> 
> Thanks.
> Best Regards
> Richard Zhu

