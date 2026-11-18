Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93560A2611
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5Jph70J
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVB4q1rF4z2y32;
	Thu, 19 Nov 2026 06:10:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795029019;
	cv=none; b=Z3uNEaRoLLf6AkzvEwgyHqvhft6cg9dp4yhk2H/aclnldAAnDGsxOgBsLIBNDvssdlyvRi1Bs+5Slhq5KsgCTSIbysjQxhhlMNNJZaH4m3t9PUsLNcNqtwrnvzDZsp8v/vlz3aqQdaovPVHMBVAEbFuGsKJMuRxZwlLjr0ISI7knGlNRnOxBBD260grVAdmbTfRToVX6+r57iEGUb+s4JyWH+HT+4ajkvE4dGaSVgVgYwaZuRCayu0FfgmBl74hzfl7ruXJg5PUzwcJ0fyrBWYfLEvuyQEYc3JE/7oIS8HTDK19fwlp45Dp0ZBJ2ztdJ3blIPH2vq2AUd7oK/SAq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795029019; c=relaxed/relaxed;
	bh=iMRUsGYu7zSEFYynNiT3pkVIolltTYn1kN2e3iJRjP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTJ2raje9wYoFLFVBFocgosr5UDh+9noISB9gQ1/Tut+ummOv3yIa89CU80vpITJQHxJaIIFu15LmYCS9+6RMgMoOyCn7c2ee4QkOIp2fLf4ZyA/mKc6u6iX+L5gdkFiM5ypaaME/G9jh/4VBlf74BSiKvYR58RC6NRR3xy1KQ8A5W/6c5TnUbcecL7VP2j9S+/RntwJBZalh0lC2dX73q3vo12BF7tgUdSzLP+PPgHyUI9rwEyp9jkBpLt0udkE0/0WQnOl6wcJhO9i/5MN2ok8BAv6koxv86TuCA8jN/B0NYGz7SB8Mn/wivt7x+wB1dFOsojFZsXE8Y/8GcK1/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5Jph70J; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5Jph70J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVB4p1vqXz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:10:18 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 487F063887;
	Wed, 18 Nov 2026 19:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5081F000C4;
	Wed, 18 Nov 2026 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029015;
	bh=iMRUsGYu7zSEFYynNiT3pkVIolltTYn1kN2e3iJRjP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N5Jph70JX2LYHDXBMhrdOmmHoE8hVNOQFsb0hD8QdJi5/HOJWMOWiILiGvRyS1xko
	 TYl8bryWfX649pvRtKP3OuUQLCY43WdJo6ES1ssjR6HL7W1Pe2MonCKbHUT3wFoXet
	 2Z/FI0yiiDwAwcCdHNWjtNP+PI/HMNp0VcQ6fsQVv7VlL/W+3M6ng8HiZQLY4s9az0
	 k44AVz0RsKIL2XEPtOV6t+CDqoZ6czFpIWR5Etk78FYZ6ggNhpZvY4LrhR78vAOMhf
	 +s7YaQykImzKFE5dj4WS/53WLMgCSKEuq/ymS0dhIYGrw6plUoYDkILvR9xTI0GgXz
	 0kWdY5+Vt60rw==
Date: Wed, 18 Nov 2026 19:10:03 +0000
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
 Avadhut Naik <avadhut.naik@amd.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>, Breno Leitao <leitao@debian.org>, Dan
 Williams <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/19] ACPI: APEI: Use empty FRU values if valid bit
 is absent
Message-ID: <20261118191003.5a4a2ddd@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-5-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-5-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:14 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> When a status block contains multiple sections, a section without valid
> FRU fields inherits pointers from the preceding section.

Perhaps rewrite that so it is clear you are referring to the
implementation of the parser not spec requirement for it to get
them from previous section. That had me briefly confused -
I even wondered why I'd never noticed that requirement :)

> 
> Use empty fru_id and fru_text values whenever the matching VALID
> bit is not set instead of reusing the value of the previous loop.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Fixes tag seems appropriate for this one given it may be reporting
confusing or invalid data today.  Probably not a thing to rush
into stable but nice to tag it anyway.

With that small reword above.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/acpi/apei/ghes.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 703f3b7f700a6..444d8e82353a7 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -979,8 +979,8 @@ static void ghes_do_proc(struct ghes *ghes,
>  	int sev, sec_sev;
>  	struct acpi_hest_generic_data *gdata;
>  	guid_t *sec_type;
> -	const guid_t *fru_id = &guid_null;
> -	char *fru_text = "";
> +	const guid_t *fru_id;
> +	const char *fru_text;
>  	bool queued = false;
>  	bool sync = is_hest_sync_notify(ghes);
>  
> @@ -990,9 +990,13 @@ static void ghes_do_proc(struct ghes *ghes,
>  		sec_sev = ghes_severity(gdata->error_severity);
>  		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
>  			fru_id = (guid_t *)gdata->fru_id;
> +		else
> +			fru_id = &guid_null;
>  
>  		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
>  			fru_text = gdata->fru_text;
> +		else
> +			fru_text = "";
>  
>  		ghes_log_hwerr(sev, sec_type);
>  		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {


