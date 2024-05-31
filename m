Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416D4C25B75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2024 06:09:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VrCPb20Stz3cGC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2024 16:09:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (unknown [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VrCP36SbQz30T1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2024 16:08:46 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE58A68BEB; Fri, 31 May 2024 08:08:27 +0200 (CEST)
Date: Fri, 31 May 2024 08:08:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 04/23] scsi: initialize scsi midlayer limits before
 allocating the queue
Message-ID: <20240531060827.GA17723@lst.de>
References: <20240520151536.GA32532@lst.de> <fc6a2243-6982-45e9-a640-9d98c29a8f53@leemhuis.info> <8734pz4gdh.fsf@mail.lhotse> <87wmnb2x2y.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmnb2x2y.fsf@mail.lhotse>
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
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Linux regression tracking \(Thorsten Leemhuis\)" <regressions@leemhuis.info>, John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>, Linux kernel regressions list <regressions@lists.linux.dev>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 31, 2024 at 12:28:21AM +1000, Michael Ellerman wrote:
> No that's wrong. The actual hardware page size is 4K, but
> CONFIG_PAGE_SIZE and PAGE_SHIFT etc. is 64K.
> 
> So at least for this user the driver used to work with 64K pages, and
> now doesn't.

Which suggested that the communicated max_hw_sectors is wrong, and
previously we were saved by the block layer increasing it to
PAGE_SIZE after a warning.  Should we just increment it to 64k?

