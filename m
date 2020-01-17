Return-Path: <SRS0=8l9v=3G=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E7BC33CB1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jan 2020 15:36:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0549D2072E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jan 2020 15:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0549D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47zlXm3YlHzDq74
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Jan 2020 02:36:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.128.67; helo=mail-wm1-f67.google.com;
 envelope-from=mstsxfx@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47zkYz2YCRzDqdk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2020 01:52:38 +1100 (AEDT)
Received: by mail-wm1-f67.google.com with SMTP id m24so7712371wmc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2020 06:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AkURUQJ+DBuKMDSx+itAbwtb7hBHyuXsOO2uXs2DdgU=;
 b=UByWR/KEoS84c1iE8s4GHKe+QvYwcZAwuMeySvUkIFv+r/tR+ZpgkvXA+lOLxgn30l
 ++h5BXEUbPDHtiJMkRPt021kblq39ZI14qODYRJp+r0m60fMF3/y36dwCVZpc181Ch/6
 MBTlXtwK9aPoGLapI1zADETUxMSFjknTpaey/S7SNE7jMGb9wlMuu/FFqw6oGEi9J8K0
 0R/y5tBVO5y3sm5lnGp8frnLnxS5IwXRgSm0R6YAOk5xvUpCMWPUY1wN46Y+BUxWYJjG
 5gnSmBNbwixImb7kjBRTnYoDCFdp0spaYudecg7Fa3CToMxo+apfM4Ef8t3EiLk1g8Tf
 VgXA==
X-Gm-Message-State: APjAAAXfrtKogpOrw0kfpH2xHAEjt4UXh7REsk+RQxQe9kYFMIHT8g8Y
 skJVTP4p0iSm4abM4Is2f3M=
X-Google-Smtp-Source: APXvYqx6QdFP6CoZLoNRt4b0Ti6hyVkI0oAXyG8bSOgUtIHhWTQMk4sw68ciudP9UEYs0HOMMg2GPg==
X-Received: by 2002:a05:600c:2290:: with SMTP id
 16mr5039901wmf.93.1579272755115; 
 Fri, 17 Jan 2020 06:52:35 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
 by smtp.gmail.com with ESMTPSA id n8sm34315771wrx.42.2020.01.17.06.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2020 06:52:34 -0800 (PST)
Date: Fri, 17 Jan 2020 15:52:33 +0100
From: Michal Hocko <mhocko@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v1] mm: is_mem_section_removable() overhaul
Message-ID: <20200117145233.GB19428@dhcp22.suse.cz>
References: <20200117105759.27905-1-david@redhat.com>
 <20200117113353.GT19428@dhcp22.suse.cz>
 <c82a0dd7-a99b-6def-83d4-a19fbdd405d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c82a0dd7-a99b-6def-83d4-a19fbdd405d9@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Leonardo Bras <leonardo@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Allison Randal <allison@lohutok.net>, lantianyu1986@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri 17-01-20 14:08:06, David Hildenbrand wrote:
> On 17.01.20 12:33, Michal Hocko wrote:
> > On Fri 17-01-20 11:57:59, David Hildenbrand wrote:
> >> Let's refactor that code. We want to check if we can offline memory
> >> blocks. Add a new function is_mem_section_offlineable() for that and
> >> make it call is_mem_section_offlineable() for each contained section.
> >> Within is_mem_section_offlineable(), add some more sanity checks and
> >> directly bail out if the section contains holes or if it spans multiple
> >> zones.
> > 
> > I didn't read the patch (yet) but I am wondering. If we want to touch
> > this code, can we simply always return true there? I mean whoever
> > depends on this check is racy and the failure can happen even after
> > the sysfs says good to go, right? The check is essentially as expensive
> > as calling the offlining code itself. So the only usecase I can think of
> > is a dumb driver to crawl over blocks and check which is removable and
> > try to hotremove it. But just trying to offline one block after another
> > is essentially going to achieve the same.
> 
> Some thoughts:
> 
> 1. It allows you to check if memory is likely to be offlineable without
> doing expensive locking and trying to isolate pages (meaning:
> zone->lock, mem_hotplug_lock. but also, calling drain_all_pages()
> when isolating)
> 
> 2. There are use cases that want to identify a memory block/DIMM to
> unplug. One example is PPC DLPAR code (see this patch). Going over all
> memory block trying to offline them is an expensive operation.
> 
> 3. powerpc-utils (https://github.com/ibm-power-utilities/powerpc-utils)
> makes use of /sys/.../removable to speed up the search AFAIK.

Well, while I do see those points I am not really sure they are worth
having a broken (by-definition) interface.
 
> 4. lsmem displays/groups by "removable".

Is anybody really using that?

> 5. If "removable=false" then it usually really is not offlineable.
> Of course, there could also be races (free the last unmovable page),
> but it means "don't even try". OTOH, "removable=true" is more racy,
> and gives less guarantees. ("looks okay, feel free to try")

Yeah, but you could be already pessimistic and try movable zones before
other kernel zones.

> > Or does anybody see any reasonable usecase that would break if we did
> > that unconditional behavior?
> 
> If we would return always "true", then the whole reason the
> interface originally was introduced would be "broken" (meaning, less
> performant as you would try to offline any memory block).

I would argue that the whole interface is broken ;). Not the first time
in the kernel development history and not the last time either. What I
am trying to say here is that unless there are _real_ usecases depending
on knowing that something surely is _not_ offlineable then I would just
try to drop the functionality while preserving the interface and see
what happens.
-- 
Michal Hocko
SUSE Labs
