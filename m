Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220C606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3kFIR10
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZv9849LVz2yPq;
	Thu, 26 Nov 2026 22:15:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691724;
	cv=none; b=iZX98gk15C9QlGPKRchhCIS41bTObcKlo/JO+FuUHmB4msguGaIY/8jNNxg334jD4vr1SQYWw4Ly1D/Paw0IpWCcAcALKJPNXe155DuY+N5cZZuQQE8L9CGvCrIpbrDXB2OtROws8Zxto45qZ9Gvx62fyz+ePFCkwzOjXYYu4UQArH5DoxTClgFWl0GWbtACFCCdPQKvvWp7a9PaMPBP6nftY7oVTVj9Rx1ng4zjvS+MR32SqhCnboocxgFwrkSfD6uASSmgo6TnApPOnZLeNEYiMhefWGT3v4YpwUJcdyG5CoWWESig+Is8mvyOXxdzrZjNA12od1Ff7YjSidOnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691724; c=relaxed/relaxed;
	bh=zImSfvTk7Ce9C0Ntm689zz11A7MeuyzdnAnXV7c96Hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PGfRe8/luUQMd0ZAgdsC8IFRezyBcI+AsP6dqpvg1DIyFwuC6V3v98Duu/labqE9z2Fd6/Jw+00KZSsLTyA7TuQykDw3gYpoL65fWRXmunrjMWqS2tQ27/qjg10nJQFgapXxBiCu/1d5m9nGmYdLzJHL8fXdbXWQkpEbxrdh0WJ5xaaiVQJsR9Qj6pDNy0Vk82xs+znUxJEiS39DMzq++QyGLjT7KIu5+QCxYoc5Yyg/bi2ziyfl1r6Fa9coMYYEXbLNylR41Qux8zSpFzbI6qWpCreWxI0MrKBBaD90Jj4qHIKYWfIkXb2XpfsMpkZyzGZ66SLQ9D/9nF5gJwv68Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3kFIR10; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3kFIR10;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZv976FVKz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:15:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D98643224;
	Thu, 26 Nov 2026 11:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCDB1F00AE3;
	Thu, 26 Nov 2026 11:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691722;
	bh=zImSfvTk7Ce9C0Ntm689zz11A7MeuyzdnAnXV7c96Hs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k3kFIR107EfL7OCOXCU8Gw8+wFHgYeB6pwLpvAtrtxNruSbP+IxmvekCmPdAtQpU6
	 UY9gwt+R1jj/XLJxRSkgFV/NN1dqYd2vaEiNbba2VGjRRqrndAy3W3NDIYMGpwGJdL
	 5I5xoLA6NN9oPGIT+cll+4qCT2QAsDrYc+8BocCiyQFLGSboxGfTEYTroUEdlDxo+c
	 GWTUcL/DyD6jX5uwq92MnSCE+qN75XIupuUympUcKEE9nsukylR8tAJqmagsFaNpi4
	 wqNpEf6O3v9v4sAEU0M1bRVvAdcO5ESPqGmgBJIygD3v50tp7Tk1xNsDGMbHsOcixL
	 hxaqNlHeGhMdg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:18 +0200
Subject: [PATCH RFC v2 05/54] s390/boot: treat dashes and underscores alike
 in parameter names
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-5-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dashes and underscores are equivalent in the names of kernel parameters,
and the kernel compares the names with parameq(). The decompressor uses
strcmp(), so it ignores "relocate-lowcore" or "prot-virt=1".

Compare the names like parameq() does.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/boot/ipl_parm.c | 51 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index ed28ea2fc1d1..ac4cf1ced71d 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -255,6 +255,25 @@ static void modify_fac_list(char *str)
 	check_cleared_facilities();
 }
 
