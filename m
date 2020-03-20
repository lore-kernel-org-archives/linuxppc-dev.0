Return-Path: <SRS0=DNDs=5F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05234C4332B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 05:20:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C59A20722
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 05:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djG4c/Rh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C59A20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kBtq3n6HzDrTy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 16:20:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=djG4c/Rh; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kBrp3VKGzDrQk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2020 16:18:49 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id 37so2472437pgm.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2020 22:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=j7gFp1OWKWE7+ZzhdXAjLVU/j2jmAeCatX7NgSk4mOM=;
 b=djG4c/Rh3RoUzp9dIkcJcoxosUGH1FQWDfXzxfmeErYC7yK5A52bvm/TNMumKXHZnZ
 fq4dSHQqzVVtsXU30q6x1iLIWNE2dkdZTT/ygBskVJKlwXiH2F94T4KCRP3jLjBNJKmn
 hFty7PaviJKFr+TP4YHq++I6JjjMEjQvrg5JCHpgXdN45kKDtqHxCSqNdbSbctkckR22
 UGRF1jAjFXCp7Jn1SelXYAz+VPeBncnU09EqgRInHAF5lBnq3eOzPS/Jioq1kBBaW13E
 zpcHl7uHKrqtC8DEJRm7hivYswoolHqToSsROfR+FtRA5tsL31k2pNUptob9ehxhk5sz
 hNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=j7gFp1OWKWE7+ZzhdXAjLVU/j2jmAeCatX7NgSk4mOM=;
 b=ClibQnYV/UxendxWK892F6UGfPy4c6w1TPwS/knE+kJarvyJ16RX5Ei64Hs0GH7aWn
 96TA4DpWd/j8A/Zps9oVsY9cYYzrlaS5fhALd6Fgkgc+Fy/enIAm1ckWEO6wv4Tm4DSh
 AHWp0HKOOG6Tu0NNHJU2/kU8hQFZNJgFRj9G1S91bR9km90AVXv/RS8edWYt36RFt0re
 5lOEprY4pgkIItCSO3qCcok9bkeeC/1yyDnQMAxrL6L+TDKah7yNJn04V0vQejGRdf3P
 Sf0aR6n1qiJpfLetTOHP26NdqshWzC0B+dmV61Ie8LOaa8PuGDYqbhijjju8ad3Dea74
 +n/g==
X-Gm-Message-State: ANhLgQ1orv3iG5YZnizt/u/toe25/TCdUj1aTxBoodHi14wCg9bkQ/Uq
 w+412+4wDrYAchMcrIN2mvvzg4NBH4o=
X-Google-Smtp-Source: ADFU+vv3XS3WUm79GmwTH5dfhoTRdOs7PLvs9axkE0VEB4h0yAHAqxiaIMfIi1lbtHWxL0/yd14VZg==
X-Received: by 2002:aa7:8806:: with SMTP id c6mr7296336pfo.175.1584681527797; 
 Thu, 19 Mar 2020 22:18:47 -0700 (PDT)
Received: from localhost.localdomain
 (180-150-65-4.b49641.syd.nbn.aussiebb.net. [180.150.65.4])
 by smtp.gmail.com with ESMTPSA id c207sm3988716pfb.47.2020.03.19.22.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 22:18:47 -0700 (PDT)
From: Jordan Niethe <jniethe5@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 00/16] Initial Prefixed Instruction support
Date: Fri, 20 Mar 2020 16:17:53 +1100
Message-Id: <20200320051809.24332-1-jniethe5@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: alistair@popple.id.au, npiggin@gmail.com, bala24@linux.ibm.com,
 Jordan Niethe <jniethe5@gmail.com>, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A future revision of the ISA will introduce prefixed instructions. A
prefixed instruction is composed of a 4-byte prefix followed by a
4-byte suffix.

All prefixes have the major opcode 1. A prefix will never be a valid
word instruction. A suffix may be an existing word instruction or a
new instruction.

This series enables prefixed instructions and extends the instruction
emulation to support them. Then the places where prefixed instructions
might need to be emulated are updated.

The series is based on top of:
https://patchwork.ozlabs.org/patch/1232619/ as this will effect
kprobes.

