Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0956C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 20:43:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDC32082C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 20:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="tjPKIU2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDC32082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Yh4s6X0szDqPk
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 07:43:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yandex.ru
 (client-ip=5.45.198.243; helo=forward102j.mail.yandex.net;
 envelope-from=st5pub@yandex.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yandex.ru header.i=@yandex.ru header.b="tjPKIU2c"; 
 dkim-atps=neutral
Received: from forward102j.mail.yandex.net (forward102j.mail.yandex.net
 [5.45.198.243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Yh343V2lzDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 07:42:04 +1100 (AEDT)
Received: from mxback5j.mail.yandex.net (mxback5j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::10e])
 by forward102j.mail.yandex.net (Yandex) with ESMTP id 3945DF21601;
 Tue,  2 Apr 2019 23:41:58 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback5j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id hTyhEB7C0p-fpP4KXkT; 
 Tue, 02 Apr 2019 23:41:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1554237716; bh=nlyxbITpbpWV++WUuQA9wS2TeXvU+5JCwzDJix4Usoo=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=tjPKIU2cCaEXSiHfxcru19tJ8/TstdyLtuyZwbPA/Sq8/Gmk0DSG7NmMB3QjZfxej
 ZvTyUnmAzsfjexhu96Zg6jg/bf/suid9Ehsx7yASkCSTZF0Lk+SsLUMMpZKaZH7Xh1
 yOEx6yM/ABY452UdMwGN416SaPeiKcOONAEazK0I=
Authentication-Results: mxback5j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-23a37bc8251c.qloud-c.yandex.net with HTTP;
 Tue, 02 Apr 2019 23:41:51 +0300
From: Andrey Abramov <st5pub@yandex.ru>
To: vgupta <vgupta@synopsys.com>, benh <benh@kernel.crashing.org>,
 paulus <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: [PATCH v3 0/5] simple sort swap function improvements
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 02 Apr 2019 23:41:51 +0300
Message-Id: <824481554237711@sas1-23a37bc8251c.qloud-c.yandex.net>
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
Cc: mhocko <mhocko@suse.com>, gustavo <gustavo@embeddedor.com>,
 peterz <peterz@infradead.org>, amir73il <amir73il@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 kamalesh <kamalesh@linux.vnet.ibm.com>, piaojun <piaojun@huawei.com>,
 "yamada.masahiro" <yamada.masahiro@socionext.com>,
 "jiang.biao2" <jiang.biao2@zte.com.cn>, jslaby <jslaby@suse.cz>,
 yuehaibing <yuehaibing@huawei.com>, rppt <rppt@linux.ibm.com>,
 "ge.changwei" <ge.changwei@h3c.com>, keescook <keescook@chromium.org>,
 jannh <jannh@google.com>, "ashish.samant" <ashish.samant@oracle.com>,
 npiggin <npiggin@gmail.com>, jiangyiwen <jiangyiwen@huawei.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lchen <lchen@suse.com>,
 malat <malat@debian.org>, Morton Andrew <akpm@linux-foundation.org>
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

Patch #5 removes size argument from the swap function because:
	1) It wasn't used.
	2) Custom swap function knows what kind of objects it swaps,
		so it already knows their sizes.

v1->v2: Only commit messages have changed to better explain
		the purpose of commits. (Thanks to George Spelvin and Greg KH)
v2->v3: Patch #5 now completely removes the size argument

Andrey Abramov (5):
  arch/arc: unwind.c: replace swap function with built-in one
  powerpc: module_[32|64].c: replace swap function with built-in one
  ocfs2: dir,refcounttree,xattr: replace swap functions with built-in
    one
  ubifs: find.c: replace swap function with built-in one
  Lib: sort.h: remove the size argument from the swap function

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
 lib/sort.c                      |  7 +++----
 12 files changed, 19 insertions(+), 100 deletions(-)

-- 
2.21.0


