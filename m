Return-Path: <SRS0=rJbe=SC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE89C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 03:31:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98EE2173C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 03:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="r2yLcjas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98EE2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44X1Gy4lb1zDqS7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 14:31:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yandex.ru
 (client-ip=5.45.198.251; helo=forward501j.mail.yandex.net;
 envelope-from=st5pub@yandex.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yandex.ru header.i=@yandex.ru header.b="r2yLcjas"; 
 dkim-atps=neutral
Received: from forward501j.mail.yandex.net (forward501j.mail.yandex.net
 [5.45.198.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Wl081Ds0zDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 03:47:51 +1100 (AEDT)
Received: from mxback15o.mail.yandex.net (mxback15o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::66])
 by forward501j.mail.yandex.net (Yandex) with ESMTP id 0A0063380055;
 Sat, 30 Mar 2019 19:41:38 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback15o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id FwYt6bfWhz-fUuGwdtu;
 Sat, 30 Mar 2019 19:41:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1553964097; bh=BAGuq6aY41vQoMTVybblCDo6g+wTKuB5ZkNrCMXNEeI=;
 h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
 b=r2yLcjasL66jIafN59BUK+sNyksLUyMg6rcLPmogPy/2DlS0P/jSubx07PiOJqTv4
 UrX91bPScueQ2KihFcebl6F7npigS0F0/mtjTfsIKZ3lZYvTmqBZ1MzsKkxVLCINhx
 CLR56e2I5oHl+LwxkL8NnPLdj6sMk5V+40LdDaG8=
Authentication-Results: mxback15o.mail.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by iva7-8a22bc446c12.qloud-c.yandex.net with HTTP;
 Sat, 30 Mar 2019 19:41:30 +0300
From: Andrey Abramov <st5pub@yandex.ru>
To: "vgupta@synopsys.com" <vgupta@synopsys.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
 "mark@fasheh.com" <mark@fasheh.com>,
 "jlbec@evilplan.org" <jlbec@evilplan.org>,
 "richard@nod.at" <richard@nod.at>,
 "dedekind1@gmail.com" <dedekind1@gmail.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
 "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
 Dave Chinner <dchinner@redhat.com>,
 "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 George Spelvin <lkml@sdf.org>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
In-Reply-To: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
Subject: [PATCH 2/5] powerpc: module_[32|64].c: replace swap function with
 built-in one
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sat, 30 Mar 2019 19:41:30 +0300
Message-Id: <21287961553964090@iva7-8a22bc446c12.qloud-c.yandex.net>
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
Cc: "mhocko@suse.com" <mhocko@suse.com>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "kamalesh@linux.vnet.ibm.com" <kamalesh@linux.vnet.ibm.com>,
 "piaojun@huawei.com" <piaojun@huawei.com>,
 "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
 "jiang.biao2@zte.com.cn" <jiang.biao2@zte.com.cn>,
 "jslaby@suse.cz" <jslaby@suse.cz>,
 "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
 "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
 "ge.changwei@h3c.com" <ge.changwei@h3c.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "jannh@google.com" <jannh@google.com>,
 "ashish.samant@oracle.com" <ashish.samant@oracle.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "jiangyiwen@huawei.com" <jiangyiwen@huawei.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "lchen@suse.com" <lchen@suse.com>, "malat@debian.org" <malat@debian.org>,
 Morton Andrew <akpm@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Replace relaswap with built-in one, because of relaswap
does a simple byte to byte swap.

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
---
 arch/powerpc/kernel/module_32.c | 17 +----------------
 arch/powerpc/kernel/module_64.c | 17 +----------------
 2 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index 88d83771f462..c311e8575d10 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -79,21 +79,6 @@ static int relacmp(const void *_x, const void *_y)
 		return 0;
 }
 
-static void relaswap(void *_x, void *_y, int size)
-{
-	uint32_t *x, *y, tmp;
-	int i;
-
-	y = (uint32_t *)_x;
-	x = (uint32_t *)_y;
-
-	for (i = 0; i < sizeof(Elf32_Rela) / sizeof(uint32_t); i++) {
-		tmp = x[i];
-		x[i] = y[i];
-		y[i] = tmp;
-	}
-}
-
 /* Get the potential trampolines size required of the init and
    non-init sections */
 static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
@@ -130,7 +115,7 @@ static unsigned long get_plt_size(const Elf32_Ehdr *hdr,
 			 */
 			sort((void *)hdr + sechdrs[i].sh_offset,
 			     sechdrs[i].sh_size / sizeof(Elf32_Rela),
-			     sizeof(Elf32_Rela), relacmp, relaswap);
+			     sizeof(Elf32_Rela), relacmp, NULL);
 
 			ret += count_relocs((void *)hdr
 					     + sechdrs[i].sh_offset,
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 8661eea78503..0c833d7f36f1 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -231,21 +231,6 @@ static int relacmp(const void *_x, const void *_y)
 		return 0;
 }
 
-static void relaswap(void *_x, void *_y, int size)
-{
-	uint64_t *x, *y, tmp;
-	int i;
-
-	y = (uint64_t *)_x;
-	x = (uint64_t *)_y;
-
-	for (i = 0; i < sizeof(Elf64_Rela) / sizeof(uint64_t); i++) {
-		tmp = x[i];
-		x[i] = y[i];
-		y[i] = tmp;
-	}
-}
-
 /* Get size of potential trampolines required. */
 static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 				    const Elf64_Shdr *sechdrs)
@@ -269,7 +254,7 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 			 */
 			sort((void *)sechdrs[i].sh_addr,
 			     sechdrs[i].sh_size / sizeof(Elf64_Rela),
-			     sizeof(Elf64_Rela), relacmp, relaswap);
+			     sizeof(Elf64_Rela), relacmp, NULL);
 
 			relocs += count_relocs((void *)sechdrs[i].sh_addr,
 					       sechdrs[i].sh_size
-- 
2.21.0


