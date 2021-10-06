Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CECC433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 16:48:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D444260235
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Oct 2021 16:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D444260235
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HPgPF2SGrz3dqJ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Oct 2021 03:48:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.161.45; helo=mail-oo1-f45.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HPgJW29VQz3053
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Oct 2021 03:43:55 +1100 (AEDT)
Received: by mail-oo1-f45.google.com with SMTP id
 w9-20020a4adec9000000b002b696945457so525062oou.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Oct 2021 09:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qVDBxu87TJi7lJ0TsvF77hW6cToukGJnTBFK4bAPEHE=;
 b=lDMywqzDoduj0F5CrdYXWcq4Z0x2mAxy4uZ5km3xe0CaIUxPxQa4JAs/nzNwWdF/bX
 0niELS8zwEazuEKNIRCuLRAvg+0/LYk7QZi6jPy8eyn/61I0P3BI3SgoqdpodkDul4gX
 IufnmEcpcXM1ohKoVFs6PYf4fPuGqFSIt/BGOEmdIMu58/y9EAY98JlzDI+Eu1GIz58Z
 oqDCCKI10LV71CZ920pNOrOVr9Wb9IlXM3vb+/s5PJ/tbK6Qz2dwk36Wpaluv7CSws5A
 9cRUc4pPqz+pFzu3FXgm7QdIfHUerSmfkfr5f4kZCxoCCjDxvnG648qfWFERfZuRdc+h
 URsQ==
X-Gm-Message-State: AOAM532nhmnl3BziJMqrFj2PKq7VAFWk5DqfNUzrdBTNL4gmJ9SWU2ix
 8wuoT+c7uCbtMNygBQ96PQ==
X-Google-Smtp-Source: ABdhPJwSo3vtevHig5e6wcfYzHn+p/9LVu6izXiBqHPOZc+ml50aXK5vctwJYkE3EswfiMHjHBf9ng==
X-Received: by 2002:a4a:e597:: with SMTP id o23mr6391984oov.96.1633538632948; 
 Wed, 06 Oct 2021 09:43:52 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Oct 2021 09:43:52 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Russell King <linux@armlinux.org.uk>, James Morse <james.morse@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Guo Ren <guoren@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 09/12] sh: Use of_get_cpu_hwid()
Date: Wed,  6 Oct 2021 11:43:29 -0500
Message-Id: <20211006164332.1981454-10-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
MIME-Version: 1.0
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
Cc: devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-sh@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Borislav Petkov <bp@alien8.de>,
 bcm-kernel-feedback-list@broadcom.com, Thomas Gleixner <tglx@linutronix.de>,
 Frank Rowand <frowand.list@gmail.com>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Replace open coded parsing of CPU nodes' 'reg' property with
of_get_cpu_hwid().

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sh/boards/of-generic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 921d76fc3358..f7f3e618e85b 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -62,9 +62,8 @@ static void sh_of_smp_probe(void)
 	init_cpu_possible(cpumask_of(0));
 
 	for_each_of_cpu_node(np) {
-		const __be32 *cell = of_get_property(np, "reg", NULL);
-		u64 id = -1;
-		if (cell) id = of_read_number(cell, of_n_addr_cells(np));
+		u64 id = of_get_cpu_hwid(np, 0);
+
 		if (id < NR_CPUS) {
 			if (!method)
 				of_property_read_string(np, "enable-method", &method);
-- 
2.30.2

