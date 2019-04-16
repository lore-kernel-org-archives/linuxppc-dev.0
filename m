Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8BDC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 23:35:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2EB720872
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 23:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EB720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kMDj2FpZzDqM1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 09:35:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux-foundation.org
 (client-ip=140.211.169.12; helo=mail.linuxfoundation.org;
 envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kMBr6mPxzDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 09:33:54 +1000 (AEST)
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
 by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A7E4C9F;
 Tue, 16 Apr 2019 23:33:52 +0000 (UTC)
Date: Tue, 16 Apr 2019 16:33:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-Id: <20190416163351.5e4e075ddfad0677239fc23a@linux-foundation.org>
In-Reply-To: <20190411202807.q2fge33uoduhtehq@ca-dmjordan1.us.oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
 <614ea07a-dd1e-2561-b6f4-2d698bf55f5b@ozlabs.ru>
 <20190411095543.GA55197@lakrids.cambridge.arm.com>
 <20190411202807.q2fge33uoduhtehq@ca-dmjordan1.us.oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Mark Rutland <mark.rutland@arm.com>, Davidlohr Bueso <dave@stgolabs.net>,
 kvm@vger.kernel.org, Alan Tull <atull@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
 Alex Williamson <alex.williamson@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Wu Hao <hao.wu@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 11 Apr 2019 16:28:07 -0400 Daniel Jordan <daniel.m.jordan@oracle.com> wrote:

> On Thu, Apr 11, 2019 at 10:55:43AM +0100, Mark Rutland wrote:
> > On Thu, Apr 11, 2019 at 02:22:23PM +1000, Alexey Kardashevskiy wrote:
> > > On 03/04/2019 07:41, Daniel Jordan wrote:
> > 
> > > > -	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %ld/%ld%s\n", current->pid,
> > > > +	dev_dbg(dev, "[%d] RLIMIT_MEMLOCK %c%ld %lld/%lu%s\n", current->pid,
> > > >  		incr ? '+' : '-', npages << PAGE_SHIFT,
> > > > -		current->mm->locked_vm << PAGE_SHIFT, rlimit(RLIMIT_MEMLOCK),
> > > > -		ret ? "- exceeded" : "");
> > > > +		(s64)atomic64_read(&current->mm->locked_vm) << PAGE_SHIFT,
> > > > +		rlimit(RLIMIT_MEMLOCK), ret ? "- exceeded" : "");
> > > 
> > > 
> > > 
> > > atomic64_read() returns "long" which matches "%ld", why this change (and
> > > similar below)? You did not do this in the two pr_debug()s above anyway.
> > 
> > Unfortunately, architectures return inconsistent types for atomic64 ops.
> > 
> > Some return long (e..g. powerpc), some return long long (e.g. arc), and
> > some return s64 (e.g. x86).
> 
> Yes, Mark said it all, I'm just chiming in to confirm that's why I added the
> cast.
> 
> Btw, thanks for doing this, Mark.

What's the status of this patchset, btw?

I have a note here that
powerpc-mmu-drop-mmap_sem-now-that-locked_vm-is-atomic.patch is to be
updated.

