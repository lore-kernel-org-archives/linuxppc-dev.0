Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA9FC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 19:25:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373C020661
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 19:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373C020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44F3d63RnRzDq6K
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 06:25:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=davemloft.net
 (client-ip=2620:137:e000::1:9; helo=shards.monkeyblade.net;
 envelope-from=davem@davemloft.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=davemloft.net
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44F3WL2KL8zDqBM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 06:20:28 +1100 (AEDT)
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 029451454DBAD;
 Wed,  6 Mar 2019 11:20:23 -0800 (PST)
Date: Wed, 06 Mar 2019 11:20:23 -0800 (PST)
Message-Id: <20190306.112023.204648705168304981.davem@davemloft.net>
To: alex@ghiti.fr
Subject: Re: [PATCH v5 4/4] hugetlb: allow to free gigantic pages
 regardless of the configuration
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190306190005.7036-5-alex@ghiti.fr>
References: <20190306190005.7036-1-alex@ghiti.fr>
 <20190306190005.7036-5-alex@ghiti.fr>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 06 Mar 2019 11:20:24 -0800 (PST)
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
Cc: dalias@libc.org, linux-sh@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, heiko.carstens@de.ibm.com, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, ysato@users.sourceforge.jp, x86@kernel.org,
 mingo@redhat.com, vbabka@suse.cz, catalin.marinas@arm.com, will.deacon@arm.com,
 bp@alien8.de, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org, mike.kravetz@oracle.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Alexandre Ghiti <alex@ghiti.fr>
Date: Wed,  6 Mar 2019 14:00:05 -0500

> On systems without CONTIG_ALLOC activated but that support gigantic pages,
> boottime reserved gigantic pages can not be freed at all. This patch
> simply enables the possibility to hand back those pages to memory
> allocator.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

For sparc:

Acked-by: David S. Miller <davem@davemloft.net>
