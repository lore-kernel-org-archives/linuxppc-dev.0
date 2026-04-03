Return-Path: <linuxppc-dev+bounces-19289-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02DAE8538E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 19:57:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnTyR0qQTz2yjn;
	Sat, 04 Apr 2026 06:57:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775246223;
	cv=none; b=B5Z6MI5ZiPhcMZf2p22U9CL5+ChRsJeyXRKJsnHEDaHpj7WUigajiwEd1Bn2fGZbKJ/phCIxhdf9uDmE2zfy1u07I9GWzys9y8opKXQECDRlfGx1AQgJGCHMxiBDtVT2VZD10OPOtMEaS1eZ4VgomUnw/6BRAOw1RIVEjAc+lKtg9H7aRtPK/V3D8mxfwLmmteg2B12cpwvyGcxgKcFMy2onnTuq5hJsv7r12J0j5Jru8IcI3tEIo/DOHeL6stmjLR5+fO5SbrU4uq8JE++br/CIXKTwbGWcVeB5NhPoA56CjVUbkuFPJwR6vkr2dZ1a9S2IVexQD2VLPA+XHg0Osg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775246223; c=relaxed/relaxed;
	bh=/5NZHFojAQBC+UTFH3gNk9HZPposBvabp2pP/FucyxE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VpF2DdNUQ7li6ZsGQpJ1QrQwOW4xNgrtd9hZCfBNdUjVmEfQXpe0RiLudD+apwR37jFY/tTFkomYOaHADEF9uDhepUWybezmao7KfTzAy1fVRXn/0wJbh6D/mACFjHb7+PwuImjfwBz0nsyG2sejHhgzi+symMPKbhGLQKEZ1L/0GvGbmOKNgAmkZVTYJslyAYuENmtfaB19uqTNdjUG7NZYhI45lcsiTP8QIEE08shNkGDwG5FsddL9qCNLZ3c/ox8cq88sXxoC/wg5Ox38Gr80KjQe79jX4P4S1iVrsEtYwHrzztN01FzCGAaQXQnE7ThIDZuCoerPth/p5VUMVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q72QCnJt; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q72QCnJt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnTyQ1Hx6z2yQj
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 06:57:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C5C5660008;
	Fri,  3 Apr 2026 19:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44607C19424;
	Fri,  3 Apr 2026 19:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775246218;
	bh=i/moDq0DGqe89rhWcnbMfpd1fOs4JQ4tDR5Rad9XOKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Q72QCnJtolrdfAl0t++TuTiC3koOuaEji+ymU3jHbtTupWzOWgx5WN5Lvu1MtXSSb
	 Ie8MNVEuYsSN36so1VJfqCVexa6J7Sf38JcGC+sMePAhc3zkXf+1dPjtVakGk1eYAX
	 I6DGKKg36VNsfeXCTDL6J4S5ACrui9iGS9YGQg1cAqYk/BQakA99RoDpQ/QHCPWwVZ
	 lZdM3dNrIL1xr09McGG/bJM/cIa5AQl8vN4JyNMEfmX01ilaZ4zNyNCu6rI8EIi48c
	 lSRZ3MZ1LMbY9yT25BafikuhDlIvA1DbyYoY7pAyQW6549UTysLsVRe3bEUW/ImAWU
	 MgAQL3FzVSy0Q==
Date: Fri, 3 Apr 2026 14:56:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, davem@davemloft.net,
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
Message-ID: <20260403195657.GA351015@bhelgaas>
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
In-Reply-To: <20260403123329.42bed564@kernel.org>

On Fri, Apr 03, 2026 at 12:33:29PM -0700, Jakub Kicinski wrote:
> On Fri, 3 Apr 2026 10:40:10 -0500 Bjorn Helgaas wrote:
> > > > -#define PCI_VENDOR_ID_ALTEON		0x12ae
> > > > -
> > > >  #define PCI_SUBVENDOR_ID_CONNECT_TECH			0x12c4
> > > >  #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232		0x0001
> > > >  #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232		0x0002  
> > 
> > > Does the PCI ID needs to be removed? There was a similar change that
> > > I recalled and the discussion eventually leads to ID not being
> > > removed.
> > > https://lore.kernel.org/all/20260123033233.16906-1-enelsonmoore@gmail.com/  
> > 
> > I don't think there is value in removing the PCI_VENDOR_ID_ALTEON
> > definition.
> 
> Do you want me to respin the patch? "there is no value" is probably fair
> but also there's no value in keeping it so LMK if you want a respin..

I think there is a little value in keeping it.  Removing
PCI_VENDOR_ID_ALTEON:

  - makes future backports slightly harder, e.g., we remove
    PCI_VENDOR_ID_ALTEON, then add a new definition like Vendor ID
    0x12af, then backport the new definition, and the backport doesn't
    apply cleanly because the context doesn't match.

  - means we wouldn't notice a future addition of another name for
    Vendor ID 0x12ae, either by mistake or via acquisition of Alteon.
    We want to know about either one so we can avoid collisions with
    Device IDs used by Alteon.

