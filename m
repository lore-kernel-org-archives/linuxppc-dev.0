Return-Path: <SRS0=TJyh=PE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D24EC433F5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Oct 2021 00:02:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8436108E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Oct 2021 00:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD8436108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HWNc03Sshz3f8w
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Oct 2021 11:02:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lAd5BhR7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=kbusch@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lAd5BhR7; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HWNb90FR8z3f4l
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Oct 2021 11:01:25 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18BA3611C3;
 Sat, 16 Oct 2021 00:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634342482;
 bh=zERYufNJ1MZk5CclnMi+gL/h2WeGYYoy9Om0aXiHGLA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lAd5BhR7dX0bhUFdgALWUXGCQ+v5W0tvJIwfUWbRKvGKqR2h6V0I6ukKcRF5Dj+Nw
 0dFWCYUmBg7S2Rodk9yCf0H1+kehM9Vr5MyDW3E957s4BJA3cyS4uAhz4e17bCP29s
 II0rzTuzcoBkDSvXr4ZGRWsUKw8yktjg7TyZT5pwSjCguTcC1658+kFky8M1STBicA
 7fLq43tAQkTcs+sDRgIw1Gv5v7j5U3hjGyPw8mDDVxsn00Q51dQWLT/IESbUsSNm65
 nxOHSWjB0mZ+Ve03BmVAuGYwTgnYAMB4qLl+33yxh5AlIshuEdLL26zAeBOF+sdd/j
 wOOh/LnbCmJTQ==
Date: Fri, 15 Oct 2021 18:01:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 02/13] nvme-multipath: add error handling support for
 add_disk()
Message-ID: <20211016000118.GA50317@C02WT3WMHTD6>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015235219.2191207-3-mcgrof@kernel.org>
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
Cc: nvdimm@lists.linux.dev, vigneshr@ti.com, linux-nvme@lists.infradead.org,
 paulus@samba.org, miquel.raynal@bootlin.com, ira.weiny@intel.com, hch@lst.de,
 dave.jiang@intel.com, sagi@grimberg.me, minchan@kernel.org,
 vishal.l.verma@intel.com, ngupta@vflare.org, linux-block@vger.kernel.org,
 dan.j.williams@intel.com, axboe@kernel.dk, geoff@infradead.org,
 linux-kernel@vger.kernel.org, jim@jtan.com, senozhatsky@chromium.org,
 richard@nod.at, linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 15, 2021 at 04:52:08PM -0700, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Since we now can tell for sure when a disk was added, move
> setting the bit NVME_NSHEAD_DISK_LIVE only when we did
> add the disk successfully.
> 
> Nothing to do here as the cleanup is done elsewhere. We take
> care and use test_and_set_bit() because it is protects against
> two nvme paths simultaneously calling device_add_disk() on the
> same namespace head.

Looks good, thank you.

Reviewed-by: Keith Busch <kbusch@kernel.org>
