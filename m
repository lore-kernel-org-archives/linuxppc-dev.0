Return-Path: <SRS0=sSB4=5S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4406C43331
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 20:44:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C9C20719
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 20:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C9C20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48tZmJ0SdtzDrc9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 07:44:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux.intel.com
 (client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=ak@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48tZkD1NG1zDrNf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2020 07:42:10 +1100 (AEDT)
IronPort-SDR: KfJtQU9dKuM85lXSpuhmayCIOeBTlWGoewMBnA/TNmKPKY5vtkgUq/EtEHo0Fg6D65nQ1D5+Xc
 dJQ6kfesaZWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2020 13:42:07 -0700
IronPort-SDR: dsv12UYcSHLKqNQF74Motq/EX9D7xvMzgi32UbnDrmWg6Z/Sgm/2agiIymeOKwXeQBjWQC0rLF
 mXXC14UIZbig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; d="scan'208";a="360320844"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
 by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2020 13:42:06 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
 id 35467301813; Thu,  2 Apr 2020 13:42:06 -0700 (PDT)
Date: Thu, 2 Apr 2020 13:42:06 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v8 6/7] tools/perf: Enable Hz/hz prinitg for
 --metric-only option
Message-ID: <20200402204206.GB397326@tassilo.jf.intel.com>
References: <20200401203340.31402-1-kjain@linux.ibm.com>
 <20200401203340.31402-7-kjain@linux.ibm.com>
 <20200402124946.GH2518490@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402124946.GH2518490@krava>
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
Cc: mark.rutland@arm.com, maddy@linux.vnet.ibm.com, peterz@infradead.org,
 yao.jin@linux.intel.com, mingo@kernel.org, kan.liang@linux.intel.com,
 alexander.shishkin@linux.intel.com, anju@linux.vnet.ibm.com,
 mamatha4@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
 ravi.bangoria@linux.ibm.com, Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
 jmario@redhat.com, namhyung@kernel.org, tglx@linutronix.de, mpetlan@redhat.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, jolsa@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 9e757d18d713..679aaa655824 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -237,8 +237,6 @@ static bool valid_only_metric(const char *unit)
> >  	if (!unit)
> >  		return false;
> >  	if (strstr(unit, "/sec") ||
> > -	    strstr(unit, "hz") ||
> > -	    strstr(unit, "Hz") ||
> 
> will this change output of --metric-only for some setups then?
> 
> Andi, are you ok with this?

Yes should be ok

$ grep -i ScaleUnit.*hz arch/x86/*/* 
$ 

Probably was for some metric we later dropped.

-Andi
