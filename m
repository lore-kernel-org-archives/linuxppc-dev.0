Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A29CC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 14:45:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E7520870
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 14:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E7520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FKNd0q4NzDqXb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 01:45:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=keith.busch@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FKLS448kzDqNx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 01:43:27 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Dec 2018 06:43:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; d="scan'208";a="127277830"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2018 06:43:21 -0800
Date: Wed, 12 Dec 2018 07:40:53 -0700
From: Keith Busch <keith.busch@intel.com>
To: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
Subject: Re: [PATCH] PCI/AER: only insert one element into kfifo
Message-ID: <20181212144052.GA10780@localhost.localdomain>
References: <1544603550-14208-1-git-send-email-yanjiang.jin@hxt-semitech.com>
 <1544603550-14208-2-git-send-email-yanjiang.jin@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544603550-14208-2-git-send-email-yanjiang.jin@hxt-semitech.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
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
Cc: sbobroff@linux.ibm.com, linux-pci@vger.kernel.org, jinyanjiang@gmail.com,
 linux-kernel@vger.kernel.org, oohall@gmail.com, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org, yu.zheng@hxt-semitech.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 12, 2018 at 04:32:30PM +0800, Yanjiang Jin wrote:
> 'commit ecae65e133f2 ("PCI/AER: Use kfifo_in_spinlocked() to
> insert locked elements")' replace kfifo_put() with kfifo_in_spinlocked().
> 
> But as "kfifo_in(fifo, buf, n)" describes:
> " * @n: number of elements to be added".
> 
> We want to insert only one element into kfifo, not "sizeof(entry) = 16".
> Without this patch, we would get 15 uninitialized elements.
> 
> Signed-off-by: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>

My bad. I had trouble testing the GHES path for this.  Thanks for the fix.

Reviewed-by: Keith Busch <keith.busch@intel.com>

> ---
>  drivers/pci/pcie/aer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a90a919..fed29de 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1064,7 +1064,7 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>                 .regs           = aer_regs,
>         };
> 
> -       if (kfifo_in_spinlocked(&aer_recover_ring, &entry, sizeof(entry),
> +       if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
>                                  &aer_recover_ring_lock))
>                 schedule_work(&aer_recover_work);
>         else
> --
> 1.8.3.1
