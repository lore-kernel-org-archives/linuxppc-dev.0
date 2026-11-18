Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A393606A334
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6dt6FME
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVBs85tp6z2xdX;
	Thu, 19 Nov 2026 06:45:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795031116;
	cv=none; b=cuPZyxZBc0UJ1IYVbVI2WFxqga6ml+n6Ug1PYca6YdLiTBX7OMB3FL1Pi+AcWnszFcDJwYroI2wkkyJV6ZxtOND8TC1JSMptk3+NpFX6ZA6+AGOeRxf6D03Jfl5Ay6NfI1equgK3j4cDcIImuMwdibP8wnDxI0G0I0Mx/IgVe0tnUve3XUn9t+PwmBXJ8XcLQhhmyJ3JVvRD7A+QOaOV+xOJlDVeo9aOQZxgDQ8UXeTaSYsBCdsEQmWbApQjk5frGuCTJzRPZVCUKaeFo8tnhx5Pzxg7dcRt65loDyW1X+A886XT2sq6+ablsnv37WWGSDJlbSgM0aLNkrjNPoEnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795031116; c=relaxed/relaxed;
	bh=na5w5nNR+vMQdY7egGSiK+WyNzzJugfy513I7z+3ojw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNB39OA5OVl8kFM+JrAJjTYCfghQWqtDzHPq3GsH61ZdK773mt+mOXKXGHYn7VCpZfHJX2I2o2jtnAT+HW58SwiSzHb0iRflgRbM66tJ9hyOnH+gl6eBNWwGMoepHoygsG9rorNwtWK5oMa8kb5F8/SvuC+MeRmppVsVZCo3+IiSMXLCpN3bR2hNC5Xc2YrZ9z7pjkpFXCGIu6bkaOQfMWpSix+4uqqIKIva0ID4zxlOdsY0OS7VCTHD7Lv7G7kdT0Xq9gW12HcDZsUrcWqVJCowZpU1qVxVfg0TsBuNlJyKjoUH3LlGdwJrah3+XGJhy1tFIQ0AeyLROQAP2IA+7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6dt6FME; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6dt6FME;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVBs74tDMz2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:45:15 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 96D9063965;
	Wed, 18 Nov 2026 19:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0221F000C4;
	Wed, 18 Nov 2026 19:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795031113;
	bh=na5w5nNR+vMQdY7egGSiK+WyNzzJugfy513I7z+3ojw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L6dt6FMEOP1zQQVYmvm4CWgf23sQN8hCZAeCPpJLUWYgTvFf7gXRCmY8q9oe8FB89
	 mFwKA3cTtvdAfFZFl9F4ioYJcVEsMKWTCue8zDVaHf+I205Vj88up8tmRM8/QJNPNo
	 vEQFVc++El8isjgs4ePvndtd+czHKU8rEk60UDeg/yTC1yvwG7kGmcolbdJL7mtuh4
	 TDuR2OHULNcxBLOrwg2XKiNuq/Wsl91E7uHihCnXYbc5Q2INuNk3OP0ridc8bmnQBi
	 e6EQvW9xW8L5Lje24dTZqRGEKPige77kZlY9Gtz4XcL4NGvfXo27DslnJIgUouq6sl
	 vJ13TA7NrXqog==
Date: Wed, 18 Nov 2026 19:45:08 +0000
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
 Avadhut Naik <avadhut.naik@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Kai-Heng Feng <kaihengf@nvidia.com>, Breno Leitao
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>, Dan Williams
 <djbw@kernel.org>, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 09/19] ACPI: extlog: Report errors independently of
 RAS consumers
Message-ID: <20261118194508.150029b4@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-10-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-10-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:19 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> The RAS consumer check removes:
> - trace events when no daemon is registered
> - CPER console report when one is registered
> This ties tracing, PCIe recovery and CXL protocol delivery to daemon
> registration, and can hide a fatal record when userspace cannot process
> its trace event before a reset.
> 
> Remove the RAS consumer registration condition and:
> - always emit trace events
> - print the CPER record only for CPER_SEV_FATAL
> 
> [1] additionally suggested to have a cmdline parameter to dynamically
> update the above policy. Keep a simple hard coded policy for now.
> 
> [1]
> https://lore.kernel.org/lkml/20240521183913.GGZkzqUSN1hdE-_OEY@fat_crate.local/

Use a link tag probably.

Link: https://lore.kernel.org/lkml/20240521183913.GGZkzqUSN1hdE-_OEY@fat_crate.local/ #1

I'm not entirely convinced this is a good idea without the policy aspect.
Still let us see what others think.

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/acpi_extlog.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e09ea571c32f5..16a16b12d8ccf 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -208,10 +208,9 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))
>  		return NOTIFY_DONE;
>  
> -	if (!ras_userspace_consumers()) {
> +	/* Print fatal records regardless of RAS consumer registration. */
> +	if (tmp->error_severity == CPER_SEV_FATAL)
>  		print_extlog_rcd(NULL, tmp, cpu);
> -		goto out;
> -	}
>  
>  	/* log event via trace */
>  	err_seq++;
> @@ -255,7 +254,6 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  		}
>  	}
>  
> -out:
>  	mce->kflags |= MCE_HANDLED_EXTLOG;
>  	return NOTIFY_OK;
>  }


