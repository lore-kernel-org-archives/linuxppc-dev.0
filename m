Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364DA606A33B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXsuDz2Q
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVCHN6R3bz2xdX;
	Thu, 19 Nov 2026 07:04:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795032272;
	cv=none; b=WBD3UYqv72BsD04SzPR2ZzlfLEjNMq3kavxIgEdLv2Ol1wRhHcXd8dro7eTie9XBA7S3EW5/A8tSFA1RVFwILkX/GOgAC2cDmt+TPWl59y9PqrFfde0Tjz9TS40rmEUZPqoz1Bz7EN+O052rvUf0ECgKt0CFIJIY/TjV0LsfDF6oH/OMeuv7vrIpXGiRBUCuoKZGWyWo7xlcVwEwPcJAZsp/qdu443iHQxEeiW5Dk8ObaAhIulhEDc3aSOuNVEMoqkYfmyLuuTC8sSArHUVJgmzDZ34BF5VI1kUmMmjQz0Xw+DncPH87bSBbR7YgNK5qn5ow4t0nmF6WQzEh0e8Ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795032272; c=relaxed/relaxed;
	bh=KG1mjfcXzaJzGAZP0WznA6ezlruVcDCnyBjVr5/t4MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpKxtuihYyxW5JzWLqf1mV/7B6HdlN/gBVtCf5O5TdsRNLh0E5HnU5umum7dNE2f3dmXeoL3IIinq+pSAHR3n1/YtomIzeWhULwfqKAYQY/G1m+2/oHiG7vPgQWSo273S204r6fh25nIIP0s9Xa6l+4BqNcH1LOYgGPcrKpx+fd26BF4kbPR897UGRJ3g76av5JsK1GYktjLXCFdnuhHp3FDBkQVgeEVDhkWg2PlF8fVgg0fGB4W+Tszoxj6MU8b7+4fQqFXvHdtb41Bc6qyTfBtxLkOGnZakqxl33hVGGnBIb0cDf0uqXc2R5P4/gou6xtROKsHSPP7YTw+apeKSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXsuDz2Q; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hXsuDz2Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVCHM5Y1zz2xSZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 07:04:31 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C0ED94026D;
	Wed, 18 Nov 2026 20:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D590A1F000C4;
	Wed, 18 Nov 2026 20:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795032268;
	bh=KG1mjfcXzaJzGAZP0WznA6ezlruVcDCnyBjVr5/t4MQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hXsuDz2QRvI+jQBnp0CteauGv8WTUwSyhTcW+rQ1X+BXjf4WM7RGS6D1q8KfBJwfr
	 jObpVFxMTFop4+tKCizD89fJAsULT4wcT96w1IGIjDzjn2NifJUmoeftL850htgPuQ
	 +9lnsce44uDoIC5/9+1jIGIcyQt/rXofzqVfRBbp6czao5x1dgpit0eXw0u8IxjKT0
	 KYUoWr5H3KcE4/InQ5Nq6if6L2lBqK6214K8V2i5kCd6Y3Pfx4AIPDA2LR4KVNqoz9
	 jBs7Otbc1XYyzrJLTSJ8p6R0WWQR67Av7pKKax+434DoYSvZq9+f5mjnTxJU1BkpvS
	 jZVBhwoHzIuFQ==
Date: Wed, 18 Nov 2026 20:04:17 +0000
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
 Zhuo <qiuxu.zhuo@intel.com>, Avadhut Naik <avadhut.naik@amd.com>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Kai-Heng Feng <kaihengf@nvidia.com>, Breno Leitao
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 12/19] ACPI: extlog: Extract CPER reporting from
 acpi_extlog
Message-ID: <20261118200417.42034547@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-13-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-13-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:22 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Extract the CPER reporting code to a separate file in order
> to re-use it in the GHES code in a later patch.
> 
> CONFIG_ACPI_EXTLOG selects ACPI_APEI_GHES and acpi_extlog_report()
> will be used in ghes.c, built with CONFIG_ACPI_APEI_GHES. Thus also
> build extlog.c under CONFIG_ACPI_APEI_GHES.
> 
> Relax the definition of extlog_mem[|2]_event tracepoints to
> CONFIG_ACPI_APEI_GHES. The common reporter references them even
> when CONFIG_ACPI_EXTLOG is disabled. Guard its memory trace calls
> with CONFIG_RAS because GHES can be enabled without RAS.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

There is too much going on in here that isn't code movement of
Kconfig stuff related to that.  Those other changes need their
own patches were you can describe fully why they are being done.

