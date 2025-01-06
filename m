Return-Path: <linuxppc-dev+bounces-4718-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E81BE77198
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2025 14:52:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YRcbZ4Zbxz2yYs;
	Tue,  7 Jan 2025 01:52:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736175146;
	cv=none; b=PyPXOCEAmm2MU0yDbe3mhFOvwnuBAVNCvsQM8kY+G8Yl1wGdjLh8H0kNr2n9brm2ZGk+2YJ+0alA+N+fs6+FpKVds4zCY0GowdctqqYRI21nc4IsB3s+eRd0qUqi9rEtnBqmLLojsUge2k1Hh/FJNLad+lIKPsjxfIxNqdYvdwKLnlBVeQvuVZEv3v8wnBIC51HzLDkDjU5ca6nUJECjTrf+y/2m+95kzX7BJaNdv9/zcQF3VFX4ShseXgmJ/tkbL1AgWuX2uVGgMxsCWZRBnoiTxIRZEpe0Wlp+z0N8FoBVjkYFHlDN0c5n3sxSacW2o7RW5IeXZAT/fYHEcC8ysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736175146; c=relaxed/relaxed;
	bh=rkGxFueoVINi5fyFIRpdOxzuvoQHxYoJE4cR1nHWUKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEGZswB9KZn+YD+I2XJgIu/kV2Fx51ojdWRbqllBIj1KCA0Yxg9Qk+CNEVNfHIafv24LiYn5U1VSnyEkwdPzQ18eUCc3vFuHJ1MnyiOc1W6TI49OCQXTLmA98IzGb9UzacQD+61P+dx2vgfzNlQO/DP128rxLwVNdBvVhTzybW3B4K3paGodqeDwlW5+0S2qVjhRKn9joNR1+YWicbeyoJvz53KZ4BewOffAsqEcikDefVpX0eW40Llp9V2KoXVfSzmd8rmXlrG/yNddiXIqsLaQ7F1vUYsvm1q0i4aVCsqEF84xqmQLcjaWbCLEECA/xndoyh0Y+rhW+YUISfcS/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dave.martin@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dave.martin@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YRcbY51x3z2yFB
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2025 01:52:24 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58B98143D;
	Mon,  6 Jan 2025 06:52:22 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24D7D3F59E;
	Mon,  6 Jan 2025 06:51:52 -0800 (PST)
Date: Mon, 6 Jan 2025 14:51:49 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, devel@daynix.com
Subject: Re: [PATCH v2 5/5] crash: Remove KEXEC_CORE_NOTE_NAME
Message-ID: <Z3vuBTiQvnRvv9DQ@e133380.arm.com>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
 <20250104-elf-v2-5-77dc2e06db4e@daynix.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104-elf-v2-5-77dc2e06db4e@daynix.com>

Hi,

On Sat, Jan 04, 2025 at 11:38:38PM +0900, Akihiko Odaki wrote:
> Now KEXEC_CORE_NOTE_NAME is only used at one place and it does not seem
> to provide any value anymore. Replace the remaining usage with the
> literal and remove the macro.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  arch/s390/kernel/crash_dump.c | 2 +-
>  include/linux/kexec.h         | 2 --
>  include/linux/vmcore_info.h   | 1 -
>  3 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index cd0c93a8fb8b..4a9817489e35 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -253,7 +253,7 @@ static const char *nt_name(Elf64_Word type)
>  	const char *name = "LINUX";
>  
>  	if (type == NT_PRPSINFO || type == NT_PRSTATUS || type == NT_PRFPREG)
> -		name = KEXEC_CORE_NOTE_NAME;
> +		name = "CORE";

If I've understood the code here correctly, the note type is supplied
at all the nt_init() and nt_size() call sites, so instead of this hack
can we wrap those in macros that get the formal name from elf.h rather
than guessing it here?  e.g.:

#define nt_size(..., note, ...) \
	__nt_size(..., NT ## _ ## note, NN ## _ ## note, ...)

etc.

The compiler is quite likely to fold away most of the implied
duplication of code (it would be interesting to look at the compiler
output) -- but anyway, this is super-slow-path: nobody expects realtime
response when the kernel has crashed.

[...]

Cheers
---Dave

