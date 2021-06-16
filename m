Return-Path: <SRS0=sb+l=LK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B55C48BE8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 14:05:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32331601FF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 14:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32331601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G4n5m2PQ3z308v
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 00:05:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux.intel.com
 (client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN>)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G4n5N3v6qz307T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jun 2021 00:05:27 +1000 (AEST)
IronPort-SDR: iCV8lJFW88PyN/QoVN5xjZFRuLtzd/YdGm6TObC+YVFlOMO3AyjY8n9XoKEIbpsjsywm0hPK47
 48yGC8ADw/rg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="186558415"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; d="scan'208";a="186558415"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2021 07:05:16 -0700
IronPort-SDR: dV2AwjTcL1XgrGLea/lTCqvSmWGX79q1zgcOfVt2RnTLz9AGIkyqcnxHK8cmqUz5/bNv8nr2FE
 Ih/VEAxYqCdQ==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; d="scan'208";a="554048291"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2021 07:05:13 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1ltWAI-002pmh-5s; Wed, 16 Jun 2021 17:05:10 +0300
Date: Wed, 16 Jun 2021 17:05:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] powerpc/papr_scm: Properly handle UUID types and
 API
Message-ID: <YMoFFn3J+eUzkUYh@smile.fi.intel.com>
References: <20210616134303.58185-1-andriy.shevchenko@linux.intel.com>
 <6f895afd-3469-c330-a4da-72db89dba6b3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f895afd-3469-c330-a4da-72db89dba6b3@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
Cc: linux-kernel@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jun 16, 2021 at 07:17:03PM +0530, Aneesh Kumar K.V wrote:
> On 6/16/21 7:13 PM, Andy Shevchenko wrote:
> > Parse to and export from UUID own type, before dereferencing.
> > This also fixes wrong comment (Little Endian UUID is something else)
> > and should eliminate the direct strict types assignments.
> > 
> > Fixes: 43001c52b603 ("powerpc/papr_scm: Use ibm,unit-guid as the iset cookie")
> > Fixes: 259a948c4ba1 ("powerpc/pseries/scm: Use a specific endian format for storing uuid from the device tree")
> 
> Do we need the Fixes: there? It didn't change any functionality right? The
> format with which we stored cookie1 remains the same with older and newer
> code. The newer one is better?

Depends if you are okay with Sparse warnings.

> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Thanks for review!

-- 
With Best Regards,
Andy Shevchenko


