Return-Path: <SRS0=ea3T=UJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1A1C4321A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Jun 2019 23:31:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F9020820
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Jun 2019 23:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h556Ql2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F9020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45N8X80hbzzDqRP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 09:31:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=radu.rendec@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="h556Ql2t"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45N8V70hvczDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2019 09:29:18 +1000 (AEST)
Received: by mail-it1-x143.google.com with SMTP id l21so1888991ita.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2019 16:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J9HPrN2ssIKly8QosgZJTvVKX7D+6ItL0Y1EM/MaSs4=;
 b=h556Ql2t33AHH/c9wvAMH6UaHR1pLK9XmQHUml6v+PHVg6mNr8lwZinqfXMlofNJHg
 l54P2/C9CDNcmVqBx5UVElDg/BX/hJGlcqWn1sh4J9a/JBQ4ZplN+ld882VIOnC1+Bvh
 IWnejCgqFApgQoASWSy/7OQMRZ9QZ/oGcTvL5Po5sSTA9Z/zF8LugjgtxkppNNIUDoqM
 Zc8c244j0Y3sXePojM+G1v2Ae8mZ8/pmWjqhIkbwfel5oRuitvxK6ZtEzt9mJTt2v5vW
 oFMItSZ2pWsVQWmp1Pa9qd0G8A0oYPibJedNXUMh8dD7nlwfTj2Zi+KgCC+Gxg8LMJLD
 ZCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J9HPrN2ssIKly8QosgZJTvVKX7D+6ItL0Y1EM/MaSs4=;
 b=LOKG81x826Y7YMS5TgHst6G8quZOigtWUA0pdi7wxccbrJlDGfU72qq8M0zXiKjf/o
 Ucjgw8rIsrI3ddi3Eb/2OTCv79TjqSMLoBcZ4CR8gS05C/ciSogJrCq+QDiygWjKM9t2
 FOklTNb4xAbZTZ4ewX8fjrNlp78YjfHLXs8riJtd8oqAuTrzmY4TIJ6jF5k9TBbc3aIY
 /UDdFperMs+S/QKwSgLCpfkhLlX0W9Ffxuyu7s2kmblTREf5HSAIPHBhppKACEwe/xrw
 56YndklxES+b1ot8EDNkJuHbtWeAB/yIiB35gKFLtU3GWTGbw9o46T9sq4rEYwYQM1ye
 Uprg==
X-Gm-Message-State: APjAAAU2oCspqjF+cuZq/qaJSQG7gP58ZoD5qJv7UP++bGD1BxMnoXX4
 bLaZjkXZ+D5ReMO1Bui7A/tmQZph
X-Google-Smtp-Source: APXvYqzeB5YKRHak/Jh5rNv57dsgpfrVp8yafb74PZxOFf47a0dnv/GprC5y6iM1w9r6TVoSNqcsAw==
X-Received: by 2002:a05:660c:20a:: with SMTP id
 y10mr15540230itj.148.1560209355821; 
 Mon, 10 Jun 2019 16:29:15 -0700 (PDT)
Received: from bat.kanata.rendec.net
 (CPE00fc8d79db03-CM00fc8d79db00.cpe.net.fido.ca. [72.140.67.131])
 by smtp.gmail.com with ESMTPSA id z138sm488770itc.36.2019.06.10.16.29.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 10 Jun 2019 16:29:15 -0700 (PDT)
From: Radu Rendec <radu.rendec@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/1] PPC32: fix ptrace() access to FPU registers
Date: Mon, 10 Jun 2019 19:27:57 -0400
Message-Id: <20190610232758.19010-1-radu.rendec@gmail.com>
X-Mailer: git-send-email 2.20.1
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
Cc: Oleg Nesterov <oleg@redhat.com>, Radu Rendec <radu.rendec@gmail.com>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Everyone,

I'm following up on the ptrace() problem that I reported a few days ago.
I believe my version of the code handles all cases correctly. While the
problem essentially boils down to dividing the fpidx by 2 on PPC32, it
becomes tricky when the same code must work correctly on both PPC32 and
PPC64.

