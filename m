Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFA606A330
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LPdTtan9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVCsw1QNqz2xns;
	Thu, 19 Nov 2026 07:31:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795033860;
	cv=none; b=N3ho/KX1M6U5K6TIUdSLrbso2/WbQdHQ8sD/DVwePVWPpjV1dYg00AChQm6kLvXvRPkTusnuoUdCTKf6yCxIYJw4d9FsV+tOVH4c25gur8lAF2wEz0/xUvc2depeh4D6LJMvZBvRvO00VPUg/fydW22gPlAj6QVMFilZlMFj/X0kvv0NypRliG+Zj/h5uPhCWqxLU+J9Rxhdm9u7DFbw8jshEaydG9sB7fTh9RaVoDpUVqL1vlulv56+FLufZ2mleh2rXEbfn22Yd2EvCHPH7K2N+P/CtwK1BimF+jcznGiKoTKXlcmF8HMXf2+ZuWtyqywvTGFAtg9NjZyfgAVj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795033860; c=relaxed/relaxed;
	bh=ez9LmG4b9eVGLBH7boAwPlHp2syyq5lIvoydQkmpo3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCWIR5lr5ZQT7A/OLGorRufN4nSWB4Ekzm2CIWufIR50oeWShRgt8jmWHqrs+hcDzQsg9Rqx/Yu/Y8EetZyaXERB7jC/IXFELq0IYfTJrbo0deH+DTEoa/yG2O+96tGvHQAHbFqnRw4xkDoS74LH+4qC9nDrxxG4KMn3jKrqlSezQgfYPfePod4cNHGTulIFJA5nITw1ieQU7BcXH3w81R1uhu6ZhKsizvYcpxJqiwTPiOH4V5X7Bi6xSzMK6UYHjogpwq0hcjyiYXxSNF/VGFFDPfXdkWP+lMx/Rt/tn+BQWQNXEdoF9XNxe7pj1uqjPpCwL9lpInuK8bY4MlfyBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LPdTtan9; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LPdTtan9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVCsv1khJz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 07:30:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6A249418D3;
	Wed, 18 Nov 2026 20:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB001F000C4;
	Wed, 18 Nov 2026 20:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795033857;
	bh=ez9LmG4b9eVGLBH7boAwPlHp2syyq5lIvoydQkmpo3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LPdTtan9fx3kfAbOLc7ZkgV9JLOAFSx25AbJpupJUJwXsr0YUUfM63BqJIkfoCTvK
	 EZXyoEjpFadBf5E7WDBJLj8OuV05ZFMcYf1ouNjYtLfxq4DExQy4cDW2kHrhzugiyt
	 Xcr25N4CUKR7ElPbCrRo2LXRcQ6ihfxFETxzI00D/mUZtMJrT4NUy6JNxEg+t/KqiC
	 ykemTAO3W2LpiIccqG9scJqxFhH2Rh8+/ivi8V7g2o+lMqqh46eN2J8+0xKxY2PJsG
	 FuflwC/ZPPe33kFESZZpanS108HCA2zObmb3FoKfak30huNGOCcZ5N7PJz9llvXlja
	 YLzJPcadmUbCA==
Date: Wed, 18 Nov 2026 20:30:46 +0000
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
 Rendec <radu@rendec.net>, Avadhut Naik <avadhut.naik@amd.com>, Kai-Heng
 Feng <kaihengf@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Breno Leitao
 <leitao@debian.org>, Dan Williams <djbw@kernel.org>, Terry Bowman
 <terry.bowman@amd.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 18/19] ACPI: APEI: Route GHES section reporting
 through extlog
Message-ID: <20261118203046.7987bebf@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-19-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-19-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:28 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Use acpi_extlog_report() for GHES section reporting and remove the
> duplicate dispatch code.
> 
> GHES memory sections now emit extlog trace events independently of EDAC
> registration, using the CPER section severity and one sequence number
> per status block. CXL events that cannot be queued fall back to the
> nonstandard trace event.
> 
> Report all sections before running the remaining GHES handlers. Keep
> memory recovery, SIGBUS handling and notifier calls in GHES.
This mix and match of where things are handled leaves me wondering
a bit if the unification is a good idea.

Sure there is a bit of duplication reduction, but we still end
up with slightly diverging flows.  The ordering of reporting could
also change due to a mixture of sections being handled by each
loop. Not necessarily a problem, but that needs some thought.

I'll wait to see if others are more in favour. 

