Return-Path: <SRS0=rJbe=SC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FBBC43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 03:30:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4C82173C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 03:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="DoVzdMUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4C82173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44X1FD3k9CzDqQl
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 14:30:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yandex.ru
 (client-ip=5.45.198.241; helo=forward101j.mail.yandex.net;
 envelope-from=st5pub@yandex.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yandex.ru header.i=@yandex.ru header.b="DoVzdMUX"; 
 dkim-atps=neutral
Received: from forward101j.mail.yandex.net (forward101j.mail.yandex.net
 [5.45.198.241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Wky32yNQzDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 03:46:03 +1100 (AEDT)
Received: from mxback2o.mail.yandex.net (mxback2o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::1c])
 by forward101j.mail.yandex.net (Yandex) with ESMTP id 8F7711BE0646;
 Sat, 30 Mar 2019 19:37:52 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback2o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 1YR4K0xhLB-bfTmTF6M; 
 Sat, 30 Mar 2019 19:37:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1553963870; bh=ua+pPFPSHTEeenSsWAP5SFeoYcFeBHynoZLbeXw8Fuk=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=DoVzdMUX1qnwqJrpMXb60TntWxN4GtWADCodkOdPYU0tODiY9WxjxOgs1Gth/w5ZT
 In7kwHcs2ipJKz2577i8Qt/J88cdSGZsmOWe+tlDHZfKsJaB2R7qtvrQRXrdIFpT2z
 d64PgIExmeKP0pwN8giHsu1+rOHiKSjmA+6Q/NFY=
Authentication-Results: mxback2o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-b3ec53dbc12b.qloud-c.yandex.net with HTTP;
 Sat, 30 Mar 2019 19:37:41 +0300
From: Andrey Abramov <st5pub@yandex.ru>
To: vgupta@synopsys.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, x86@kernel.org, mark@fasheh.com, jlbec@evilplan.org,
 richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com,
 gregkh@linuxfoundation.org, naveen.n.rao@linux.vnet.ibm.com,
 jpoimboe@redhat.com, Dave Chinner <dchinner@redhat.com>,
 darrick.wong@oracle.com, ard.biesheuvel@linaro.org,
 George Spelvin <lkml@sdf.org>, linux-snps-arc@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
 linux-mtd@lists.infradead.org, sfr@canb.auug.org.au
Subject: [PATCH 0/5] simple sort swap function usage improvements
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sat, 30 Mar 2019 19:37:41 +0300
Message-Id: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Mailman-Approved-At: Sun, 31 Mar 2019 14:25:41 +1100
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
Cc: mhocko@suse.com, gustavo@embeddedor.com, peterz@infradead.org,
 amir73il@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 kamalesh@linux.vnet.ibm.com, piaojun@huawei.com, yamada.masahiro@socionext.com,
 jiang.biao2@zte.com.cn, jslaby@suse.cz, yuehaibing@huawei.com,
 rppt@linux.ibm.com, ge.changwei@h3c.com, keescook@chromium.org,
 jannh@google.com, ashish.samant@oracle.com, npiggin@gmail.com,
 jiangyiwen@huawei.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 lchen@suse.com, malat@debian.org, Morton Andrew <akpm@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is the logical continuation of sort improvements by George Spelvin
"lib/sort & lib/list_sort: faster and smaller" series
(added to the linux-next really recently).

Patches from 1 to 4 replace simple swap functions with the built-in
(which is now much faster) and grouped by subsystem (after that only
3 files implement custom swap - arch/x86/kernel/unwind_orc.c,
kernel/jump_label.c and lib/extable.c).

Patch #5 replaces the int type with the size_t type of the size argument
in the swap function.

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


