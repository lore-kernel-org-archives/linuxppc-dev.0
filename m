Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925D9C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 10:06:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2F822419
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 10:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUZt+y2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2F822419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42w0Wk5lPkzF3ZZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 21:06:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kUZt+y2F";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="kUZt+y2F"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42w0Sm1LyJzF3S2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 21:03:48 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id x2-v6so7654686pfm.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 02:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=6xSUduzYKVvcq6cKNxLgEZlOBjfKb9+Sl/B0AVBfewM=;
 b=kUZt+y2F4HCJ1gdP5ksaWADRNQR3bwh5UXsvOksbzStyAnQxEtkYqcrZf/0ZQ7lAjk
 0rRKG5HvZbqa3jUip5uZQKQZc+waBzUqUw4k+nv4s8FlJ3k+jpWHGT2bRbNTq4lzqMOo
 UrByBjnFBLWEKSiUhDPD1Dyi4SIZyN6uxQiB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6xSUduzYKVvcq6cKNxLgEZlOBjfKb9+Sl/B0AVBfewM=;
 b=Y1u0s2G6SAmx84HO8WlA32XPDs6qrqtn+MWfl13bnujS6135s2sv5lqqSLnMnqANmQ
 DxXCV0S5wQqpcY1foKLW0zaYD3vtKfPec2IfC1zKt6AHB7v10ESAT1gHDKIdz4KpdJLy
 DttP4lsFYUND4NW7hSHLBt7fx1JW4P4aSj3+keHR1YYZTSIc++qygiMlqqj9glKDKNrA
 QuX2LMHX6ASDnmGLlXP6DfMXSwTR2/ikpEIt5FW5KPRZFndynttyv+6Kcub5Yw4cuox+
 VOoacR7F/L6SdcHmPGoflpBpHZXSp6Dy8H0EwxL39qUz05FIW/9MkTzfyIZkM5sy3QtH
 Zx3Q==
X-Gm-Message-State: AGRZ1gKnPNeoJRn8Fz8Li/kTqszxy0xklYFAcQdztK+VvozOhecEb+hQ
 QW9f6F4BkeKJKZ6Bfo4QbvmG2A==
X-Google-Smtp-Source: AJdET5eW5H8R9aWNqk+6t3OR1fmogCNSbaFCW8JfFB0rj0pQVznTeaKdkLF6j+6zF12dj8UjMTMFOQ==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr1177088pgv.438.1542189826546; 
 Wed, 14 Nov 2018 02:03:46 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id g15sm21633873pfj.131.2018.11.14.02.03.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 14 Nov 2018 02:03:45 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, Ram Pai <linuxram@us.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH v2 0/4] powerpc: system call table generation support
Date: Wed, 14 Nov 2018 15:33:14 +0530
Message-Id: <1542189798-27713-1-git-send-email-firoz.khan@linaro.org>
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
	- Compat entry name.
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

Changes since v1:
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
 arch/powerpc/include/asm/systbl.h           | 396 ---------------------------
 arch/powerpc/include/asm/unistd.h           |   3 +-
 arch/powerpc/include/uapi/asm/Kbuild        |   2 +
 arch/powerpc/include/uapi/asm/unistd.h      | 389 +-------------------------
 arch/powerpc/kernel/Makefile                |  10 -
 arch/powerpc/kernel/syscalls/Makefile       |  61 +++++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 408 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/syscalls/syscallhdr.sh  |  36 +++
 arch/powerpc/kernel/syscalls/syscalltbl.sh  |  41 +++
 arch/powerpc/kernel/systbl.S                |  37 +--
 arch/powerpc/kernel/systbl_chk.c            |  60 ----
 arch/powerpc/platforms/cell/spu_callbacks.c |  17 +-
 14 files changed, 575 insertions(+), 892 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/systbl.h
 create mode 100644 arch/powerpc/kernel/syscalls/Makefile
 create mode 100644 arch/powerpc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/powerpc/kernel/systbl_chk.c

-- 
1.9.1

