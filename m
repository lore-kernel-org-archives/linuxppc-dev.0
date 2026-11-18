Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA2F606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beDKPYGP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVCZW3hq1z2xnQ;
	Thu, 19 Nov 2026 07:17:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795033059;
	cv=none; b=FVtdia37NQSaitgSwL84vXu57lDwoPZUw2IRFzCpR8omiDDAE8/do0UO1FzSbvh17zGzZSOB6RHxc8pSMTQInj8x+Y6ZOgtOq7RdoDT6LHE/u0SLgLe1OjLmxH5CuiMCCQAG/4Q6qs4GnHaiDHCnhqIKnC0NpC/SnWDbpCoh34zSOzTAU3I5irCdtf/zHczIP5l88P12llt8TxGlwj1+vkCnSgQ1n1s4qpFPjOzC4lL2VMUFebegbPZuiK7R4cq0/iS6AcQOgeprlD25JmfeGRp2AE8LfXzY48tM0AkpmEvCF4xhDUe0yBSDD3ttwhhhnDDSD4UWof35h6xErjKl1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795033059; c=relaxed/relaxed;
	bh=mVKoPdMSwhZTZlNTmmoGkN3w0L7rZ4fmniowdnKasL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+yY/DY+JmUNV4okZ2NYIlXX2HxJ9ticdM7vMNVDx9y7su8ILIXnjgKD0SaeHE2Qj0vPVaxi3L02C8EeQvkdGym2VtIWG4Mkh3S++bfCkc48yoccaQ12DRQilGlO+lsKmZIG35VaW6kKiupNjx5Dcwun+1/qA/F90mzI+tCKhxdMUcmLmehv48OvJ/ka16mx07G1x1BTixpqyOBWldux3DqH+PayyDwAN2t6u2wU+6pw7LjjlR4QEbsWokRcMRiPtpIBCHuSR8IpPn4pCWp0FTAyoLeoIMRRyiqMkVmjt7X2WckRTU67diVyAkf1NnQHnE4jcdk+krKyoNXBWc37vQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beDKPYGP; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beDKPYGP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVCZV6wvbz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 07:17:38 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 204C741A29;
	Wed, 18 Nov 2026 20:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8341F000C7;
	Wed, 18 Nov 2026 20:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795033057;
	bh=mVKoPdMSwhZTZlNTmmoGkN3w0L7rZ4fmniowdnKasL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=beDKPYGPep6s5kZbcTpNzbPBGelfYYwJQX6xK4lL4gSNE0x6CH+gKjVOdA9SVmNaF
	 EFYsCmTMH2K7XZmpsiepqr/FflIzKX2yvXmXBxzieXGu/Yg4Op50JpppR58y4hMhOr
	 gxRvQWKN+1Uu/YsnaRceSzATK+5zMhJYNIUJuJm3bEhTvlC4n0HkvwPz+89zXUclKx
	 zTSI+B1Jd58xjMI/cZSNq9L7JonxRc/hpfODsDcu87j7fuOPOq+drZ++9v73W7GEd8
	 OC7JDx6iVDYSLA0S43DhlYyrwrfp1+7v03nfEykZaJ9Y46uTRD9PddKSQLmRNu1Isq
	 mlQ8EPrQCrDYw==
Date: Wed, 18 Nov 2026 20:17:22 +0000
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
 Feng <kaihengf@nvidia.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Breno Leitao <leitao@debian.org>, Dan Williams <djbw@kernel.org>, Terry
 Bowman <terry.bowman@amd.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 16/19] ACPI: extlog: Report error severity using GHES
 bindings in MCE
Message-ID: <20261118201722.2e449ec9@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-17-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-17-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:26 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> MCE extended logs report raw CPER severity values to
> log_non_standard_event(). GHES relies on the GHES bindings in
> ghes_do_proc(). The rasdaemon interprets the severity
> as a GHES_SEV_* value.
> 
> Translate the CPER severity with ghes_severity() before reporting
> the event.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Bug? Fixes tag 

+ Upstream this sooner rather than later so drag to start of patch set.

> ---
>  drivers/acpi/apei/extlog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/extlog.c b/drivers/acpi/apei/extlog.c
> index 8cae5bdacf1c6..bd407436928b4 100644
> --- a/drivers/acpi/apei/extlog.c
> +++ b/drivers/acpi/apei/extlog.c
> @@ -216,7 +216,7 @@ void acpi_extlog_report(const struct acpi_hest_generic_status *estatus)
>  			void *err = acpi_hest_get_payload(gdata);
>  
>  			log_non_standard_event(sec_type, fru_id, fru_text,
> -					       gdata->error_severity, err,
> +					       ghes_severity(gdata->error_severity), err,
>  					       gdata->error_data_length);
>  		}
>  	}