> diff --git a/drivers/acpi/apei/extlog.c b/drivers/acpi/apei/extlog.c
> new file mode 100644
> index 0000000000000..8eef33a4326a7
> --- /dev/null
> +++ b/drivers/acpi/apei/extlog.c

> +/**
> + * acpi_extlog_mem_error - trace a validated CPER memory section
> + * @gdata: section header followed by its payload
> + * @err_seq: sequence number shared by sections in the same error record
> + *
> + * The caller must validate the payload length, including any optional fields
> + * claimed by the memory validation bits, before calling this function.
> + */
> +static void acpi_extlog_mem_error(struct acpi_hest_generic_data *gdata, u32 err_seq)
> +{
> +#ifdef CONFIG_RAS
> +	struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
> +	const guid_t *fru_id;
> +	const char *fru_text;
> +
> +	if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
> +		fru_id = (guid_t *)gdata->fru_id;
> +	else
> +		fru_id = &guid_null;
> +	if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
> +		fru_text = gdata->fru_text;
> +	else
> +		fru_text = "";

See below. This work is done in the caller unless I'm going crazy
and it's a different fru entry...

> +
> +	trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
> +			       (u8)gdata->error_severity);
> +#endif
> +}
> +
> +/**
> + * acpi_extlog_mem2_error - trace a validated CPER memory section 2
> + * @gdata: section header followed by its payload
> + * @err_seq: sequence number shared by sections in the same error record
> + *
> + * The caller must validate the payload length before calling this function.
> + */
> +static void acpi_extlog_mem2_error(struct acpi_hest_generic_data *gdata, u32 err_seq)
> +{
> +#ifdef CONFIG_RAS
> +	struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
> +	const guid_t *fru_id;
> +	const char *fru_text;
> +
> +	if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
> +		fru_id = (guid_t *)gdata->fru_id;
> +	else
> +		fru_id = &guid_null;
> +	if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
> +		fru_text = gdata->fru_text;
> +	else
> +		fru_text = "";
> +
> +	trace_extlog_mem2_event(mem, err_seq, fru_id, fru_text,
> +				(u8)gdata->error_severity);
> +#endif
> +}
> +
> +/**
> + * acpi_extlog_report - report sections of a validated generic error status block
> + * @estatus: caller-owned status block, already checked by cper_estatus_check()
> + *
> + * The caller handles console output and firmware acknowledgment. Section
> + * processing, including PCIe recovery, does not depend on RAS consumers.
> + */
> +void acpi_extlog_report(const struct acpi_hest_generic_status *estatus)

Given there are functional changes in here, it may make sense to do them
separately from the code move  / factor out. 

> +{
> +	static atomic_t seqno = ATOMIC_INIT(0);

Why did this become an atomic?  I don't mind that but I'd have made
the change in a separate patch so you can explain it.

> +	struct acpi_hest_generic_data *gdata;
> +	const guid_t *fru_id;
> +	const char *fru_text;
> +	guid_t *sec_type;
> +	u32 err_seq;
> +
> +	/* log event via trace */
> +	err_seq = atomic_inc_return(&seqno);
> +	apei_estatus_for_each_section(estatus, gdata) {
> +		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
> +			fru_id = (guid_t *)gdata->fru_id;
> +		else
> +			fru_id = &guid_null;
> +		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
> +			fru_text = gdata->fru_text;
> +		else
> +			fru_text = "";
> +		sec_type = (guid_t *)gdata->section_type;
> +		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
> +			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
> +
> +			if (gdata->error_data_length >= sizeof(*mem))
> +				acpi_extlog_mem_error(gdata, err_seq);

I'd move them with old name then rename in a follow up patch.
Particularly as the new code duplicates the fru stuff above - that
needs explaining which can't be done in code move patch.

> +		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
> +			struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
> +
> +			if (gdata->error_data_length >= sizeof(*mem))
> +				acpi_extlog_mem2_error(gdata, err_seq);

Same for this.

> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> +			struct cxl_cper_sec_prot_err *prot_err =
> +				acpi_hest_get_payload(gdata);
> +
> +			cxl_cper_post_prot_err(prot_err,
> +					       gdata->error_severity,
> +					       gdata->error_data_length);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
> +			extlog_print_pcie(gdata);
> +		} else {
> +			void *err = acpi_hest_get_payload(gdata);
> +
> +			log_non_standard_event(sec_type, fru_id, fru_text,
> +					       gdata->error_severity, err,
> +					       gdata->error_data_length);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_FOR_MODULES(acpi_extlog_report, "acpi_extlog");



