Return-Path: <SRS0=kIvJ=ER=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D68DC56201
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 13:40:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6DA2065C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 13:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJSxGfIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6DA2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CWQq30YzmzDqpv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 00:40:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::841;
 helo=mail-qt1-x841.google.com; envelope-from=zhuyifei1999@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=YJSxGfIb; dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CWQgx2P7YzDqSP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2020 00:34:35 +1100 (AEDT)
Received: by mail-qt1-x841.google.com with SMTP id p12so1232624qtp.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2020 05:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ADY2JmYxE9Xly9S24Z1LRnTUA3RyY71p6BFzajWHuao=;
 b=YJSxGfIbb1UUIY/29x8l4T1Jgc/yvQs31iNrz+gq8lShwrVPuHybhNR6GJR2b7ujTh
 QXkNda2M3eSKkjAcLLD3C+040OUac/TeqxIQ4kKWh1L61WubktOhPd4WOSZc7To8b+sR
 jcvHPDdLofNDeZQFZI6zTyzwiTZI58E4j7EHZSBLV1AVXppIZtxsLNOxs1YSHzxtaIyi
 /8HpFYA+y+MUg78ZtzBB1bfvaT8TL/NlfNctAizFSHUGW5eGeI6PDGrklFXYAAJQKgEB
 E8onifEyVUdSHl7UZUr5Lsm3j3fv9Fv5friHKntdo5FtOXwpCVL7DFWbsNCOMCfZLyYf
 O7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ADY2JmYxE9Xly9S24Z1LRnTUA3RyY71p6BFzajWHuao=;
 b=Yo+eQMEXlJ+sL9kDFraHa73yWKcqP/Ory3haBJe/pbwDnEP6XLkSL3jkNpnPX84/6R
 Cbpm8y0P+W3T3hfYo5PM3FdPH61wi+H/ZF2HBbFVUU4oje1DlZDCmdiUhgOR23saD1ln
 0C0bD9s5DbOB3EASbNhudsuHjSVlO/Ygto9eKu6ngcVgg4gKNe7mFVKEv9y4ssfoFEON
 cY8h7V/D+QXjwn6KY4xrEPlQ2KMPLPvtzFLxR8BskSGIVdFP4387Mozg2KMMB+DXHcLz
 Eg4h8wQQgoaPIjEiHu0uhXyBvwRXrxLnSYBYBGuZ/0XSH0wa8n+VlOkPla1MSQrzrYEs
 vEgA==
X-Gm-Message-State: AOAM5307oP7MIRyTHNeDI3uRFiD9EbHmqcUJTfz2ChYbxf2Hh9IPtSDW
 VKcV6ZO1jPuxwQ2Gt+Us3ao=
X-Google-Smtp-Source: ABdhPJzHUfo2j/Nsf18vB+1vJm4vfXG7t/Ethu+Cj5/ykTWucn6CwriV6xUlfxlPz1n756bgw31C9g==
X-Received: by 2002:ac8:130d:: with SMTP id e13mr23000296qtj.3.1605101669342; 
 Wed, 11 Nov 2020 05:34:29 -0800 (PST)
Received: from localhost.localdomain
 (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
 by smtp.gmail.com with ESMTPSA id r190sm1997814qkf.101.2020.11.11.05.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 05:34:28 -0800 (PST)
From: YiFei Zhu <zhuyifei1999@gmail.com>
To: containers@lists.linux-foundation.org
Subject: [PATCH seccomp v2 0/8] seccomp: add bitmap cache support on remaining
 arches and report cache in procfs
Date: Wed, 11 Nov 2020 07:33:46 -0600
Message-Id: <cover.1605101222.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.29.2
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
Cc: linux-sh@vger.kernel.org, Tobin Feldman-Fitzthum <tobin@ibm.com>,
 Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>,
 linux-riscv@lists.infradead.org, Andrea Arcangeli <aarcange@redhat.com>,
 linux-s390@vger.kernel.org, YiFei Zhu <yifeifz2@illinois.edu>,
 linux-csky@vger.kernel.org, Tianyin Xu <tyxu@illinois.edu>,
 linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, Valentin Rothberg <vrothber@redhat.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Josep Torrellas <torrella@illinois.edu>,
 Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
 David Laight <David.Laight@aculab.com>,
 Giuseppe Scrivano <gscrivan@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Tycho Andersen <tycho@tycho.pizza>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: YiFei Zhu <yifeifz2@illinois.edu>

This patch series enables bitmap cache for the remaining arches with
SECCOMP_FILTER, other than MIPS.

I was unable to find any of the arches having subarch-specific NR_syscalls
macros, so generic NR_syscalls is used. SH's syscall_get_arch seems to
only have the 32-bit subarch implementation. I'm not sure if this is
expected.

This series has not been tested; I have not built all the cross compilers
necessary to build test, let alone run the kernel or benchmark the
performance, so help on making sure the bitmap cache works as expected
(selftests/seccomp/{seccomp_benchmark,seccomp_bpf}) would be appreciated.
The series applies on top of Kees's for-next/seccomp branch.

v1 -> v2:
* ppc, sh: s/__SECCOMP_ARCH_LE_BIT/__SECCOMP_ARCH_LE/
* ppc: add "le" suffix to arch name when the arch is little endian.
* ppc: add explanation of why __LITTLE_ENDIAN__ is used to commit message.

YiFei Zhu (8):
  csky: Enable seccomp architecture tracking
  parisc: Enable seccomp architecture tracking
  powerpc: Enable seccomp architecture tracking
  riscv: Enable seccomp architecture tracking
  s390: Enable seccomp architecture tracking
  sh: Enable seccomp architecture tracking
  xtensa: Enable seccomp architecture tracking
  seccomp/cache: Report cache data through /proc/pid/seccomp_cache

 arch/Kconfig                       | 15 ++++++++
 arch/csky/include/asm/Kbuild       |  1 -
 arch/csky/include/asm/seccomp.h    | 11 ++++++
 arch/parisc/include/asm/Kbuild     |  1 -
 arch/parisc/include/asm/seccomp.h  | 22 +++++++++++
 arch/powerpc/include/asm/seccomp.h | 23 ++++++++++++
 arch/riscv/include/asm/seccomp.h   | 10 +++++
 arch/s390/include/asm/seccomp.h    |  9 +++++
 arch/sh/include/asm/seccomp.h      | 10 +++++
 arch/xtensa/include/asm/Kbuild     |  1 -
 arch/xtensa/include/asm/seccomp.h  | 11 ++++++
 fs/proc/base.c                     |  6 +++
 include/linux/seccomp.h            |  7 ++++
 kernel/seccomp.c                   | 59 ++++++++++++++++++++++++++++++
 14 files changed, 183 insertions(+), 3 deletions(-)
 create mode 100644 arch/csky/include/asm/seccomp.h
 create mode 100644 arch/parisc/include/asm/seccomp.h
 create mode 100644 arch/xtensa/include/asm/seccomp.h


base-commit: 38c37e8fd3d2590c4234d8cfbc22158362f0eb04
--
2.29.2
