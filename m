Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B53C6787C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 18:04:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4152087D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 18:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4152087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WwhM2KdtzF3TC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:04:19 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WwfG3l0PzF3Kp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 05:02:29 +1100 (AEDT)
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net
 [67.183.145.105]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 45BE6133E9F9A;
 Fri, 12 Oct 2018 11:02:21 -0700 (PDT)
Date: Fri, 12 Oct 2018 11:02:20 -0700 (PDT)
Message-Id: <20181012.110220.321284613911888246.davem@davemloft.net>
To: kirill@shutemov.name
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Fri, 12 Oct 2018 11:02:23 -0700 (PDT)
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
 lokeshgidra@google.com, joel@joelfernandes.org,
 linux-riscv@lists.infradead.org, elfring@users.sourceforge.net,
 jonas@southpole.se, linux-s390@vger.kernel.org, dancol@google.com,
 linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, deller@gmx.de,
 hughd@google.com, jejb@parisc-linux.org, kasan-dev@googlegroups.com,
 kvmarm@lists.cs.columbia.edu, mingo@redhat.com, geert@linux-m68k.org,
 aryabinin@virtuozzo.com, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, fenghua.yu@intel.com, jdike@addtoit.com,
 linux-um@lists.infradead.org, Julia.Lawall@lip6.fr,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, bp@alien8.de,
 luto@kernel.org, nios2-dev@lists.rocketboards.org, gxt@pku.edu.cn,
 linux-arm-kernel@lists.infradead.org, chris@zankel.net, richard@nod.at,
 linux-parisc@vger.kernel.org, pantin@google.com, jcmvbkbc@gmail.com,
 linux-kernel@vger.kernel.org, minchan@kernel.org, linux-alpha@vger.kernel.org,
 lftan@altera.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Fri, 12 Oct 2018 14:30:56 +0300

> I looked into the code more and noticed move_pte() helper called from
> move_ptes(). It changes PTE entry to suite new address.
> 
> It is only defined in non-trivial way on Sparc. I don't know much about
> Sparc and it's hard for me to say if the optimization will break anything
> there.
> 
> I think it worth to disable the optimization if __HAVE_ARCH_MOVE_PTE is
> defined. Or make architectures state explicitely that the optimization is
> safe.

What sparc is doing in move_pte() is flushing the data-cache
(synchronously) if the virtual address color of the mapping changes.

Hope this helps.
