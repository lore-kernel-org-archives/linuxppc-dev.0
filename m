Return-Path: <SRS0=Va0a=WT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF17C3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Aug 2019 14:42:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AD82054F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Aug 2019 14:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AD82054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46FPJQ084HzDsNg
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Aug 2019 00:42:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46FPFc68GczDrgp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2019 00:40:16 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8663C309175F;
 Fri, 23 Aug 2019 14:40:14 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 515BE5F9D2;
 Fri, 23 Aug 2019 14:40:13 +0000 (UTC)
Date: Fri, 23 Aug 2019 08:40:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel] vfio/spapr_tce: Fix incorrect tce_iommu_group
 memory free
Message-ID: <20190823084012.202ba70f@x1.home>
In-Reply-To: <20190823053241.hogc44em2ccwdwq4@oak.ozlabs.ibm.com>
References: <20190819015117.94878-1-aik@ozlabs.ru>
 <20190823053241.hogc44em2ccwdwq4@oak.ozlabs.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 23 Aug 2019 14:40:14 +0000 (UTC)
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
Cc: kvm@vger.kernel.org, Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 23 Aug 2019 15:32:41 +1000
Paul Mackerras <paulus@ozlabs.org> wrote:

> On Mon, Aug 19, 2019 at 11:51:17AM +1000, Alexey Kardashevskiy wrote:
> > The @tcegrp variable is used in 1) a loop over attached groups
> > 2) it stores a pointer to a newly allocated tce_iommu_group if 1) found
> > nothing. However the error handler does not distinguish how we got there
> > and incorrectly releases memory for a found+incompatible group.
> > 
> > This fixes it by adding another error handling case.
> > 
> > Fixes: 0bd971676e68 ("powerpc/powernv/npu: Add compound IOMMU groups")
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>  
> 
> Good catch.  This is potentially nasty since it is a double free.
> Alex, are you going to take this, or would you prefer it goes via
> Michael Ellerman's tree?
> 
> Reviewed-by: Paul Mackerras <paulus@ozlabs.org>

I can take it, I've got it queued, but was hoping for an ack/review by
you or David.  I'll add the R-b and push it out to my next branch.
Thanks,

Alex
