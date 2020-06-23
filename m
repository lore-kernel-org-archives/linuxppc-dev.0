Return-Path: <SRS0=X5Ay=AE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726A6C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 00:50:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A78206C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 00:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A78206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49rSNj2y9GzDqZw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 10:49:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux.intel.com
 (client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=jarkko.sakkinen@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49rSLw4dJ5zDqS0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2020 10:48:24 +1000 (AEST)
IronPort-SDR: 09Hz2H3rQ9g/Yix1zbfoReSzfO2zOJBSy7P+8jE2DagCwyP7/bQnxmHM6znD+UXgJBKSbaUyjL
 c6Pvg0XaFCNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="141422316"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="141422316"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 17:48:19 -0700
IronPort-SDR: 9jEEJuxfpBhX37hxIAiIqJr7MzUGTlfXJVnvnstDhgdyY8D03DaTh7iAXHM34LgVacTLSlUS2/
 c/icCE4uxyQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="275173913"
Received: from jczajka-mobl.ger.corp.intel.com (HELO localhost)
 ([10.249.40.133])
 by orsmga003.jf.intel.com with ESMTP; 22 Jun 2020 17:48:14 -0700
Date: Tue, 23 Jun 2020 03:48:13 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCHv2] tpm: ibmvtpm: Wait for ready buffer before probing for
 TPM2 attributes
Message-ID: <20200623004813.GB28795@linux.intel.com>
References: <20200619033040.121412-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619033040.121412-1-david@gibson.dropbear.id.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
Cc: nayna@linux.ibm.com, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
 paulus@samba.org, peterhuewe@gmx.de, linuxppc-dev@lists.ozlabs.org,
 linux-integrity@vger.kernel.org, stefanb@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jun 19, 2020 at 01:30:40PM +1000, David Gibson wrote:
> The tpm2_get_cc_attrs_tbl() call will result in TPM commands being issued,
> which will need the use of the internal command/response buffer.  But,
> we're issuing this *before* we've waited to make sure that buffer is
> allocated.
> 
> This can result in intermittent failures to probe if the hypervisor / TPM
> implementation doesn't respond quickly enough.  I find it fails almost
> every time with an 8 vcpu guest under KVM with software emulated TPM.
> 
> To fix it, just move the tpm2_get_cc_attrs_tlb() call after the
> existing code to wait for initialization, which will ensure the buffer
> is allocated.
> 
> Fixes: 18b3670d79ae9 ("tpm: ibmvtpm: Add support for TPM2")
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
