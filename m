Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44256606A32C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MP3x1Ccg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZv8z01rsz2yNj;
	Thu, 26 Nov 2026 22:15:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795691714;
	cv=none; b=cwVOkrf6dYsI6XRW7yb65zaqjAiBKTUzEQJtcWtRR4aYryY8+KjozYkWNcsCIawyJ2H3XDq2Y18LGNYfOfB5kAOdGV8KdhW81zZ/pfOZ2GIo8E1mYWMaLLPGVOHl8IjXlkWhtu4m86+Xd4QqgQwXwmz0sTCPeJ4zzZubTdjDnUwetSe9yGG94mKVDslOUF0aC9l79bYP6B8KYSP04MukiQRM4GTu9EcA7+rmtcBddmilKkF1ERyjpuHr/OMbZGm57c63btXQVWpmaXAt3kr/wBheLPGas6MP+7due1AIL3/591yo24RofSJeQyH6bEw6PAFp1LkRVFm8AWhpMfXVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795691714; c=relaxed/relaxed;
	bh=Pa/qSMCChRGH42K3rYTSztXsaxvBOYR3oBjTN9/+VqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BhRiQUJfi4m57Rdsh2eyU/WZ1EeP0vlWZwLZjH/32nj6/tJrq5WChe/u26IO8xhKrmlvVm7uCuzNCxdNe1CjVCVeBROYENfHla1zxIDpenZnHtPzn5WaY+qA++0EIyBNdybBAKbuxu3t32jNvi4pje4hkrshk9I3Hry0pOYJPwx8U2c/Fb/OZl3IWkdWmuC6fpBBVh4T3gJtk0bpki9VaQ/PTAspIbazwJxb/794oCHxmxKu5PFmvIVTrEmP99alcwJcoTSMcRhSf9sweBlepvo9ivw2Yc8CXC5e+F3Ygc/2Osef1QklyO492qudwyrlls+IvA65d3hIeGK+2h9zwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MP3x1Ccg; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MP3x1Ccg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZv8y3Nwfz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:15:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F014F44FDC;
	Thu, 26 Nov 2026 11:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F70E1F000D3;
	Thu, 26 Nov 2026 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691712;
	bh=Pa/qSMCChRGH42K3rYTSztXsaxvBOYR3oBjTN9/+VqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MP3x1CcgVdwXZovNmf2Ki608k9RA+upmwxLp4DhhwvWZFzw5QHNd1LujvDkgy5dqK
	 VudlIr+IQ0y5h01MkihEvEk+fN3u6e0wS395BMpBkuMKyfNQDtQIXifIJtscUMPgMn
	 mRMkfl5ZkqBv6Pnrvr3XlMzLeXxLL8XTGCTeQjY+DsJ0sPHkki4BSfureOMycyH4Ig
	 6F6k/5CR5+LLNSNVwEdIqxm8cn75nagz+yLvq8j0f6/pr5fLtiTxD0jmw41RAcqdG1
	 gDHYFA178/+99Xx/ijLHYcEFPmOPjXC5GwRv8Ar3G2pFnmTMGX0EXfDolIxf5QrwSJ
	 NJqE+CbJ3opQQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:17 +0200
Subject: [PATCH RFC v2 04/54] s390/boot: stop parsing the command line at
 "--"
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
Message-Id: <20261126-generic-set-memory-v0-1-v2-4-723f1e33c3d8@kernel.org>
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

The kernel parses its parameters up to "--" and passes everything after it
to init. The decompressor parses the whole command line, so an argument
meant for init still takes effect in the decompressor if it has the name of
a parameter the decompressor knows, like "mem=".

Stop at "--", like parse_args() does.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/boot/ipl_parm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 8bbd102fa50f..ed28ea2fc1d1 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -268,6 +268,10 @@ void parse_boot_command_line(void)
 	while (*args) {
 		args = next_arg(args, &param, &val);
 
+		/* The arguments after "--" are for init */
+		if (!val && !strcmp(param, "--"))
+			break;
+
 		if (!strcmp(param, "mem") && val)
 			memory_limit = round_down(memparse(val, NULL), PAGE_SIZE);
 

-- 
2.53.0


