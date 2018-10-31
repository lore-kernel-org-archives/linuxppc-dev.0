Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B9DC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 12:36:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CECD420685
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 12:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPb+Z7nC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECD420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lSWL6RywzF3GG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 23:36:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OPb+Z7nC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OPb+Z7nC"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lSQT3BrCzF1pS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 23:32:17 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id s10-v6so14939558wmc.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 05:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=WgHkHlKH5h23Lr+mABtPK0cTX37CfKxS8tJSHtuvTgU=;
 b=OPb+Z7nC1bds8q6XTLEpUH8R3d7sSdK1ZoHBkVXN4fq3n0yPCB57hZONT7M0I+9H9S
 AyOC6E/S+3TKPjgSAyE3/Xk8RBzyxdBdtFFzypUx18EWM7hYGEYYcb4B0mRIW170Qt5f
 qf9HesTCPjTbDXfYCqh2lP/XGc+FLDfKwmSrvDb1lxUJUtJLk8+c8Y33bdghVIrNakPq
 Cwcwsn3rfDSnqO1rSo2mFe3AgGQFKGCmNm9PSFbKddWJCJEdSN+hipL+JUafWKaV9PMB
 ww4IDeT9E0TkRb1TAVbwQQNUNmM8xPFwWjM1MSAw9SbeE+4IuYJquGe1fYpIY5WVTU2x
 OHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=WgHkHlKH5h23Lr+mABtPK0cTX37CfKxS8tJSHtuvTgU=;
 b=bThCrnh9CwVncyYNm3KbYH9kSEBOZf1Ln0a0WzecvEebfXuoMir0gOD2zJvV2G4/dl
 grib7rUXMafCbCY86itUEUaeJek8oaD4ss8MDzE85cf0cxdKi42+q989bpQ4+LXuU5WP
 dPQ/RH5odmhIsT4z5INYPYAKw0qCe214FoGi4dgKoiBNUuyw338TUL47GBjYzAdvoDkH
 I55iNwLYHrzqV84puG7Ef8PdmCYJumCReV7Rkdu0VT+10TfCJC9A7XrC9af3Rvr5tktM
 pWoRZSIRynYsnyEH/l9qwj7GTSE1BmJ6B3ge3iNjaIS/i+tYp3tLGIe8OpbkU/6/Drj2
 HIFA==
X-Gm-Message-State: AGRZ1gIlUFUx1N/o8JJdOR31h0Fh0t/4t4aIlj3Atl8sAsHZwuoSWWlV
 E+Xa5k0Zi7qZbkuiWusHeu0=
X-Google-Smtp-Source: AJdET5fh+LKAmHufCXnnBYzzusrl7/Jg3ns1oFwjgqrqw353cRrnremPG2q6tATkA6aiRVG1BYP/Kw==
X-Received: by 2002:a1c:1694:: with SMTP id
 142-v6mr2288120wmw.113.1540989132627; 
 Wed, 31 Oct 2018 05:32:12 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id v11-v6sm17398781wrw.3.2018.10.31.05.32.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 31 Oct 2018 05:32:11 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 4DEAE1142338; Wed, 31 Oct 2018 13:32:10 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/32: Add .data..Lubsan_data*/.data..Lubsan_type*
 sections explicitly
Date: Wed, 31 Oct 2018 13:31:56 +0100
Message-Id: <20181031123157.24947-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
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
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When both `CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y` and `CONFIG_UBSAN=y`
are set, link step typically produce numberous warnings about orphan
section:

  + powerpc-linux-gnu-ld -EB -m elf32ppc -Bstatic --orphan-handling=warn --build-id --gc-sections -X -o .tmp_vmlinux1 -T ./arch/powerpc/kernel/vmlinux.lds --who
  le-archive built-in.a --no-whole-archive --start-group lib/lib.a --end-group
  powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data393' from `init/main.o' being placed in section `.data..Lubsan_data393'.
  powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data394' from `init/main.o' being placed in section `.data..Lubsan_data394'.
  ...
  powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_type11' from `init/main.o' being placed in section `.data..Lubsan_type11'.
  powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_type12' from `init/main.o' being placed in section `.data..Lubsan_type12'.
  ...

This commit remove those warnings produced at W=1.

Link: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg135407.html
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 434581bcd5b4..1148c3c60c3b 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -308,6 +308,10 @@ SECTIONS
 #ifdef CONFIG_PPC32
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
+#ifdef CONFIG_UBSAN
+		*(.data..Lubsan_data*)
+		*(.data..Lubsan_type*)
+#endif
 		*(.data.rel*)
 		*(SDATA_MAIN)
 		*(.sdata2)
-- 
2.11.0

