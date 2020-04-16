Return-Path: <SRS0=XoDJ=6A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6361DC2BB85
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 10:08:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B653221D92
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 10:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B653221D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492w0053QfzDrVn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 20:08:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=jani.nikula@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492vxv0GBxzDrRV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2020 20:05:57 +1000 (AEST)
IronPort-SDR: mwMuG9Vzx28dX+ZJdIXuPBY4NZF5XQTyxutB21XXx+7jEsc+tQn8bjv85CCrGIloWe4zEI3tAA
 IF589Ys+fLNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2020 03:05:53 -0700
IronPort-SDR: RjBv+uX+qdBSawkGTFreimgV4amAPsx7yEe1IJ3aQIXgdP4x219JR8hl3o9eqO/hwoAVeQq9M9
 UXTLT5nwMsgA==
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; d="scan'208";a="427781153"
Received: from ellenfax-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.249.44.122])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2020 03:05:42 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 0/2] Don't generate thousands of new warnings when
 building docs
In-Reply-To: <20200320171020.78f045c5@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1584716446.git.mchehab+huawei@kernel.org>
 <20200320171020.78f045c5@lwn.net>
Date: Thu, 16 Apr 2020 13:05:39 +0300
Message-ID: <87a73b4ufg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Ricardo Ribalda Delgado <ribalda@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 target-devel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Alex Shi <alex.shi@linux.alibaba.com>,
 linux-scsi@vger.kernel.org, x86@kernel.org, Tyler Hicks <code@tyhicks.com>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jacopo Mondi <jacopo@jmondi.org>, Luca Ceresoli <luca@lucaceresoli.net>,
 Johannes Berg <johannes.berg@intel.com>, ecryptfs@vger.kernel.org,
 Matthias Maennich <maennich@google.com>, dmaengine@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Harry Wei <harryxiyou@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 20 Mar 2020, Jonathan Corbet <corbet@lwn.net> wrote:
> On Fri, 20 Mar 2020 16:11:01 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>
>> This small series address a regression caused by a new patch at
>> docs-next (and at linux-next).
>
> I don't know how I missed that mess, sorry.  I plead distracting times or
> something like that.  Heck, I think I'll blame everything on the plague
> for at least the next few weeks.
>
> Anyway, I've applied this, thanks for cleaning it up.

There's still more fallout from the autosectionlabel extension
introduced in 58ad30cf91f0 ("docs: fix reference to
core-api/namespaces.rst"), e.g. in i915.rst.

The biggest trouble is, if you have headings in kernel-doc comments,
Sphinx is unable pinpoint where the dupes are. For example:

 Documentation/gpu/i915.rst:610: WARNING: duplicate label gpu/i915:layout, other instance in
 Documentation/gpu/i915.rst

However there is no "layout" label in i915.rst. The one being warned
about I can dig into based on the line number, but not the second
one. You have to resort to grepping the source. And avoiding duplicate
subsection headings in completely isolated places is a minefield.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
