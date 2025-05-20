Return-Path: <linuxppc-dev+bounces-8767-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C8BC54E71
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 May 2025 19:48:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b24qg19hcz30N8;
	Wed, 21 May 2025 05:48:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747770527;
	cv=none; b=DWOPYt0hybjGwQZsd9qLCwiO2i872E/dfgSz2knfcs5aIp1xu89nxKjXKp+9DkJWxQ0u8ql50mXil1ffmkhZzFnCAfJAB+Z8uRpFXHGJNUMKwgkc2YHr746jn/Tb2HTQQT4pQvUBUZ0zaJK6+RMrv+7EpnIns+1SAZYQb4qeU1lpz49lwUDEahKy58ktqCNGWf6y4Lj7VyEFlMxr2LzyOhqlxtb6qsXZgQKrieizPD7QD6anOTY3x54igEMDuYo/FnKmDXm9h+uJtGbZFeYzl8huXSidQocuw3ebZ2hTogfS6MdAoASOK4gWRLlZr9kUeJ/I4LT3aaU10u+buVK4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747770527; c=relaxed/relaxed;
	bh=SX7MJfKZjZVgd8tmYuyuiZ4ICwofJ4NtjUqrQGjGPLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AKTpDag5Lvh0HJweLkJjsjLcghydc6JmLpSFaXvaaE8LgdCXXZVLMHaQhlP0ifObpnGx2saAGglTh9vwdbUtxA01yxeVNKSNJLFxYLBUOehefYFY2W5nr2hLZJ/JQgGpMnPCrBT0E5b2pJAbPfXkzRRlup0obUTzQtwZ/fukygjYm+z5NwE7YauOek9rRICYZveR9m73LEfHyXV3uf/Z+RDg3NWvpclfv93tKJJ+JUfrzfQWeO1NKh/EB5jLcESMEVbWTL1CnucIvAAW9A4nMx5ZbiIsD6mX87+ZmwPKVEmui69jv1QWQHN6e9RIY8w84l/+IxkXiXjo9l8uw0Hukw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vJeCd7ed; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vJeCd7ed;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b24qf3N1sz2yr8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2025 05:48:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A0EB9A4ECC4;
	Tue, 20 May 2025 19:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F9BC4CEEF;
	Tue, 20 May 2025 19:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747770523;
	bh=rJ1NiSRfc8gpNdAqLlhzaGL9WlXqzxBGZtEhkpBNqWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vJeCd7ed0I5OQT/nS2fBITuRrAGtfXaxPS/EEjWf5+++YkUUyHEUnd5QyhRwccQoJ
	 cHSsMu18hMq3i+PlKGWx4XKZo4KUcxqztv1/L+w7bEPHrGFpVeCJjS8xESkhBVH2w3
	 PlZs6mxDe8tRcyDXDdCdaz9kJeHftHaUQh7O7m72pGJuJJxJ9BPssncTR8B26gTDZ8
	 JTt0/aQPbhIa8mCfxxsjwK+OICMFJONwprmU/lYq4bhtpUXJzAxBq/EAuQUlLULnOT
	 QhARHJa7o73VRZeaNEalCseBqxtE8T8I8chDLtShaCgkJPNlrhhncTIxrT0eI/Q+en
	 Qm/orCRlfQpHQ==
Date: Tue, 20 May 2025 14:48:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 15/16] PCI/AER: Add ratelimits to PCI AER Documentation
Message-ID: <20250520194841.GA1322094@bhelgaas>
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
In-Reply-To: <75a3749b-36d9-467c-80a7-7e4a42e2f9b1@linux.intel.com>

On Mon, May 19, 2025 at 10:01:09PM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> > From: Jon Pan-Doh <pandoh@google.com>
> > 
> > Add ratelimits section for rationale and defaults.

> > +AER Ratelimits
> > +--------------
> > +
> > +Since error messages can be generated for each transaction, we may see
> > +large volumes of errors reported. To prevent spammy devices from flooding
> > +the console/stalling execution, messages are throttled by device and error
> > +type (correctable vs. uncorrectable).
> 
> Can we list exceptions like DPC and FATAL errors (if added) ?

Like this?

  +... messages are throttled by device and error
  +type (correctable vs. non-fatal uncorrectable).  Fatal errors, including
  +DPC errors, are not ratelimited.

DPC is currently only triggered for fatal errors.

