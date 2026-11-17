Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E23606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:50:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTNMb62YMz2xnZ;
	Tue, 17 Nov 2026 22:50:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:1000::53df:5fcc:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794916219;
	cv=none; b=OoqPrZMWrOovQbSFgbgfAne6Us6HA1VEbwwhhvb9hFdo6bjKNExtOBlsOwfhaiIRdOcokt1uZmKqgEDs2VKeTe1RbkpxG0PYdSBjcpUDvm1FD4YJuAiKi3kAKra+Y+jyAUYIl7mw3QrBODdFtMOpaBEfZhKWz25QgH0pw4sASYLjtW8xLnu8cfKTwzBVjG1od1POvoBJ1ngQa8lvqtgFfJEfGMqhEDggoaJQvzgaNvQYodNJg/FgByIqioOvvbclQtk9rzNeBSrUKnBxyU3Np7qLJ3w4dTulTwnhaMGWd4O7TesD8kJDNrTavHApGScT0wk+iQ/kwtNMIbzudSt+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794916219; c=relaxed/relaxed;
	bh=EwfpX7pGND05sD8odESGTeZ36nfl99+U15YYrIY2qBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAjjcVlnMP2q9bJ06aXtVzcphmyk1bpq3uuEPAiFBRSe1DShf/u0MmN1nQ1AI0+YafJRMz8O7iqi7Liyw1xmKkTJw6QOMVYjv9N1HXBLCDagK7kS/juoznsLw6Ggtjj4EssdeVpWddqipQb4RCd7kpHk4W0tIA1MtYtxzT2C9eJSRxM7wFC2UuuNB3o2wWHKDtsAycyGOwT3/B1vofxb4zXntrhY58ujgp6j+ahNG8u9O5ulUsylDxpmUqZKwxbbLTokSsQ8Ozm6HsEPLPyl57HHZHWwLgUoW9dPBSXge9Fu9WBqIye0TlZWDesrjw5LF77Nle4NHTo8BccZsv4Fdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 151247 seconds by postgrey-1.37 at boromir; Tue, 17 Nov 2026 22:50:18 AEDT
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTNMZ6lcrz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:50:18 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 145D31A07;
	Tue, 17 Nov 2026 12:50:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F2DAC6039C25; Tue, 17 Nov 2026 12:50:13 +0100 (CET)
Date: Tue, 17 Nov 2026 12:50:13 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>, Radu Rendec <radu@rendec.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 19/19] PCI/ERR: Avoid NULL bridge pointer
Message-ID: <avw_daENKPcY7_04@wunner.de>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-20-pierre.gondois@arm.com>
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
In-Reply-To: <20261117111444.4185512-20-pierre.gondois@arm.com>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 12:10:29PM +0100, Pierre Gondois wrote:
> Return PCI_ERS_RESULT_DISCONNECT when no upstream bridge is available,
> avoiding a NULL pointer dereference in pci_walk_bridge().

How can that happen?  If it can happen (which I doubt), why isn't this
patch tagged for stable?

Why is it at the end of this series?  Does the series somehow make it
possible that there's no upstream bridge?  Which patch does that?
If the preceding patches are not the cause of a potential NULL
pointer deref, why isn't this patch submitted separately from the series?

Thanks,

Lukas

