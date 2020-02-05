Return-Path: <SRS0=GzqQ=3Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C062C35247
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Feb 2020 23:36:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185F620730
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Feb 2020 23:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185F620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48CdHk6y64zDqQs
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Feb 2020 10:36:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux.intel.com
 (client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=richardw.yang@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48CdF52vdRzDqHr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2020 10:34:16 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Feb 2020 15:34:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; d="scan'208";a="264405373"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga002.fm.intel.com with ESMTP; 05 Feb 2020 15:34:12 -0800
Date: Thu, 6 Feb 2020 07:34:28 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v6 08/10] mm/memory_hotplug: Don't check for "all holes"
 in shrink_zone_span()
Message-ID: <20200205233428.GD28446@richard>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com>
 <20200205095924.GC24162@richard>
 <20200205144811.GF26758@MiWiFi-R3L-srv>
 <20200205225633.GA28446@richard>
 <20200205230826.GF8965@MiWiFi-R3L-srv>
 <20200205232620.GC28446@richard>
 <20200205233051.GG8965@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205233051.GG8965@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: linux-s390@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 David Hildenbrand <david@redhat.com>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Wei Yang <richardw.yang@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org,
 Oscar Salvador <osalvador@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 06, 2020 at 07:30:51AM +0800, Baoquan He wrote:
>On 02/06/20 at 07:26am, Wei Yang wrote:
>> On Thu, Feb 06, 2020 at 07:08:26AM +0800, Baoquan He wrote:
>> >On 02/06/20 at 06:56am, Wei Yang wrote:
>> >> On Wed, Feb 05, 2020 at 10:48:11PM +0800, Baoquan He wrote:
>> >> >Hi Wei Yang,
>> >> >
>> >> >On 02/05/20 at 05:59pm, Wei Yang wrote:
>> >> >> >diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> >> >> >index f294918f7211..8dafa1ba8d9f 100644
>> >> >> >--- a/mm/memory_hotplug.c
>> >> >> >+++ b/mm/memory_hotplug.c
>> >> >> >@@ -393,6 +393,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>> >> >> > 		if (pfn) {
>> >> >> > 			zone->zone_start_pfn = pfn;
>> >> >> > 			zone->spanned_pages = zone_end_pfn - pfn;
>> >> >> >+		} else {
>> >> >> >+			zone->zone_start_pfn = 0;
>> >> >> >+			zone->spanned_pages = 0;
>> >> >> > 		}
>> >> >> > 	} else if (zone_end_pfn == end_pfn) {
>> >> >> > 		/*
>> >> >> >@@ -405,34 +408,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>> >> >> > 					       start_pfn);
>> >> >> > 		if (pfn)
>> >> >> > 			zone->spanned_pages = pfn - zone_start_pfn + 1;
>> >> >> >+		else {
>> >> >> >+			zone->zone_start_pfn = 0;
>> >> >> >+			zone->spanned_pages = 0;
>> >> >> >+		}
>> >> >> > 	}
>> >> >> 
>> >> >> If it is me, I would like to take out these two similar logic out.
>> >> >
>> >> >I also like this style. 
>> >> >> 
>> >> >> For example:
>> >> >> 
>> >> >> 	if () {
>> >> >> 	} else if () {
>> >> >> 	} else {
>> >> >> 		goto out;
>> >> >Here the last else is unnecessary, right?
>> >> >
>> >> 
>> >> I am afraid not.
>> >> 
>> >> If the range is not the first or last, we would leave pfn not initialized.
>> >
>> >Ah, you are right. I forgot that one. Then pfn can be assigned the
>> >zone_start_pfn as the old code. Then the following logic is the same
>> >as the original code, find_smallest_section_pfn()/find_biggest_section_pfn() 
>> >have done the iteration the old for loop was doing.
>> >
>> >	unsigned long pfn = zone_start_pfn;	
>> >	if () {
>> >	} else if () {
>> >	} 
>> >
>> >	/* The zone has no valid section */
>> >	if (!pfn) {
>> >        	zone->zone_start_pfn = 0;
>> >        	zone->spanned_pages = 0;
>> >	}
>> 
>> This one look better :-)
>
>Thanks for your confirmation, I will make one patch like this and post.

Sure :-)

-- 
Wei Yang
Help you, Help me
