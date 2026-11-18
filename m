Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1A7606A339
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mreWieIE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVB0v2fZ2z2xMt;
	Thu, 19 Nov 2026 06:06:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795028815;
	cv=none; b=jVURgP7aGBKcyWwm/kMnHMFlzHhKpgiKG9N5zwfKfh/5APGXIqO0eWaXovPZhx3Nl/hwvYhgHhvy6NMXN88lGRBIz+li9Fouk2qgsXlU6OXqpPqKXgsyiGJ1cf4EfYN94CvTVnm9SN5yttU2B0LCyugrS/AXWqLRa35zoYXNvFGbiQ/AY/cddbTfQ6WAjbGGDDfusmlwR4YMnQf06q8KmKc0zJCAZ5Iq4WoIYeOE2ZgnrJ7sWAIep9WWbL0XwKryejs+kU6k0oqDCFtJN67MI74LNMBJP7J+A7+Zqtk490z9R6wl+6rVU9Sfg7gRHIqXe0H2Hv4PJ1yJJeDh0DMAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795028815; c=relaxed/relaxed;
	bh=FxU/Ni1onbxi/KQipCfK1DOJbeJSAyS+b8tm3BOgzg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxI8GkMXjxTTsx8X1d6Ly4YK7gkYdyb1dOFx67gwHUKzi2ez5P3tvKn8Bi0jwQhl20/hfFAyYowPOfpN2jzZ9Js8Rmiore/JE2yaE7tPKP8PKGICT84fMnXw19uudd31p1EbmMSi7pe7gIfSjVlEoyxGWbKtz6a1SVCC8XhdlD8q2ej4s6fVH4whY6WMU3r0lw/pp2RDtFoveqrmdAbP5JmRUrkGpeJJxudCs1QJIJv+M5+P5BisGkSVsmzUur8/O8KSf8l60zSC0QpO018XVV8bgSGQ68fG7XlP80d0SyEH6MK53/drZbUcsCPfs2DzMUbA2oPpiriuPKEvf81ayg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mreWieIE; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mreWieIE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVB0t2dslz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 06:06:54 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C9C0A470B3;
	Wed, 18 Nov 2026 19:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0B11F000C6;
	Wed, 18 Nov 2026 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795028811;
	bh=FxU/Ni1onbxi/KQipCfK1DOJbeJSAyS+b8tm3BOgzg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mreWieIEaUoX19DC2dVQNzL2lS1r8X5JzevZX7IjEC+p2+DHMU4GBywPDUtVPxOod
	 84VmnE/dXuVDNsUJW+PDqRipf8wypZ4XHnyy2qKxr65aAe4c6emLFnEspzwz5tkIa9
	 EVV9c5zEuvi6o39Df8A2tSqC9uLv0sDtRLn5F0N6rZ15cFCjjqYMVcfmiaH3hGjFEr
	 vMGgCsy2OwEgoqKk0lgP5i9zBXf17k3iJ4N1U2irfcj63qY0KfeYN4UjpbFyx/XQgi
	 Quj+pmGct4j0iOOFX64pwDIL80xg6AHF/RKk/iEkJoQzFEz8ZCBGuhUNupviiiStUg
	 NmIlSDb8uPdSg==
Date: Wed, 18 Nov 2026 19:06:35 +0000
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
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Kai-Heng Feng
 <kaihengf@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, Breno Leitao
 <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>, Dan Williams
 <djbw@kernel.org>, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 03/19] ras: Bound CPER FRU strings in trace events
Message-ID: <20261118190635.4e1a65b8@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-4-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-4-pierre.gondois@arm.com>
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

On Tue, 17 Nov 2026 12:10:13 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> CPER FRU text occupies a fixed 20-byte field and need not contain a NUL
> terminator. Using __string() can read past the field and, for a short
> nonstandard section, past the end of the firmware record.
> 
> Bound FRU text in the legacy memory and nonstandard trace events with
> __string_len() and strnlen(), as already done for the Section 2 event.

Given the many many definitions of __string() in different parts
of the tracepoint infrastructure, might be worth a pointer here
to where it trips up.  I think that's just in stage5 with other
stages ignoring the actual length.

Patch seems valid to me and not directly related to rest of the series.
So perhaps a hardening change to pull out ahead?

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  include/ras/ras_event.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index ce759ee1cf4cc..069c7b3a5e6c0 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -39,7 +39,7 @@ TRACE_EVENT(extlog_mem_event,
>  		__field(u64, pa)
>  		__field(u8, pa_mask_lsb)
>  		__field_struct(guid_t, fru_id)
> -		__string(fru_text, fru_text)
> +		__string_len(fru_text, fru_text, strnlen(fru_text, 20))
>  		__field_struct(struct cper_mem_err_compact, data)
>  	),
>  
> @@ -370,7 +370,7 @@ TRACE_EVENT(non_standard_event,
>  	TP_STRUCT__entry(
>  		__array(char, sec_type, UUID_SIZE)
>  		__array(char, fru_id, UUID_SIZE)
> -		__string(fru_text, fru_text)
> +		__string_len(fru_text, fru_text, strnlen(fru_text, 20))
>  		__field(u8, sev)
>  		__field(u32, len)
>  		__dynamic_array(u8, buf, len)


