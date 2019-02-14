Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1D3C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 19:41:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45C42229F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 19:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45C42229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440mx036R5zDqNj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 06:41:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440mmN6k8xzDqWF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 06:34:09 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Feb 2019 11:34:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; d="scan'208";a="116276999"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga006.jf.intel.com with ESMTP; 14 Feb 2019 11:33:59 -0800
Date: Thu, 14 Feb 2019 11:33:53 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/5] use pinned_vm instead of locked_vm to account pinned
 pages
Message-ID: <20190214193352.GA7512@iweiny-DESK2.sc.intel.com>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211225447.GN24692@ziepe.ca>
 <20190214015314.GB1151@iweiny-DESK2.sc.intel.com>
 <20190214060006.GE24692@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214060006.GE24692@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
 aik@ozlabs.ru, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 linux-mm@kvack.org, alex.williamson@redhat.com, mdf@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, cl@linux.com,
 hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 13, 2019 at 11:00:06PM -0700, Jason Gunthorpe wrote:
> On Wed, Feb 13, 2019 at 05:53:14PM -0800, Ira Weiny wrote:
> > On Mon, Feb 11, 2019 at 03:54:47PM -0700, Jason Gunthorpe wrote:
> > > On Mon, Feb 11, 2019 at 05:44:32PM -0500, Daniel Jordan wrote:
> > > 
> > > > All five of these places, and probably some of Davidlohr's conversions,
> > > > probably want to be collapsed into a common helper in the core mm for
> > > > accounting pinned pages.  I tried, and there are several details that
> > > > likely need discussion, so this can be done as a follow-on.
> > > 
> > > I've wondered the same..
> > 
> > I'm really thinking this would be a nice way to ensure it gets cleaned up and
> > does not happen again.
> > 
> > Also, by moving it to the core we could better manage any user visible changes.
> > 
> > From a high level, pinned is a subset of locked so it seems like we need a 2
> > sets of helpers.
> > 
> > try_increment_locked_vm(...)
> > decrement_locked_vm(...)
> > 
> > try_increment_pinned_vm(...)
> > decrement_pinned_vm(...)
> > 
> > Where try_increment_pinned_vm() also increments locked_vm...  Of course this
> > may end up reverting the improvement of Davidlohr  Bueso's atomic work...  :-(
> > 
> > Furthermore it would seem better (although I don't know if at all possible) if
> > this were accounted for in core calls which tracked them based on how the pages
> > are being used so that drivers can't call try_increment_locked_vm() and then
> > pin the pages...  Thus getting the account wrong vs what actually happened.
> > 
> > And then in the end we can go back to locked_vm being the value checked against
> > RLIMIT_MEMLOCK.
> 
> Someone would need to understand the bug that was fixed by splitting
> them. 
>

My suggestion above assumes that splitting them is required/correct.  To be
fair I've not dug into if this is true or not, but I trust Christopher.

What I have found is this commit:

bc3e53f682d9 mm: distinguish between mlocked and pinned pages

I think that commit introduced the bug (for IB) which at the time may have been
"ok" because many users of IB at the time were HPC/MPI users and I don't think
MPI does a lot of _separate_ mlock operations so the count of locked_vm was
probably negligible.  Alternatively, the clusters I've worked on in the past
had compute nodes set with RLIMIT_MEMLOCK to 'unlimited' whilst running MPI
applications on compute nodes of a cluster...  :-/

I think what Christopher did was probably ok for the internal tracking but we
_should_ have had something which summed the 2 for RLIMIT_MEMLOCK checking at
that time to be 100% correct?  Christopher do you remember why you did not do
that?

[1] http://lkml.kernel.org/r/20130524140114.GK23650@twins.programming.kicks-ass.net

> 
> I think it had to do with double accounting pinned and mlocked pages
> and thus delivering a lower than expected limit to userspace.
> 
> vfio has this bug, RDMA does not. RDMA has a bug where it can
> overallocate locked memory, vfio doesn't.

Wouldn't vfio also be able to overallocate if the user had RDMA pinned pages?

I think the problem is that if the user calls mlock on a large range then both
vfio and RDMA could potentially overallocate even with this fix.  This was your
initial email to Daniel, I think...  And Alex's concern.

> 
> Really unclear how to fix this. The pinned/locked split with two
> buckets may be the right way.

Are you suggesting that we have 2 user limits?

Ira

> 
> Jason
