Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D528BC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 15:28:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FF92192D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 15:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="KSNOoqqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FF92192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441HGn20jYzDqgr
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 02:28:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=amazonses.com
 (client-ip=54.240.9.37; helo=a9-37.smtp-out.amazonses.com;
 envelope-from=01000168f1c4718d-91714478-72d3-47cd-ae36-2d781947ebde-000000@amazonses.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.b="KSNOoqqs"; dkim-atps=neutral
Received: from a9-37.smtp-out.amazonses.com (a9-37.smtp-out.amazonses.com
 [54.240.9.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441HDY1kkWzDqc6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 02:26:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1550244409;
 h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
 bh=ph+Ox1e7xNScZGS+VdWAQM0Ff/E6RjNkQYhIunoJh5I=;
 b=KSNOoqqsLE+r8KYX2OGbVKpGlhsa+Ylr4yLduMXvPZjEz1KtCJCrXjbXi05MCABz
 GfKhX70kQFfDTpoB3XA0etFSJKc3qzbKiYMlp8/e0SZ/sM66h8/4m0+1mqYIrp4Ss5v
 X7EU6bVAeo2r2h9wXORmJ3AkbZYhtBwR8GhooEac=
Date: Fri, 15 Feb 2019 15:26:49 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
In-Reply-To: <20190214221629.GD1739@ziepe.ca>
Message-ID: <01000168f1c4718d-91714478-72d3-47cd-ae36-2d781947ebde-000000@email.amazonses.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
 <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
 <20190214060006.GE24692@ziepe.ca>
 <20190214193352.GA7512@iweiny-DESK2.sc.intel.com>
 <20190214201231.GC1739@ziepe.ca>
 <20190214214650.GB7512@iweiny-DESK2.sc.intel.com>
 <20190214221629.GD1739@ziepe.ca>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.15-54.240.9.37
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
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
Cc: dave@stgolabs.net, jack@suse.cz, kvm@vger.kernel.org, atull@kernel.org,
 aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
 alex.williamson@redhat.com, mdf@kernel.org, akpm@linux-foundation.org,
 Ira Weiny <ira.weiny@intel.com>, hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 14 Feb 2019, Jason Gunthorpe wrote:

> On Thu, Feb 14, 2019 at 01:46:51PM -0800, Ira Weiny wrote:
>
> > > > > Really unclear how to fix this. The pinned/locked split with two
> > > > > buckets may be the right way.
> > > >
> > > > Are you suggesting that we have 2 user limits?
> > >
> > > This is what RDMA has done since CL's patch.
> >
> > I don't understand?  What is the other _user_ limit (other than
> > RLIMIT_MEMLOCK)?
>
> With todays implementation RLIMIT_MEMLOCK covers two user limits,
> total number of pinned pages and total number of mlocked pages. The
> two are different buckets and not summed.

Applications were failing at some point because they were effectively
summed up. If you mlocked/pinned a dataset of more than half the memory of
a system then things would get really weird.

Also there is the possibility of even more duplication because pages can
be pinned by multiple kernel subsystems. So you could get more than
doubling of the number.

The sane thing was to account them separately so that mlocking and
pinning worked without apps failing and then wait for another genius
to find out how to improve the situation by getting the pinned page mess
under control.

It is not even advisable to check pinned pages against any limit because
pages can be pinned by multiple subsystems.

The main problem here is that we only have a refcount to indicate pinning
and no way to clearly distinguish long term from short pins. In order to
really fix this issue we would need to have a list of subsystems that have
taken long term pins on a page. But doing so would waste a lot of memory
and cause a significant performance regression.

And the discussions here seem to be meandering around these issues.
Nothing really that convinces me that we have a clean solution at hand.

