Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AE2C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 04:30:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BFE2081B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 04:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e70ic9Am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BFE2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4354MY0qJwzDr2d
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 15:30:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e70ic9Am";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="e70ic9Am"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4354J93WR7zDr24
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 15:27:52 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id 64so368844pfr.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 20:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=glFocJvmDJt9uBXTAlN3W1kgDT/Asdeikb/chKzP/Sg=;
 b=e70ic9AmD8LODVYoWeStMH4rZBNOYEAuj3SsrJ4iV4hyy2s6arxoQ6xmbg2nqwj6jD
 YOgB53KZi/5qAkdTge7x7OrKSIWO9y34VINfaMIquK0+b/56hVc+2QFRQJRwVQO7ZCtQ
 RY0xnRqcdnvMtWkzYjxIE/Ls/oAlBUBhrn8MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=glFocJvmDJt9uBXTAlN3W1kgDT/Asdeikb/chKzP/Sg=;
 b=UQInUkGU0yH8VnZQtz3ioXGpzMadDsUeAemzVjZHYL8qVps8yB2wWkNN2wHYbwsSj2
 7yz7HViRW8hdcXpAOp0MXP3HucH8XznKg7i/VIQuOE2FETHRamLygtSIOu+tL/4ohTs2
 LnL0SrqhpV55VFtclrj38no1Yk4yf1aubckZkE1reiK/wwf6UYf7dpUTjT/pdJkaiuao
 tQwH1fbAZCYC1pmCxdiZYHm/kFb+oLSYjarwmp9UBM7LzFV63Mm3cVF506xQU37eZZ9Z
 n9HDiFr0Dhf22u+UIWy48lJAKuFLkHNEBvIUKnkSbfQt1ujObf3cEnz+LHk0Pt58oe8Z
 6hbw==
X-Gm-Message-State: AGRZ1gLkwp0IkHjM5CaiUiV/8OADPL2aU+bkVf8ArXAZ9TapGL+DIOcc
 MCR0SbQfvGkNwQ4hOGE0E6MsN2+tCJY=
X-Google-Smtp-Source: AJdET5dbaKNc8fvJXS775I4BncW88LTEtgaGkPLncAlNGvBE/jT9FYEM7K8F73jxawJZB3RFFvdT4w==
X-Received: by 2002:a62:47d9:: with SMTP id p86mr39509518pfi.95.1543465670694; 
 Wed, 28 Nov 2018 20:27:50 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id p2sm770473pfb.28.2018.11.28.20.27.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 28 Nov 2018 20:27:50 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Ram Pai <linuxram@us.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH v3 0/4] powerpc: system call table generation support
Date: Thu, 29 Nov 2018 09:56:47 +0530
Message-Id: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
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
Cc: linux-arch@vger.kernel.org, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
 firoz.khan@linaro.org, deepa.kernel@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The purpose of this patch series is, we can easily
add/modify/delete system call table support by cha-
nging entry in syscall.tbl file instead of manually
changing many files. The other goal is to unify the 
system call table generation support implementation 
across all the architectures. 

The system call tables are in different format in 
all architecture. It will be difficult to manually
add, modify or delete the system calls in the resp-
ective files manually. To make it easy by keeping a 
script and which'll generate uapi header file and 
syscall table file.

syscall.tbl contains the list of available system 
calls along with system call number and correspond-
ing entry point. Add a new system call in this arch-
itecture will be possible by adding new entry in 
the syscall.tbl file.

Adding a new table entry consisting of:
        - System call number.
        - ABI.
        - System call name.
        - Entry point name.
	- Compat entry name, if required.
	- spu entry name, if required.

ARM, s390 and x86 architecuture does exist the sim-
ilar support. I leverage their implementation to 
come up with a generic solution.

I have done the same support for work for alpha, 
ia64, m68k, microblaze, mips, parisc, sh, sparc, 
and xtensa. Below mentioned git repository contains
more details about the workflow.

https://github.com/frzkhn/system_call_table_generator/

Finally, this is the ground work to solve the Y2038
issue. We need to add two dozen of system calls to 
solve Y2038 issue. So this patch series will help to
add new system calls easily by adding new entry in the
syscall.tbl.

changes since v2:
 - modified/optimized the syscall.tbl to avoid duplicate
   for the spu entries.
 - updated the syscalltbl.sh to meet the above point.

changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall_*.tbl.
 - changed from generic-y to generated-y in Kbuild.

Firoz Khan (4):
  powerpc: add __NR_syscalls along with NR_syscalls
  powerpc: move macro definition from asm/systbl.h
  powerpc: add system call table generation support
  powerpc: generate uapi header and system call table files

 arch/powerpc/Makefile                       |   3 +
 arch/powerpc/include/asm/Kbuild             |   4 +
 arch/powerpc/include/asm/systbl.h           | 396 --------------------------
 arch/powerpc/include/asm/unistd.h           |   3 +-
 arch/powerpc/include/uapi/asm/Kbuild        |   2 +
 arch/powerpc/include/uapi/asm/unistd.h      | 389 +------------------------
 arch/powerpc/kernel/Makefile                |  10 -
 arch/powerpc/kernel/syscalls/Makefile       |  63 ++++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 427 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/syscalls/syscallhdr.sh  |  36 +++
 arch/powerpc/kernel/syscalls/syscalltbl.sh  |  36 +++
 arch/powerpc/kernel/systbl.S                |  37 +--
 arch/powerpc/kernel/systbl_chk.c            |  60 ----
 arch/powerpc/platforms/cell/spu_callbacks.c |  17 +-
 14 files changed, 591 insertions(+), 892 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/systbl.h
 create mode 100644 arch/powerpc/kernel/syscalls/Makefile
 create mode 100644 arch/powerpc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/powerpc/kernel/systbl_chk.c

-- 
1.9.1

