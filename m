Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C6EC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 16:21:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7AF4208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 16:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AF4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pTGf3YMrzDqDZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 02:21:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=mark.rutland@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44pTDf1B5VzDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:19:45 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1AFD80D;
 Tue, 23 Apr 2019 09:19:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD5F03F557;
 Tue, 23 Apr 2019 09:19:34 -0700 (PDT)
Date: Tue, 23 Apr 2019 17:19:32 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v12 04/31] arm64/mm: define
 ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
Message-ID: <20190423161931.GE56999@lakrids.cambridge.arm.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-5-ldufour@linux.ibm.com>
 <20190416142710.GA54515@lakrids.cambridge.arm.com>
 <4ef9ff4b-2230-0644-2254-c1de22d41e6c@linux.ibm.com>
 <20190416144156.GB54708@lakrids.cambridge.arm.com>
 <20190418215113.GD11645@redhat.com>
 <73a3650d-7e9f-bc9e-6ea1-2cef36411b0c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73a3650d-7e9f-bc9e-6ea1-2cef36411b0c@linux.ibm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
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
Cc: jack@suse.cz, sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
 Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org,
 paulus@samba.org, Punit Agrawal <punitagrawal@gmail.com>, hpa@zytor.com,
 Michel Lespinasse <walken@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, ak@linux.intel.com,
 Minchan Kim <minchan@kernel.org>, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 David Rientjes <rientjes@google.com>, paulmck@linux.vnet.ibm.com,
 Haiyan Song <haiyanx.song@intel.com>, npiggin@gmail.com, sj38.park@gmail.com,
 Jerome Glisse <jglisse@redhat.com>, dave@stgolabs.net, kemi.wang@intel.com,
 kirill@shutemov.name, Thomas Gleixner <tglx@linutronix.de>,
 zhong jiang <zhongjiang@huawei.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, Mike Rapoport <rppt@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>, akpm@linux-foundation.org,
 Tim Chen <tim.c.chen@linux.intel.com>, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 23, 2019 at 05:36:31PM +0200, Laurent Dufour wrote:
> Le 18/04/2019 à 23:51, Jerome Glisse a écrit :
> > On Tue, Apr 16, 2019 at 03:41:56PM +0100, Mark Rutland wrote:
> > > On Tue, Apr 16, 2019 at 04:31:27PM +0200, Laurent Dufour wrote:
> > > > Le 16/04/2019 à 16:27, Mark Rutland a écrit :
> > > > > On Tue, Apr 16, 2019 at 03:44:55PM +0200, Laurent Dufour wrote:
> > > > > > From: Mahendran Ganesh <opensource.ganesh@gmail.com>
> > > > > > 
> > > > > > Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT for arm64. This
> > > > > > enables Speculative Page Fault handler.
> > > > > > 
> > > > > > Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
> > > > > 
> > > > > This is missing your S-o-B.
> > > > 
> > > > You're right, I missed that...
> > > > 
> > > > > The first patch noted that the ARCH_SUPPORTS_* option was there because
> > > > > the arch code had to make an explicit call to try to handle the fault
> > > > > speculatively, but that isn't addeed until patch 30.
> > > > > 
> > > > > Why is this separate from that code?
> > > > 
> > > > Andrew was recommended this a long time ago for bisection purpose. This
> > > > allows to build the code with CONFIG_SPECULATIVE_PAGE_FAULT before the code
> > > > that trigger the spf handler is added to the per architecture's code.
> > > 
> > > Ok. I think it would be worth noting that in the commit message, to
> > > avoid anyone else asking the same question. :)
> > 
> > Should have read this thread before looking at x86 and ppc :)
> > 
> > In any case the patch is:
> > 
> > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> 
> Thanks Mark and Jérôme for reviewing this.
> 
> Regarding the change in the commit message, I'm wondering if this would be
> better to place it in the Series's letter head.
> 
> But I'm fine to put it in each architecture's commit.

I think noting it in both the cover letter and specific patches is best.

Having something in the commit message means that the intent will be
clear when the patch is viewed in isolation (e.g. as they will be once
merged).

All that's necessary is something like:

  Note that this patch only enables building the common speculative page
  fault code such that this can be bisected, and has no functional
  impact. The architecture-specific code to make use of this and enable
  the feature will be addded in a subsequent patch.

Thanks,
Mark.
