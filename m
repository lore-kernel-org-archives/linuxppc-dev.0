Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D12C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 00:53:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C8220878
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 00:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E0F6hjuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C8220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qwXX1655zDqdW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 10:53:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="E0F6hjuo"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qwVF23r4zDqdR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 10:51:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZPxMilL55F88OfnrEUq9EeEkyqqENOE39GSG+Um9TxI=; b=E0F6hjuoTiAbr23o8nn5Dpddz
 W2QnBTSDLijahKTNq51dB36Q26RPSHKGDMcbHl3mNZ7/2TB6PcDitNtwEsUH4qjhfqb8NruFV5Bdl
 Zjqr+j73L7y/6aiZCiWrVn1GhBSnczo24TZGBrkITbqsS8D63JOkFxwnhUIDhKlLMD9IVKKfSLHzx
 gFmt8CBd4G4CcrHR5wj3+QsIKwHD7Y49lwsayA6YTkmZ94uV8MHLFIN4ZBtC2M6EEyR2oQ7kcWoLf
 3rayZelRy2skZeQ7D8uS7667hcWZ6TIALxdtMaZlyKVjJ6aAHyJVmXKT0ei21HN6FUBiVyhaDKMU9
 hqLRXyD8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1hJp5J-0000Zp-2k; Fri, 26 Apr 2019 00:51:25 +0000
Date: Thu, 25 Apr 2019 17:51:24 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] mm: Fix modifying of page protection by
 insert_pfn_pmd()
Message-ID: <20190426005124.GA25606@bombadil.infradead.org>
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
User-Agent: Mutt/1.9.2 (2017-12-15)
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
 stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
 Chandan Rajendra <chandan@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 25, 2019 at 05:33:04PM -0700, Dan Williams wrote:
> On Thu, Apr 25, 2019 at 12:32 AM Jan Kara <jack@suse.cz> wrote:
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

The vmf_ prefix was originally used to indicate 'returns a vm_fault_t'
instead of 'returns an errno'.  That said, I like the interpretation
you're coming up with here, and it makes me wonder if we shouldn't
change vmf_insert_pfn_pmd() to take (vmf, pfn, write) as arguments
instead of separate vma, address & pmd arguments.

