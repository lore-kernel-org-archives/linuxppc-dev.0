Return-Path: <SRS0=DmFP=KB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D940C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 May 2021 04:58:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E466661185
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 May 2021 04:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E466661185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FbLvW1m2Nz3bq9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 May 2021 14:58:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FbLv31x6kz2ydK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 May 2021 14:58:21 +1000 (AEST)
IronPort-SDR: JEFTjQ5obrJkvygsVeSC94qCfvOq55bPBlPCKZmzUHSEFKR3WP1Jq4b8gOcPpdkLAPE0Xsngdu
 AxZaK2w2nKVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="219254068"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; d="scan'208";a="219254068"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2021 21:58:18 -0700
IronPort-SDR: EF+8N3LXcl59PTDiecfIj5KDpwG3f9jF/LViXUSOrhWkGtYqM8jSlfn2mr6B5jTXwGP6Lxp/L4
 GGknPeZgbUvA==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; d="scan'208";a="434161480"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2021 21:58:18 -0700
Date: Wed, 5 May 2021 21:58:17 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/papr_scm: Reduce error severity if nvdimm
 stats inaccessible
Message-ID: <20210506045817.GF1068722@iweiny-DESK2.sc.intel.com>
References: <20210505191606.51666-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505191606.51666-1-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: Santosh Sivaraj <santosh@fossix.org>, linux-nvdimm@lists.01.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 06, 2021 at 12:46:06AM +0530, Vaibhav Jain wrote:
> Currently drc_pmem_qeury_stats() generates a dev_err in case
> "Enable Performance Information Collection" feature is disabled from
> HMC or performance stats are not available for an nvdimm. The error is
> of the form below:
> 
> papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
> 	 performance stats, Err:-10
> 
> This error message confuses users as it implies a possible problem
> with the nvdimm even though its due to a disabled/unavailable
> feature. We fix this by explicitly handling the H_AUTHORITY and
> H_UNSUPPORTED errors from the H_SCM_PERFORMANCE_STATS hcall.
> 
> In case of H_AUTHORITY error an info message is logged instead of an
> error, saying that "Permission denied while accessing performance
> stats". Also '-EACCES' error is return instead of -EPERM.

I thought you clarified before that this was a permission issue.  So why change
the error to EACCES?

> 
> In case of H_UNSUPPORTED error we return a -EPERM error back from
> drc_pmem_query_stats() indicating that performance stats-query
> operation is not supported on this nvdimm.

EPERM seems wrong here too...  ENOTSUP?

Ira
