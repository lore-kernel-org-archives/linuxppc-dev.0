Return-Path: <SRS0=gM2d=AL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF71C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 18:21:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE5F2074D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 18:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE5F2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49xCNr0b30zDqnB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 04:21:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49xCLd1bBDzDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2020 04:19:35 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2C5A868B05; Tue, 30 Jun 2020 20:19:29 +0200 (CEST)
Date: Tue, 30 Jun 2020 20:19:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: rename ->make_request_fn and move it to the
 block_device_operations
Message-ID: <20200630181928.GA7853@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
 <bd1443c0-be37-115b-1110-df6f0e661a50@kernel.dk>
 <6ddbe343-0fc2-58c8-3726-c4ba9952994f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ddbe343-0fc2-58c8-3726-c4ba9952994f@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 drbd-dev@lists.linbit.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 30, 2020 at 09:43:31AM -0600, Jens Axboe wrote:
> On 6/30/20 7:57 AM, Jens Axboe wrote:
> > On 6/29/20 1:39 PM, Christoph Hellwig wrote:
> >> Hi Jens,
> >>
> >> this series moves the make_request_fn method into block_device_operations
> >> with the much more descriptive ->submit_bio name.  It then also gives
> >> generic_make_request a more descriptive name, and further optimize the
> >> path to issue to blk-mq, removing the need for the direct_make_request
> >> bypass.
> > 
> > Looks good to me, and it's a nice cleanup as well. Applied.
> 
> Dropped, insta-crashes with dm:

Hmm.  Can you send me what is at "submit_bio_noacct+0x1f6" from gdb?
Or your .config?
