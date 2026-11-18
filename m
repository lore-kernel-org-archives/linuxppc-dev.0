Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3897D606CB22
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPTRhgOs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVCLS6zZyz2xlY;
	Thu, 19 Nov 2026 07:07:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795032432;
	cv=none; b=FbT6vEUd+aIgSLN5P5w9NvP0dTixD53xwXLcT9zK2ez26T0g8aGeBmyMEvCEoZUIogErGLsVbFszXZfisoLYTGUcdfgCOOHXS6yBmxfJjiZXLbqj0Jd8+5XvKlkVU9suuHOTXLCFi6WkOgp0MpTiVTRFnxIhqahJkVBJW5DJXu1TbOOea5KtQk+Rdo15AIThjbXj1DsCCUzFu633By0wQRIaWcof26ni1CAnkxaW+y6Rf04dDUWSjfdvvLpChBhG7j0DQZfk61DR4UZ2vDc4mUkWaa/6B0RPekSIkf6v03QQt74+J90dZQiqOFWl1WVhBviw9ip5mPyn+SDWLYe3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795032432; c=relaxed/relaxed;
	bh=Ydr2zuUo4Y+Eu5vs2uIcRAQ0D83Gb2IoOYjqdt7Pl2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H677urmdce2qzpsU0R7KsosDZ2RXZVfOaSgh4BYGd7YuURoq9rLunzBvpKehHYq4X2hzkphNRCyXOZCC96qvBwoAnfRgG4JrpYmTwk5zEzDtsnSTocLgYreUVcT2cgTDDNkECFUUk+MB38q+B2B9BRe44G0tZLv9+DIv4FQhqYVQIGyIcgvmQOnv36EPPjB6ILipZOVmKulYeLlJJq5qLmWb67tJLk9yafn5YRU6IhwDCbrYsJ38JPs5i71mnrO1n+jkGsuWC5XY7phuOK0A9s6ZRZCwxTboE39dxSDcXJoNO4857Xka8kWKvQOOIOaQvRWO4rB+/SBRg5JWo+2xgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPTRhgOs; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPTRhgOs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVCLS2SKZz2xdX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 07:07:12 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8900663A6D;
	Wed, 18 Nov 2026 20:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0821F000D3;
	Wed, 18 Nov 2026 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795032429;
	bh=Ydr2zuUo4Y+Eu5vs2uIcRAQ0D83Gb2IoOYjqdt7Pl2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jPTRhgOsJ3gg9xAK3g1Kxi/CA9EBREb/tAFnQ69biXVG8KJQxY4VY55gGxMgxbxMm
	 HuUwmxC6iqTnSdybEJfmpuaXeFpp+csnzklAdxn7PjBEs5WIWMcgYJyhT2OFeTBee9
	 y0BRDXSr+3DPOn9WkTbyfg0ILxQAWuhvk5F26WpWV1g8oOstjYX+kdxU4ekO9rkTXw
	 Yy/qU9eXDfUrBkjNvne7I6B98W6eOVnwLr80IOwKhpsn7thKaHjd/uOO8F7ebaUdnZ
	 DWmuXVGRBFLjieYHQ1/v3GOQUEuJJguNK84Y5TVkq4/NJtLsBBkmSubqbE78/+3N8g
	 1tSzHbnWZ2khg==
Date: Wed, 18 Nov 2026 20:06:56 +0000
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
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Radu
 Rendec <radu@rendec.net>, Avadhut Naik <avadhut.naik@amd.com>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, Breno Leitao
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>, Dan Williams
 <djbw@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 14/19] ACPI: APEI: Return status from
 cxl_cper_post_event()
Message-ID: <20261118200656.596420c2@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-15-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-15-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:24 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Callers cannot tell whether cxl_cper_post_event() queued a CPER event or
> discarded it. Return 0 if success and 1 if aborted. Existing callers
> continue to ignore the result for now.
> 
> A worker that is already scheduled still processes the queued event, so
> its schedule_work() return value does not indicate a delivery failure.
> 
> This prepares for a following patch moving PCI/CXL handling to
> extlog.c.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Given no error codes are returned, why not a bool return?


