Return-Path: <SRS0=BVGK=CV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA97DC433E2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2020 11:15:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14FA20855
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2020 11:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lxbnERcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14FA20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BpVQk0hjYzDqw1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Sep 2020 21:15:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=keescook@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lxbnERcX; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BpVH04DlVzDqsv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2020 21:08:27 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id 34so8185416pgo.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2020 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qryMAhh4tCU77jVApdDoFb63yM4c6k01SDqhkwf1rR0=;
 b=lxbnERcXy+J7vWuyRLux24/YF+Scq3YZcjre8kUbR0Fvb4JjXcrDpAuJYIbx0s7Szo
 SCpNE6vcqS6SkUKkfyeHCdjQFgyVa/JW4qT/hBTp7+60WwtB92PGYsy/s6InhaUg0Iqd
 e7QE5NCl5CYO9aCTFnXI0PCpQSxqRvyp3aSGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qryMAhh4tCU77jVApdDoFb63yM4c6k01SDqhkwf1rR0=;
 b=FXRNrKBejy0PzqKUz/F402f8YBPNUXP6HrMoJhPwulR+Kkbv5BoK6xsYGaTA+M7o3c
 avbyFLREOw15EGA9sgVNJUtENCIowNL7QdA0Cnuyi13huVLX3HeZA8I18epbSp2143xH
 ILJbRpCZkOyqy5xJ8h67yl2E+SrfGwjHQyCl13nxwXonEXidlb/IZyQzEsxLPffzKhcz
 Ni7+KNRNgKLNMiEElVPE2x9jb/KPGZAojJSft0n+uWOg1YWeUTI9j3pNSoR6gyOJB5Wu
 xNTPpbLeYQA6KXc+iskLJ4VHhYNh6AyqQW4UTHqgC7iDXw+r6b8v/NRt5nGs+dNeaCga
 a7JQ==
X-Gm-Message-State: AOAM530BXQEBKSFQFFBxKxQnQseMWILB3j3a6paP2I1My4xzr4FNu4MZ
 qVYkzWtfZqze1LNqor0hI2jeaw==
X-Google-Smtp-Source: ABdhPJyZOtkAmn+q/X44Pwpnmi6XqAZyxaYzw+q4IoaZx/a0QbSZc5nYuFdBvbPz0fB5B+xl5qPKPA==
X-Received: by 2002:a63:2f43:: with SMTP id v64mr416632pgv.69.1599908904499;
 Sat, 12 Sep 2020 04:08:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id s9sm3964920pgm.40.2020.09.12.04.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 04:08:23 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] selftests/seccomp: Refactor change_syscall()
Date: Sat, 12 Sep 2020 04:08:05 -0700
Message-Id: <20200912110820.597135-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
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
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
 Will Drewry <wad@chromium.org>, Kees Cook <keescook@chromium.org>,
 linux-xtensa@linux-xtensa.org, linux-mips@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Christian Brauner <christian@brauner.io>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

This refactors the seccomp selftest macros used in change_syscall(),
in an effort to remove special cases for mips, arm, arm64, and xtensa,
which paves the way for powerpc fixes.

I'm not entirely done testing, but all-arch build tests and x86_64
selftests pass. I'll be doing arm, arm64, and i386 selftests shortly,
but I currently don't have an easy way to check xtensa, mips, nor
powerpc. Any help there would be appreciated!

(FWIW, I expect to take these via the seccomp tree.)

Thanks,

-Kees


Kees Cook (15):
  selftests/seccomp: Refactor arch register macros to avoid xtensa
    special case
  selftests/seccomp: Provide generic syscall setting macro
  selftests/seccomp: mips: Define SYSCALL_NUM_SET macro
  selftests/seccomp: arm: Define SYSCALL_NUM_SET macro
  selftests/seccomp: arm64: Define SYSCALL_NUM_SET macro
  selftests/seccomp: mips: Remove O32-specific macro
  selftests/seccomp: Remove syscall setting #ifdefs
  selftests/seccomp: Convert HAVE_GETREG into ARCH_GETREG/ARCH_SETREG
  selftests/seccomp: Convert REGSET calls into ARCH_GETREG/ARCH_SETREG
  selftests/seccomp: Avoid redundant register flushes
  selftests/seccomp: Remove SYSCALL_NUM_RET_SHARE_REG in favor of
    SYSCALL_RET_SET
  selftests/seccomp: powerpc: Fix seccomp return value testing
  selftests/seccomp: powerpc: Set syscall return during ptrace syscall
    exit
  selftests/clone3: Avoid OS-defined clone_args
  selftests/seccomp: Use __NR_mknodat instead of __NR_mknod

 .../selftests/clone3/clone3_selftests.h       |  16 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 313 ++++++++++--------
 2 files changed, 184 insertions(+), 145 deletions(-)

-- 
2.25.1

