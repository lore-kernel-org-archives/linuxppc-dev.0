Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17395C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 12:00:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B032082F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 12:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B032082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ns7j1B6hzDqJt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 23:00:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=catalin.marinas@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44Ns4l4pG3zDqJB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 22:57:54 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1E1D1596;
 Tue, 19 Mar 2019 04:57:51 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 00CD03F614; Tue, 19 Mar 2019 04:57:49 -0700 (PDT)
Date: Tue, 19 Mar 2019 11:57:47 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2] kmemleak: skip scanning holes in the .bss section
Message-ID: <20190319115747.GB59586@arrakis.emea.arm.com>
References: <20190313145717.46369-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313145717.46369-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Qian,

On Wed, Mar 13, 2019 at 10:57:17AM -0400, Qian Cai wrote:
> @@ -1531,7 +1547,14 @@ static void kmemleak_scan(void)
>  
>  	/* data/bss scanning */
>  	scan_large_block(_sdata, _edata);
> -	scan_large_block(__bss_start, __bss_stop);
> +
> +	if (bss_hole_start) {
> +		scan_large_block(__bss_start, bss_hole_start);
> +		scan_large_block(bss_hole_stop, __bss_stop);
> +	} else {
> +		scan_large_block(__bss_start, __bss_stop);
> +	}
> +
>  	scan_large_block(__start_ro_after_init, __end_ro_after_init);

I'm not a fan of this approach but I couldn't come up with anything
better. I was hoping we could check for PageReserved() in scan_block()
but on arm64 it ends up not scanning the .bss at all.

Until another user appears, I'm ok with this patch.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
