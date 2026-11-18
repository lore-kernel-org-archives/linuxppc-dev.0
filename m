Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D1B60A260A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuK7hCqB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV9pJ0rvHz2xdX;
	Thu, 19 Nov 2026 05:57:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795028264;
	cv=none; b=KI4b5Mjk3bTZQ3XXuO2dKy3ierBiRIU4Y0ihgzWahZem2Z4/IJ152f9X+xB6/TLnZL0ARNDNHideCYVhg16myrUGjQIBDpiuPXQksJN5p0Zs2Q1zBMeJgA+P76SdWPMtSIlbBFyo8Qd73FqffDotQR1yOd+WBqBcVF0b1OylIMrfICCC69TnHkK1Ssa9WISEGQe7jFRKIL56w1I1ErIk+GK4ndi64o5KxpRNUtQl6ikSMpZi/26oYZ0pDN3xVgAatx5YERiRkVaujzFecovvfmPHVPc0ghSJ5pm5MKgO8r7YAmr74MKWG3fVBrNxC30dQflKEnTthfhlFWKCj22czA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795028264; c=relaxed/relaxed;
	bh=wtLQxfMRtrekLd+atuTLxz0xh/VLPsXiZh9Wc00ROy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQrZvTwepNOyenaFBimVj5FtLg7HQKCa9a9qnZJzikSHgrBpQ/nMTVCkFqWk+3RI40FOJ0VMzmdhomnTN8yUCaPUIwq02XAo4FHkUQrms4SR334iGySTYC4D2US4XvTAljuIxCwLPS4dWKjty0DHTsNyZ2lLbl8J9EIJVXyJ2d5haAYAOku3lGuQVaISTVRONOnSc2iTBu+uyHo9V+kDRQnKC8WipBCauOl2htx4ZEISHJVJ2yU59C/kICCoSafzflTcr+eRwwt9Vg0VBh3iqv+27K8T9dBjOzQAHc1hc+HjPgTJX4VfZaDu3oDqV7z4YUkK/PBrbaLSz9MaH+seuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuK7hCqB; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LuK7hCqB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV9pH28qtz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 05:57:43 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 359F963825;
	Wed, 18 Nov 2026 18:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66A11F000C5;
	Wed, 18 Nov 2026 18:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795028260;
	bh=wtLQxfMRtrekLd+atuTLxz0xh/VLPsXiZh9Wc00ROy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LuK7hCqBsWO5Cipeg3+rarR8Ul56thvo1icX282u2Yrw9tPr1sW27gfa7QmNrUKhd
	 VX7RACiX99M+VjFrFyVC09R7g/0PZak5M2u1SiUExVC8tfQEdxZfA7+/pcB0hbwDDk
	 QRD+m5Zx6BqDtSscym6xKDP9SaYQrFtvLGE/GWIIm7lIIdVf7J7W7AP+raXqGndq0c
	 XVbi2vVWqNVSs5KQhfa7Zf8KKvyuk6IQbdpi76SAX2L/OznyEhu8qjEu4xPLkcp5ws
	 94lXHDqPwhp04HXyGjmM6u27nyAcMKX/GnhkRiABcQhyDBrWxixSt19N8gKqfFXhEf
	 N0ch+X6AzXtig==
Date: Wed, 18 Nov 2026 18:57:21 +0000
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
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Kai-Heng
 Feng <kaihengf@nvidia.com>, Breno Leitao <leitao@debian.org>, Dan Williams
 <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 02/19] x86/APEI: Report Memory Error Section 2
 through MCE
Message-ID: <20261118185721.11639b38@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-3-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-3-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:12 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Add support for CPER Memory Error Section 2 through MCE, allowing
> to emit an mce_record trace event. The implementation follows
> the existing CPER Memory Error Section (1) implementation.
> 
> Fix the mismatch between the parameter definition/declaration
> of apei_mce_report_mem_error().

Do that separately.  Trivial but shouldn't be buried in a patch
doing anything else.

Otherwise seems fine to me but I'll defer to x86 folk on whether
this is the approach they prefer.

With the trivial change split out, for both of them.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 07306af5a54b9..703f3b7f700a6 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1030,6 +1030,7 @@ static void ghes_do_proc(struct ghes *ghes,
>  			}
>  
>  			atomic_notifier_call_chain(&ghes_report_mem2_chain, sev, mem_err);
> +			arch_apei_report_mem_error2(sev, mem_err);
>  			queued |= ghes_handle_memory_failure2(gdata, sev, sync);
>  		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>  			ghes_handle_aer(gdata);
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index dc60f7db5524f..a92174793d9c2 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -52,6 +52,7 @@ int erst_clear(u64 record_id);
>  
>  int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
>  void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
> +void arch_apei_report_mem_error2(int sev, struct cper_sec_mem_err2 *mem_err);
>  
>  #endif
>  #endif


