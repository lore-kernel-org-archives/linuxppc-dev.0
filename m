Return-Path: <SRS0=BcJT=SB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC0EC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 18:40:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B916218A3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 18:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8zL3K/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B916218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44WnTg3QpkzDqTL
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 05:40:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z8zL3K/6"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WnRy1FMvzDqRh
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 05:38:36 +1100 (AEDT)
Received: from localhost (unknown [62.119.166.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3EBD02082C;
 Sat, 30 Mar 2019 18:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553971113;
 bh=vM5XqOYIzrKLgI9QaO+v6rMuxnWCOX6vb912khkZumM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z8zL3K/6e1BCa/IS41rGnV9LgxCrji6MJAcOVtk1N4vYWpj0Ifi8Lws/EroR3Q1xA
 l2XvbbLc5Vm/jEVDNA9G4RNBLRp9lRR7HVuW8OJLQRiUGHMYi5hUIr0TYRwaZLD476
 jLL7zA+oC+JldczlxlZqN7m3X6HFSO8n95MM8Lak=
Date: Sat, 30 Mar 2019 19:38:26 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Andrey Abramov <st5pub@yandex.ru>
Subject: Re: [PATCH 5/5] Lib: sort.h: replace int size with size_t size in
 the swap function
Message-ID: <20190330183826.GB21828@kroah.com>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
 <20467491553964233@myt4-c0b480c282c8.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20467491553964233@myt4-c0b480c282c8.qloud-c.yandex.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: "mhocko@suse.com" <mhocko@suse.com>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 Dave Chinner <dchinner@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "piaojun@huawei.com" <piaojun@huawei.com>,
 "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
 "paulus@samba.org" <paulus@samba.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "jiang.biao2@zte.com.cn" <jiang.biao2@zte.com.cn>,
 "jslaby@suse.cz" <jslaby@suse.cz>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
 "richard@nod.at" <richard@nod.at>, "mark@fasheh.com" <mark@fasheh.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
 "lchen@suse.com" <lchen@suse.com>, "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
 "ge.changwei@h3c.com" <ge.changwei@h3c.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "kamalesh@linux.vnet.ibm.com" <kamalesh@linux.vnet.ibm.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "jannh@google.com" <jannh@google.com>,
 "ashish.samant@oracle.com" <ashish.samant@oracle.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "jiangyiwen@huawei.com" <jiangyiwen@huawei.com>, "bp@alien8.de" <bp@alien8.de>,
 "jlbec@evilplan.org" <jlbec@evilplan.org>,
 "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 George Spelvin <lkml@sdf.org>, "dedekind1@gmail.com" <dedekind1@gmail.com>,
 "malat@debian.org" <malat@debian.org>,
 "vgupta@synopsys.com" <vgupta@synopsys.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Morton Andrew <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 30, 2019 at 07:43:53PM +0300, Andrey Abramov wrote:
> Replace int type with size_t type of the size argument
> in the swap function, also affect all its dependencies.

This says _what_ the patch does, but it gives no clue as to _why_ you
are doing this.  Neither did your 0/5 patch :(

Why make this change?  Nothing afterward depends on it from what I can
tell, so why is it needed?

thanks,

greg k-h
