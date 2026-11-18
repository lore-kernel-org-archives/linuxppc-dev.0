Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD015606A32A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAVBtdBK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV9kT2wtyz2xMt;
	Thu, 19 Nov 2026 05:54:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795028065;
	cv=none; b=Xzz5+V9Kd/64nEfX/J0OaoN+zGjQKiQXIHro9MXcxa4XGK32OS19bqls3DWsXZnraP+PEXRU1NNNXRvayApYJss2YT+g38bKqlatYblYmJmsytD8ht9X7vkh0bOosusWzR+SwPEOqoz8GzjAYa7JjpYHJJs83P9nOD9EjOwZ6FTql5cPFwvujiFqWsbXcTN3Ugub2nCWpzQGQZ58RXvE7OqPpLmhYElaTHs9I2Ga0b0VwXP+aZCFfVwABByqDB7WIFoLm4au6iAFMVX1jQrQemFv9cTrBpVmDnQiMOFJJ53XtgZZ94/hcHUQTPlwePgYEAg8iP4Svm20cudKlPu3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795028065; c=relaxed/relaxed;
	bh=TZsTikxfxLhewEbP2xR/h7zJwb5pgHnbb8uIv7AdPeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8y3jTYsxp4XpSTJqv8k16Eg+lE877xU43EBaUwDyD3yl38HQRzbUYDPWbAhH9rHqm1axhoYyv0/W3CBWVU7ssgmGsUfpESqb5fRSLarrqjAn3G9p6fknX5vr7P8fol1jhLqVCK9ED94qxSdw7exoI06YJfXy1/q49NGDrzDO9K5bLmlNc1+AKbFYr4AaoGdk6T+YDXt7+KeUNmp50bKW4vAGUFB7c4PBXl95m0h9JGYFc0yoKQqOq2UR6nZL1LC7RN90Y76Ahn6YHqRJaA9C1AslByW9DTxaauPjcbvIS/a7UUymtPMo+t3fd8ADcH3jxlrBwqmtRKDgJPSFNmcKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAVBtdBK; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAVBtdBK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV9kS1hRxz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 05:54:24 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 391B162363;
	Wed, 18 Nov 2026 18:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD461F000C4;
	Wed, 18 Nov 2026 18:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795028060;
	bh=TZsTikxfxLhewEbP2xR/h7zJwb5pgHnbb8uIv7AdPeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CAVBtdBKiBua6AQR1YohOwJUX4aO/2Q0tv9TEF+7XlxUgb8/hTMAcTjU1BRo9mNhM
	 vXlXljYJ68uR0nta3BcJzXxhizkEaFpau8HtwwTpAMB9EpYrh7caZXxus/c58QuuJY
	 OxQVkJTcj1AU9jmeUw5z+Xmix19MT+e/a7VRcvEgtTgCWDxrCx5CLRGY2oJVGilPrG
	 aIR6R36xz2meISdE12Fj3Lz8mjYuedoWR31zdi66bRgzItaXpNzih99tvTnHEOYx4z
	 3XvTuBvys9gsXyDPTo2lbtBEFr+VVVG264RmidGpNQZXHyWiy/OI5CEwB/o4aShiAP
	 GkmDQRva+xv1A==
Date: Wed, 18 Nov 2026 18:54:06 +0000
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
 <avadhut.naik@amd.com>, Dave Jiang <dave.jiang@intel.com>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Breno Leitao <leitao@debian.org>, Dan Williams
 <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 01/19] x86/APEI: Extract common CPER memory error
 reporting helper
Message-ID: <20261118185406.21700e81@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-2-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-2-pierre.gondois@arm.com>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 12:10:11 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Prepare for reporting CPER Memory Error Section 2 records through MCE
> by extracting apei_mce_report_mem_error_common().
> 
> No functional change.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
One curious question + trivial comment inline.

Otherwise, this is a simple refactor and seems clean to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  arch/x86/kernel/cpu/mce/apei.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index 0a89947e47bc8..b993ac78a3b36 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -26,24 +26,15 @@
>  
>  #include "internal.h"
>  
> -void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
> +static void apei_mce_report_mem_error_common(int severity, u64 physical_addr,
> +					     u64 physical_addr_mask)
>  {
>  	struct mce_hw_err err;
>  	struct mce *m;
>  	int lsb;
>  
> -	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> -		return;
> -
> -	/*
> -	 * Even if the ->validation_bits are set for address mask,
> -	 * to be extra safe, check and reject an error radius '0',
> -	 * and fall back to the default page size.
> -	 */
> -	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
> -		lsb = find_first_bit((void *)&mem_err->physical_addr_mask, PAGE_SHIFT);
> -	else
> -		lsb = PAGE_SHIFT;
> +	/* Missing or zero masks default to page granularity. */
> +	lsb = find_first_bit((void *)&physical_addr_mask, PAGE_SHIFT);

Silly question.  What stops it being bigger than a page?  I appreciate you
aren't changing what is already here but it made me curious.  It's 8 bytes
so limiting it to page size seems odd.

That larger usecase came up last year for how to handle error injection
into a VM that was running smaller pages than the host.

I guess on x86 it simply isn't ever bigger than one page?


>  
>  	mce_prep_record(&err);
>  	m = &err.m;
> @@ -60,9 +51,21 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  		m->tsc = rdtsc();
>  	}
>  
> -	m->addr = mem_err->physical_addr;
> +	m->addr = physical_addr;
>  	mce_log(&err);
>  }
> +
> +void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
> +{
> +	u64 mask = 0;
> +
> +	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> +		return;

I'd add a blank line here given that return is a mite hard to spot.

> +	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
> +		mask = mem_err->physical_addr_mask;
> +
> +	apei_mce_report_mem_error_common(severity, mem_err->physical_addr, mask);
> +}
>  EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
>  
>  int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)


