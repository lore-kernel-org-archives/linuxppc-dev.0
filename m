Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A88C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 17:24:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BEF20578
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 17:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BEF20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fvFx0459zDqlh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 04:24:21 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fvC74j6YzDqmJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 04:21:54 +1100 (AEDT)
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 58B4C14B56D28;
 Wed, 16 Jan 2019 09:21:48 -0800 (PST)
Date: Wed, 16 Jan 2019 09:21:47 -0800 (PST)
Message-Id: <20190116.092147.2222967221278304230.davem@davemloft.net>
To: rppt@linux.ibm.com
Subject: Re: [PATCH 15/21] sparc: add checks for the return value of
 memblock_alloc*()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1547646261-32535-16-git-send-email-rppt@linux.ibm.com>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-16-git-send-email-rppt@linux.ibm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 16 Jan 2019 09:21:50 -0800 (PST)
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, devicetree@vger.kernel.org,
 catalin.marinas@arm.com, heiko.carstens@de.ibm.com, x86@kernel.org,
 linux-mips@vger.kernel.org, jcmvbkbc@gmail.com, guoren@kernel.org,
 sparclinux@vger.kernel.org, hch@lst.de, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, ysato@users.sourceforge.jp, richard@nod.at,
 linux-sh@vger.kernel.org, linux@armlinux.org.uk, kasan-dev@googlegroups.com,
 geert@linux-m68k.org, msalter@redhat.com, dennis@kernel.org,
 mattst88@gmail.com, linux-snps-arc@lists.infradead.org,
 uclinux-h8-devel@lists.sourceforge.jp, pmladek@suse.com,
 linux-xtensa@linux-xtensa.org, linux-alpha@vger.kernel.org,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 robh+dt@kernel.org, green.hu@gmail.com, xen-devel@lists.xenproject.org,
 shorne@gmail.com, gxt@pku.edu.cn, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tony.luck@intel.com, linux-mm@kvack.org,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul.burton@mips.com, vgupta@synopsys.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 openrisc@lists.librecores.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 16 Jan 2019 15:44:15 +0200

> Add panic() calls if memblock_alloc*() returns NULL.
> 
> Most of the changes are simply addition of
> 
>         if(!ptr)
>                 panic();
> 
> statements after the calls to memblock_alloc*() variants.
> 
> Exceptions are pcpu_populate_pte() and kernel_map_range() that were
> slightly refactored to accommodate the change.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: David S. Miller <davem@davemloft.net>
