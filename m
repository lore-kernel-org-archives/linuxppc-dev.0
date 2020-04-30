Return-Path: <SRS0=8RrW=6O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDA4C83001
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2020 05:41:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D0F2082E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2020 05:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D0F2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49CPPX49x9zDqR0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2020 15:41:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49CPMJ49FSzDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2020 15:39:06 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8412A68D0D; Thu, 30 Apr 2020 07:39:01 +0200 (CEST)
Date: Thu, 30 Apr 2020 07:39:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 2/2] powerpc/spufs: stop using access_ok
Message-ID: <20200430053901.GA6981@lst.de>
References: <20200429070303.17599-1-jk@ozlabs.org>
 <20200429070303.17599-2-jk@ozlabs.org>
 <ebc47890-649e-71c7-02b1-179db964db37@c-s.fr>
 <9c629b09cf25d143c7787548516c1f276bd09aa5.camel@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c629b09cf25d143c7787548516c1f276bd09aa5.camel@ozlabs.org>
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
Cc: linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 30, 2020 at 08:39:00AM +0800, Jeremy Kerr wrote:
> Hi Christophe,
> 
> > > Just use the proper non __-prefixed get/put_user variants where
> > > that is not done yet.
> > 
> > But it means you are doing the access_ok() check everytime, which is 
> > what is to be avoided by doing the access_ok() once then using the 
> > __-prefixed variant.
> 
> 5 out of 8 of these are just a access_ok(); simple_read_from_buffer().
> 
> For the cases where it's multiple __put/get_user()s, the max will be 5.
> (for the mbox access). Is that worth optimising the access_ok() checks?

access_ok is just trivial comparism to the segment limit, I don't
think it has a relavant performance impact.
