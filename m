Return-Path: <SRS0=+4wI=W6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79E2C3A5A5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 12:42:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CFF20870
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 12:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CFF20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46N6740cKszDqkp
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Sep 2019 22:42:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=dsterba@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46N61G4wtmzDqkh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2019 22:37:54 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CF030B028;
 Tue,  3 Sep 2019 12:37:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id D3BB9DA8CD; Tue,  3 Sep 2019 14:38:09 +0200 (CEST)
Date: Tue, 3 Sep 2019 14:38:09 +0200
From: David Sterba <dsterba@suse.cz>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Subject: Re: [mainline][BUG][PPC][btrfs][bisected 00801a] kernel BUG at
 fs/btrfs/locking.c:71!
Message-ID: <20190903123809.GC2752@suse.cz>
Mail-Followup-To: dsterba@suse.cz, Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mpe <mpe@ellerman.id.au>, Brian King <brking@linux.vnet.ibm.com>,
 chandan <chandan@linux.vnet.ibm.com>,
 sachinp <sachinp@linux.vnet.ibm.com>,
 David Sterba <dsterba@suse.com>,
 Nikolay Borisov <nborisov@suse.com>, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <1567500907.5082.12.camel@abdul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567500907.5082.12.camel@abdul>
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
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Nikolay Borisov <nborisov@suse.com>,
 josef@toxicpanda.com, linux-kernel <linux-kernel@vger.kernel.org>,
 David Sterba <dsterba@suse.com>, chandan <chandan@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-btrfs@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Sep 03, 2019 at 02:25:07PM +0530, Abdul Haleem wrote:
> Greeting's
> 
> Mainline kernel panics with LTP/fs_fill-dir tests for btrfs file system on my P9 box running mainline kernel 5.3.0-rc5
> 
> BUG_ON was first introduced by below commit

Well, technically the bug_on was there already the only change is the
handling of the updates of the value.

> commit 00801ae4bb2be5f5af46502ef239ac5f4b536094
> Author: David Sterba <dsterba@suse.com>
> Date:   Thu May 2 16:53:47 2019 +0200
> 
>     btrfs: switch extent_buffer write_locks from atomic to int
>     
>     The write_locks is either 0 or 1 and always updated under the lock,
>     so we don't need the atomic_t semantics.

Assuming the code was correct before the patch, if this got broken one
of the above does not hold anymore:

* 0/1 updates -- this can be verified in code that all the state
  transitions are valid, ie. initial 0, locked update to 1, locked
  update 1->0

* atomic_t -> int behaves differently and the changes of the value get
  mixed up, eg. on the instruction level where intel architecture does
  'inc' while p9 does I-don't-know-what a RMW update?

But even with a RMW, this should not matter due to
write_lock/write_unlock around all the updates.
