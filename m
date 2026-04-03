Return-Path: <linuxppc-dev+bounces-19288-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20648E8538E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 19:33:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnTRZ4Vfjz2yjn;
	Sat, 04 Apr 2026 06:33:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775244826;
	cv=none; b=VjTPnQZBqTXOa/jahHDxr81mn3JYwXS9/pHlO+tsfSongaVtNhDrS6ihXnPU98/mTEa+FwaSQhzqtqgdoM0/ykTXrruA/gEcF2jOjt9TQYWlsGY9mALI9HTRNx490leIMH9EnuIUkXKjsGoQEqhP3X7yArFZ/Fj0rPk0rVLqXPX7X570vkg9pqJcCJSkvzVOE4GmO6JF3DKjqy0R7ZnbNRf9V84/bkvXCvxn+xZw7hANGSX27tDOHIBgzuKeF0KMlGgbpdxOdPVF/2iDaS3k7s1GZZAsUM8aZaZpm4vi4fwmDS98PGcbSKUkLMhvhIqiZDeqv2V8xA9cChIECSvD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775244826; c=relaxed/relaxed;
	bh=DRwPbKcPp5HoqWfnkOge4P3NzcEuwHYO46izRHo7UI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVFwlOPTCHfe/SzlG3ZYYI2FqFrrQUOpWx3vAAi4Dcj+IzyGwtqMAVweS+XhdLQOHCvscGWT9RGNQkabaPXfvLNxtJISNCRiiDBLBMQE0Yun0sTXXPcZ/rK/Pe3BZ4NM9F+PXveeMx5y1i+iQrsOBvBWK6yaqlMHsdu05CH1wMPLF3TILOcbc6qHv+WCm04XF+OIV37foJB+69GAJqeM2fD3oexRXdQGdU2B1Rkk+Nm8+OtryWZ0ZPcCXwn6tAtUylh13PZ9nh+4fGSlIn244w2VxDGlawzloXNSnvDGkha380cXzV/jB6IX2dpun1Tjf/oPyrkk+Qa2A2L8TvRZ8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QRWyWbgt; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QRWyWbgt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnTRY1zQHz2yQj
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 06:33:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C64514346E;
	Fri,  3 Apr 2026 19:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E55C4CEF7;
	Fri,  3 Apr 2026 19:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775244822;
	bh=9DYHGS2w6V5E2Mnrip1cBt+8QF4uaeoksv9BYbR3ECE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QRWyWbgtxPR+sXvwAe8gmv2Q9I7xZWULfj9giVMpio64qX0ikjHrMqRn2wV+jIJPq
	 8vvZ2/fxfbkMGDZCWY+UvVvBsD/Umx6xkRarnbjgK4kCl14EscwXd8G5wODwG5VWw/
	 5yPFBJrhVkDNChW2z8SBv5BX3LMF6FvLGeFq0lSwOGTknK79Xg8JFM+iJcLJP6Qhy+
	 VrdbQ2t4pzACOKtUXPnPNlPPJ2rV2Sd/byfqeOLMt2Z4+Et6irSABEAVcGYFFs46dy
	 YRLhekx9eER7uh3s19YQ3Li82TVCAiZjLZEYRXcMjo6GS/5kb3CGZOvu4Y7dUOHOTo
	 cggqD92ptrIgA==
Date: Fri, 3 Apr 2026 12:33:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jes@trained-monkey.org,
 chenhuacai@kernel.org, kernel@xen0n.name, tsbogend@alpha.franken.de,
 James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, bhelgaas@google.com,
 dakr@kernel.org, kwilczynski@kernel.org, ojeda@kernel.org,
 boqun@kernel.org, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 ebiggers@google.com, ardb@kernel.org, tiwai@suse.de, tytso@mit.edu,
 enelsonmoore@gmail.com, martin.petersen@oracle.com, jirislaby@kernel.org,
 gregkh@linuxfoundation.org, geert@linux-m68k.org,
 herbert@gondor.apana.org.au, vineethr@linux.ibm.com, lirongqing@baidu.com,
 kshk@linux.ibm.com, vadim.fedorenko@linux.dev, dong100@mucse.com,
 wangruikang@iscas.ac.cn, hkallweit1@gmail.com, kees@kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH net-next] eth: remove the driver for acenic / tigon1&2
Message-ID: <20260403123329.42bed564@kernel.org>
In-Reply-To: <20260403154010.GA335042@bhelgaas>
References: <DHJKGY0F52GL.14FQPOWWO0F77@garyguo.net>
	<20260403154010.GA335042@bhelgaas>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Apr 2026 10:40:10 -0500 Bjorn Helgaas wrote:
> > > -#define PCI_VENDOR_ID_ALTEON		0x12ae
> > > -
> > >  #define PCI_SUBVENDOR_ID_CONNECT_TECH			0x12c4
> > >  #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232		0x0001
> > >  #define PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232		0x0002  
> 
> > Does the PCI ID needs to be removed? There was a similar change that
> > I recalled and the discussion eventually leads to ID not being
> > removed.
> > https://lore.kernel.org/all/20260123033233.16906-1-enelsonmoore@gmail.com/  
> 
> I don't think there is value in removing the PCI_VENDOR_ID_ALTEON
> definition.

Do you want me to respin the patch? "there is no value" is probably fair
but also there's no value in keeping it so LMK if you want a respin..

