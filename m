Return-Path: <SRS0=bXCp=74=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB39C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2020 23:18:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A372068E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2020 23:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A372068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49m6gy2CW0zDqV4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 09:18:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=fenghua.yu@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49m6f06BMPzDqVl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2020 09:16:22 +1000 (AEST)
IronPort-SDR: udAogHkGfRHP1SyruUYVd6aU5+jnIg9OG4nEvl98/6n2IE9BpeR4/yukZZOecfEHz5c/2NHmGN
 +1P0YOaxo1Fg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2020 16:16:20 -0700
IronPort-SDR: T6ZjbELIrapPoUUC8t/yjki9aqCic7a2OCwmjZ4mzrjLS+BziTN1GdCLNAuNKeyY7ttZANoaUg
 /GtVSFW3HOXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; d="scan'208";a="290863836"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga002.jf.intel.com with ESMTP; 15 Jun 2020 16:16:19 -0700
Date: Mon, 15 Jun 2020 16:16:18 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 04/12] docs: x86: Add documentation for SVA (Shared
 Virtual Addressing)
Message-ID: <20200615231618.GF13792@romley-ivt3.sc.intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-5-git-send-email-fenghua.yu@intel.com>
 <9d1bd13c-0e0d-bead-f9a8-9422996a33f8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d1bd13c-0e0d-bead-f9a8-9422996a33f8@linux.intel.com>
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
 Frederic Barrat <fbarrat@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi, Baolu,

On Sat, Jun 13, 2020 at 08:17:40PM +0800, Lu Baolu wrote:
> Hi Fenghua,
> 
> On 2020/6/13 8:41, Fenghua Yu wrote:
> >+implement implement fairness or ensure forward progress can be made.
> 
> Repeated "implement".

Will fix this.

> >+For example, the Intel Data Streaming Accelerator (DSA) uses
> >+intel_svm_bind_mm(), which will do the following.
> 
> The Intel SVM APIs have been deprecated. Drivers should use
> iommu_sva_bind_device() instead. Please also update other places in
> this document.

Will fix this.

Thanks.

-Fenghua

