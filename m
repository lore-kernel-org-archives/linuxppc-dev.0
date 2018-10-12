Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2B1C6787C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 18:20:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603D62064E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 18:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603D62064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Wx3861sxzF3HX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:20:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=davemloft.net
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Wx104s00zF3Fg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 05:18:43 +1100 (AEDT)
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net
 [67.183.145.105]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 33244136DD156;
 Fri, 12 Oct 2018 11:18:37 -0700 (PDT)
Date: Fri, 12 Oct 2018 11:18:36 -0700 (PDT)
Message-Id: <20181012.111836.1569129998592378186.davem@davemloft.net>
To: joel@joelfernandes.org
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181012125046.GA170912@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Fri, 12 Oct 2018 11:18:39 -0700 (PDT)
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, mhocko@kernel.org, linux-mm@kvack.org,
 lokeshgidra@google.com, linux-riscv@lists.infradead.org,
 elfring@users.sourceforge.net, jonas@southpole.se, linux-s390@vger.kernel.org,
 dancol@google.com, linux-xtensa@linux-xtensa.org,
 linux-hexagon@vger.kernel.org, deller@gmx.de, hughd@google.com,
 jejb@parisc-linux.org, kasan-dev@googlegroups.com,
 kvmarm@lists.cs.columbia.edu, mingo@redhat.com, geert@linux-m68k.org,
 aryabinin@virtuozzo.com, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, fenghua.yu@intel.com, jdike@addtoit.com,
 linux-um@lists.infradead.org, Julia.Lawall@lip6.fr,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, bp@alien8.de,
 luto@kernel.org, nios2-dev@lists.rocketboards.org, kirill@shutemov.name,
 gxt@pku.edu.cn, linux-arm-kernel@lists.infradead.org, chris@zankel.net,
 richard@nod.at, linux-parisc@vger.kernel.org, pantin@google.com,
 jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org, minchan@kernel.org,
 linux-alpha@vger.kernel.org, lftan@altera.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 12 Oct 2018 05:50:46 -0700

> If its an issue, then how do transparent huge pages work on Sparc?  I don't
> see the huge page code (move_huge_pages) during mremap doing anything special
> for Sparc architecture when moving PMDs..

This is because all huge pages are larger than SHMLBA.  So no cache flushing
necessary.

> Also, do we not flush the caches from any path when we munmap
> address space?  We do call do_munmap on the old mapping from mremap
> after moving to the new one.

Sparc makes sure that shared mapping have consistent colors.  Therefore
all that's left are private mappings and those will be initialized by
block stores to clear the page out or similar.

Also, when creating new mappings, we flush the D-cache when necessary
in update_mmu_cache().

We also maintain a bit in the page struct to track when a page which
was potentially written to on one cpu ends up mapped into another
address space and flush as necessary.

The cache is write-through, which simplifies the preconditions we have
to maintain.
