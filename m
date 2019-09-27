Return-Path: <SRS0=CCuM=XW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F57C4360C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Sep 2019 10:46:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E8C217D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Sep 2019 10:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZydjFrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E8C217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46fpPq1ZhJzDqvy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Sep 2019 20:46:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="eZydjFrD"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46fpMX3Rw3zDqc3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2019 20:44:39 +1000 (AEST)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 37D1720673;
 Fri, 27 Sep 2019 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569581076;
 bh=5Lac1CASlk0sJZm0YRYXdQK/2vCuj3n357uUlZay40k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=eZydjFrDuSZnpesNdZsaPt4D2G0uqy5fIKVIF/YS2kuXkL8bWnm481fx2gs1yG4/S
 4ScUI1NV2LO4EKmFkJ1zNFdAWSX+M6QsTZTfvajyMJwLW/BjVE2v/Im9kHEY4MVvbo
 44+WJhG7XI5AUZfAj4U2uxwFQCtPCfUNL7bqOAEg=
Date: Fri, 27 Sep 2019 05:44:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] PCI/AER: Use for_each_set_bit()
Message-ID: <20190927104434.GA23330@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827151823.75312-1-andriy.shevchenko@linux.intel.com>
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
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, linux-pci@vger.kernel.org,
 Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Aug 27, 2019 at 06:18:22PM +0300, Andy Shevchenko wrote:
> This simplifies and standardizes slot manipulation code
> by using for_each_set_bit() library function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied both with Kuppuswamy's reviewed-by to pci/aer for v5.5,
thanks!

> ---
>  drivers/pci/pcie/aer.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index b45bc47d04fe..f883f81d759a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -15,6 +15,7 @@
>  #define pr_fmt(fmt) "AER: " fmt
>  #define dev_fmt pr_fmt
>  
> +#include <linux/bitops.h>
>  #include <linux/cper.h>
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
> @@ -657,7 +658,8 @@ const struct attribute_group aer_stats_attr_group = {
>  static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
>  				   struct aer_err_info *info)
>  {
> -	int status, i, max = -1;
> +	unsigned long status = info->status & ~info->mask;
> +	int i, max = -1;
>  	u64 *counter = NULL;
>  	struct aer_stats *aer_stats = pdev->aer_stats;
>  
> @@ -682,10 +684,8 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
>  		break;
>  	}
>  
> -	status = (info->status & ~info->mask);
> -	for (i = 0; i < max; i++)
> -		if (status & (1 << i))
> -			counter[i]++;
> +	for_each_set_bit(i, &status, max)
> +		counter[i]++;
>  }
>  
>  static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
> @@ -717,14 +717,11 @@ static void __print_tlp_header(struct pci_dev *dev,
>  static void __aer_print_error(struct pci_dev *dev,
>  			      struct aer_err_info *info)
>  {
> -	int i, status;
> +	unsigned long status = info->status & ~info->mask;
>  	const char *errmsg = NULL;
> -	status = (info->status & ~info->mask);
> -
> -	for (i = 0; i < 32; i++) {
> -		if (!(status & (1 << i)))
> -			continue;
> +	int i;
>  
> +	for_each_set_bit(i, &status, 32) {
>  		if (info->severity == AER_CORRECTABLE)
>  			errmsg = i < ARRAY_SIZE(aer_correctable_error_string) ?
>  				aer_correctable_error_string[i] : NULL;
> -- 
> 2.23.0.rc1
> 
