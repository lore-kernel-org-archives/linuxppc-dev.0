Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8CCC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 06:35:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BAB21871
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 06:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e40su7bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BAB21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43KQ9k35cMzDqXm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 17:35:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="e40su7bY";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+660da67c63f4a722ad6d+5596+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="e40su7bY"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43KQ6H2QClzDqWN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 17:32:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eYosKYhh+v4DyPVI0cqOxrSm05orDmuAqERz3SYf468=; b=e40su7bYjGZhTlE6AlgNs/wtW
 WHPnj8mynWZ/dq8rBzS2ZMrBcuY+PLULwe69RUFWJemqgRi/5PbYzbzqvii7YebbdsBzf50Ojui4i
 BvWZkCSU6TV5DB82x66dxlDdFV8skHJ8KywiPgYk56PG3gMuzcIXYBsWcOWOBoqf3Z5/3HaOUJeMN
 Fpt+2bo17nt40XrA9iWbl0wcrE9Houh6e8fI1tEK7Zx8UfIQ3eS6nFVbfebjOrwkPWiul0P9K5Fv4
 l9blB6iLsqm0LsbY7WLlufHoXFNYZ5ALcEnwcOippFHI4c9vKqG3JYsw7G+vAkBcCu8ww4uNY2noL
 AAeFo56jQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gZVOY-000689-LB; Wed, 19 Dec 2018 06:31:50 +0000
Date: Tue, 18 Dec 2018 22:31:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH V4 5/5] arch/powerpc/mm/hugetlb: NestMMU workaround for
 hugetlb mprotect RW upgrade
Message-ID: <20181219063150.GA23418@infradead.org>
References: <20181218094137.13732-1-aneesh.kumar@linux.ibm.com>
 <20181218094137.13732-6-aneesh.kumar@linux.ibm.com>
 <20181218172236.GC22729@infradead.org>
 <87r2eefbhi.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2eefbhi.fsf@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: x86@kernel.org, npiggin@gmail.com, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, paulus@samba.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 19, 2018 at 08:50:57AM +0530, Aneesh Kumar K.V wrote:
> That was done considering that ptep_modify_prot_start/commit was defined
> in asm-generic/pgtable.h. I was trying to make sure I didn't break
> anything with the patch. Also s390 do have that EXPORT_SYMBOL() for the
> same. hugetlb just inherited that.
> 
> If you feel strongly about it, I can drop the EXPORT_SYMBOL().

Yes.  And we should probably remove the s390 as well as it isn't used
either.
