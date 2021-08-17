Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB06AC4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 13:04:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FC560F35
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 13:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48FC560F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gprnp3wZpz30Qm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 23:03:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g3H9J0xa;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g3H9J0xa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=g3H9J0xa; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g3H9J0xa; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gprn20bJSz2ymS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2021 23:03:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629205391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oQqo8hoVlThMMKnyM3FPqRihSiJEUC2ucaiuvvbW2TA=;
 b=g3H9J0xadxyXedJQhVfBLp7W14Fqlvwne3diwo8SxvivzI42hjoKymO6tWvF+8FCPbe6oY
 XbBVuAOoh00uxOioWTv1WdjisSEX4dxm6cHEzGG6bLIbWvgvjoi7NRVNpAZjJAAtg9uELy
 WE7ELLDyac32nSSqOY/EZIntSnq32oU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629205391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oQqo8hoVlThMMKnyM3FPqRihSiJEUC2ucaiuvvbW2TA=;
 b=g3H9J0xadxyXedJQhVfBLp7W14Fqlvwne3diwo8SxvivzI42hjoKymO6tWvF+8FCPbe6oY
 XbBVuAOoh00uxOioWTv1WdjisSEX4dxm6cHEzGG6bLIbWvgvjoi7NRVNpAZjJAAtg9uELy
 WE7ELLDyac32nSSqOY/EZIntSnq32oU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-sR4Wrbx7Nd6psWd4z1W6HQ-1; Tue, 17 Aug 2021 09:03:06 -0400
X-MC-Unique: sR4Wrbx7Nd6psWd4z1W6HQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5013EC73A0;
 Tue, 17 Aug 2021 13:03:05 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 514A95C1D5;
 Tue, 17 Aug 2021 13:03:03 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH/RFC] powerpc/module_64: allow .init_array constructors to run
Date: Tue, 17 Aug 2021 15:02:54 +0200
Message-Id: <920acea9aa18e4f2956581a8e158bdaa376fdf63.1629203945.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: linux-kernel@vger.kernel.org, jstancek@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

gcov and kasan rely on compiler generated constructor code.
For modules, gcc-8 with gcov enabled generates .init_array section,
but on ppc64le it doesn't get executed. find_module_sections() never
finds .init_array section, because module_frob_arch_sections() renames
it to _init_array.

Avoid renaming .init_array section, so do_mod_ctors() can use it.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
I wasn't able to trace the comment:
  "We don't handle .init for the moment: rename to _init"
to original patch (it pre-dates .git). I'm not sure if it
still applies today, so I limited patch to .init_array. This
fixes gcov for modules for me on ppc64le 5.14.0-rc6.

Renaming issue is also mentioned in kasan patches here:
  https://patchwork.ozlabs.org/project/linuxppc-dev/cover/20210319144058.772525-1-dja@axtens

 arch/powerpc/kernel/module_64.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 6baa676e7cb6..c604b13ea6bf 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -299,8 +299,16 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 					  sechdrs[i].sh_size);
 
 		/* We don't handle .init for the moment: rename to _init */
-		while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init")))
+		while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init"))) {
+#ifdef CONFIG_CONSTRUCTORS
+			/* find_module_sections() needs .init_array intact */
+			if (strstr(secstrings + sechdrs[i].sh_name,
+				".init_array")) {
+				break;
+			}
+#endif
 			p[0] = '_';
+		}
 
 		if (sechdrs[i].sh_type == SHT_SYMTAB)
 			dedotify((void *)hdr + sechdrs[i].sh_offset,
-- 
2.27.0