Jonathan

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/apei/apei-internal.h |  1 -
>  drivers/acpi/apei/extlog.c        |  2 +-
>  drivers/acpi/apei/ghes.c          | 57 +++++++------------------------
>  3 files changed, 13 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
> index 22a33a21017a3..5063c743b4cf0 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -14,7 +14,6 @@ int ghes_severity(int severity);
>  int cxl_cper_post_event(enum cxl_event_type event_type,
>  			struct cxl_cper_event_rec *rec, u32 len);
>  u32 acpi_extlog_mem_err_min_len(u64 validation_bits);
> -void extlog_print_pcie(struct acpi_hest_generic_data *gdata);
>  void acpi_extlog_report(const struct acpi_hest_generic_status *estatus);
>  
>  struct apei_exec_context;
> diff --git a/drivers/acpi/apei/extlog.c b/drivers/acpi/apei/extlog.c
> index 42ba8ba13804f..d1677d299e389 100644
> --- a/drivers/acpi/apei/extlog.c
> +++ b/drivers/acpi/apei/extlog.c
> @@ -31,7 +31,7 @@
>   * CPER_SEV_FATAL or CPER_SEC_RESET -> AER_FATAL
>   *     These both need to be reported and recovered from by the AER driver.
>   */
> -void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
> +static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
>  {
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
>  	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 7d2864fa14503..221f0a81c94f6 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -566,9 +566,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>  	char *p;
>  
>  	sec_sev = ghes_severity(gdata->error_severity);
> -	if (length >= sizeof(*err)) {
> -		log_arm_hw_error(err, sec_sev);
> -	} else {
> +	if (length < sizeof(*err)) {
>  		pr_warn(FW_BUG "arm error length: %d\n", length);
>  		pr_warn(FW_BUG "length is too small\n");
>  		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
> @@ -884,34 +882,23 @@ static void ghes_log_hwerr(int sev, guid_t *sec_type)
>  static void ghes_do_proc(struct ghes *ghes,
>  			 const struct acpi_hest_generic_status *estatus)
>  {
> -	int sev, sec_sev;
> +	int sev;
>  	struct acpi_hest_generic_data *gdata;
>  	guid_t *sec_type;
> -	const guid_t *fru_id;
> -	const char *fru_text;
>  	bool queued = false;
>  	bool sync = is_hest_sync_notify(ghes);
>  
> +	acpi_extlog_report(estatus);
> +
>  	sev = ghes_severity(estatus->error_severity);
>  	apei_estatus_for_each_section(estatus, gdata) {
>  		sec_type = (guid_t *)gdata->section_type;
> -		sec_sev = ghes_severity(gdata->error_severity);
> -		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
> -			fru_id = (guid_t *)gdata->fru_id;
> -		else
> -			fru_id = &guid_null;
> -
> -		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
> -			fru_text = gdata->fru_text;
> -		else
> -			fru_text = "";
> -
>  		ghes_log_hwerr(sev, sec_type);
>  		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
>  			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
>  
>  			/*
> -			 * Check once for all three consumers below. The 73-byte
> +			 * Check once for all consumers below. The 73-byte
>  			 * UEFI 2.1/2.2 layout is the floor, matching
>  			 * cper_estatus_print_section() and making
>  			 * validation_bits safe to read.
> @@ -944,37 +931,17 @@ static void ghes_do_proc(struct ghes *ghes,
>  			atomic_notifier_call_chain(&ghes_report_mem2_chain, sev, mem_err);
>  			arch_apei_report_mem_error2(sev, mem_err);
>  			queued |= ghes_handle_memory_failure2(gdata, sev, sync);
> -		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
> -			extlog_print_pcie(gdata);
>  		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>  			queued |= ghes_handle_arm_hw_error(gdata, sev, sync);
> -		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
> -			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
> -
> -			cxl_cper_post_prot_err(prot_err, gdata->error_severity,
> -					       gdata->error_data_length);
> -		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
> -			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> -
> -			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec,
> -					    gdata->error_data_length);
> -		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
> -			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> -
> -			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec,
> -					    gdata->error_data_length);
> -		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
> -			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> -
> -			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec,
> -					    gdata->error_data_length);
> +		} else if (guid_equal(sec_type, &CPER_SEC_PCIE) ||
> +			   guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR) ||
> +			   guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID) ||
> +			   guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID) ||
> +			   guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
> +			/* Reporting and subsystem delivery are handled by extlog. */
> +			continue;
>  		} else {
> -			void *err = acpi_hest_get_payload(gdata);
> -
>  			ghes_defer_non_standard_event(gdata, sev);
> -			log_non_standard_event(sec_type, fru_id, fru_text,
> -					       sec_sev, err,
> -					       gdata->error_data_length);
>  		}
>  	}
>  


