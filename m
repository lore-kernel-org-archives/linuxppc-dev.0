Return-Path: <linuxppc-dev+bounces-22096-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA880CD6E74
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 04:14:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWp4G5z6mz2xdb;
	Fri, 05 Jun 2026 14:14:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780632894;
	cv=none; b=KN8cX4LeYVkkJ4LjjCh7LwIOvupYdG3q3yBs6I+9M1kZggK/yxsZ/DB8alWszmSaJSn64nxiznZsN7kbPQbXdpZoEIWm3+h4cwXhGMb37iGD4TsoLtEP/4IQGIlSMxWjTskzRIMB7q+XirQeK/VjWuRk+RZmAf9aynLEHsJj/sq/ieespXWMP+uCcEMK2ngNNFJSUMo36ZNLYYUglZCxuKc5FMVUGSQpgFKWwEGKZWMlkVa/UGNGWl0pm4ZTN88bhS73jLstVJbNaS+pC+z7nmB/xblGsCjLQ/AqHsI5Xx816pouatgFN3ec91AWMp31lABMuaWr+3jAw/O47tlFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780632894; c=relaxed/relaxed;
	bh=LJ7z4fiMTAZ7fAzEyfiZAHwdxVS2Jyf7F7sA34zhgfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKaTLisKjQA1oCuxfUHKtpyRzcdfI4cbUWEwd0Xn+ZIB4syaSQ+SPlmR/736ly11UrcxwGU+tMk1CjcFf483cQhtkScEU1FbQFU9DFwKwXcBn04282elR/qS/obGmF/RdsmSTBp5EI0vUarl1Jf4L6NuM7oK5tVLJeKAF0euz69GwRvASfrZxsP/mioFGOQOLdm8QNR450rpEQTsZ62ucp6iWZz6y8wFwUvUB0BKP2CBahk6RO7/pHqqm1C02xjG9i1HWt/CQRDv6M+aprmeiRA03RnEEURVb2cW4DUxnhGscVPoAyiqcfgvdQ0viEG8iZCUwPnjZvj/r995wM98lA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SA0RTFbt; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+25760b9178a0880d3e7d+8321+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SA0RTFbt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+25760b9178a0880d3e7d+8321+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWp483gr0z2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 14:14:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LJ7z4fiMTAZ7fAzEyfiZAHwdxVS2Jyf7F7sA34zhgfk=; b=SA0RTFbtw7++xeqM4/TBi2XyHl
	OsNHxj9gdfi0UgM2EebSZZ5pP6ZD20zBkoA1aRnOH1iKaGBpFvTFyAA6LA9t4HDaVEdA7kTTbx1N3
	UC9hF8blJBELprFrQ3F0S6pjYGlbCpJnJERQ5XapS7co2zJQCzPJZukheGd7mSzvM+9W2g1fNkurp
	s9n+QHKcf2b02WissFhhCZMd8QUsS4UOjeN/RYUWc1PPTNQF2fENqoiFet+BZXyy+T5KAY5KkP7ix
	Sy0Jy0Z9FTKpx0xD56IQ30IR1Y43bLhYMCck7lQouY6AJ7p8xjxiJ1odiPKjhItw8K+cdyeNIydU8
	epqVkWfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLx1-000000004Gb-1FHI;
	Fri, 05 Jun 2026 04:14:31 +0000
Date: Thu, 4 Jun 2026 21:14:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
Message-ID: <aiJNJ0zP5BocG-Yy@infradead.org>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
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
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 04, 2026 at 08:01:41AM -0700, Dimitri Daskalakis wrote:
> From: Dimitri Daskalakis <daskald@meta.com>
> 
> Scalable I/O Virtualization (SIOV) is the next-generation alternative
> to SR-IOV.

It's not.  It is a yet another very different technology.

