Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83065606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 16:54:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSv8j5NJtz2xdR;
	Tue, 17 Nov 2026 03:54:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ee9:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794848053;
	cv=none; b=OvR/rbclH9G/gNhE6vovJNZqEJSyc0vECqdDICYmiqiGBaYM5o+USenCrwip01EBiTDPZlfRM98ZTjZwCV4jGH0J4gEYjhSJK+4EFiqsPknM5CP1R2YTScI1ljkOa8Uw+c7rg1XzklCeqNdJTCd6TGAOPsqX1EJRi3zvYBxRmiRMsCtRKSMcPwR4uIgzYDzmUYd8jpNbWpnru199itcTGhKsnv7Tq22dEe4jzy2YYRaBz+5nnLsiKfMhnO7vFDcwhbuL//UMZieLx8r6kZFFix7rHFNBeGWanV6jk9vmRDz7r8buWDoypRjcgZIMvLztqRq0cUPITiZdwk/mdMf3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794848053; c=relaxed/relaxed;
	bh=LLYENQ2KuzrurPfd6Up/el300vi7eM3VvpjLowoKYEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi41A3Qo7j87sHXW61GV4w1IVKKHHG7pQOziHxjNwUyVJjd3+La22TLvPejnmRmT5KqR4gNKgWbHRQp/EU0NnLjXoeUzHstMeX+mGoRRcMbtOcI44NBNtwsRxBspTEfakMLLj2HRtrD7kHLsYkGGfR0Pebo/MFaY+y5x4yapHIRYIWN7DoSbjcF1A8ws5eXihfu2l81TffudSe6sPN0BQADOIuChb2nq+sCkNUwTGTXLh5cIAN6CJp5hCPBpFwJ6QeZgFmAD5nkzciuyjRs5yJnAy69Frj/2ib8g4mWAxOAq3rXfGkJrzlEEUarSFIjeiz40Iea+WPU9/fko3leJkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSv8h2sTjz2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 03:54:12 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 7D79A8AD8;
	Mon, 16 Nov 2026 17:54:08 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6C0B36035F1F; Mon, 16 Nov 2026 17:54:08 +0100 (CET)
Date: Mon, 16 Nov 2026 17:54:08 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: "Bowman, Terry" <terry.bowman@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>,
	Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
	Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/7] PCI/AER: Drop AER native check from
 handles_cxl_errors()
Message-ID: <avs1MPhrZtf7u_uB@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <1a00e832eab9539f7328f5d547f11b67e17bd0da.1790531238.git.lukas@wunner.de>
 <2604b3c2-4c6e-453c-b7be-d7ff6be1dbb0@amd.com>
 <f6f6c126-cfbe-4e67-8002-c11cf6f84189@intel.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6f6c126-cfbe-4e67-8002-c11cf6f84189@intel.com>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 07:36:21PM +0530, Tauro, Riana wrote:
> Since pcie_aer_is_native() is a generic PCIe helper that could be reused by
> other consumers,
> could we also remove the CXL namespace from its export?

After patch [5/7] in this series, pcie_aer_is_native() shrinks
to a 2-liner:

https://lore.kernel.org/r/6a21637111397810d75679d1ca597766f3bf5605.1790531238.git.lukas@wunner.de/

I think such a tiny function could just be moved to include/linux/aer.h
and become a static inline.  It should also be changed to return bool.

Thanks,

Lukas

