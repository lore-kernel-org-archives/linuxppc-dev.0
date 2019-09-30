Return-Path: <SRS0=cA15=XZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D48C32792
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Sep 2019 12:17:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD782054F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Sep 2019 12:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD782054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46hhGn2HFwzDqLd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Sep 2019 22:17:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.intel.com
 (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46hhCq2Sf4zDqKH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2019 22:14:31 +1000 (AEST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Sep 2019 05:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,567,1559545200"; d="scan'208";a="194156456"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga003.jf.intel.com with ESMTP; 30 Sep 2019 05:13:14 -0700
Received: from andy by smile with local (Exim 4.92.1)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1iEuYD-0001Kd-BT; Mon, 30 Sep 2019 15:13:13 +0300
Date: Mon, 30 Sep 2019 15:13:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v1 1/2] PCI/AER: Use for_each_set_bit()
Message-ID: <20190930121313.GV32742@smile.fi.intel.com>
References: <20190827151823.75312-1-andriy.shevchenko@linux.intel.com>
 <20190927123913.GA32321@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927123913.GA32321@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
Cc: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Sep 27, 2019 at 07:39:13AM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 27, 2019 at 06:18:22PM +0300, Andy Shevchenko wrote:
> > This simplifies and standardizes slot manipulation code
> > by using for_each_set_bit() library function.

> > +	unsigned long status = info->status & ~info->mask;
> > +	int i, max = -1;

> > -	for (i = 0; i < max; i++)
> > -		if (status & (1 << i))
> > -			counter[i]++;
> > +	for_each_set_bit(i, &status, max)
> 
> I applied this,

Thank you!

> but I confess to being a little ambivalent.  It's
> arguably a little easier to read,

I have another opinion here. Instead of parsing body of for-loop, the name of
the function tells you exactly what it's done. Besides the fact that reading
and parsing two lines, with zero conditionals, is faster.

> but it's not nearly as efficient
> (not a great concern here)

David, do you know why for_each_set_bit() has no optimization for the cases
when nbits <= BITS_PER_LONG? (Actually find_*bit() family of functions)

> and more importantly much harder to verify
> that it's correct because you have to chase through
> for_each_set_bit(), find_first_bit(), _ffs(), etc, etc.

If for_each_set_bit() or any other fundamental bit operation helper is broken,
PCI subsystem is a little concern here.

> No doubt it's
> great for bitmaps of arbitrary size, but for a simple 32-bit register
> I'm a little hesitant.  But I applied it anyway.
> 
> > +		counter[i]++;

-- 
With Best Regards,
Andy Shevchenko


