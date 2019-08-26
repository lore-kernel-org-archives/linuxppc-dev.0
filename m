Return-Path: <SRS0=H2FS=WW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E47C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Aug 2019 16:48:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23A521848
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Aug 2019 16:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23A521848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46HHyK4dFNzDqR1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 02:48:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=dsterba@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46HHvm36BkzDqWw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2019 02:46:26 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9B23DAE47;
 Mon, 26 Aug 2019 16:46:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id 1DFFCDA98E; Mon, 26 Aug 2019 18:46:47 +0200 (CEST)
Date: Mon, 26 Aug 2019 18:46:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2] btrfs: fix allocation of bitmap pages.
Message-ID: <20190826164646.GX2752@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, erhard_f@mailbox.org,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <c3157c8e8e0e7588312b40c853f65c02fe6c957a.1566399731.git.christophe.leroy@c-s.fr>
 <20190826153757.GW2752@twin.jikos.cz>
 <a096d653-8b64-be15-3e81-581536a88e8a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a096d653-8b64-be15-3e81-581536a88e8a@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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
Reply-To: dsterba@suse.cz
Cc: erhard_f@mailbox.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, dsterba@suse.cz,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 26, 2019 at 06:40:24PM +0300, Nikolay Borisov wrote:
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204371
> >> Fixes: 69d2480456d1 ("btrfs: use copy_page for copying pages instead of memcpy")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >> ---
> >> v2: Using kmem_cache instead of get_zeroed_page() in order to benefit from SLAB debugging features like redzone.
> > 
> > I'll take this version, thanks. Though I'm not happy about the allocator
> > behaviour. The kmem cache based fix can be backported independently to
> > 4.19 regardless of the SL*B fixes.
> > 
> >> +extern struct kmem_cache *btrfs_bitmap_cachep;
> > 
> > I've renamed the cache to btrfs_free_space_bitmap_cachep
> > 
> > Reviewed-by: David Sterba <dsterba@suse.com>
> 
> Isn't this obsoleted by
> 
> '[PATCH v2 0/2] guarantee natural alignment for kmalloc()' ?

Yeah, but this would add maybe another whole dev cycle to merge and
release. The reporters of the bug seem to care enough to identify the
problem and propose the fix so I feel like adding the btrfs-specific fix
now is a little favor we can afford.

The bug is reproduced on an architecture that's not widely tested so
from practical POV I think this adds more coverage which is desirable.
