Return-Path: <linuxppc-dev+bounces-26650-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C569C79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 06:52:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdd6J51w5z2yvX;
	Mon, 07 Sep 2026 16:52:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788763928;
	cv=none; b=M3/2Sz5PoSqpBCpUwgZt5XF/tExiiTjBnClwxVpmtIuM6e/rTA3ZLYqAqbndv2utbGSkEr5tUUtU1Y+FlDMlq/oHRZAUNvABhQCkh3xjceMo1bD6AJx22SbqG2jR82xNwINlz8rEVaL171GWw+wthMhvNXpayrp8W8cH9W2zw/PU6bnqIepwOVS8CT9yTkseanO5W7V8ORZXGdyW8lRbPF14lEhlXSq1oyXPmg0cm6xJ7kTZZiMcNPg0qJhnwyG97cGslNxf7Qyfix1uZeW0nwdya1eGOBnn1rorywoMh26YYnn+fX3tPFq9aCf09tZdgPpu94wKWg2EtlBKD1Iwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788763928; c=relaxed/relaxed;
	bh=eJnRbzrCd1m2NleK0en88gJsG/d6sqX5zOAxr1Lx8cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0nmHK9ab5d8nsaq6dtm+BPDBYe8Tonac0YyhflBW0/LXacjXmERz2Qy0e5r7WNS195UUsuvbO8qeiWODMKMmnB5VDVoHkgvEGrmbn1goe+tmtlkAVV2myyxLjJ6lpYnLZ5+4WRc+TRNC81L9f/vcxqooolj1Fhz8qf0byh5d2gytKVBQfHteCAwGHWb3b1YuwqG8qI54x4yNVroZsXiuYCxrgqvPkifa5WFjkZnfPKN3/wKpkqE/QG63yeZbAlXeiZfPS5FBFXDtF6R63k7gPyK11ugIuCIKWPhuGYI8agoSB5rU3AGtrcplJPn4Ni44BDaIVx2ZYrnmjh/TFXH/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OpvEBG02; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OpvEBG02;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdd6H05Njz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 16:52:05 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso2271497a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 23:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763923; x=1789368723; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eJnRbzrCd1m2NleK0en88gJsG/d6sqX5zOAxr1Lx8cg=;
        b=OpvEBG02Po4oYMq0vxnjmoOX8dCK4AJXoyzRUQe/5elz2DaHRL6lbEvHyA/nUzpr2t
         x5Ao9MFyBF1O8/UwSOOPcC8Y2nuCJmxFRDqU7kNUD0CZ0JxPV0KEDTjog98wgavmm4J2
         cRGtDqnLHW1eB2ApxepRWkvJmd0T8J0uPN8VwNV8uWvlrrR9OhT17JbkMX9mNJYjq+zU
         ijantuonCPjBeQNJv4nNtli4P9zE3aG5Izjp3VSgp3ufvRusqxPQEhpy46MbXjrMvQ0n
         vamuBHBM0j1zWY6sg1GNJFpKjsG3S90NFhK2+mimlP6I6Xl6VyYwlUF0BJMopS4C9tPG
         61Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763923; x=1789368723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eJnRbzrCd1m2NleK0en88gJsG/d6sqX5zOAxr1Lx8cg=;
        b=WEfUkhANsG80+cwx3PmkSHHMfJa8kK2YMdU8aPXmuBjavUATliPMAp0QBlW0dcbRoO
         YbE7Sws04ADvOEJZ7H6uYzoVeyjgfIrYgykxvXl2ByEq7z1ZZgUtJIb6qO/vBmUehObO
         1efkIUKTB2ZMqLODpc1DIwHHTU9YnNYRUkuF/eVQnd7Jmuub/5xkX/0v82DXFO/JnDOh
         yUySOtKCwKH7NGaLVf8HMNqbt6zKuN3iFX+Jr9G9RxOnLH7c8LPzHA6Skp3FCCSjfUHs
         rpQVQmAkf6P3VtcabswUcV3Va2ZO1JVO4lu5zVOYxcYseH0wHhJ/SBlH6EhLCwYoAFEG
         Y9lg==
X-Gm-Message-State: AFuF++m3eJZ46Ebnyw9M0gOgzyz57Ywa1OfIHMzufgOhoZxfHjO/UTy7
	+d2HQcYNhdMFL3hfLxvGHtNwMPRbahaKRWnML4w8Pt7xIXFUJ5tRMl+K
X-Gm-Gg: AYBFou2RcBhp1NwMZd2KWtY77t9OqfN/ViTy+pZjOP4ALZkqbp1StjABW8mRkRVmCrJ
	OCCGbVcU+RfoeRWi7VaH4OrH0/BiCu3cQvdUDw78RVeWLfWsCVCqKPH1S/2g0NEkOdflEYzz+Py
	Mzz0FlIaD9FThXYRQ5wPGKhgZZgcWPRRRac+ke6fyFsTRfDBcXZpBEKHu20GmqqC3zLD0LiY5a8
	s/+Pa8xk4iA+iNyq8Tu4etXv3ct3+DI8uwH/GspuOJeIBjBGU2HBqV4yX0nIOSr8X1cpn+qBN15
	E4+qS5WO1CnzBkiWhDsV5kLWCdG/S/224RU1H0GQMS/LSFOMY2WjvrhLY5O7alkSb+WlUqTwYMo
	Wn0ZZ06Os33aMTj7IBi96pCTM7I4+DbcDXSy7hizXiaJrE5+HxT6ghbiG0FLt+U//PETVD47Vy6
	UAq0oRnHBCTmKqueSZcfZYA3sQBXgbaRyammJqa5B3nKMN82lAYXsMJC5SVk95eRsaS0HsdJ7MD
	l14vYuF6MHN/7I=
X-Received: by 2002:a05:6a21:7748:b0:3da:6bdd:2c74 with SMTP id adf61e73a8af0-3da6bdd6cfcmr13705124637.10.1788763923318;
        Sun, 06 Sep 2026 23:52:03 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm28825941eec.21.2026.09.06.23.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:52:02 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] powerpc: fix typos and repeated words in comments
Date: Mon,  7 Sep 2026 12:21:51 +0530
Message-ID: <20260907065153.33578-1-hemanth.selam@gmail.com>
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

This corrects 2 misspellings and repeated words in comments.  Each is a
separate patch so that any one of them can be dropped without touching
the rest.

Nothing outside comments changes.  Every touched C file was checked by
dropping its comments, replacing each string literal with a placeholder
and collapsing whitespace; what remained was identical before and after,
so the compiled code cannot differ.

The mistakes were found with scripts/checkpatch.pl against the list in
scripts/spelling.txt.  The scanning, the edits and the changelogs were
produced with Cursor running the claude-opus-5 model, from a request to
find and fix spelling mistakes across the tree, and every correction was
then re-checked by the comparison described above.  Words that name an
identifier were left alone deliberately, even when they read as typos,
because correcting the prose would make the comment disagree with the
code it describes.

Tested by building x86_64 defconfig at v7.3-rc1-269-gbc35965f6940, which
is clean.  Nothing else was built, so any patch touching code that
x86_64 defconfig does not compile has been read but not compiled.

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
 drivers/net/ethernet/ibm/ibmvnic.h                     |  4 ++--
 drivers/tty/hvc/hvc_opal.c                             |  2 +-
 .../testing/selftests/powerpc/tm/tm-signal-msr-resv.c  |  2 +-
 tools/testing/selftests/powerpc/tm/tm-tar.c            |  2 +-
 56 files changed, 81 insertions(+), 81 deletions(-)


