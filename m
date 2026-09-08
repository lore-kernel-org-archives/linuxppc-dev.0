Return-Path: <linuxppc-dev+bounces-26723-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F41C79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 05:51:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfCk81Z8kz2yjN;
	Tue, 08 Sep 2026 15:51:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788846704;
	cv=none; b=lkkbbn5or3y11JQPmSPJseoZsxxOwi873SBEvT5JUSmfUlvDvFP9GoR255C8fgudcecrrhl9rc/YsvtC3hwb7EIt144uapgsaaa8rMW6Qr08kdh1J0R0+Uxmo7ZO4bp6wZGVnKBFr3vTvzPwSEQkreFPZiSrlgldECx/ESAPYal3i74xRGkB25M8a/17y9gNGt478sUW9Xs9D9gzAfAE4IrFLHcJSJXA6bwZRlLqLY1zRoMXynWYJjLLFZq82BElIMU24lRASuFBtq91JgKLbPtkmeOAYczxEdet2KeZyybtET5zl+BrdBAJbFWERjUuuko5TRctxsmm4yVoYPW+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788846704; c=relaxed/relaxed;
	bh=k4gh5k6ECBQWHxt1QP4VjfRnV+K82E4kkpVh09p6XGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=keCgE2lKEtyJObwAEVRPg1Z55M3EqF/tfP+VtfICNhEAO0LHoOrJ7WDT9202hSrYei12T+Nva97wBB/xraDEF2ScPdZSD+IghixpeP+kwxe18shWofcwgCaDa9TSA2EImVSRxC9u9iXmeYKeEWwtlaIgaF/sDrvClkjLwHz482VCfPDCT1rl8DzCagI5jsIiH7fbhqjnEpor8Z7oQXTpxPPdqZbPV4UASCc4qJpxLu0BOQVnr0ktOaqzrarTUgjY1VLVZ0se9TV/AKT5krP1NA4ALdfrSjs6WPHSnxEYtey3kk3nGGDu31/oY1O4CVGg0wQoTo80mnqeImyH0nhXGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mfLf8McA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mfLf8McA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfCk72vNJz2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 15:51:43 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-84830c774a0so3990583b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846701; x=1789451501; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k4gh5k6ECBQWHxt1QP4VjfRnV+K82E4kkpVh09p6XGw=;
        b=mfLf8McAMRWm7VswtnOljZ6ptEoAOPRrKSQ0Chy1ncRW+UuS4NetLSjc1ooaz0crpV
         pfp01VT6klwERjVgGa91vkdWSDDEh7mmiXvTa+8oEYzOOqsrzrr2N+ntMuh9ZmRR10d3
         A2KS3fN9y/bPdHXlqnsj/dopQqOFgcAmSVG+TyMK7ajV4o1xdixgfR6nQBmVxqpcfOAy
         vV/8Day+3s78N0uRc2DfR9mD3eBg6m/naTNDcXb2qwh921q2nRLE6DiARI3qVmoxOHeD
         vEBjLybbJxQ1YAf3xZFuGxGwTtHgC+aAgouzStRX1PGjyJH65VFAw0XTEcVQh7D92vHK
         R0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846701; x=1789451501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k4gh5k6ECBQWHxt1QP4VjfRnV+K82E4kkpVh09p6XGw=;
        b=Ec1+PFOcDnfcbwu3SryhS8wsjUp80TZRSNtDRn/U5UJs9O2sFIOwLgid3ECJ7rMj99
         br9LS6+zM6vmR8TgObFLd6phBwQt7M9JPvB+J0Kw95mR5LpLREvKafrY1R0o9GRl50Wq
         VkFU9nTah4rGXxt2WE2hc2oBI54ulblUX0wVYdVFTygXfxtlKmZGWNmvzzoOyHeu54HO
         1ctDrQa3VSnN5MnDkPCdftm/RttBC7J5qJ7a5Zk6MYJIF3z799gH0HBpbLBlMrrkP2C6
         5ViWULnAF3/w45NLKGY2DUtrhAJAKhDYFf0T3xrag0ULi3kbGAxsZn1m138yB4vrSMV/
         DKzA==
X-Forwarded-Encrypted: i=1; AKwUvBzT/6Toiyz2NYeuxuxMz8vAfZRvdhaF20/xim1q7GsHv5AYLF0b5ufOeA3sxNsNJQQW7WuK3P3l3m+iI+U=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l+aMdkrVVsQFxUWyEqidEhLadxk6P59Kd5OEAllBLjoqmBTvWk
	gpU71SeDg0yU6ll+E3tSBetEdkQiLbr4wadVNIJ13WgMNmQKkudjve4l
X-Gm-Gg: AYBFou3jDyImtPqiBYBpkPlkwevCsfsA576k2OYqFbovPIiumoG99NoVj6BadRpdOe8
	H1xkfQpEcHZYPUMjyow1HMetxb9DcTrVX/nJpPuZb9qhYE/VmdnZoEwNseXFdcfqeo/gmSjGoq5
	/m6WNCFjcgOMbYnlfRGF0zfuWd3509sP2kg51lccrEFSYMyF12pTxhhVlPpq/ghH8gSbLdE4KFi
	271mL1tNoucvHRUDZbwuZQHM7wgn6VPOxQfQBXUnNjvwA6T6XPTCf1omikNOcOho12N0h/EMw0r
	Sfgn5viQQ0R203/joR/OkG3fSORlNyuJl7f8BCkNzkuXd7swViiJej0VK4mLS9R/BOxHAuj27Oa
	r0fhY7oE3iV1c5Ar0H0wMq9FYEXGklNY7sRyfTwi+WTCJ+vkCUGq8Oceh67D1KkBdK3Zhuu1LEQ
	gBQjdxKN9HKwAks1xAdE6GBxr+zq7/6HTXlN7lQ9LJMIaZocQhXmC16KOPUDowJJvdmEz9PzKVF
	PYAi5ZWh4vcOt0WSt5mnN3d
