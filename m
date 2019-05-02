Return-Path: <SRS0=aDnU=TC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD72CC43219
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 May 2019 13:03:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712BC2063F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 May 2019 13:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712BC2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44vwRn4hw0zDqQJ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 May 2019 23:03:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=mhocko@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44vwNl47stzDqRc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2019 23:00:38 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7A7E5AEF9;
 Thu,  2 May 2019 13:00:34 +0000 (UTC)
Date: Thu, 2 May 2019 09:00:31 -0400
From: Michal Hocko <mhocko@kernel.org>
To: Barret Rhoden <brho@google.com>
Subject: Re: [PATCH 1/2] x86, numa: always initialize all possible nodes
Message-ID: <20190502130031.GC29835@dhcp22.suse.cz>
References: <20190212095343.23315-1-mhocko@kernel.org>
 <20190212095343.23315-2-mhocko@kernel.org>
 <34f96661-41c2-27cc-422d-5a7aab526f87@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34f96661-41c2-27cc-422d-5a7aab526f87@google.com>
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
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Pingfan Liu <kernelfans@gmail.com>, linux-mm@kvack.org,
 Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed 01-05-19 15:12:32, Barret Rhoden wrote:
[...]
> A more elegant solution may be to avoid registering with sysfs during early
> boot, or something else entirely.  But I figured I'd ask for help at this
> point.  =)

Thanks for the report and an excellent analysis! This is really helpful.
I will think about this some more but I am traveling this week. It seems
really awkward to register a sysfs file for an empty range. That looks
like a bug to me.

-- 
Michal Hocko
SUSE Labs
