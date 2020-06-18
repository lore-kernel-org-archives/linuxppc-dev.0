Return-Path: <SRS0=k+Co=77=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5D1C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 15:44:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924E32070A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 15:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924E32070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nmSj3smYzDrKq
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2020 01:44:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=fenghua.yu@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nmKZ3r1QzDqR1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2020 01:37:51 +1000 (AEST)
IronPort-SDR: B6WW++CwvtmXsnpxC9/o5tkDzh0I6I23PGcjAfJzB4297Kk1tnIFKoHlyDcu158XZKssFsvqg4
 JiU6dU8bZL2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="144138247"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; d="scan'208";a="144138247"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 08:37:47 -0700
IronPort-SDR: CzS5MoOz9LW2W8ufcf7VltJ40EwQvdPZ9f1UIByPKyXcF7fjAaxqMgTRiN1ED9CIyfAtjpBrfb
 JU43hSx3nDnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; d="scan'208";a="291807299"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga002.jf.intel.com with ESMTP; 18 Jun 2020 08:37:47 -0700
Date: Thu, 18 Jun 2020 08:37:47 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v2 02/12] ocxl: Change type of pasid to unsigned int
Message-ID: <20200618153747.GE15763@romley-ivt3.sc.intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-3-git-send-email-fenghua.yu@intel.com>
 <972dc2cb-9643-53af-b11d-ebb56d96053d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <972dc2cb-9643-53af-b11d-ebb56d96053d@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: Dave Hansen <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Joerg Roedel <joro@8bytes.org>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Ingo Molnar <mingo@redhat.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Sohil Mehta <sohil.mehta@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi, Frederic,

On Thu, Jun 18, 2020 at 10:05:19AM +0200, Frederic Barrat wrote:
> 
> 
> Le 13/06/2020 à 02:41, Fenghua Yu a écrit :
> >PASID is defined as "int" although it's a 20-bit value and shouldn't be
> >negative int. To be consistent with type defined in iommu, define PASID
> >as "unsigned int".
> 
> 
> It looks like this patch was considered because of the use of 'pasid' in
> variable or function names. The ocxl driver only makes sense on powerpc and
> shouldn't compile on anything else, so it's probably useless in the context
> of that series.
> The pasid here is defined by the opencapi specification
> (https://opencapi.org), it is borrowed from the PCI world and you could
> argue it could be an unsigned int. But then I think the patch doesn't go far
> enough. But considering it's not used on x86, I think this patch can be
> dropped.

The first 3 patches clean up pasid and flag defitions to prepare for
following patches.

If you think this patch can be dropped, we will drop it.

Thanks.

-Fenghua
