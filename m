Return-Path: <linuxppc-dev+bounces-24402-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9EFC4450A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Jul 2026 07:08:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2HtF5CWPz3c2t;
	Sat, 18 Jul 2026 17:08:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:1000::53df:5fcc:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784358485;
	cv=none; b=atPn24NpBVNx1UALiuk79BMNao5cUwnUpnwTKGxMplv2aQY/UUdE2qi+BByB9ACLznD34UVqJJelpkiPCBQN8ILz2ykUTA2NIV2K9xsqv6Xyy/YK0+m3loVU/mfPi6uNkd52nCQauaI5pDHqGmCncqnnQ+k8Ud8pylSkvnWTIoMCQBWUyu8tMtrvwGTECD9hksuY+pYl/SouVJEC2s5dPsxnSMo8LFKkAilJMGJen8fDRaYpHfzMPZfQ9Ee4d3vETFcYEybNi0m26MxVXeAqnm7YAR4gmBJSw4bplnegmzYlLC9IJAWNTu0L96ITMwXwxiOzyX+TFGZISG7vtqQGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784358485; c=relaxed/relaxed;
	bh=oJLCKYcTclfcDuJWpAWJnS/12qDJiq86hlh4ZJlSbMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S07EpUrUnSkO6o7gmBAo3G6uUtlATddVZJ8612IiwytseYe810CevPppcx6ctcT8RVkLttda1hSw9OwjeR9DBVUNIy7TyogTeHk+V1GOuOLP46tbiHLS/EqI708By9NY8r/Wc+fs+//oT9PABJO17VTVJ7fqlAtFCKuhcMHQPi3obdgBewnl/CqTczTNWNgIvxbVJBb9JJ3T2IuOKvXz+vzdqcpYEmtOiAXZa8Mm7X9i1uD3ZNS4I/5ma7phNtma2WBbuKBGJuDf7GAkfULB/he5Ohl1qoaAHXOow5IRDZbOHnLdwDRMogoURZTs9Uqb7c42d+1vHzQvDtiUwcHnAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 336 seconds by postgrey-1.37 at boromir; Sat, 18 Jul 2026 17:08:03 AEST
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h2HtC6TH1z3c8G
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 17:08:03 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id B53A5378;
	Sat, 18 Jul 2026 09:02:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A23CC603E05C; Sat, 18 Jul 2026 09:02:15 +0200 (CEST)
Date: Sat, 18 Jul 2026 09:02:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Robert Richter <rrichter@amd.com>, linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Alejandro Lucero <alucerop@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Gregory Price <gourry@gourry.net>,
	Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Oliver O'Halloran <oohall@gmail.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 11/13] PCI: Cache PCI DSN into pci_dev->dsn during
 probe
Message-ID: <alsk97jVqw9jbRdQ@wunner.de>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-12-terry.bowman@amd.com>
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
In-Reply-To: <20260717222706.3540281-12-terry.bowman@amd.com>

On Fri, Jul 17, 2026 at 05:27:04PM -0500, Terry Bowman wrote:
> Add a u64 dsn field to struct pci_dev and populate it from pci_get_dsn()
> during pci_init_capabilities() at probe time via pci_dsn_init(). Only
> write dev->dsn when the read succeeds. The zero initial value from
> pci_dev allocation already represents 'no DSN available.'

The DSN is already cached on (natively handled) PCIe hotplug ports
to detect device replacement during system sleep, see struct controller
in drivers/pci/hotplug/pciehp.h.

Please remove that member from struct controller, remove the two
assignments to the member in pciehp_configure_device() and pcie_init()
and change the comparison in pciehp_device_replaced() to use the new
member in struct pci_dev.  You can do this either as part of this patch
or in a separate patch.

Thanks,

Lukas

