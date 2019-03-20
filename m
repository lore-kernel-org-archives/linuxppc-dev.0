Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A27CC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 22:14:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6CF2175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 22:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJoHSa2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6CF2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Pkjw2ZgZzDqNX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 09:14:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="uJoHSa2v"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Pkgy4QldzDqNH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 09:13:02 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7FD822175B;
 Wed, 20 Mar 2019 22:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553119979;
 bh=G+jCJeiztv5MQ05x6fsnzWCVxnBmXCrPv6xFGNTK3QU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uJoHSa2v+N2C+2ffE2ZjtdtUHENfqpuZEzkEH/u8U5gq13+AC2fUtHbl70bdiGcTZ
 V6HxB2gV0HLADokaX8AnnvcQWK26UF8/1a9gF9A79LPmG/IIrgqjiRmrToRiYXzs5I
 8yTwiLNrTvvmLECwwdNzUgRwWrlI21XD8SBWiuz0=
Date: Wed, 20 Mar 2019 17:12:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] hotplug/drc-info: ininitialize fndit to zero
Message-ID: <20190320221257.GI251185@google.com>
References: <20190316214016.6612-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316214016.6612-1-colin.king@canonical.com>
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
Cc: linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[+cc Michael B (original author)]

On Sat, Mar 16, 2019 at 09:40:16PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently variable fndit is not initialized and contains a
> garbage value, later it is set to 1 if a drc entry is found.
> Ensure fndit is not containing garbage by initializing it to
> zero. Also remove an extraneous space at the end of an
> sprintf call.
> 
> Detected by static analysis with cppcheck.
> 
> Fixes: 2fcf3ae508c2 ("hotplug/drc-info: Add code to search ibm,drc-info property")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Michael E, I assume you'll take this since you took the original?
Let me know if you want me to.

> ---
>  drivers/pci/hotplug/rpaphp_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index bcd5d357ca23..28213f44f64a 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -230,7 +230,7 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
>  	struct of_drc_info drc;
>  	const __be32 *value;
>  	char cell_drc_name[MAX_DRC_NAME_LEN];
> -	int j, fndit;
> +	int j, fndit = 0;
>  
>  	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
>  	if (info == NULL)
> @@ -254,7 +254,7 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
>  	/* Found it */
>  
>  	if (fndit)
> -		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix, 
> +		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
>  			my_index);
>  
>  	if (((drc_name == NULL) ||
> -- 
> 2.20.1
> 
