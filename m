Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E001C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 23:48:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87272089D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 23:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87272089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wykH6PW6zF3Zt
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 10:48:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=keith.busch@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wyhC4DvbzF3b9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 10:47:05 +1100 (AEDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Nov 2018 15:47:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,238,1539673200"; d="scan'208";a="108532213"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2018 15:47:02 -0800
Date: Thu, 15 Nov 2018 16:43:38 -0700
From: Keith Busch <keith.busch@intel.com>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH 2/2] PCI/AER: Determine AER ownership based on _OSC
 instead of HEST
Message-ID: <20181115234338.GE13334@localhost.localdomain>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <20181115231605.24352-3-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115231605.24352-3-mr.nuke.me@gmail.com>
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
Cc: alex_gagniuc@dellteam.com, helgaas@google.com,
 Sam Bobroff <sbobroff@linux.ibm.com>, linux-pci@vger.kernel.org,
 Shyam_Iyer@Dell.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukas@wunner.de,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 austin_bolen@dell.com, linuxppc-dev@lists.ozlabs.org,
 Len Brown <lenb@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 15, 2018 at 05:16:03PM -0600, Alexandru Gagniuc wrote:
>  static void aer_set_firmware_first(struct pci_dev *pci_dev)
>  {
> -	int rc;
> -	struct aer_hest_parse_info info = {
> -		.pci_dev	= pci_dev,
> -		.firmware_first	= 0,
> -	};
> +	struct pci_host_bridge *host = pci_find_host_bridge(pci_dev->bus);
>  
> -	rc = apei_hest_parse(aer_hest_parse, &info);
> -
> -	if (rc)
> -		pci_dev->__aer_firmware_first = 0;
> -	else
> -		pci_dev->__aer_firmware_first = info.firmware_first;
> +	pci_dev->__aer_firmware_first = !host->native_aer;
>  	pci_dev->__aer_firmware_first_valid = 1;
>  }

I think we can clean this up even more by removing the setter and the
__aer_firmware_first fields, and have the pcie_aer_get_firmware_first()
go directly to the host bride->native_aer.
