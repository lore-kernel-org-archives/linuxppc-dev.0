Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F4606A335
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:45:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTNFW44Dvz2xqJ;
	Tue, 17 Nov 2026 22:45:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ee9:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794915903;
	cv=none; b=T081ADJ+u9RCPFgTCk/ZPOKAZdZbCDKVsQ3TwOXVSGDDThBp2DTbKUXVD4coRKcJ6eSsdgdWGDGJGZfMCzP7oADmycNPqjHZdZyzAOenGL44bNWK1A012BvOpXLTAQ+nqm46ShvTcnL2e6Z9+IVasztpNKCGYFYkgCoxLhStgXGJVcg5IWFOC9tRNxxJiWSTD/5+zpaTRg903UbsgJ9UMgJs8KgQaXrFMPoYz2ojWvEu/QI1Rbjsf82NsvZORuEb59Y6IjwOc+r1KNTd1OjwKgvJuPaSHOloXiapYgWS0Q1wV+zn5lWahaIksYUCypteb1gyBxiEmF7adJ55jv2ITg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794915903; c=relaxed/relaxed;
	bh=n6w3cO92Rq3N51GC+FtnyfKYSdVpvLf9WR3UZ2ynCHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv6IR/iIKfA0w7jlmGW+mEqPQFtIFXu4drM3SeO8W9nTAeFU/LRQPoPAzEeW9mvcF2Xcdx7uvlyp5fsu8U3s0je4OaeDvUTIbRPyd23MqtcuMOTfMkkeG6epms8KTvF8sYNqUIP9dCdwHrQJYx6nfjJKgtVspDm2Lot0dUb/MLbk69wL3dnk8Df879xyd+bzC5ww3CUbqf7cZ00OPT8TxN54o+k7swlQrh0o/Qa5X8ehVl5gt2EprUJzUK9tDJ1Hzbn9MubxN/Md/bS9ZGnpTBMOX+X0BUps02PFSAWAVXxcgl+3qKdeYINzoE1CivQIOdoAbouRdR/H7XewewE2oA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTNFT5YxMz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:44:58 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 107EE2825;
	Tue, 17 Nov 2026 12:44:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EFB5E6039C25; Tue, 17 Nov 2026 12:44:52 +0100 (CET)
Date: Tue, 17 Nov 2026 12:44:52 +0100
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
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 05/19] PCI/AER: Embed aer_capability_regs copy in
 struct aer_recover_entry
Message-ID: <avw-NChMgIjwFuv1@wunner.de>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-6-pierre.gondois@arm.com>
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
In-Reply-To: <20261117111444.4185512-6-pierre.gondois@arm.com>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 12:10:15PM +0100, Pierre Gondois wrote:
> commit e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error
> status data has multiple sections") passed to aer_recover_queue() a
> newly allocated copy of pcie_err->aer_info instead of providing a
> pointer to the ghes struct. This prevented corruptions of the ghes
> record (in case the ghes record was re-used for a new error before
> the previous error was logged).

Since commit eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors"),
aer_regs is modified for a recursive invocation of __pci_print_aer().
The copy is necessary because we don't want to modify a buffer owned by
platform firmware.

> +++ b/drivers/pci/pcie/aer.c
> @@ -1352,7 +1352,7 @@ struct aer_recover_entry {
>  	u8	devfn;
>  	u16	domain;
>  	int	severity;
> -	struct aer_capability_regs *regs;
> +	struct aer_capability_regs regs;
>  };

This increases stack usage significantly in aer_recover_queue(),
which is not good.  A kzalloc() allocation may be better suited
for such a large struct, instead of relying on the stack.

> @@ -1374,24 +1374,14 @@ static void aer_recover_work_func(struct work_struct *work)
>  					   PCI_SLOT(entry.devfn),
>  					   PCI_FUNC(entry.devfn));
>  		else
> -			pci_print_aer(pdev, entry.severity, entry.regs);
> +			pci_print_aer(pdev, entry.severity, &entry.regs);
>  
> -		regs = entry.regs;
> +		regs = &entry.regs;
>  		if (entry.severity == AER_CORRECTABLE)
>  			err = regs->cor_status & ~regs->cor_mask;
>  		else
>  			err = regs->uncor_status & ~regs->uncor_mask;
>  
> -		/*
> -		 * Memory for aer_capability_regs(entry.regs) is being
> -		 * allocated from the ghes_estatus_pool to protect it from
> -		 * overwriting when multiple sections are present in the
> -		 * error status. Thus free the same after processing the
> -		 * data.
> -		 */
> -		ghes_estatus_pool_region_free((unsigned long)entry.regs,
> -					    sizeof(struct aer_capability_regs));
> -

So you're removing the call to ghes_estatus_pool_region_free() from the
worker...

> @@ -1441,17 +1431,18 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		.devfn		= devfn,
>  		.domain		= domain,
>  		.severity	= severity,
> -		.regs		= aer_regs,
> +		.regs		= *aer_regs,
>  	};
>  
> +	ghes_estatus_pool_region_free((unsigned long)aer_regs,
> +				      sizeof(struct aer_capability_regs));
> +

... and instead call it earlier, before even launching the worker.
So where's the benefit?  You've traded less memory usage in the
pool for higher stack usage.  How is that useful?

Thanks,

Lukas

