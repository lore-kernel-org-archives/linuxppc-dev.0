Return-Path: <SRS0=Ntje=PC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A331CC433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 06:26:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356FF61152
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 06:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 356FF61152
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HVKCz69TBz3c59
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 17:26:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HVKB1235sz3bjN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2021 17:24:24 +1100 (AEDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4HVK9Y0wtgz9sSh;
 Thu, 14 Oct 2021 08:24:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xEpU4t-_hzV8; Thu, 14 Oct 2021 08:24:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4HVK9W4L3pz9sSK;
 Thu, 14 Oct 2021 08:23:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7EBAE8B788;
 Thu, 14 Oct 2021 08:23:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GT0Cp90ehmlN; Thu, 14 Oct 2021 08:23:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.231])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 21F058B763;
 Thu, 14 Oct 2021 08:23:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19E5oQYu2266010
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 14 Oct 2021 07:50:26 +0200
Received: (from chleroy@localhost)
 by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19E5oQDw2266009;
 Thu, 14 Oct 2021 07:50:26 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to
 christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 04/13] powerpc: Prepare func_desc_t for refactorisation
Date: Thu, 14 Oct 2021 07:49:53 +0200
Message-Id: <9c5dfd474978b95044bea23f2c6ecfcd0e70be36.1634190022.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634190022.git.christophe.leroy@csgroup.eu>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1634190596; l=1982; s=20211009;
 h=from:subject:message-id; bh=xaEIMhoO1iu6jIQRZVCIT+Eww/WREG5Dwrfz1rPUWtk=;
 b=8Ir9TJ6MIw2RLbZG6Si6TAr4RCB3gm8vbl5kr7oxBMxtdSEzi7oItu0KpctWd6X54AbJ6LLJaoYt
 POQStJJBDmkGbNm6iXhxAbB1ygkEztilH7NmMOr64weRaH303Vr0
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519;
 pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
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
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation of making func_desc_t generic, change it to
a struct containing 'addr' element.

In addition this allows using single helpers common to ELFv1 and ELFv2.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/module_64.c | 34 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 82908c9be627..dc99a3f6cee2 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -33,19 +33,13 @@
 #ifdef PPC64_ELF_ABI_v2
 
 /* An address is simply the address of the function. */
-typedef unsigned long func_desc_t;
+typedef struct {
+	unsigned long addr;
+} func_desc_t;
 
 static func_desc_t func_desc(unsigned long addr)
 {
-	return addr;
-}
-static unsigned long func_addr(unsigned long addr)
-{
-	return addr;
-}
-static unsigned long stub_func_addr(func_desc_t func)
-{
-	return func;
+	return (func_desc_t){addr};
 }
 
 /* PowerPC64 specific values for the Elf64_Sym st_other field.  */
@@ -68,15 +62,7 @@ typedef struct ppc64_opd_entry func_desc_t;
 
 static func_desc_t func_desc(unsigned long addr)
 {
-	return *(struct ppc64_opd_entry *)addr;
-}
-static unsigned long func_addr(unsigned long addr)
-{
-	return func_desc(addr).addr;
-}
-static unsigned long stub_func_addr(func_desc_t func)
-{
-	return func.addr;
+	return *(func_desc_t *)addr;
 }
 static unsigned int local_entry_offset(const Elf64_Sym *sym)
 {
@@ -93,6 +79,16 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
 }
 #endif
 
+static unsigned long func_addr(unsigned long addr)
+{
+	return func_desc(addr).addr;
+}
+
+static unsigned long stub_func_addr(func_desc_t func)
+{
+	return func.addr;
+}
+
 #define STUB_MAGIC 0x73747562 /* stub */
 
 /* Like PPC32, we need little trampolines to do > 24-bit jumps (into
-- 
2.31.1

