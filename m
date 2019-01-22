Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585ADC282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 20:22:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9867C217D6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 20:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbWc/jj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9867C217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kfwf4rX4zDqMs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 07:22:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="RbWc/jj4"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kftb2JSHzDqJT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 07:20:39 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4AB4520866;
 Tue, 22 Jan 2019 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548188437;
 bh=5ziCHOV8ZUAvvDOzEMcRPrlvW0YUizC8EC/qZLv3Z1o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RbWc/jj4LDnrdATEqBjHPy0xSDU0Z7f5e1MG8pT1xwR05wmTmH0KMSWi++rjmKHV+
 CyECWzQGJ7R0+J/f+eDLq8BC/u2ndKBh/GHaMuQdD3hxxf7czt4ZwgBSDKxzK0LQwe
 cNrcaE/DiCps2pnZGTgDa/RMBGH8mt6AizM34u4A=
Date: Tue, 22 Jan 2019 14:20:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] PCI: Use of_node_name_eq for node name comparisons
Message-ID: <20190122202035.GD14636@google.com>
References: <20181205195050.4759-18-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205195050.4759-18-robh@kernel.org>
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
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[+cc Michael B]

On Wed, Dec 05, 2018 at 01:50:34PM -0600, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

I applied the pci/of.c change to pci/misc for v5.1, thanks!

I dropped the rpaphp_core.c part because there's another patch
in-flight [1] that touches the same code, and it would be easier if
Michael picked up this change and added it to his series.

Bjorn

[1] https://lore.kernel.org/lkml/20181214205120.16435.46952.stgit@powerkvm6.aus.stglabs.ibm.com/

> ---
>  drivers/pci/hotplug/rpaphp_core.c | 2 +-
>  drivers/pci/of.c                  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> index bcd5d357ca23..7697d9c92b98 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -354,7 +354,7 @@ int rpaphp_add_slot(struct device_node *dn)
>  	const int *indexes, *names, *types, *power_domains;
>  	char *name, *type;
>  
> -	if (!dn->name || strcmp(dn->name, "pci"))
> +	if (!of_node_name_eq(dn, "pci"))
>  		return 0;
>  
>  	/* If this is not a hotplug slot, return without doing anything. */
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 4c4217d0c3f1..3d32da15c215 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -113,7 +113,7 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
>  		 * a fake root for all functions of a multi-function
>  		 * device we go down them as well.
>  		 */
> -		if (!strcmp(node->name, "multifunc-device")) {
> +		if (of_node_name_eq(node, "multifunc-device")) {
>  			for_each_child_of_node(node, node2) {
>  				if (__of_pci_pci_compare(node2, devfn)) {
>  					of_node_put(node);
> -- 
> 2.19.1
> 
