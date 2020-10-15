Return-Path: <SRS0=6wQL=DW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975B4C433E7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2020 14:50:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8B2218AC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2020 14:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8B2218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CBsf60g6jzDqWd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 01:50:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CBsYg2MLLzDqVs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2020 01:46:47 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 17619AC24;
 Thu, 15 Oct 2020 14:46:44 +0000 (UTC)
Date: Thu, 15 Oct 2020 16:46:41 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v6 02/11] mm/gup: Use functions to track lockless pgtbl
 walks on gup_pgd_range
Message-ID: <20201015144641.GE29778@kitsune.suse.cz>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
 <20200206030900.147032-3-leonardo@linux.ibm.com>
 <760c238043196e0628c8c0eff48a8e938ef539ba.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <760c238043196e0628c8c0eff48a8e938ef539ba.camel@linux.ibm.com>
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
Cc: linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Mike Rapoport <rppt@linux.ibm.com>, linux-arch@vger.kernel.org,
 Steven Price <steven.price@arm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>, kvm-ppc@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Reza Arbab <arbab@linux.ibm.com>, Allison Randal <allison@lohutok.net>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

On Thu, Feb 06, 2020 at 12:25:18AM -0300, Leonardo Bras wrote:
> On Thu, 2020-02-06 at 00:08 -0300, Leonardo Bras wrote:
> >                 gup_pgd_range(addr, end, gup_flags, pages, &nr);
> > -               local_irq_enable();
> > +               end_lockless_pgtbl_walk(IRQS_ENABLED);
> >                 ret = nr;
> >         }
> >  
> 
> Just noticed IRQS_ENABLED is not available on other archs than ppc64.
> I will fix this for v7.

Has threre been v7?

I cannot find it.

Thanks

Michal
