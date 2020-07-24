Return-Path: <SRS0=CqhW=BD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFB2C433E8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 00:22:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43F7206E3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 00:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vha/kLm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43F7206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BCVJX51ClzDrfy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 10:22:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--morbo.bounces.google.com
 (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com;
 envelope-from=3uygaxwukdawy03n0s00sxq.o0yxuz6911o-pq7xu454.0bxmn4.03s@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=vha/kLm0; dkim-atps=neutral
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BCV9l0GlvzDrdf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2020 10:16:22 +1000 (AEST)
Received: by mail-yb1-xb4a.google.com with SMTP id n141so8354642yba.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2020 17:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=xDOq18BI5bjxxCx+oLv8deV3U12/TD8jTJOWQZI9A/0=;
 b=vha/kLm0EwSE9rQde40bTq1hKdK62on3/eSPpb+kodZkHHuCLBJAiesCE7Es1KLnj/
 V0YNXaaQp0phjxUGyDAmegNJurYuDbYVQOevpg0M4DQPzfNSLgf+wr8txaG9bPbEmq7L
 yvFuBUM2bF/bxYC55ySJ6cm0PEx6MfzZzbiRMXz1V10WGG7km5KHQdKInzB8IwMwAm2L
 uTCmnDqgDiUmlzg/RZaP7/y7CVstVgWOKzxlsxObUaZQPMCXyJBL6R5J1c0LNOFa9CS3
 c2SDTdKHInMiA6kkKjKZqoT2TjzIVshH4weK1DDhHA80KZKRGopdLODau+ZctvAmDd26
 YNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=xDOq18BI5bjxxCx+oLv8deV3U12/TD8jTJOWQZI9A/0=;
 b=eU6uinDgJa/fQ8rtRvceWQverG0POgwZtDA/RTihUPUhqjFJryYyiGsSftFt58arU6
 DWZLjgFvhIu8b24ZOxAaZ7gs1NPsf1qXcMxFhdjolISRSEkWBiWa6rIWuV9xSY/KlFva
 TFTrbAbpekQJOWzaNPRMI09AW6k36TxlLBTWkgFreIeriQ3g/TTl7lgap60IcjytSZc3
 mP1mVwlzHojYVoc1u+2tInyBXDVY1R0vf8mA3mdLYs8y1GLlKNtgRlKN6CRyYgZQXLi5
 CMtFsIKoWHSdtFuxJgBZMZj8fUCVu5liAmqMoj8Cjc7jeDH9DcBm06y5zi1GFYH4ARzo
 P5/Q==
X-Gm-Message-State: AOAM530Mdp4cXl7IVT/crmopiZz2QSxY6/wBIu7qX29VoGfmQJGAupfO
 725bEL5tHAvYGQzyRSPzoPGyX9+N
X-Google-Smtp-Source: ABdhPJwdfMgsfDu6ZXkM8HzQ3uRW+I49HBzT5CNSM9cqnDum/LM4JiqKeYmaKSvmjqHIwrlzLvZ4yMjWLg==
X-Received: by 2002:a25:9843:: with SMTP id k3mr10455799ybo.292.1595549779096; 
 Thu, 23 Jul 2020 17:16:19 -0700 (PDT)
Date: Thu, 23 Jul 2020 17:16:05 -0700
Message-Id: <20200724001605.3718561-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v 1/1] powerpc/64s: allow for clang's objdump differences
From: Bill Wendling <morbo@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 24 Jul 2020 10:20:37 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, Bill Wendling <morbo@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Clang's objdump emits slightly different output from GNU's objdump,
causing a list of warnings to be emitted during relocatable builds.
E.g., clang's objdump emits this:

   c000000000000004: 2c 00 00 48  b  0xc000000000000030
   ...
   c000000000005c6c: 10 00 82 40  bf 2, 0xc000000000005c7c

while GNU objdump emits:

   c000000000000004: 2c 00 00 48  b    c000000000000030 <__start+0x30>
   ...
   c000000000005c6c: 10 00 82 40  bne  c000000000005c7c <masked_interrupt+0x3c>

Adjust llvm-objdump's output to remove the extraneous '0x' and convert
'bf' and 'bt' to 'bne' and 'beq' resp. to more closely match GNU
objdump's output.

Note that clang's objdump doesn't yet output the relocation symbols on
PPC.

Signed-off-by: Bill Wendling <morbo@google.com>
---
 arch/powerpc/tools/unrel_branch_check.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/tools/unrel_branch_check.sh b/arch/powerpc/tools/unrel_branch_check.sh
index 77114755dc6f..71ce86b68d18 100755
--- a/arch/powerpc/tools/unrel_branch_check.sh
+++ b/arch/powerpc/tools/unrel_branch_check.sh
@@ -31,6 +31,9 @@ grep -e "^c[0-9a-f]*:[[:space:]]*\([0-9a-f][0-9a-f][[:space:]]\)\{4\}[[:space:]]
 grep -v '\<__start_initialization_multiplatform>' |
 grep -v -e 'b.\?.\?ctr' |
 grep -v -e 'b.\?.\?lr' |
+sed 's/\bbt.\?[[:space:]]*[[:digit:]][[:digit:]]*,/beq/' |
+sed 's/\bbf.\?[[:space:]]*[[:digit:]][[:digit:]]*,/bne/' |
+sed 's/[[:space:]]0x/ /' |
 sed 's/://' |
 awk '{ print $1 ":" $6 ":0x" $7 ":" $8 " "}'
 )