X-Received: by 2002:a05:6a20:b418:b0:3d3:adbf:7777 with SMTP id adf61e73a8af0-3da3a066ef5mr43666492637.19.1788846701101;
        Mon, 07 Sep 2026 22:51:41 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm37719041eec.7.2026.09.07.22.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:51:40 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] powerpc: fix typos and repeated words in comments
Date: Tue,  8 Sep 2026 11:21:31 +0530
Message-ID: <20260908055133.16469-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix misspellings and repeated words in comments, found with
scripts/checkpatch.pl using the misspelling list in scripts/spelling.txt.
Comments only, no code changes.

Changes since v1:
 - dropped the drivers/net/ethernet/ibm/ibmvnic.h hunk.  Andrew Lunn
   asked for the networking change to go to netdev rather than through
   the powerpc tree, so it will be sent there separately.

Hemanth Selam (2):
  powerpc: fix typos in comments
  powerpc: fix repeated words in comments

 arch/powerpc/include/asm/book3s/64/mmu-hash.h          |  8 ++++----
 arch/powerpc/include/asm/book3s/64/radix.h             |  2 +-
 arch/powerpc/include/asm/fsl_hcalls.h                  |  2 +-
 arch/powerpc/include/asm/io.h                          |  2 +-
 arch/powerpc/include/asm/machdep.h                     |  2 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h           |  2 +-
 arch/powerpc/include/asm/pmac_feature.h                |  2 +-
 arch/powerpc/include/asm/prom.h                        |  2 +-
 arch/powerpc/include/asm/sfp-machine.h                 |  2 +-
 arch/powerpc/include/asm/smu.h                         | 10 +++++-----
 arch/powerpc/include/asm/task_size_64.h                |  2 +-
 arch/powerpc/include/asm/uaccess.h                     |  2 +-
 arch/powerpc/include/uapi/asm/bootx.h                  |  2 +-
 arch/powerpc/kernel/eeh.c                              |  4 ++--
 arch/powerpc/kernel/eeh_event.c                        |  2 +-
 arch/powerpc/kernel/exceptions-64e.S                   |  2 +-
 arch/powerpc/kernel/exceptions-64s.S                   |  4 ++--
 arch/powerpc/kernel/fadump.c                           |  2 +-
 arch/powerpc/kernel/irq_64.c                           |  2 +-
 arch/powerpc/kernel/paca.c                             |  4 ++--
 arch/powerpc/kernel/pci_dn.c                           |  2 +-
 arch/powerpc/kernel/prom.c                             |  4 ++--
 arch/powerpc/kernel/setup_64.c                         |  2 +-
 arch/powerpc/kernel/signal_64.c                        |  2 +-
 arch/powerpc/kernel/smp.c                              |  2 +-
 arch/powerpc/kernel/switch.S                           |  2 +-
 arch/powerpc/kexec/core_64.c                           |  2 +-
 arch/powerpc/kvm/book3s_pr.c                           |  2 +-
 arch/powerpc/kvm/book3s_xive.c                         |  8 ++++----
 arch/powerpc/kvm/bookehv_interrupts.S                  |  2 +-
 arch/powerpc/lib/copyuser_power7.S                     |  4 ++--
 arch/powerpc/lib/memcpy_power7.S                       |  4 ++--
 arch/powerpc/lib/rheap.c                               |  2 +-
 arch/powerpc/mm/book3s64/hash_native.c                 |  6 +++---
 arch/powerpc/mm/book3s64/hugetlbpage.c                 |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c                   |  4 ++--
 arch/powerpc/mm/book3s64/slb.c                         |  4 ++--
 arch/powerpc/mm/nohash/tlb.c                           |  2 +-
 arch/powerpc/perf/imc-pmu.c                            |  2 +-
 arch/powerpc/platforms/powermac/low_i2c.c              |  2 +-
 arch/powerpc/platforms/powermac/pci.c                  |  2 +-
 arch/powerpc/platforms/powermac/sleep.S                |  2 +-
 arch/powerpc/platforms/powernv/opal-memory-errors.c    |  2 +-
 arch/powerpc/platforms/powernv/opal.c                  |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c              |  2 +-
 arch/powerpc/platforms/powernv/vas.h                   |  2 +-
 arch/powerpc/platforms/ps3/platform.h                  |  4 ++--
 arch/powerpc/platforms/pseries/firmware.c              |  4 ++--
 arch/powerpc/platforms/pseries/papr_scm.c              |  4 ++--
 arch/powerpc/sysdev/xics/xics-common.c                 |  2 +-
 arch/powerpc/xmon/ppc-opc.c                            |  4 ++--
 arch/powerpc/xmon/ppc.h                                |  2 +-
 drivers/tty/hvc/hvc_opal.c                             |  2 +-
 .../testing/selftests/powerpc/tm/tm-signal-msr-resv.c  |  2 +-
 tools/testing/selftests/powerpc/tm/tm-tar.c            |  2 +-
 55 files changed, 79 insertions(+), 79 deletions(-)

-- 
2.48.1


