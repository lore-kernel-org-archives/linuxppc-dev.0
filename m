Return-Path: <linuxppc-dev+bounces-12879-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB63CCD185
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Oct 2025 06:41:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmhM148wLz3cgB;
	Wed, 15 Oct 2025 17:41:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760510493;
	cv=none; b=W12tx+g9+hneoIsMWkbnv2M30t3uHnMOCu6Fg2pJnzpbd2HpE08aS8HftnqdTihGM763p3RHLL2aqL0z8hY92Q5x7dYCA5QFiAYiD2TVGmkG+LZMSBmlln6oy7/UkMkJ1OEh/EJsO30G14V2az3y31XQPmy/zMBfv75obaiaIWiZEFIqz7AfY8oSmhH4t56Qpy0nVrmoMfrTDzrQbRg8sz6e4zQglMYyqVeXSMjub18/ZV1lIL3epqgdXVyCV1/AG1w+de226VUllPxlb9a5XQ9+KKQYUQ5oFOqI+9RxFNNZd8M29gWd9F7+/GrHJRtNqpr0+LyC0ZFKUoS7+uHMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760510493; c=relaxed/relaxed;
	bh=2qUnO+i6zOw3nAt1oSKIEhvJ8i2aTXhylVZi3nDcW/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XT6CGB5JT/2aIoSycHGmkQropqWlAMMbVL5xV0rk/kGkFn+mdizN7XiRQ72s6TmnjANUz99s8Lt/s17I3wTGDSR/nnPpouUMx6Vo346oLzPV9J5m+KyfxSrnssX2pb/6bGIcl9spqpPLC4p17Hxy/sbIMy7o/tOrTGi84tSCc11iBuy9Mk+2cWvMkmr4r+uL/2rwXBGXbFlc3fPkjs3+S9cN3g1uod0ZFSGxZ9rixM9hKPDGz/lCSEJwOMOoHBHIRCbaopgl56Vg+7NzMiHPIX3pLAb57tY+jrcRHyNvI0ZAYSo15QqUuCm8Fc+YeTHsAR06vrEYuJF4FVYm76czTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EJJt/ILK; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EJJt/ILK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmhM04nWCz3cfx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2025 17:41:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 27B204329F;
	Wed, 15 Oct 2025 06:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD38C4CEFE;
	Wed, 15 Oct 2025 06:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760510490;
	bh=m/Rd3ahVy6pnBD+xeaNqsODPEiInTFOFb5f8DzKRI+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJJt/ILK3ju+7jPsBaqQBz3NPG7iFqr8o2lpTr4cXgFZxoRkgdMgfbva/T02t6U23
	 /etET6p2GGcAh8IE0q7sfmd0hxvI+hk5M0ECqVgSHea08Sq2Ds0fH8rwb1uRWXRpEA
	 B7WK+uNLFT11n/1+sbGup7eFozI/EO+IlvUOaqeY05bndwttgVZ/OG0QyZsVlJsqhM
	 jrE/2OffDpT8HgZpSvo6OHklBnH83Vx5ZICg4KntrQ1qdY7KVaM8gm+7hLPDZ3RDiB
	 /pqyxb//+V/KPzuiZPV6HT7qrQ3/XgBc/DnuktqcHic3K0JrTa4PL7SvmpkBsJHhZH
	 KMk/T42Va6Zrg==
Date: Wed, 15 Oct 2025 12:11:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>, 
	"R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>, 
	debian-powerpc@lists.debian.org
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <6avz6bsxu6uyvhk4tfvdaofxt7qptfq22un2geet5rd6pvt77c@sojadc7hp26n>
References: <2E40B1CD-5EDA-4208-8914-D1FC02FE8185@xenosoft.de>
 <7FB0AB81-AD0F-420D-B2CB-F81C5E47ADF3@xenosoft.de>
 <3fba6283-c8e8-48aa-9f84-0217c4835fb8@xenosoft.de>
 <mg2ahzgcwgm6h5mtgs4tsel3yrphrfqgfcjydfxgzgxq5h7kot@jtealdt6vvcz>
 <a2ee06b1-28a5-4cb1-9940-b225f9e6d6ee@xenosoft.de>
 <00fe408b-db39-4a9f-b996-0fad73724759@xenosoft.de>
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
In-Reply-To: <00fe408b-db39-4a9f-b996-0fad73724759@xenosoft.de>

On Tue, Oct 14, 2025 at 06:55:07AM +0200, Christian Zigotzky wrote:
> On 13 October 2025 at 05:58 pm, Manivannan Sadhasivam wrote:
> > Either the Root Port could be triggering these AER messages due to ASPM
> issue or
> > due to the endpoint connected downstream.
> >
> > If possible, please share the whole dmesg log instead of the snippet so
> that we
> > can be sure from where the AER messages are coming from.
> >
> > You can also add the below quirk and check:
> >
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FSL, 0x0451,
> quirk_disable_aspm_all);
> >
> > But it would be better to get the whole dmesg.
> >
> > - Mani
> 
> Hello Mani,
> 
> Thanks for your help.
> 
> The kernel doesn't compile with PCI_VENDOR_ID_FSL but it compiles with
> PCI_VENDOR_ID_FREESCALE.
> 
> I tried it with the following patch:
> 
> diff -rupN a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> --- a/drivers/pci/quirks.c    2025-10-12 22:42:36.000000000 +0200
> +++ b/drivers/pci/quirks.c    2025-10-13 17:59:51.473097708 +0200
> @@ -2525,6 +2525,16 @@ static void quirk_disable_aspm_l0s_l1(st
>   */
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080,
> quirk_disable_aspm_l0s_l1);
> 
> +
> +static void quirk_disable_aspm_all(struct pci_dev *dev)
> +{
> +       pci_info(dev, "Disabling ASPM\n");
> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
> quirk_disable_aspm_all);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID,
> quirk_disable_aspm_all);
> +
>  /*
>   * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>   * Link bit cleared after starting the link retrain process to allow this
> 
> ---
> 
> Unfortunately it doesn't solve the issue with pcieport 0001:00:00.0.
> 

That's unfortunate indeed. Could you please share the 'sudo lspci -vv' output?

That will allow us to see the topology and AER status.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

