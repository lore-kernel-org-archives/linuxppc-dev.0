Return-Path: <SRS0=eeko=PU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989E5C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 15:51:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE022084E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 15:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rccc7BFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE022084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43cPNx4mZ4zDr9j
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 02:51:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="rccc7BFO"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43cPM84Wm2zDr7f
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jan 2019 02:50:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E5jeThNuXJiosx7Bk1oeBAmKTo11eywDu/ykXx4V/zo=; b=rccc7BFOuB4X/7wNfKDBViyyw
 tCIq00thjE8uBpRc2EMKCYg5Pjp4pL5OD8AkcjqW5KJKQYIqo0djjpzork/c108Trm/6QyapyO3DC
 hU7wELBi+gG1L1fDiiyok/NRypETF5628z9SQ0EAS7cNcGp3EUvUu864qCBeiplTY1rTPwtjPS0Fp
 2lhX45+RO4vzvcTo/lAzPKzmJ8xOYJe54ylsedrg2VIUSKglaC1737qr31qWSqgl8CW0YCdM5D9R1
 dzSpWXEq2u0NZuZtlrmd9FIUNx8PQQpuI6MgJo/7FEp0Vp67At7crqTQ9StU23rHHuNQEIaLpjgiM
 RcF5Bo9Ng==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1giLXc-0000SR-TQ; Sat, 12 Jan 2019 15:49:44 +0000
Date: Sat, 12 Jan 2019 07:49:44 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
Message-ID: <20190112154944.GT6310@bombadil.infradead.org>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org>
 <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
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
Cc: mark.rutland@arm.com, mhocko@suse.com, linux-sh@vger.kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 will.deacon@arm.com, christoffer.dall@arm.com, linux-mm@kvack.org,
 kvmarm@lists.cs.columbia.edu, aneesh.kumar@linux.ibm.com,
 linux@armlinux.org.uk, mingo@redhat.com, vbabka@suse.cz, rientjes@google.com,
 Anshuman Khandual <anshuman.khandual@arm.com>, marc.zyngier@arm.com,
 rppt@linux.vnet.ibm.com, shakeelb@google.com, kirill@shutemov.name,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, linuxppc-dev@lists.ozlabs.org, steve.capper@arm.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, akpm@linux-foundation.org,
 robin.murphy@arm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jan 12, 2019 at 02:49:29PM +0100, Christophe Leroy wrote:
> As far as I can see,
> 
> #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
> 
> So what's the difference between:
> 
> (GFP_KERNEL_ACCOUNT | __GFP_ZERO) & ~__GFP_ACCOUNT
> 
> and
> 
> (GFP_KERNEL | __GFP_ZERO) & ~__GFP_ACCOUNT

Nothing.  But there's a huge difference in the other parts of that same
file where GFP_ACCOUNT is _not_ used.

I think this unification is too small to bother with.  Something I've
had on my todo list for some time and have not done anything about
is to actually unify all of the architecture pte/pmd/... allocations.
There are tricks some architectures use that others would benefit from.
