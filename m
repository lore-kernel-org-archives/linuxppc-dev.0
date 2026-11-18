Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420F606A32C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgDlJU9K
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVCVz4Ksqz2xlY;
	Thu, 19 Nov 2026 07:14:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795032875;
	cv=none; b=fWi0mxt/kN20Knl3dcuowaEZ8Z/tM2pBa5a6M+yeYQ5G6uH00d5WVuyzVFBulDJ+brRt6jhZDEjpwaJNFVxeRAjLDkk8nygFmB3CRHlneLV5akVOMhP9uMnE0Q9ruoR4XLok8s8cWZYbh5AypUwxPVukhNJOhfdN9nt1Lssi4WfN9rND3XcTIV/ppyKwLCwYOvPI//sRRRTYQhwlrQk0dJSVJ/8PwThPqpqNd7C7VbERDzXHc4TfIw8KyyHBYKxWGnb6UBK2BxNBCkfxhOmYMfH0FX9z5Br3hgHh+q4ucaJkKnXFKSbivVESKkUW9kKDV1Wn+cXife8sCC1DtjrSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795032875; c=relaxed/relaxed;
	bh=pUhs6fW7JTG/XV7F5yinkkxTZdkT2kLrXXwi/BnqRWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpHTDNXfazWizaTeIMN9hHVuz1s09p46M2QmhQvYL0SzekoDRJ4bxYLfxZ+dQbcToNUGozgPpwmQDjIItmtReuoXVdcImn76Yeb5OKY04uf9aXoZ7sxqUKGmrHj/GIgUZEjosn4MIlsRcdvmvmAMqgSLoFkshT9jeWip6LNHftQo0wGMdO52bCm2ekJBThlTiC6kFom/UU47+Crdfy17dY+cYiOEBUVYMAEce8O83hPdPSJq4D6Eri8c5YOdDy1SbUV4Rrz3jRIIwNzAD4jpm0978EcvGuJQLBBD/cpZcL5ODBgokGpIHa1WzKgCpkSFtmJ/x9T5dthyXW7jAT0ydg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgDlJU9K; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgDlJU9K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVCVy4hF6z2xdX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 07:14:34 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 179384087F;
	Wed, 18 Nov 2026 20:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292131F000C4;
	Wed, 18 Nov 2026 20:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795032872;
	bh=pUhs6fW7JTG/XV7F5yinkkxTZdkT2kLrXXwi/BnqRWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SgDlJU9KQwoCY7Uj7jzC0Qcq473jHIyRID8jZ5fvl0wB8SFc8SfBVnUdD2m1Pkfe0
	 +FVlzCHOF7CVIbheRt1Jaf9XvfAoDCOfZ/vlacxvcQLrCIbwz8PHgMf5+VIWDS7UuG
	 QRu4rUGXHUZ7Zz31zetvTyZdx+z4u86WqG/VRcFvfFMDnCjF8VsBTrucw6yDPEiGdg
	 G3gD80JGuI+UFz0js3gcgBM4TLrupQLcWQ1MR6bNT4PnOL35ZjP7jKGCZOtjde1+t0
	 NqQm5QLRhKfiqVaVmdoONuIgH2vX9a4TwcmTVUIT2/tiwHfVpfXxa0azpvAEVvUQET
	 6qKwxwvqSqcKg==
Date: Wed, 18 Nov 2026 20:14:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Hanjun Guo
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai
 Xue <xueshuai@linux.alibaba.com>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu
 Zhuo <qiuxu.zhuo@intel.com>, Radu Rendec <radu@rendec.net>, Avadhut Naik
 <avadhut.naik@amd.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, Breno Leitao
 <leitao@debian.org>, Dan Williams <djbw@kernel.org>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman
 <terry.bowman@amd.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 15/19] ACPI: APEI: Extend common CPER reporting for
 GHES section types
Message-ID: <20261118201426.5698499a@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-16-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-16-pierre.gondois@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 12:10:25 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add ARM processor tracing and CXL media delivery to acpi_extlog_report()
> to prepare for GHES reuse. Trace CXL records as nonstandard events when
> validation or queueing fails, preserving their payload and FRU metadata.
> 
> Reuse acpi_extlog_mem_err_min_len() to accept legacy 73-byte memory
> sections while rejecting records with missing fields marked valid.

I'd do this separately and add more info on why... 
The others are more trivial

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>


