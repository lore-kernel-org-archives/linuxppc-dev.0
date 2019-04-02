Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8E6C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 20:49:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CCD2082C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 20:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="HPkQWz6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CCD2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YhCJ0wJDzDqD7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 07:49:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=yandex.ru
 (client-ip=77.88.28.110; helo=forward500p.mail.yandex.net;
 envelope-from=st5pub@yandex.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=yandex.ru header.i=@yandex.ru header.b="HPkQWz6+"; 
 dkim-atps=neutral
Received: from forward500p.mail.yandex.net (forward500p.mail.yandex.net
 [77.88.28.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Yh9M6cppzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 07:47:34 +1100 (AEDT)
Received: from mxback11o.mail.yandex.net (mxback11o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::62])
 by forward500p.mail.yandex.net (Yandex) with ESMTP id 498B8940636;
 Tue,  2 Apr 2019 23:47:29 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback11o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ts1rVg2WiC-lM7iKRvA;
 Tue, 02 Apr 2019 23:47:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1554238048; bh=THhA4iYx1mlmYH8MJ7BZaVU4UIyCdDLth+errTX31Jc=;
 h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
 b=HPkQWz6+REMRODCfKBojCOW1Nxhq4K/RAKT+dDIdmBELMTemMr/weUTPULQatXV9w
 yIyya/iOw1iqxin4coG3FVXRE6yFoFkp9M9YYEsNTXua6lHEHuqRvJZMhkFidQAGcp
 GyxEOPIbhFyLrsRMJo1Arss+oHRcwpD/hkMOK1w0=
Authentication-Results: mxback11o.mail.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by iva8-b333b7f98ab0.qloud-c.yandex.net with HTTP;
 Tue, 02 Apr 2019 23:47:22 +0300
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
In-Reply-To: <824481554237711@sas1-23a37bc8251c.qloud-c.yandex.net>
References: <824481554237711@sas1-23a37bc8251c.qloud-c.yandex.net>
Subject: [PATCH v3 2/5] powerpc: module_[32|64].c: replace swap function with
 built-in one
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 02 Apr 2019 23:47:22 +0300
Message-Id: <994931554238042@iva8-b333b7f98ab0.qloud-c.yandex.net>
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
Cc: malat <malat@debian.org>, "yamada.masahiro" <yamada.masahiro@socionext.com>,
 npiggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Replace relaswap with built-in one, because relaswap
does a simple byte to byte swap.

Since Spectre mitigations have made indirect function calls more
expensive, and the default simple byte copies swap is implemented
without them, an "optimized" custom swap function is now
a waste of time as well as code.

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
Reviewed by: George Spelvin <lkml@sdf.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
---
v2->v3: nothing changed

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


