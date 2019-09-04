Return-Path: <SRS0=Ib4m=W7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F244C3A5A7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 11:50:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787A320820
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 11:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787A320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Nhw43L7zzDqpp
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Sep 2019 21:50:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Nhst4qjxzDqnR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2019 21:48:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 46Nhst3rV0z9sNT; Wed,  4 Sep 2019 21:48:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46Nhst0LFBz9sN1;
 Wed,  4 Sep 2019 21:48:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v5 17/31] powernv/fadump: Warn before processing partial
 crashdump
In-Reply-To: <156630277243.8896.14703161064045769922.stgit@hbathini.in.ibm.com>
References: <156630261682.8896.3418665808003586786.stgit@hbathini.in.ibm.com>
 <156630277243.8896.14703161064045769922.stgit@hbathini.in.ibm.com>
Date: Wed, 04 Sep 2019 21:48:33 +1000
Message-ID: <871rwwqo32.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>, Oliver <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hari Bathini <hbathini@linux.ibm.com> writes:
> diff --git a/arch/powerpc/platforms/powernv/opal-fadump.c b/arch/powerpc/platforms/powernv/opal-fadump.c
> index 10f6086..6a05d51 100644
> --- a/arch/powerpc/platforms/powernv/opal-fadump.c
> +++ b/arch/powerpc/platforms/powernv/opal-fadump.c
> @@ -71,6 +71,30 @@ static void opal_fadump_get_config(struct fw_dump *fadump_conf,
>  	 */
>  	fadump_conf->reserve_dump_area_start = fdm->rgn[0].dest;
>  
> +	/*
> +	 * Rarely, but it can so happen that system crashes before all
> +	 * boot memory regions are registered for MPIPL. In such
> +	 * cases, warn that the vmcore may not be accurate and proceed
> +	 * anyway as that is the best bet considering free pages, cache
> +	 * pages, user pages, etc are usually filtered out.
> +	 *
> +	 * Hope the memory that could not be preserved only has pages
> +	 * that are usually filtered out while saving the vmcore.
> +	 */
> +	if (fdm->region_cnt > fdm->registered_regions) {
> +		pr_warn("Not all memory regions are saved as system seems to have crashed before all the memory regions could be registered for MPIPL!\n");

That line is rather long, I mean the actual printed line not the source line.

Also "seems to" is vague, I think better to just state what we know to
be true, ie: "Not all memory regions were saved".

> +		pr_warn("  The below boot memory regions could not be saved:\n");
> +		i = fdm->registered_regions;
> +		while (i < fdm->region_cnt) {
> +			pr_warn("\t%d. base: 0x%llx, size: 0x%llx\n", (i + 1),
> +				fdm->rgn[i].src, fdm->rgn[i].size);
> +			i++;
> +		}
> +
> +		pr_warn("  Wishing for the above regions to have only pages that are usually filtered out (user pages, free pages, etc..) and proceeding anyway..\n");
> +		pr_warn("  But the sanity of the '/proc/vmcore' file depends on whether the above region(s) have any kernel pages or not.\n");

Again those lines are too long for people on small consoles.

And "Wishing" is not really what people want to see when their system
has crashed :)

You should say something more definite, eg:
  "If the unsaved regions only contain pages that are filtered out (eg.
   free/user pages), the vmcore should still be usable. If the unsaved
   regions contain kernel pages the vmcore will be corrupted."

Or something like that.

cheers

