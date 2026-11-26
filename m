Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1F606A681
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtsNJXH5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZv8p0ggbz2yMP;
	Thu, 26 Nov 2026 22:15:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691706;
	cv=none; b=VVGh2kBSLU/VpGqY0BtLRyXIWwMXHF20hjm0SzuQf9u2WJG1ud7rZujOML0IhRFtbWlblkKXKh3oPBuzs1j720B2b5Fdx3mbIViEbHvIgYBfGmL1QhCPVJVKjSogIAz3a0ugfNA/RKwl6NBXNr0U9VqZ6P52Lob+r0uS0L7rvF3kcB/khuh7fnbEG+DMaVx+JPXu/k9aHeZ8eHe3w+20+cyB+2K6sgi/3TntbSoBllgrrPPWjhlvjgv2FqA+RjSn2fIh6S9OjKgqNLPqna1h10rVO8aYzMGWIA5wnFEXmI+Vxcb8p2QVrydjzc4mfhgYZwniuPp3klilE4xI4YyPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691706; c=relaxed/relaxed;
	bh=bj8/4t1D3486bMWuOXwhLcAKxLKyES2zSNh6vuKXpeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRHaQ83uHK9EuW2VOjVWNKBH8kAAP6QNyaMJZK6QRyPF/U5sAPX+t1alKaLWl/PXc3+a0JQzrPykbJaY8MWIoW/oJ9y395z99bkNRQbR3EUoqEBzafo1ZaJsUUI5/CioOgdCqt1aiI4fG6xofkurMsYJon1JY7CwzedFg2pHEEEf2YyL3Bp9BMQ2dgIEmh5yyHJAC9L4TZENv42VTXv6qXfmlP7ck/F9Ssj9T7/6DwZ3pxZAKPsbJ7GAr1ux/2iNYSIJlYVzBMCRJxuFMZkygOwoyM3Dorx2adr1DWgdB+G8tePtkQ8ksFfCYdsABWjJXhVYau7tGoCZQxinkkD0nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtsNJXH5; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtsNJXH5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZv8n0dSYz2yMK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:15:05 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 919D645CBF;
	Thu, 26 Nov 2026 11:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18B61F000C0;
	Thu, 26 Nov 2026 11:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691703;
	bh=bj8/4t1D3486bMWuOXwhLcAKxLKyES2zSNh6vuKXpeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UtsNJXH5LkGbLvmX8h3OWLUUPvo5d1Agxt9hiYQPPnM54LtZfxIJvEkh7mIytiaPL
	 R/iQ8gA7kJPLRFnQ2FHCXHvqEw5yPC6eW6oxNL4Gli3chYbPmwhbjwy2PutbebUGMc
	 R73R+kL6N6mVGWCCB1VsAFs8AB9+g4AyJv+7cH0WQ+PHsw7ExmQ0tVphZP274UDziY
	 3gfWXTO7rOPovoqCNUi+BQdyjUiAqRxeTnYvKTBDnS5fdyx3AoxmmN1YYITXMeU6u5
	 58JA57EHTN+Mt/ar7zYd+kdqSTSqOfYOBW/fd8UrNniZmSKj+/mHWAgxeBE9NdurAa
	 swzGR3b7HpeBA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:16 +0200
Subject: [PATCH RFC v2 03/54] s390/boot: parse boolean parameters like the
 kernel
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-3-723f1e33c3d8@kernel.org>
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

The decompressor has a copy of kstrtobool() that takes only y/n, 1/0 and
on/off. The kernel's kstrtobool() also takes true/false since 0d6ea3ac94ca
("lib/kstrtox.c: add "false"/"true" support to kstrtobool()") and
enabled/disabled since ae5b3500856f ("kstrtox: add support for enabled and
disabled in kstrtobool()").

The decompressor ignores these values, so "cmma=false" leaves CMMA enabled
and "prot_virt=true" does not enable it.

Copy kstrtobool() from lib/kstrtox.c. This also adds the break after the
on/off switch, which only replaces a fall through to the empty default
case.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/boot/string.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/boot/string.c b/arch/s390/boot/string.c
index e4ad196cb720..c12fee2670e3 100644
--- a/arch/s390/boot/string.c
+++ b/arch/s390/boot/string.c
@@ -132,13 +132,21 @@ int kstrtobool(const char *s, bool *res)
 		return -EINVAL;
 
 	switch (s[0]) {
+	case 'e':
+	case 'E':
 	case 'y':
 	case 'Y':
+	case 't':
+	case 'T':
 	case '1':
 		*res = true;
 		return 0;
+	case 'd':
+	case 'D':
 	case 'n':
 	case 'N':
+	case 'f':
+	case 'F':
 	case '0':
 		*res = false;
 		return 0;
@@ -156,6 +164,7 @@ int kstrtobool(const char *s, bool *res)
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}

-- 
2.53.0


