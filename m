Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12913606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 11:59:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSmcF60DTz3bTR;
	Mon, 16 Nov 2026 22:59:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ee9:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794830349;
	cv=none; b=gHHncLhkkMn19BuwJJjAjz3E3K1LUWdFAqpOZFK0YRd2T+OwV8snnq8NwXWyJpeG3CM9T99oqoaZ3QZ90ZBIfRoRyeq6uWTVAa/CwyMBwtTDT0JhqonqO+/cGbB5ngTLUGvJ1M2LTWaVMRZuJtKNMQ/WXHzCw0/9xvTySpantkK1vGJWADt2l4uzre6ldQn3mnfRQQ8PYvcd4oqv96KdOtpuQ0ykH36AnZbLsPR7c/OUJW7i3DRtwyVUD+e2pu50I/61+1PFJzuGV/w8HDFI15uJgNzeLHF4iurmXSebady8g6cvi/LSordCtg5aMciQ/zeWn/jZha6+cm6cso9dWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794830349; c=relaxed/relaxed;
	bh=NHGeGqCVFN2Tv1lma1Bg8GLYblLTY4Dtm4iduW7dQss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVZij5NnzRSf6Qrwt2+WOEZRLTkHPW++EGPZKUxHZVJVZDQc+Zy8tZAxQvBlvZXuDLKkJFklCKCsUpeUnFZRxXa7Ql7vgUsJElQDVcNobCedREEFc5I6nawzkbQjbSF7IQaZzRQll6eTLC9H3o4po9yr635pb/LXgp0ICvMSOwy2AgVqxedy6S221RYBGSK2lPqkS9nt+LRbzYajPXQNgOjfgaFL/wijKrEGXXC1f89mGFfdBk9Q2l34YCVQTevHIs3f6h9h9mVe19rrCTh0CXnQmSqATvMZ7fwteiVHFzTvv9+UW7E+i6snh5g4WSAaJdk3AaxCyksRBG0ZsJzPOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSmcD0kq4z30Yb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 22:59:05 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id BE474283E;
	Mon, 16 Nov 2026 12:58:59 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A33D66031F0E; Mon, 16 Nov 2026 12:58:59 +0100 (CET)
Date: Mon, 16 Nov 2026 12:58:59 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
	Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5/7] PCI/AER: Move AER capability check out of
 pcie_aer_is_native()
Message-ID: <avrwA4wokDuOACxx@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <6a21637111397810d75679d1ca597766f3bf5605.1790531238.git.lukas@wunner.de>
 <7d21f908-ea38-4b8c-9646-0aaaa520206a@linux.intel.com>
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
In-Reply-To: <7d21f908-ea38-4b8c-9646-0aaaa520206a@linux.intel.com>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 29, 2026 at 12:47:26PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> > When firmware grants control of Advanced Error Reporting to the operating
> > system, that not only encompasses the AER capability, but also error
> > enable/status bits in the Device Control and Device Status registers
> > (PCI Firmware r3.3 table 4-6 bit 3).
> > 
> > PCIe devices without AER capability still support baseline capability
> > error reporting through these enable/status bits (PCIe r7.1 sec 6.2.1),
> > but the bits must not be modified unless AER control was granted.
> > 
> > pcie_aer_is_native() is unsuitable to check for control of AER-incapable
> > devices because it implicitly checks for presence of an AER capability.
> > 
> > Move that check to its callers (where needed) to allow using the function
> > for the imminent baseline capability error reporting.
> 
> Agreed that ownership and AER presence are separate questions, but
> changing the semantics while keeping the name may trip up callers that
> assume "native" implies "present".  Would a separate ownership-only
> helper (e.g. pcie_err_is_native()) be cleaner?  It could also replace
> cxl_error_is_native().

We usually use spec terms in the code to make it easier to connect the
code to the spec.  PCI Firmware r3.3 table 4-6 bit 3 uses the term
"PCI Express Advanced Error Reporting control", so pcie_aer_is_native()
seems apt.  I agree that it is a little non-obvious that it also
encompasses baseline error reporting control, but that's the way it is.

Thanks,

Lukas

