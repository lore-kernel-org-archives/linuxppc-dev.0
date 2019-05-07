Return-Path: <SRS0=Sivu=TH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3757CC004C9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 May 2019 17:27:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E053C205ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 May 2019 17:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E053C205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44z64G6gNKzDqJl
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 May 2019 03:27:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44z62h5BPdzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2019 03:26:03 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 743FB36887;
 Tue,  7 May 2019 17:26:00 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D766E171AD;
 Tue,  7 May 2019 17:25:59 +0000 (UTC)
Date: Tue, 7 May 2019 11:25:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] vfio-pci/nvlink2: Fix potential VMA leak
Message-ID: <20190507112559.2022645c@x1.home>
In-Reply-To: <20190507090145.4be12c82@bahia.lan>
References: <155568823785.601037.2151744205292679252.stgit@bahia.lan>
 <20190506155845.70f3b01d@x1.home>
 <20190507014915.GA10274@tungsten.ozlabs.ibm.com>
 <20190507090145.4be12c82@bahia.lan>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 07 May 2019 17:26:00 +0000 (UTC)
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
Cc: Sam Bobroff <sbobroff@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 7 May 2019 09:01:45 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Tue, 7 May 2019 11:52:44 +1000
> Sam Bobroff <sbobroff@linux.ibm.com> wrote:
> 
> > On Mon, May 06, 2019 at 03:58:45PM -0600, Alex Williamson wrote:  
> > > On Fri, 19 Apr 2019 17:37:17 +0200
> > > Greg Kurz <groug@kaod.org> wrote:
> > >     
> > > > If vfio_pci_register_dev_region() fails then we should rollback
> > > > previous changes, ie. unmap the ATSD registers.
> > > > 
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---    
> > > 
> > > Applied to vfio next branch for v5.2 with Alexey's R-b.  Thanks!
> > > 
> > > Alex    
> > 
> > Should this have a fixes tag? e.g.:
> > Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
> >   
> 
> Oops... you're right.
> 
> Alex, can you add the above tag ?

Added.  Thanks,

Alex
