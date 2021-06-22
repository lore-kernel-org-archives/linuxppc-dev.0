Return-Path: <SRS0=MtJN=LQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D76C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 12:47:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AEE60FE7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 12:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AEE60FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G8R5856GJz3bTb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jun 2021 22:47:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux.intel.com
 (client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN>)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G8R4m51yhz304G
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jun 2021 22:47:36 +1000 (AEST)
IronPort-SDR: NqmTqoAY4+4Jv8q81zdU5mx4QV1jWkZniqeC1rQlyX1aG+8UjVW2B3TrFO4Sl7xv/wpHMXcN19
 iOQeNoGRkApQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="187426933"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; d="scan'208";a="187426933"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2021 05:47:32 -0700
IronPort-SDR: YEsZAytSydJ9ZEEyXdHQKV+xEWIRoClVPExk3AvAamRvPCwsJ1bnbduRlQZClO8TDmSr9/4hj3
 AnQvP68YEh2Q==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; d="scan'208";a="480801356"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2021 05:47:30 -0700
Received: from andy by smile with local (Exim 4.94.2)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1lvfoM-004TK5-FQ; Tue, 22 Jun 2021 15:47:26 +0300
Date: Tue, 22 Jun 2021 15:47:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] powerpc/papr_scm: Properly handle UUID types and
 API
Message-ID: <YNHb3mm0l9i/+Asm@smile.fi.intel.com>
References: <20210616134303.58185-1-andriy.shevchenko@linux.intel.com>
 <YNHbSGzdgQh+6F+O@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNHbSGzdgQh+6F+O@smile.fi.intel.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 22, 2021 at 03:44:56PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 16, 2021 at 04:43:03PM +0300, Andy Shevchenko wrote:
> > Parse to and export from UUID own type, before dereferencing.
> > This also fixes wrong comment (Little Endian UUID is something else)
> > and should eliminate the direct strict types assignments.
> 
> Any comments on this version? Can it be applied?

"Any _other_ comments..."

> > Fixes: 43001c52b603 ("powerpc/papr_scm: Use ibm,unit-guid as the iset cookie")
> > Fixes: 259a948c4ba1 ("powerpc/pseries/scm: Use a specific endian format for storing uuid from the device tree")

AFAIU it's fine to have Fixes tags, but if anybody insist I will remove them
and send v3.

> > ---
> > v2: added missed header (Vaibhav), updated comment (Aneesh),
> >     rewrite part of the commit message to avoid mentioning the Sparse

-- 
With Best Regards,
Andy Shevchenko


