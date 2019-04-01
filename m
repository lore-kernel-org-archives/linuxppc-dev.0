Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F283DC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 10:29:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E652087F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 10:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E652087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XpW00DFDzDqNB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 21:29:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.intel.com
 (client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XpTJ1PHfzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 21:28:19 +1100 (AEDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Apr 2019 03:28:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,296,1549958400"; d="scan'208";a="333890611"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
 by fmsmga005.fm.intel.com with ESMTP; 01 Apr 2019 03:28:09 -0700
Received: from andy by smile with local (Exim 4.92)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1hAuAg-0003zN-6d; Mon, 01 Apr 2019 13:28:06 +0300
Date: Mon, 1 Apr 2019 13:28:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: George Spelvin <lkml@sdf.org>
Subject: Re: [PATCH v2 5/5] Lib: sort.h: replace int size with size_t size in
 the swap function
Message-ID: <20190401102806.GE9224@smile.fi.intel.com>
References: <19606671554056883@myt3-1179f584969c.qloud-c.yandex.net>
 <23051461554058370@iva6-3ac3de5fcc31.qloud-c.yandex.net>
 <20190401093555.GD9224@smile.fi.intel.com>
 <201904010956.x319u70q021113@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904010956.x319u70q021113@sdf.org>
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
Cc: peterz@infradead.org, dchinner@redhat.com, linux-kernel@vger.kernel.org,
 st5pub@yandex.ru, linux-mtd@lists.infradead.org, hpa@zytor.com, jslaby@suse.cz,
 sfr@canb.auug.org.au, darrick.wong@oracle.com, mark@fasheh.com, x86@kernel.org,
 mingo@redhat.com, naveen.n.rao@linux.vnet.ibm.com,
 linux-snps-arc@lists.infradead.org, jannh@google.com, bp@alien8.de,
 jlbec@evilplan.org, jpoimboe@redhat.com, tglx@linutronix.de,
 ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org, dedekind1@gmail.com,
 adrian.hunter@intel.com, vgupta@synopsys.com, richard@nod.at, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 01, 2019 at 09:56:07AM +0000, George Spelvin wrote:
> On Mon, 1 Apr 2019 at 12:35:55 +0300, Andy Shevchenko wrote:
> > Hmm... If (*swap)() is called recursively it means the change might increase
> > stack usage on 64-bit platforms.
> > 
> > Am I missing something?
> 
> Under what conceivable circumstance would someone write a recursive
> (*swap)() function?
> 
> You're technically right, but the precondition is more fantastical
> than "if the U.K.'s parliament get their shit together before the
> 12th", so I have a hard time worrying about it.
> 
> But you did make me think of something: the whole reason swap()
> takes a size argument is for the benefit of the (no longer existing)
> generic swap functions.  All of the custom swap functions ignore
> it.
> 
> So how about *deleting* the parameter instead?  That simplifies
> everything.

I like this idea!

-- 
With Best Regards,
Andy Shevchenko