+static char dash2underscore(char c)
+{
+	if (c == '-')
+		return '_';
+	return c;
+}
+
+/* Dashes and underscores are equivalent in parameter names */
+static bool parameq(const char *a, const char *b)
+{
+	size_t i, n = strlen(a) + 1;
+
+	for (i = 0; i < n; i++) {
+		if (dash2underscore(a[i]) != dash2underscore(b[i]))
+			return false;
+	}
+	return true;
+}
+
 void parse_boot_command_line(void)
 {
 	char *param, *val;
@@ -272,15 +291,15 @@ void parse_boot_command_line(void)
 		if (!val && !strcmp(param, "--"))
 			break;
 
-		if (!strcmp(param, "mem") && val)
+		if (parameq(param, "mem") && val)
 			memory_limit = round_down(memparse(val, NULL), PAGE_SIZE);
 
-		if (!strcmp(param, "vmalloc") && val) {
+		if (parameq(param, "vmalloc") && val) {
 			vmalloc_size = round_up(memparse(val, NULL), _SEGMENT_SIZE);
 			vmalloc_size_set = 1;
 		}
 
-		if (!strcmp(param, "dfltcc") && val) {
+		if (parameq(param, "dfltcc") && val) {
 			if (!strcmp(val, "off"))
 				zlib_dfltcc_support = ZLIB_DFLTCC_DISABLED;
 			else if (!strcmp(val, "on"))
@@ -293,49 +312,49 @@ void parse_boot_command_line(void)
 				zlib_dfltcc_support = ZLIB_DFLTCC_FULL_DEBUG;
 		}
 
-		if (!strcmp(param, "facilities") && val)
+		if (parameq(param, "facilities") && val)
 			modify_fac_list(val);
 
-		if (!strcmp(param, "debug-alternative"))
+		if (parameq(param, "debug-alternative"))
 			alt_debug_setup(val);
 
-		if (!strcmp(param, "nokaslr"))
+		if (parameq(param, "nokaslr"))
 			__kaslr_enabled = 0;
 
-		if (!strcmp(param, "cmma")) {
+		if (parameq(param, "cmma")) {
 			rc = kstrtobool(val, &enabled);
 			if (!rc && !enabled)
 				cmma_flag = 0;
 		}
 
 #ifdef CONFIG_STACKPROTECTOR
-		if (!strcmp(param, "debug_stackprotector"))
+		if (parameq(param, "debug_stackprotector"))
 			stack_protector_debug = 1;
 #endif
 
 #if IS_ENABLED(CONFIG_KVM)
-		if (!strcmp(param, "prot_virt")) {
+		if (parameq(param, "prot_virt")) {
 			rc = kstrtobool(val, &enabled);
 			if (!rc && enabled)
 				prot_virt_host = 1;
 		}
 #endif
-		if (!strcmp(param, "relocate_lowcore") && test_facility(193))
+		if (parameq(param, "relocate_lowcore") && test_facility(193))
 			set_machine_feature(MFEATURE_LOWCORE);
-		if (!strcmp(param, "earlyprintk"))
+		if (parameq(param, "earlyprintk"))
 			boot_earlyprintk = true;
-		if (!strcmp(param, "debug"))
+		if (parameq(param, "debug"))
 			boot_console_loglevel = CONSOLE_LOGLEVEL_DEBUG;
-		if (!strcmp(param, "bootdebug")) {
+		if (parameq(param, "bootdebug")) {
 			bootdebug = true;
 			if (val)
 				strscpy(bootdebug_filter, val);
 		}
-		if (!strcmp(param, "quiet"))
+		if (parameq(param, "quiet"))
 			boot_console_loglevel = CONSOLE_LOGLEVEL_QUIET;
-		if (!strcmp(param, "ignore_loglevel"))
+		if (parameq(param, "ignore_loglevel"))
 			boot_ignore_loglevel = true;
-		if (!strcmp(param, "loglevel")) {
+		if (parameq(param, "loglevel")) {
 			boot_console_loglevel = simple_strtoull(val, NULL, 10);
 			if (boot_console_loglevel < CONSOLE_LOGLEVEL_MIN)
 				boot_console_loglevel = CONSOLE_LOGLEVEL_MIN;

-- 
2.53.0


