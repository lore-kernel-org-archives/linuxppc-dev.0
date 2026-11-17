Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0DB606A896
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ISSwAncL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTYrm5k2jz2xcB;
	Wed, 18 Nov 2026 05:57:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794941864;
	cv=none; b=BkQtP6w5YsHbhP8MtLCO6RSRzJZd4DMMb3UIujvdN9SI0fLjgoTDtnGw4ITi2CD4849veRi0FM9zhMHCEcrUotLlk8RUbuos5c3BI9vV7+zaH0TWL3QpCFwF6XCTepwRwgjZ2IR7sZMpuLfrkC1V+qB2qG6BXQ4a5mmcsmtPw1T9Q+tWkCSEUlyYpplJNl7V/iYLwW4kvc/YrA/5N5HUue/ne5F8co2Qj2kZNzoCltKysWHuwLQcTfU/6gboRofQyY7Bre3EVtC2Cu/bGVv0hFpSxVKybPyB5mNikzosnEpvXK0AzCXm4ddc6aXeEHfALTObfo/nyNoeYJ1WHPoj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794941864; c=relaxed/relaxed;
	bh=HdkDes0ncCU4WGhgyR7YXxDGwX38qel+esSZ7Ve7TMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJZA6aQoeK5CtOikeE9b+ZMNyaZgRs1oiTLR4hzaIrGTzD08o/r8eFyGdtm8BjK69WxFrfJpNALu8/jcMx1zR4ixqsKeboyurmUiAMUp4n4a5jUDdTCyV3rCp94ZvqEBJHF/YbIAsbaWFUyofqKl7rMeroARjUqxYvXix/HGD1hv0rgN6NsSxTGGw3iYWtS2opmuxL6IhuVYtvT4OqFvJJkmaLFyUNgzAIGa0SeikpEyaReyOQ3DHfq+bqEEdEyuuQLDYbovouWF1VIUcD7nG7+SFPJ6wZjr7QVszVcpy78r+poY5aR4y4c9lWH2pqVDbckDWolNPE8Ly0OEwBZHpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ISSwAncL; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ISSwAncL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTYrj5lSvz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 05:57:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794941862; x=1826477862;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v1NsJvl2MeAn+U0ELjw0P121EwhLfFQaHMoHS8YBAvw=;
  b=ISSwAncLkGjmC6zt5mSf5rKXDNGo4zbzMqiM+2HANic0GhLSk0g2x7xj
   uRBz0YELwDT+uZptGptaB5u3EJlq7gWH/P9tIs1eXOXeT5BaoqCWuSHHL
   3PTmtWzBDWpjpeWmcr+qCPl3Dy3jyVXovmp9QoGeP9+fZk6T/3zTcj44v
   3prZdC6xeWBtyH/NaWn3Jq/1aPfm6MlerFmnP2CHf15k/dhE/aljcHFxo
   /L+XSfVMg2x/xZuNlFIoHyyS7uTqcxjx5yDMb0NoCIhTaEfcGfT85cZCh
   ConDCCEsAxCSXdDpMerQXc4K+vR5U0IdyQVbzwDdRpLtnbKTRV5E1pSxp
   A==;
X-CSE-ConnectionGUID: 270RARzkSD++pZkA/HWCnA==
X-CSE-MsgGUID: Gv9tZY28QmGEB3x7wwToxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3753812"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3753812"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:57:34 -0800
X-CSE-ConnectionGUID: DPWAMEErR3Kxtj4lkE/CAw==
X-CSE-MsgGUID: y3FAroW/Sx6yGrYcfClEAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="11733291"
Received: from skuppusw-desk1.jf.intel.com (HELO [10.24.80.125]) ([10.24.80.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:57:34 -0800
Message-ID: <28da8229-99f9-47c7-b2d6-d301ae34253f@linux.intel.com>
Date: Tue, 17 Nov 2026 10:57:33 -0800
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 19/19] PCI/ERR: Avoid NULL bridge pointer
To: Lukas Wunner <lukas@wunner.de>, Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Avadhut Naik <avadhut.naik@amd.com>, Radu Rendec <radu@rendec.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-20-pierre.gondois@arm.com>
 <avw_daENKPcY7_04@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <avw_daENKPcY7_04@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/17/26 03:50, Lukas Wunner wrote:
> On Tue, Nov 17, 2026 at 12:10:29PM +0100, Pierre Gondois wrote:
>> Return PCI_ERS_RESULT_DISCONNECT when no upstream bridge is available,
>> avoiding a NULL pointer dereference in pci_walk_bridge().
> 
> How can that happen?  If it can happen (which I doubt), why isn't this
> patch tagged for stable?

One way I can see is a device without a PCIe capability on a root bus.
pci_pcie_type() returns 0, which is PCI_EXP_TYPE_ENDPOINT, and
pci_upstream_bridge() returns NULL. Native AER never gets there. Only
firmware-first can, through aer_recover_work_func(), and only if
firmware reports a PCIe error section for such a device. If that is
the case, skipping recovery for !pci_is_pcie(pdev) in
aer_recover_work_func() seems a better fit than a check in
pcie_do_recovery().

> 
> Why is it at the end of this series?  Does the series somehow make it
> possible that there's no upstream bridge?  Which patch does that?
> If the preceding patches are not the cause of a potential NULL
> pointer deref, why isn't this patch submitted separately from the series?
> 
> Thanks,
> 
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


