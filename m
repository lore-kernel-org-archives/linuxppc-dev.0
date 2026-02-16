Return-Path: <linuxppc-dev+bounces-16885-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F4AE81A25
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Feb 2026 15:15:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fF5tz6qdNz2xlq;
	Tue, 17 Feb 2026 02:15:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771254939;
	cv=none; b=c/wjCL6G0SRXKhg/DFCu30mwFh+FUb7rAS37ZQpB048Xw1bmxQB1UQlIUPcfG2zcfpIjzuivN34p+CeugfSNOleLc9MMlfEOarJ9m8aocRFXN0Ubgmym2MEbX8tEIptMWjSChpmAXAB9tIu7TRccwWUVxSFOy6uL/qlFhokWH6LAe2E3V0OI0pwkepK5bjVQ7HGkWK4oL4SNp1Hd+uVmjziZ8AdhM8dHi0RQUcb8Lev+g+aaCeAWGctRrRBX8AO3aEzwl3FVCVH3/DYqDGrWRAd5gKsp3dsAISWKGMCqLzrl3ej9QcWZRXP7IxAuf6m2plKOqRCUcp4wFxjmtsWAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771254939; c=relaxed/relaxed;
	bh=P6sI1XImtIgHuyzvVkTZIk/Ol4dy/LnLxklTJ6uAFSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yif3pY2dnknFCz68bPyh2ZVDV83eOF6TEQ+Tr5uBpoEyFJTiZ1KlTgB/7jYWzUaghRb/fQ/os1u2s98/qnMuwaKH4RHgC024gKHUSBsCQK3Y1f85rsmkDhN3T6ZfeQqvzL3sCC2aHHA2OYTzCllwJXVTHAXVxCvLlJiRgp2zRU6rOCiG/SEZKbNFKvMSnfkkBmKKpAUqubdhFOAsMFIIVcYY1jaU0zgPLRJRhcHukdH3RTXed8z+pT3xy8SsA8wucUa3T6FB5qvXBC2Zd6X4lWn55ZbfZNrKqeCl4NxCxUYz6tbRJwl4UzHVx3RMZvyikhJfE+tavcri92+ZbZKO2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eVAmm0hV; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eVAmm0hV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fF5tz09S7z2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2026 02:15:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 75B2743B09;
	Mon, 16 Feb 2026 15:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CDFC19423;
	Mon, 16 Feb 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771254936;
	bh=T0/dBAH4A6VtIhLGFbkca4e08w1S8Y6tr6iOo5y+MLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVAmm0hV5VPgoD8Na1fqz30ujWFYw2iZR7Xeepn3HwBgpweurYwSUjOsEhwJJqY0i
	 RC4PisqqVINr9iOO2DQ5iymWQQa7ztNq/7ftY6gOf5E6SPGI5bN5dx5Kpm80NsXXqr
	 L2Vy2EQnhW4+sq70Wo9fSTkxNMU0Kh1uoS8ae8mUOhPFp4LKlMtwotnJ7JEU8Hkn3d
	 80XYwVPsogpL4Z96+zTD94LTqQbkd9BngC8QA2yyHpAdVob+s0D4URZYhvECQudqrW
	 4e7IZdvnK4e9HNDeATC+z4rRzlghwzR3e5ABG4SmldLqggK0V73aBqV8Wy1GLUoqV2
	 oSdjNt8fSlpNg==
Date: Mon, 16 Feb 2026 20:45:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] PCI: mvebu: Simplify with scoped for each OF child
 loop
Message-ID: <2w3cvp43y5fxjveifmagikxhlbrotuztjufa2eoaxesi2fzz2f@6fkyex46nucd>
References: <20260102124900.64528-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20260105103502.00002efe@huawei.com>
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
In-Reply-To: <20260105103502.00002efe@huawei.com>

On Mon, Jan 05, 2026 at 10:35:02AM +0000, Jonathan Cameron wrote:
> On Fri,  2 Jan 2026 13:49:01 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> 
> > Use scoped for-each loop when iterating over device nodes to make code a
> > bit simpler.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Hi Krzysztof,
> 
> Drive by review.  Your changes are functionally equivalent and lgtm.
> However, I am curious at whether the lack of reference count for child
> when stashed in port->dn (and then used in the for loop) is a potential
> issue.
> 

Looks like it. But the current code doesn't drop the reference either :/

- Mani

> Jonathan
> 
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index a72aa57591c0..4d3c97b62fe0 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -1452,7 +1452,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> >  	struct mvebu_pcie *pcie;
> >  	struct pci_host_bridge *bridge;
> >  	struct device_node *np = dev->of_node;
> > -	struct device_node *child;
> >  	int num, i, ret;
> >  
> >  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
> > @@ -1474,16 +1473,14 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  
> >  	i = 0;
> > -	for_each_available_child_of_node(np, child) {
> > +	for_each_available_child_of_node_scoped(np, child) {
> >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> >  
> >  		ret = mvebu_pcie_parse_port(pcie, port, child);
> > -		if (ret < 0) {
> > -			of_node_put(child);
> > +		if (ret < 0)
> >  			return ret;
> > -		} else if (ret == 0) {
> > +		else if (ret == 0)
> >  			continue;
> > -		}
> >  
> >  		port->dn = child;
> >  		i++;
> > @@ -1493,6 +1490,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> >  	for (i = 0; i < pcie->nports; i++) {
> >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> >  		int irq = port->intx_irq;
> > +		struct device_node *child;
> >  
> >  		child = port->dn;
> >  		if (!child)
> 

-- 
மணிவண்ணன் சதாசிவம்