v4 is based on feedback from Nick Piggins, Christophe Leroy and Daniel Axtens.
The major changes:
    - Move xmon breakpoints from data section to text section
    - Introduce a data type for instructions on powerpc

v3 is based on feedback from Christophe Leroy. The major changes:
    - Completely replacing store_inst() with patch_instruction() in
      xmon
    - Improve implementation of mread_instr() to not use mread().
    - Base the series on top of
      https://patchwork.ozlabs.org/patch/1232619/ as this will effect
      kprobes.
    - Some renaming and simplification of conditionals.

v2 incorporates feedback from Daniel Axtens and and Balamuruhan
S. The major changes are:
    - Squashing together all commits about SRR1 bits
    - Squashing all commits for supporting prefixed load stores
    - Changing abbreviated references to sufx/prfx -> suffix/prefix
    - Introducing macros for returning the length of an instruction
    - Removing sign extension flag from pstd/pld in sstep.c
    - Dropping patch  "powerpc/fault: Use analyse_instr() to check for
      store with updates to sp" from the series, it did not really fit
      with prefixed enablement in the first place and as reported by Greg
      Kurz did not work correctly.

Alistair Popple (1):
  powerpc: Enable Prefixed Instructions

Jordan Niethe (15):
  powerpc/xmon: Remove store_inst() for patch_instruction()
  xmon: Move out-of-line instructions to text section
  powerpc: Use a datatype for instructions
  powerpc: Use a macro for creating instructions from u32s
  powerpc: Use a function for masking instructions
  powerpc: Use a function for getting the instruction op code
  powerpc: Introduce functions for instruction nullity and equality
  powerpc: Use an accessor for word instructions
  powerpc: Use a function for reading instructions
  powerpc: Make test_translate_branch() independent of instruction
    length
  powerpc: Define new SRR1 bits for a future ISA version
  powerpc: Support prefixed instructions in alignment handler
  powerpc64: Add prefixed instructions to instruction data type
  powerpc sstep: Add support for prefixed load/stores
  powerpc sstep: Add support for prefixed fixed-point arithmetic

 arch/powerpc/include/asm/code-patching.h |  33 +-
 arch/powerpc/include/asm/inst.h          | 143 +++++++
 arch/powerpc/include/asm/kprobes.h       |   2 +-
 arch/powerpc/include/asm/reg.h           |   7 +-
 arch/powerpc/include/asm/sstep.h         |  15 +-
 arch/powerpc/include/asm/uaccess.h       |  22 ++
 arch/powerpc/include/asm/uprobes.h       |   6 +-
 arch/powerpc/kernel/align.c              |  13 +-
 arch/powerpc/kernel/hw_breakpoint.c      |   5 +-
 arch/powerpc/kernel/jump_label.c         |   2 +-
 arch/powerpc/kernel/kprobes.c            |  19 +-
 arch/powerpc/kernel/mce_power.c          |   5 +-
 arch/powerpc/kernel/module_64.c          |   2 +-
 arch/powerpc/kernel/optprobes.c          |  68 ++--
 arch/powerpc/kernel/optprobes_head.S     |   3 +
 arch/powerpc/kernel/security.c           |   8 +-
 arch/powerpc/kernel/trace/ftrace.c       | 179 +++++----
 arch/powerpc/kernel/traps.c              |  22 +-
 arch/powerpc/kernel/uprobes.c            |   4 +-
 arch/powerpc/kernel/vmlinux.lds.S        |   2 +-
 arch/powerpc/kvm/book3s_hv_nested.c      |   2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |   2 +-
 arch/powerpc/kvm/emulate_loadstore.c     |   3 +-
 arch/powerpc/lib/code-patching.c         | 184 ++++-----
 arch/powerpc/lib/feature-fixups.c        |  47 +--
 arch/powerpc/lib/sstep.c                 | 455 ++++++++++++++++-------
 arch/powerpc/lib/test_emulate_step.c     |  56 +--
 arch/powerpc/xmon/xmon.c                 |  93 +++--
 28 files changed, 925 insertions(+), 477 deletions(-)
 create mode 100644 arch/powerpc/include/asm/inst.h

-- 
2.17.1

