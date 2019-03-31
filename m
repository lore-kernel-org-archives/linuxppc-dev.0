Return-Path: <SRS0=rJbe=SC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F1FC43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 18:30:04 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB9820870
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 18:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="TLgnmUDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB9820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XPCY2RFkzDqQ4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 05:30:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yandex.ru
 (client-ip=2a02:6b8:0:1472:2741:0:8b7:101; helo=forward101p.mail.yandex.net;
 envelope-from=st5pub@yandex.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yandex.ru header.i=@yandex.ru header.b="TLgnmUDp"; 
 dkim-atps=neutral
X-Greylist: delayed 92748 seconds by postgrey-1.36 at bilbo;
 Mon, 01 Apr 2019 05:28:22 AEDT
Received: from forward101p.mail.yandex.net (forward101p.mail.yandex.net
 [IPv6:2a02:6b8:0:1472:2741:0:8b7:101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XP9g4smMzDqNs
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 05:28:21 +1100 (AEDT)
Received: from mxback7o.mail.yandex.net (mxback7o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::21])
 by forward101p.mail.yandex.net (Yandex) with ESMTP id 7576F3281026;
 Sun, 31 Mar 2019 21:28:12 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback7o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id lzbbfWFCEq-S3FSYh1n; 
 Sun, 31 Mar 2019 21:28:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1554056890; bh=f2JRF5w+tmRWVJuRZ3lEps5Sncaj4gNE54Sru/b1wwg=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=TLgnmUDp31I0RwIEZQEU2JdWAyGn/NuJN3eEWj69OoOrzE/dpiNrXyW6QvnglkcDq
 m6+o9GlMP76IUCWMK1J8CPeAmfRIusv1onsadKrgJBLl9AuHVWvxeT6Ftm+ErWu+dT
 OeCGPKUpaxDfpoUh3rkAqrpXCuOgRYCbA7v88Qt0=
Authentication-Results: mxback7o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt3-1179f584969c.qloud-c.yandex.net with HTTP;
 Sun, 31 Mar 2019 21:28:03 +0300
From: Andrey Abramov <st5pub@yandex.ru>
To: vgupta <vgupta@synopsys.com>, benh <benh@kernel.crashing.org>,
 paulus <paulus@samba.org>, mpe <mpe@ellerman.id.au>,
 tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>, bp <bp@alien8.de>,
 hpa <hpa@zytor.com>, x86 <x86@kernel.org>, mark <mark@fasheh.com>,
 jlbec <jlbec@evilplan.org>, richard <richard@nod.at>,
 dedekind1 <dedekind1@gmail.com>, adrian.hunter <adrian.hunter@intel.com>,
 gregkh <gregkh@linuxfoundation.org>,
 naveen.n.rao <naveen.n.rao@linux.vnet.ibm.com>,
 jpoimboe <jpoimboe@redhat.com>, Dave Chinner <dchinner@redhat.com>,
 darrick.wong <darrick.wong@oracle.com>,
 ard.biesheuvel <ard.biesheuvel@linaro.org>, George Spelvin <lkml@sdf.org>,
 linux-snps-arc <linux-snps-arc@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 ocfs2-devel <ocfs2-devel@oss.oracle.com>,
 linux-mtd <linux-mtd@lists.infradead.org>, sfr <sfr@canb.auug.org.au>
Subject: [PATCH v2 0/5] simple sort swap function improvements
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sun, 31 Mar 2019 21:28:03 +0300
Message-Id: <19606671554056883@myt3-1179f584969c.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
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
Cc: peterz <peterz@infradead.org>, mhocko <mhocko@suse.com>,
 "ashish.samant" <ashish.samant@oracle.com>, keescook <keescook@chromium.org>,
 jannh <jannh@google.com>, malat <malat@debian.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, amir73il <amir73il@gmail.com>,
 yuehaibing <yuehaibing@huawei.com>, jiangyiwen <jiangyiwen@huawei.com>,
 npiggin <npiggin@gmail.com>, rppt <rppt@linux.ibm.com>,
 piaojun <piaojun@huawei.com>,
 "yamada.masahiro" <yamada.masahiro@socionext.com>,
 "ge.changwei" <ge.changwei@h3c.com>, Morton Andrew <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jslaby <jslaby@suse.cz>,
 kamalesh <kamalesh@linux.vnet.ibm.com>, gustavo <gustavo@embeddedor.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is the logical continuation of the "lib/sort & lib/list_sort:
faster and smaller" series by George Spelvin (added to linux-next
recently).

Since Spectre mitigations have made indirect function calls more
expensive, and the previous patch series implements the default
simple byte copies without them, an "optimized" custom swap
function is now a waste of time as well as code.

Patches 1 to 4 replace trivial swap functions with the built-in
(which is now much faster) and are grouped by subsystem.
Being pure code deletion patches, they are sure to bring joy to
Linus's heart.

Having reviewed all call sites, only three non-trivial swap
functions remain:  arch/x86/kernel/unwind_orc.c,
kernel/jump_label.c and lib/extable.c.

Patch #5 takes the opportunity to clean up a long-standing
interface wart: the swap function's size parameter was an int,
which doesn't match the size_t element size passed to sort()
function itself.  So change it to size_t.

v1->v2: Only commit messages have changed to better explain
	the purpose of commits. (Thanks to George Spelvin and Greg KH)

Andrey Abramov (5):
  arch/arc: unwind.c: replace swap function with built-in one
  powerpc: module_[32|64].c: replace swap function with built-in one
  ocfs2: dir,refcounttree,xattr: replace swap functions with built-in
    one
  ubifs: find.c: replace swap function with built-in one
  Lib: sort.h: replace int size with size_t size in the swap function

 arch/arc/kernel/unwind.c        | 20 ++------------------
 arch/powerpc/kernel/module_32.c | 17 +----------------
 arch/powerpc/kernel/module_64.c | 17 +----------------
 arch/x86/kernel/unwind_orc.c    |  2 +-
 fs/ocfs2/dir.c                  | 13 +------------
 fs/ocfs2/refcounttree.c         | 13 +++----------
 fs/ocfs2/xattr.c                | 15 +++------------
 fs/ubifs/find.c                 |  9 +--------
 include/linux/sort.h            |  2 +-
 kernel/jump_label.c             |  2 +-
 lib/extable.c                   |  2 +-
 lib/sort.c                      |  6 +++---
 12 files changed, 19 insertions(+), 99 deletions(-)

-- 
2.21.0