One other thing that I believe was handled incorrectly in the previous
version is the unused half of fpscr on PPC32. Note that while PT_FPSCR
is defined as (PT_FPR0 + 2*32 + 1), making only the upper half visible,
PT_FPR0 + 2*32 still corresponds to a possible address that userspace
can pass. In that case, comparing fpidx to (PT_FPSCR - PT_FPR0) would
cause an invalid access to the FPU registers array.

I tested the patch on 4.9.179, but that part of the code is identical in
recent kernels so it should work just the same.

I wrote a simple test program than can be used to quickly test (on an
x86_64 host) that all cases are handled correctly for both PPC32/PPC64.
The code is included below.

I also tested with gdbserver (test patch included below) and verified
that it generates two ptrace() calls for each FPU register, with
addresses between 0xc0 and 0x1bc.

8<--------------- Makefile ---------------------------------------------
.PHONY: all clean

all: ptrace-fpregs-32 ptrace-fpregs-64

ptrace-fpregs-32: ptrace-fpregs.c
	$(CC) -o ptrace-fpregs-32 -Wall -O2 -m32 ptrace-fpregs.c

ptrace-fpregs-64: ptrace-fpregs.c
	$(CC) -o ptrace-fpregs-64 -Wall -O2 ptrace-fpregs.c

clean:
	rm -f ptrace-fpregs-32 ptrace-fpregs-64
8<--------------- ptrace-fpregs.c --------------------------------------
#include <stdio.h>
#include <errno.h>

#define PT_FPR0	48

#ifndef __x86_64

#define PT_FPR31 (PT_FPR0 + 2*31)
#define PT_FPSCR (PT_FPR0 + 2*32 + 1)

#else

#define PT_FPSCR (PT_FPR0 + 32)

#endif

int test_access(unsigned long addr)
{
	int ret;

	do {
		unsigned long index, fpidx;

		ret = -EIO;

		/* convert to index and check */
		index = addr / sizeof(long);
		if ((addr & (sizeof(long) - 1)) || (index > PT_FPSCR))
			break;

		if (index < PT_FPR0) {
			ret = printf("ptrace_put_reg(%lu)", index);
			break;
		}

		ret = 0;
#ifndef __x86_64
		if (index == PT_FPSCR - 1) {
			/* corner case for PPC32; do nothing */
			printf("corner_case");
			break;
		}
#endif
		if (index == PT_FPSCR) {
			printf("fpscr");
			break;
		}

		/*
		 * FPR is always 64-bit; on PPC32, userspace does two 32-bit
		 * accesses. Add bit2 to allow accessing the upper half on
		 * 32-bit; on 64-bit, bit2 is always 0 (we validate it above).
		 */
		fpidx = (addr - PT_FPR0 * sizeof(long)) / 8;
		printf("TS_FPR[%lu] + %lu", fpidx, addr & 4);
		break;
	} while (0);

	return ret;
}

int main(void)
{
	unsigned long addr;
	int rc;

	for (addr = 0; addr < PT_FPSCR * sizeof(long) + 16; addr++) {
		printf("0x%04lx: ", addr);
		rc = test_access(addr);
		if (rc < 0)
			printf("!err!");
		printf("\t<%d>\n", rc);
	}

	return 0;
}
8<--------------- gdb.patch --------------------------------------------
--- gdb/gdbserver/linux-low.c.orig	2019-06-10 11:45:53.810882669 -0400
+++ gdb/gdbserver/linux-low.c	2019-06-10 11:49:32.272929766 -0400
@@ -4262,6 +4262,8 @@ store_register (struct regcache *regcach
   pid = lwpid_of (get_thread_lwp (current_inferior));
   for (i = 0; i < size; i += sizeof (PTRACE_XFER_TYPE))
     {
+      printf("writing register #%d offset %d at address %#x\n",
+             regno, i, (unsigned int)regaddr);
       errno = 0;
       ptrace (PTRACE_POKEUSER, pid,
 	    /* Coerce to a uintptr_t first to avoid potential gcc warning
8<----------------------------------------------------------------------

Radu Rendec (1):
  PPC32: fix ptrace() access to FPU registers

 arch/powerpc/kernel/ptrace.c | 85 ++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 33 deletions(-)

-- 
2.20.1

