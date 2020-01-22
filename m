Return-Path: <SRS0=NP7W=3L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB4AC2D0DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jan 2020 13:12:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AFF720678
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jan 2020 13:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="O5WSDQYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFF720678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 482m5v5RC7zDqTv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jan 2020 00:12:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=O5WSDQYU; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 482lrY0NJPzDqT5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2020 00:00:43 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 482lrR2trSz9v4T6;
 Wed, 22 Jan 2020 14:00:39 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=O5WSDQYU; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 4nbWYbYP4Gr5; Wed, 22 Jan 2020 14:00:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 482lrR1szqz9v4T4;
 Wed, 22 Jan 2020 14:00:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1579698039; bh=iFbImthIOlCPbURK2OGGbKh/yT9m4I8aqMlWfZTcU+E=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=O5WSDQYUFN5WmBLlV7O7THG41xuhILXKO98/NXe+lxig1aGv17e6ZnyrB6MRXu2jG
 NKawLj1k3m9pU27WuQZl9Hxp658ypN/7l88qegRA3KkX1sbFpaYV32f6js0KjkO8M0
 JSprLI+a3mhuKSTS0CsmbIguNDPym/7m/92wTCsE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E6698B7FC;
 Wed, 22 Jan 2020 14:00:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id eOSvAb_poZnv; Wed, 22 Jan 2020 14:00:40 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.100])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C78FE8B7FA;
 Wed, 22 Jan 2020 14:00:39 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id BF986651E0; Wed, 22 Jan 2020 13:00:39 +0000 (UTC)
Message-Id: <36561aa79bfe4c6b8085ebd87a1967ea639fb878.1579697910.git.christophe.leroy@c-s.fr>
In-Reply-To: <a02d3426f93f7eb04960a4d9140902d278cab0bb.1579697910.git.christophe.leroy@c-s.fr>
References: <a02d3426f93f7eb04960a4d9140902d278cab0bb.1579697910.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 5/6] powerpc/32s: prepare prevent_user_access() for
 user_access_end()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 22 Jan 2020 13:00:39 +0000 (UTC)
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
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation of implementing user_access_begin and friends
on powerpc, the book3s/32 version of prevent_user_access() need
to be prepared for user_access_end().

user_access_end() doesn't provide the address and size which
were passed to user_access_begin(), required by prevent_user_access()
to know which segment to modify.

The list of segments which where unprotected by allow_user_access()
are available in current->kuap. But we don't want prevent_user_access()
to read this all the time, especially everytime it is 0 (for instance
because the access was not a write access).

Implement a special direction case named KUAP_SELF. In this case only,
the addr and end are retrieved from current->kuap.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/kup.h | 25 ++++++++++++++++++------
 arch/powerpc/include/asm/kup.h           |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 3c1798e56b55..a99fc3428ac9 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -117,6 +117,7 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 		return;
 
 	end = min(addr + size, TASK_SIZE);
+
 	current->thread.kuap = (addr & 0xf0000000) | ((((end - 1) >> 28) + 1) & 0xf);
 	kuap_update_sr(mfsrin(addr) & ~SR_KS, addr, end);	/* Clear Ks */
 }
@@ -127,15 +128,27 @@ static __always_inline void prevent_user_access(void __user *to, const void __us
 	u32 addr, end;
 
 	BUILD_BUG_ON(!__builtin_constant_p(dir));
-	if (!(dir & KUAP_W))
-		return;
 
-	addr = (__force u32)to;
+	if (dir == KUAP_SELF) {
+		u32 kuap = current->thread.kuap;
 
-	if (unlikely(addr >= TASK_SIZE || !size))
-		return;
+		if (unlikely(!kuap))
+			return;
+
+		addr = kuap & 0xf0000000;
+		end = kuap << 28;
+	} else {
+		if (!(dir & KUAP_W))
+			return;
+
+		addr = (__force u32)to;
+
+		if (unlikely(addr >= TASK_SIZE || !size))
+			return;
+
+		end = min(addr + size, TASK_SIZE);
+	}
 
-	end = min(addr + size, TASK_SIZE);
 	current->thread.kuap = 0;
 	kuap_update_sr(mfsrin(addr) | SR_KS, addr, end);	/* set Ks */
 }
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 49fd977a498e..0676df6f3f86 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -5,6 +5,7 @@
 #define KUAP_R		1
 #define KUAP_W		2
 #define KUAP_RW		(KUAP_R | KUAP_W)
+#define KUAP_SELF	4
 
 #ifdef CONFIG_PPC64
 #include <asm/book3s/64/kup-radix.h>
-- 
2.25.0

