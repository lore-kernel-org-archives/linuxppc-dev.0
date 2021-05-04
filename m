Return-Path: <SRS0=2Civ=J7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E32C433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 13:09:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE61613C0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 13:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE61613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FZKty6mf4z30Cn
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 23:09:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OrG7CH+d;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TLpzwcK4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=cohuck@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=OrG7CH+d; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TLpzwcK4; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FZKtN1RZFz2xy4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 May 2021 23:09:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620133747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+a3Gqq/AQH86AQgX5MsIHGOIG8nweku9Ika1zopWOs=;
 b=OrG7CH+dmKwc0rUWbsSyQE7YIRE0F/5PFJaLBOPNH5Z2pG8jUaTfcSqdBZT96ognY1tHoB
 jhaMzv84G/lbK3ws3khdEujkoV42CDNjso0GTwWsEXkTJ7GEBRJBE1J7qAdiI8632ybV0p
 7Hrl7l5vpMeXRF2BHmrO+lC9arQYPDM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620133748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+a3Gqq/AQH86AQgX5MsIHGOIG8nweku9Ika1zopWOs=;
 b=TLpzwcK4O1OyEy3cUL3ZhRSzsz3pR/Dyurqtv+dMTYwkENlCk1d+FXOCHsoLVklLpqoFpc
 Xu62FioVYaQQBaWZ1e2/z55Tpid+3c5NYFq0sh5DmYBciy5MI1/h8Xj7mu6B4cxuF1Aed5
 gBWh5SBzyZaQAXgSW6oIXHkWdZKX3ds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-sAMffVlyOI2oanb_IGH7cQ-1; Tue, 04 May 2021 09:09:03 -0400
X-MC-Unique: sAMffVlyOI2oanb_IGH7cQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4102964157;
 Tue,  4 May 2021 13:09:01 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-126.ams2.redhat.com
 [10.36.113.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37B075D72F;
 Tue,  4 May 2021 13:08:53 +0000 (UTC)
Date: Tue, 4 May 2021 15:08:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: remove the nvlink2 pci_vfio subdriver v2
Message-ID: <20210504150851.54e278f8.cohuck@redhat.com>
In-Reply-To: <20210504130039.GA7711@lst.de>
References: <20210326061311.1497642-1-hch@lst.de>
 <20210504142236.76994047@bahia.lan> <YJFFG1tSP0dUCxcX@kroah.com>
 <20210504130039.GA7711@lst.de>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, qemu-devel@nongnu.org,
 dri-devel@lists.freedesktop.org, Greg Kurz <groug@kaod.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Daniel Vetter <daniel@ffwll.ch>,
 qemu-ppc@nongnu.org, linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 4 May 2021 15:00:39 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, May 04, 2021 at 02:59:07PM +0200, Greg Kroah-Hartman wrote:
> > > Hi Christoph,
> > > 
> > > FYI, these uapi changes break build of QEMU.  
> > 
> > What uapi changes?
> > 
> > What exactly breaks?
> > 
> > Why does QEMU require kernel driver stuff?  
> 
> Looks like it pull in the uapi struct definitions unconditionally
> instead of having a local copy.  We could fix that by just putting
> them back, but to me this seems like a rather broken configuration
> in qemu when it pulls in headers from the running/installed kernel
> without any feature checks before using them.
> 

It is not pulling them from the installed kernel, but from a
development version to get new definitions. Removing things in the
kernel requires workarounds in QEMU until it can remove those things as
well. It is not a dumb update...

