Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771E8C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 09:07:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20C720873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 09:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlX7SFDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20C720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Fnr05f52zDqtd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 20:07:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YlX7SFDR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="YlX7SFDR"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Fnmc0JH7zDqdn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 20:04:15 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id t13so739092pgr.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 01:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=kx/v8SQuOHTsbh88Np6JyLP5jvdQm+NuUr90LMrVo8w=;
 b=YlX7SFDR9cj48oXpkjb8Bukgm61kV0HMDsIsI4L2Fb30Z0FvEYwl1mrFzqFvQdKKcc
 QSxW5pVMOBhw92lu0Fa3ZeOlrDWnL1qDZ1KFyow881D/srcc1bwF1RTcGwwK12ODmONw
 zFj7rrVQnO1zMzeeuohiRLjr0zbm3VRnnJftk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=kx/v8SQuOHTsbh88Np6JyLP5jvdQm+NuUr90LMrVo8w=;
 b=EnBsd7CAt2TO0uUZyApkXqZoOQlxHrRZIQlNZQdrGyxviMKYWZP+kgrruL8+9/wMF7
 vKdP3bN9mZlmiB5lFJhX68IPyB7cl+E2Gp9mOmC91v3Fxidc16o+U/sR0REGSehikQd7
 p7guf+R3s+zCkCp4o0kSIFHtElGOEY9fAOaEkDrel/kTKWDrPmZz2uClcC3On11JDrmh
 XErm/xLUGhmylkM2opA6Rm6NT1EEHs8VDwEfjPZ+3YpeZfYJP9wvKDqTPM9B1FPpXAof
 n3oZKHuZTy8YTX8JsMUSEWpnP+WMEUvsZhAoltCohLXWuuXKsy5B3O1zcZo0xwbNgrhi
 Vtjw==
X-Gm-Message-State: AA+aEWYjG7MagKCCwM1oA8pt0dGSDZgoqPzUNOV7DtxvgOliMFZ46Zm7
 b12/tZrGYBcsKVYJ12OmOxXDnoSOwoI=
X-Google-Smtp-Source: AFSGD/XUa3MDhpCNsjqrFCGouyWgWVa8l1cO2bNkMJVwhoosGiP1NCR5LgAROIywliqJWNy2/j9hSA==
X-Received: by 2002:a62:f907:: with SMTP id o7mr22862310pfh.244.1544691853295; 
 Thu, 13 Dec 2018 01:04:13 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id s9sm1888305pgl.88.2018.12.13.01.04.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 13 Dec 2018 01:04:12 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Ram Pai <linuxram@us.ibm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun.feng@gmail.com>, Breno Leitao <leitao@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH v5 0/5] powerpc: system call table generation support
Date: Thu, 13 Dec 2018 14:32:45 +0530
Message-Id: <1544691770-8938-1-git-send-email-firoz.khan@linaro.org>
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

Changes since v4:
 - DOTSYM macro removed for ppc32, which was causing
   the compilation error.

Changes since v3:
 - split compat syscall table out from native table.
 - modified the script to add new line in the generated
   file.

Changes since v2:
 - modified/optimized the syscall.tbl to avoid duplicate
   for the spu entries.
 - updated the syscalltbl.sh to meet the above point.

Changes since v1:
 - optimized/updated the syscall table generation 
   scripts.
 - fixed all mixed indentation issues in syscall.tbl.
 - added "comments" in syscall_*.tbl.
 - changed from generic-y to generated-y in Kbuild.

Firoz Khan (5):
  powerpc: add __NR_syscalls along with NR_syscalls
  powerpc: move macro definition from asm/systbl.h
  powerpc: add system call table generation support
  powerpc: split compat syscall table out from native table
  powerpc: generate uapi header and system call table files

 arch/powerpc/Makefile                       |   3 +
 arch/powerpc/include/asm/Kbuild             |   4 +
 arch/powerpc/include/asm/syscall.h          |   3 +-
 arch/powerpc/include/asm/systbl.h           | 396 --------------------------
 arch/powerpc/include/asm/unistd.h           |   3 +-
 arch/powerpc/include/uapi/asm/Kbuild        |   2 +
 arch/powerpc/include/uapi/asm/unistd.h      | 389 +------------------------
 arch/powerpc/kernel/Makefile                |  10 -
 arch/powerpc/kernel/entry_64.S              |   7 +-
 arch/powerpc/kernel/syscalls/Makefile       |  63 ++++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 427 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
 arch/powerpc/kernel/syscalls/syscalltbl.sh  |  36 +++
 arch/powerpc/kernel/systbl.S                |  40 ++-
 arch/powerpc/kernel/systbl_chk.c            |  60 ----
 arch/powerpc/kernel/vdso.c                  |   7 +-
 arch/powerpc/platforms/cell/spu_callbacks.c |  17 +-
 17 files changed, 606 insertions(+), 898 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/systbl.h
 create mode 100644 arch/powerpc/kernel/syscalls/Makefile
 create mode 100644 arch/powerpc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/powerpc/kernel/systbl_chk.c

-- 
1.9.1

