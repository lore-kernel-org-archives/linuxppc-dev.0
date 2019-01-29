Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5FCC169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 22:39:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CBAA2147A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 22:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubrrcQdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBAA2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43q1dJ0M5jzDqRF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 09:39:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ubrrcQdR"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43q1bT2s8NzDqRF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 09:37:40 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 787AB20856;
 Tue, 29 Jan 2019 22:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548801458;
 bh=iGo8tCSgKwO46329OhBCVywerfK6lXwTzNiIxn0oTy0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ubrrcQdR/SnJcELbaOOMO2SgO9rVkeatt2DESOz3vHCdHyVjhrolxR+mPZylBteQ/
 FFRR4dzYniXsVdGaRXHGyNtmgXp4yOOBb1imukydog+dWw5QpRoIjNSf6gPCyYrTH3
 OKoOtbIE0EAruNtT+ztoJFtiQwbJzQOnV7Ltio9U=
Date: Tue, 29 Jan 2019 16:37:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] PCI/AER: use match_string() helper to simplify the code
Message-ID: <20190129223735.GD91506@google.com>
References: <20190128115728.68240-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128115728.68240-1-andriy.shevchenko@linux.intel.com>
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
Cc: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 28, 2019 at 01:57:28PM +0200, Andy Shevchenko wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to pci/aer for v5.1, thanks!

> ---
>  drivers/pci/pcie/aer.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index fed29de783e0..f8fc2114ad39 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -117,7 +117,7 @@ bool pci_aer_available(void)
>  
>  static int ecrc_policy = ECRC_POLICY_DEFAULT;
>  
> -static const char *ecrc_policy_str[] = {
> +static const char * const ecrc_policy_str[] = {
>  	[ECRC_POLICY_DEFAULT] = "bios",
>  	[ECRC_POLICY_OFF] = "off",
>  	[ECRC_POLICY_ON] = "on"
> @@ -203,11 +203,8 @@ void pcie_ecrc_get_policy(char *str)
>  {
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(ecrc_policy_str); i++)
> -		if (!strncmp(str, ecrc_policy_str[i],
> -			     strlen(ecrc_policy_str[i])))
> -			break;
> -	if (i >= ARRAY_SIZE(ecrc_policy_str))
> +	i = match_string(ecrc_policy_str, ARRAY_SIZE(ecrc_policy_str), str);
> +	if (i < 0)
>  		return;
>  
>  	ecrc_policy = i;
> -- 
> 2.20.1
> 
