Return-Path: <SRS0=7NNx=XB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99538C43140
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Sep 2019 15:52:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0282C214DE
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Sep 2019 15:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0282C214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Q2Bv1jhnzDrD1
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Sep 2019 01:52:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=dsterba@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Q28f5CQRzDrBc
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2019 01:50:56 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 432B5B0E2;
 Fri,  6 Sep 2019 15:50:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id D58D2DA8F3; Fri,  6 Sep 2019 17:51:15 +0200 (CEST)
Date: Fri, 6 Sep 2019 17:51:15 +0200
From: David Sterba <dsterba@suse.cz>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Subject: Re: [mainline][BUG][PPC][btrfs][bisected 00801a] kernel BUG at
 fs/btrfs/locking.c:71!
Message-ID: <20190906155115.GD2850@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, nborisov@suse.com,
 dsterba@suse.com, linux-btrfs@vger.kernel.org,
 chandan <chandan@linux.vnet.ibm.com>, josef@toxicpanda.com,
 mpe <mpe@ellerman.id.au>, sachinp <sachinp@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
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
Cc: sachinp <sachinp@linux.vnet.ibm.com>, nborisov@suse.com,
 linux-kernel <linux-kernel@vger.kernel.org>, josef@toxicpanda.com,
 Brian King <brking@linux.vnet.ibm.com>, chandan <chandan@linux.vnet.ibm.com>,
 dsterba@suse.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-btrfs@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Sep 03, 2019 at 02:25:07PM +0530, Abdul Haleem wrote:
> Greeting's
> 
> Mainline kernel panics with LTP/fs_fill-dir tests for btrfs file
> system on my P9 box running mainline kernel 5.3.0-rc5

Is the issue reproducible? And if yes, how reliably? Thanks.
