Return-Path: <SRS0=I40Z=CT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E845C433E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 15:59:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415832087C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 15:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415832087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BnNqm5Y73zDqgV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2020 01:59:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BnNlg5lV7zDqdf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2020 01:55:56 +1000 (AEST)
IronPort-SDR: HoPNvUDQa3KY00PJW/8OK9wwbvAnkk00rWods022gH1bS/YYbGrSMZHndO3z8mCyNlyjd+0v4N
 PaB+p1VUisKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="146268336"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="146268336"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 08:55:53 -0700
IronPort-SDR: mdE+NB6LIJFFEpYlXw+w/dp1bIOLDHSskRELYdPHSV87quvSW71AhFkqp6C9isjWBxvi00K/Ij
 QcMBUzhKiWiA==
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="480943809"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 08:55:52 -0700
Date: Thu, 10 Sep 2020 08:55:52 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH] powerpc/papr_scm: Fix warning triggered by
 perf_stats_show()
Message-ID: <20200910155552.GN1930795@iweiny-DESK2.sc.intel.com>
References: <20200910092212.107674-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910092212.107674-1-vaibhav@linux.ibm.com>
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
 Oliver O'Halloran <oohall@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 10, 2020 at 02:52:12PM +0530, Vaibhav Jain wrote:
> A warning is reported by the kernel in case perf_stats_show() returns
> an error code. The warning is of the form below:
> 
>  papr_scm ibm,persistent-memory:ibm,pmemory@44100001:
>  	  Failed to query performance stats, Err:-10
>  dev_attr_show: perf_stats_show+0x0/0x1c0 [papr_scm] returned bad count
>  fill_read_buffer: dev_attr_show+0x0/0xb0 returned bad count
> 
> On investigation it looks like that the compiler is silently truncating the
> return value of drc_pmem_query_stats() from 'long' to 'int', since the
> variable used to store the return code 'rc' is an 'int'. This
> truncated value is then returned back as a 'ssize_t' back from
> perf_stats_show() to 'dev_attr_show()' which thinks of it as a large
> unsigned number and triggers this warning..
> 
> To fix this we update the type of variable 'rc' from 'int' to
> 'ssize_t' that prevents the compiler from truncating the return value
> of drc_pmem_query_stats() and returning correct signed value back from
> perf_stats_show().
> 
> Fixes: 2d02bf835e573 ('powerpc/papr_scm: Fetch nvdimm performance
>        stats from PHYP')
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index a88a707a608aa..9f00b61676ab9 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -785,7 +785,8 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
>  static ssize_t perf_stats_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> -	int index, rc;
> +	int index;
> +	ssize_t rc;

I'm not sure this is really fixing everything here.

drc_pmem_query_stats() can return negative errno's.  Why are those not checked
somewhere in perf_stats_show()?

It seems like all this fix is handling is a > 0 return value: 'ret[0]' from
line 289 in papr_scm.c...  Or something?

Worse yet drc_pmem_query_stats() is returning ssize_t which is a signed value.
Therefore, it should not be returning -errno.  I'm surprised the static
checkers did not catch that.

I believe I caught similar errors with a patch series before which did not pay
attention to variable types.

Please audit this code for these types of errors and ensure you are really
doing the correct thing when using the sysfs interface.  I'm pretty sure bad
things will eventually happen (if they are not already) if you return some
really big number to the sysfs core from *_show().

Ira

>  	struct seq_buf s;
>  	struct papr_scm_perf_stat *stat;
>  	struct papr_scm_perf_stats *stats;
> -- 
> 2.26.2
> 
