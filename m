Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AECC001DE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Aug 2023 13:56:24 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SJoM7tBW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RMlh70z9qz3c3N
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Aug 2023 23:56:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SJoM7tBW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=acme@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RMlg96ld8z2ydR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2023 23:55:33 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 269FF65F21;
	Fri, 11 Aug 2023 13:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4A9C433C8;
	Fri, 11 Aug 2023 13:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691762130;
	bh=UkgBygCz01uYtfZgJPAYAw3hDod7s6by5RvrWS+roXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJoM7tBWKvb4QgM+r9Iz12SUKJYpK/cuh/2g8Cpl6TNFH5/HSh/bMpWiOA12M00Y1
	 KZiZ/AA/LKUh2dLvijty78PHoNSXTpCbm5r7LZr+D7LEzncVcWtkgjyHAO7Y5robXj
	 KM4vpScUR7gTqBtmNP0iodH7b7gFqtRwufq5Q2bgo9nj3xAKvucGQhIuaJvbOBWI1x
	 Bs78+VBgH7TQ0Vqo+BVD3iSaHEE7K3N9G+tsr63rq/psgZjseSpA7NOyU2grvVajjc
	 vk3kzdKyav4wp1s1jN1eSsDez5OC0P1TFaicZTjHb5tJLj3cl7vCXCvIT22GxjuWt9
	 9Jk4O3c2Y/X3A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 8A99F404DF; Fri, 11 Aug 2023 10:55:27 -0300 (-03)
Date: Fri, 11 Aug 2023 10:55:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] tools/perf: Add text_end to "struct dso" to save
 .text section size
Message-ID: <ZNY9zwZOs47ETwnU@kernel.org>
References: <20230811052128.70282-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811052128.70282-1-atrajeev@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: irogers@google.com, maddy@linux.ibm.com, kjain@linux.ibm.com, linux-perf-users@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, disgoel@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Fri, Aug 11, 2023 at 10:51:27AM +0530, Athira Rajeev escreveu:
> Update "struct dso" to include new member "text_end".
> This new field will represent the offset for end of text
> section for a dso. This value is derived as:
> sh_size (Size of section in byes) + sh_offset (Section file
> offst) of the elf header for text.

You're stating what this patch does, but not why. So far was not needed,
why now?

Probably the second patch will have the answer, but please try to add
the reason on the patch that introduces the new field.

Thanks,

- Arnaldo
 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/dso.h        | 1 +
>  tools/perf/util/symbol-elf.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index b41c9782c754..70fe0fe69bef 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -181,6 +181,7 @@ struct dso {
>  	u8		 rel;
>  	struct build_id	 bid;
>  	u64		 text_offset;
> +	u64		 text_end;
>  	const char	 *short_name;
>  	const char	 *long_name;
>  	u16		 long_name_len;
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 8bd466d1c2bd..252d26a59e64 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1512,8 +1512,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>  	}
>  
>  	if (elf_section_by_name(runtime_ss->elf, &runtime_ss->ehdr, &tshdr,
> -				".text", NULL))
> +				".text", NULL)) {
>  		dso->text_offset = tshdr.sh_addr - tshdr.sh_offset;
> +		dso->text_end = tshdr.sh_offset + tshdr.sh_size;
> +	}
>  
>  	if (runtime_ss->opdsec)
>  		opddata = elf_rawdata(runtime_ss->opdsec, NULL);
> -- 
> 2.31.1
> 

-- 

- Arnaldo
