Return-Path: <SRS0=1YdR=PK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBCFC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 01:17:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AA82080A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 01:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzydY/U4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AA82080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43TtSm24mMzDqFJ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 12:17:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DzydY/U4";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="DzydY/U4"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43TtPx0CxWzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jan 2019 12:15:00 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E9C022080A;
 Wed,  2 Jan 2019 01:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546391698;
 bh=zZnndJDsLws64tetl6IqT7F3YlAXOLO3e8DUus80V/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DzydY/U46KF/RHCKgNBQpb9GTgUOHniD7ICnO+H3/fFiZb/vRjZCuWl9dqhgD+9Ib
 cgZKy4CZPlbBBtMqQR6O2VE/XtVBcxIsqp+BSfeN1frgk8kC6ium+Jq7MorEV/0HY+
 ZhU1QC2JB3BtACLLLM3rT2zJcCSXIW5bOrF8fjpI=
Date: Tue, 1 Jan 2019 19:14:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 1/2] PCI/IOV: provide flag to skip VF scanning
Message-ID: <20190102011453.GA126384@google.com>
References: <20181217173546.GA4106@infradead.org>
 <20181218101650.23089-1-sebott@linux.ibm.com>
 <20181220200750.GF183878@google.com>
 <alpine.LFD.2.21.1812211514570.22598@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1812211514570.22598@schleppi>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 21, 2018 at 03:19:49PM +0100, Sebastian Ott wrote:
> Hello Bjorn,
> 
> On Thu, 20 Dec 2018, Bjorn Helgaas wrote:
> > I think the strategy is fine, but can you restructure the patches
> > like this:
> > 
> >   1) Factor out sriov_add_vfs() and sriov_dev_vfs().  This makes no
> >      functional change at all.
> > 
> >   2) Add dev->no_vf_scan, set it in the s390 pcibios_add_device(), and
> >      test it in sriov_add_vfs(), and sriov_del_vfs().
> > 
> > I think both pieces will be easier to review that way.
> 
> Done. I took the liberty to add Christoph's R-b to the first two patches
> since it's just a split of the patch he gave the R-b to.

Thanks.

It's really way too late to do this, but they're pretty trivial, and
I've been out longer than expected for vacation and illness, so I applied
these to pci/virtualization for v4.21.

Bjorn
