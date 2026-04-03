Return-Path: <linuxppc-dev+bounces-19263-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA6EE7E34C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 08:48:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnC6n1X9Bz2yVP;
	Fri, 03 Apr 2026 19:48:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775206097;
	cv=none; b=buCcM4uUMUgVDG4tZxT0YJXSo3i9edmgdVkXmRYoo2fKh5oGCnO0AJ9PE5Q1paCBfU0k3vto4frt6qHsn39bu4iTDHisDZcg4lUsoXrt53flD1HDtMcw0puD50TCTaU9mv6Y0lo22IYLzjwYIT9tK+6QsUA9LOPRXUxEGufuQV9CS/zwpeXQ/1KdTCHSPWSYj3hZ+Eag0x5NA2kxmwWAnNLKV0L/7NMjDG4dsnowp7/9DHIqO39FR9P7HIIlfmu5mud67/rXUJ2g5uRsvPtFrkwgVqjn8uLTCXSK39prMmN3cbIlrNibrG3CXTq83vpjMQL96/4ZAWlddxlfzoEFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775206097; c=relaxed/relaxed;
	bh=nRDFfBm/JeJ3dXzFWfWimPLBBQigrP32GadmM5uxPOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxZe/BBUrLPE5I5wnVDFrjAsIoCk8pjYQ+H4wNhwEL0lqQDg49ux8vWM9zT2peY35EHjAc1NkQxnVjTVtXgHKV9HTQTIuplIYoX657k3F7K+8oKKaYNY70IXnnyvMO2h8uez7QscsVlMs91+1gY621H3ktHDsVrTD5wiKA13xy/GrQGL7dJcEJx222p+wG0QhnsHxIQmb2LFsI3iQO5N5XcO+eLCH/cALAHFPtTwQlt5eqeNA5fsDtHBm9tKNbDl9wPBuMOmEYhqcTdZULTiC2FrBFq5wvDmvZ/T0Z4SjN2ZJHQ4TonMyZX3V/fuZQwtu1WjUij9vJ2BUacu4wVS1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LDnk7S/p; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LDnk7S/p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnC6h6Tg2z2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 19:48:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D2A7460132;
	Fri,  3 Apr 2026 08:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5078CC2BCB0;
	Fri,  3 Apr 2026 08:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775206089;
	bh=06cSFbB6Pd8/6jNNaiACu6E5Rd6wULxB8jLFZ7TA/XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDnk7S/pNFohQ10dX4/nYUt5Jgi6pqvcaG/5+Z17/3TfF57gHIwm+IPPm3DCcIV4K
	 1m0r3PW3Qgh1rqa/Fi6GDMYw2CM5NqZ69Ab0CSIQ8tkafCEEca6ZkEU13ibl4g+pP6
	 xtgPq9tl41QLyNGGkg0C6MVpppASUZa43AqTncHA=
Date: Fri, 3 Apr 2026 10:48:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jes@trained-monkey.org, chenhuacai@kernel.org, kernel@xen0n.name,
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
	deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, bhelgaas@google.com,
	dakr@kernel.org, kwilczynski@kernel.org, ojeda@kernel.org,
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, ebiggers@google.com, ardb@kernel.org,
	tiwai@suse.de, tytso@mit.edu, enelsonmoore@gmail.com,
	martin.petersen@oracle.com, jirislaby@kernel.org,
	geert@linux-m68k.org, herbert@gondor.apana.org.au,
	vineethr@linux.ibm.com, lirongqing@baidu.com, kshk@linux.ibm.com,
	vadim.fedorenko@linux.dev, dong100@mucse.com,
	wangruikang@iscas.ac.cn, hkallweit1@gmail.com, kees@kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH net-next] eth: remove the driver for acenic / tigon1&2
Message-ID: <2026040357-flick-coil-0c5d@gregkh>
References: <20260402183029.1236713-1-kuba@kernel.org>
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
In-Reply-To: <20260402183029.1236713-1-kuba@kernel.org>

On Thu, Apr 02, 2026 at 11:30:29AM -0700, Jakub Kicinski wrote:
> The entire git history for this driver looks like tree-wide
> and automated cleanups. There's even more coming now with
> AI, so let's try to delete it instead.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

