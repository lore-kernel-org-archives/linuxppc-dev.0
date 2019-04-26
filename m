Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697FAC43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 08:38:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC28020652
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 08:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC28020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r6s15d6czDqhF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 18:38:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r6qH40RzzDqdk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 18:36:57 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 76901AF35;
 Fri, 26 Apr 2019 08:36:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id F01381E3618; Fri, 26 Apr 2019 10:36:53 +0200 (CEST)
Date: Fri, 26 Apr 2019 10:36:53 +0200
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] mm: Fix modifying of page protection by
 insert_pfn_pmd()
Message-ID: <20190426083653.GB11637@quack2.suse.cz>
References: <20190402115125.18803-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hzRj5yxVJ5-7AZgzzBxEL02xf2xwhDv-U9_osWFm9kiA@mail.gmail.com>
 <20190424173833.GE19031@bombadil.infradead.org>
 <CAPcyv4gLGUa69svQnwjvruALZ0ChqUJZHQJ1Mt_Cjr1Jh_6vbQ@mail.gmail.com>
 <20190425073149.GA21215@quack2.suse.cz>
 <CAPcyv4iYMP4NWxa08zTdRxtc4UcbFFOCwbMZijB0bc2WcawggQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iYMP4NWxa08zTdRxtc4UcbFFOCwbMZijB0bc2WcawggQ@mail.gmail.com>
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Matthew Wilcox <willy@infradead.org>, Linux MM <linux-mm@kvack.org>,
 Chandan Rajendra <chandan@linux.ibm.com>, stable <stable@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu 25-04-19 17:33:04, Dan Williams wrote:
> On Thu, Apr 25, 2019 at 12:32 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 24-04-19 11:13:48, Dan Williams wrote:
> > > On Wed, Apr 24, 2019 at 10:38 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Wed, Apr 24, 2019 at 10:13:15AM -0700, Dan Williams wrote:
> > > > > I think unaligned addresses have always been passed to
> > > > > vmf_insert_pfn_pmd(), but nothing cared until this patch. I *think*
> > > > > the only change needed is the following, thoughts?
> > > > >
> > > > > diff --git a/fs/dax.c b/fs/dax.c
> > > > > index ca0671d55aa6..82aee9a87efa 100644
> > > > > --- a/fs/dax.c
> > > > > +++ b/fs/dax.c
> > > > > @@ -1560,7 +1560,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct
> > > > > vm_fault *vmf, pfn_t *pfnp,
> > > > >                 }
> > > > >
> > > > >                 trace_dax_pmd_insert_mapping(inode, vmf, PMD_SIZE, pfn, entry);
> > > > > -               result = vmf_insert_pfn_pmd(vma, vmf->address, vmf->pmd, pfn,
> > > > > +               result = vmf_insert_pfn_pmd(vma, pmd_addr, vmf->pmd, pfn,
> > > > >                                             write);
> > > >
> > > > We also call vmf_insert_pfn_pmd() in dax_insert_pfn_mkwrite() -- does
> > > > that need to change too?
> > >
> > > It wasn't clear to me that it was a problem. I think that one already
> > > happens to be pmd-aligned.
> >
> > Why would it need to be? The address is taken from vmf->address and that's
> > set up in __handle_mm_fault() like .address = address & PAGE_MASK. So I
> > don't see anything forcing PMD alignment of the virtual address...
> 
> True. So now I'm wondering if the masking should be done internal to
> the routine. Given it's prefixed vmf_ it seems to imply the api is
> prepared to take raw 'struct vm_fault' parameters. I think I'll go
> that route unless someone sees a reason to require the caller to
> handle this responsibility.

Yeah, that sounds good to me. Thanks for fixing this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
