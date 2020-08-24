Return-Path: <SRS0=9Gbk=CC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A65AC433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2020 08:22:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDEE52075B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2020 08:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="spkzDgNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEE52075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BZlVl0WSfzDqQn
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2020 18:22:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=spkzDgNb; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BZlSg2hHmzDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2020 18:21:06 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BFFE820738;
 Mon, 24 Aug 2020 08:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598257264;
 bh=uegVTyPdmDOaXg3hu8ylF/f6W1qvT/HHlR+Ri/ENx44=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=spkzDgNbN7eQUmoJoD15yQwlHSxwIAgdk7pVjkjUVhgIa3jWRu0Z22jWzJn6LH7aR
 cjEmlTHaEHVvhjyvKS/MbgrDRsNtFqZL5H2k/CT3NjrSjZhalBuvgyz7xs4lXc4MHG
 2PgYlKoktmzhl+NsVzzMhPnqKrwYHlKlHKSpmGdY=
Date: Mon, 24 Aug 2020 10:21:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] usb: gadget: fsl: Fix unsigned expression compared with
 zero in fsl_udc_probe
Message-ID: <20200824082122.GA336539@kroah.com>
References: <20200824080437.229826-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824080437.229826-1-yebin10@huawei.com>
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
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 leoyang.li@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 24, 2020 at 04:04:37PM +0800, Ye Bin wrote:
> Signed-off-by: Ye Bin <yebin10@huawei.com>

I can't take patches without any changelog text, sorry.

greg k-h
