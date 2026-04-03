Return-Path: <linuxppc-dev+bounces-19281-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07799E8537A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 15:40:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnNG84tJNz2yjV;
	Sat, 04 Apr 2026 02:40:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775230816;
	cv=none; b=OrHYN1O/54v04+7dGfqpGse/7m37k6KvyCJxjl0nlnm7HosUZpVaeAoOcftTPFaUGrs9VRjh0kTV6dTpEY6mSzNoAXkhImhOsbbaTac3CG4fnDTuZrOtuBBgZxTGAzNPOSRuM7CdXmSMGGWz93EdTKl2Arkn+cqyK+6ouaLgYYB23RansVj+9RMqHylE/6vSx94kVx/I9IbSwRiPujPP7MCmUlsSsaFOyYC75m3oJlbjbN8I37THlPL2stRiGz7s/9DVuG6HumK8SQdpeDbMW8F9jjnGK+zZos4O3isAgVp0n3KGcktIaDWKJ8m1kQi52MfLjDP6IyC3xIJaVLJ6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775230816; c=relaxed/relaxed;
	bh=6VQdikDmkqss8oNEp6p8NXRlmdw5MYzutLZflVZooZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M/Ma/voAW2OS3untrvYdmwHVRtxWa8y8/5VyU/AP3CTNiCogqnMR6V1GJH2B53DLCLocMA+atTS7kT9lvJh/j1A4xSnraBYDLJs9sffQlliNYRKYPku1vcZZBB4u+2isJEdkujKSt9o1a9bFXBWVvUM5gd6crH3+ieEb716HPS1zHv9jIF7FEOfcqujazu8goiNN/4Hw13D71/MHdFOwFFCoiP7cV7TJqxOTAvSLt1iOgPYnrVr3c9AWyUer4WVrRCzAb6tDr4vuh+az0c80K9oCJPOliETP7dJq1z9OiA74hd8GYH43p0FrIzbp45du8WX4qBQ/fZgGlbsxPEL3dQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hjvMUx4l; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hjvMUx4l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnNG80GYfz2yhX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 02:40:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 62D8260121;
	Fri,  3 Apr 2026 15:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F20C4CEF7;
	Fri,  3 Apr 2026 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775230812;
	bh=yWko4zVzCCAWynSjp/vVAZSdx+z+fWAaf2R5l3ZiPuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hjvMUx4lf3sd+/gDlfQLmiRx5snEoHkgPiH5lf/5ptZo9cDFe1xDojgFNmCi7cnk1
	 PFbUbeQvKtO8q5aDzlMCAu7k7+Eiv3YaX2SPLAX+NmSEmy2HzTM+1z0FCu3NSTIDDq
	 u34GrXS7Kkv4v+Uk8la0WnKNGZ1NDlin0qdyDxYdYrBKWgc9J8Ah5Hb5OA3Y4TCt+i
	 FTUsWbqBMVsRBNI/sS/84EisFl14G7KVv1CM4nTigP4w59xVYchXVBZJxroFPFlNh5
	 aps6TryG2jequWFoX4yJbR38ZMgCAE8OWpnvg4EZXo0vcp1dO13i8TOUcogejw3GDM
	 YBBhrPcypgaGg==
Date: Fri, 3 Apr 2026 10:40:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, jes@trained-monkey.org,
	chenhuacai@kernel.org, kernel@xen0n.name, tsbogend@alpha.franken.de,
	James.Bottomley@hansenpartnership.com, deller@gmx.de,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, bhelgaas@google.com, dakr@kernel.org,
	kwilczynski@kernel.org, ojeda@kernel.org, boqun@kernel.org,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, ebiggers@google.com,
	ardb@kernel.org, tiwai@suse.de, tytso@mit.edu,
	enelsonmoore@gmail.com, martin.petersen@oracle.com,
	jirislaby@kernel.org, gregkh@linuxfoundation.org,
	geert@linux-m68k.org, herbert@gondor.apana.org.au,
	vineethr@linux.ibm.com, lirongqing@baidu.com, kshk@linux.ibm.com,
	vadim.fedorenko@linux.dev, dong100@mucse.com,
	wangruikang@iscas.ac.cn, hkallweit1@gmail.com, kees@kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH net-next] eth: remove the driver for acenic / tigon1&2
Message-ID: <20260403154010.GA335042@bhelgaas>
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
In-Reply-To: <DHJKGY0F52GL.14FQPOWWO0F77@garyguo.net>

On Fri, Apr 03, 2026 at 02:50:32PM +0100, Gary Guo wrote:
> On Thu Apr 2, 2026 at 7:30 PM BST, Jakub Kicinski wrote:
> > The entire git history for this driver looks like tree-wide
> > and automated cleanups. There's even more coming now with
> > AI, so let's try to delete it instead.

> > +++ b/include/linux/pci_ids.h
> > @@ -1809,8 +1809,6 @@
> >  /* formerly Platform Tech */
> >  #define PCI_DEVICE_ID_ESS_ESS0100	0x0100
> >  
> > -#define PCI_VENDOR_ID_ALTEON		0x12ae
> > -
> >  #define PCI_SUBVENDOR_ID_CONNECT_TECH			0x12c4
> >  #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232		0x0001
> >  #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232		0x0002

> Does the PCI ID needs to be removed? There was a similar change that
> I recalled and the discussion eventually leads to ID not being
> removed.
> https://lore.kernel.org/all/20260123033233.16906-1-enelsonmoore@gmail.com/

I don't think there is value in removing the PCI_VENDOR_ID_ALTEON
definition.

