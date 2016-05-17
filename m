Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r88bW2rFYzDq9y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 17:48:55 +1000 (AEST)
Received: by mail-pa0-x22a.google.com with SMTP id xk12so4085284pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 00:48:55 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: sbauer@plzdonthack.me
Subject: [RFC 0/2] SROP Mitigation for powerpc
Date: Tue, 17 May 2016 17:47:49 +1000
Message-Id: <1463471271-26788-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is all derived from Scott Bauer's x86 patches (https://lkml.org/lkml/2016/3/29/788). Have tested rc5 with these patches on: 
	- BE VM
	- BE bare metal
	- LE VM
	- LE bare metal

with the Linux Test Project runltp test script with all default configs. From rc5 to rc5 with these patches no new tests failed. 

Any comments/suggestions are welcome!

Rashmica Gupta (2):
  powerpc/SROP Mitigation: Architecture independent SROP mitigation code
  powerpc/SROP mitigation: Add cookies to sigframes

 arch/powerpc/kernel/signal_32.c | 33 +++++++++++++++++++++++++++++----
 arch/powerpc/kernel/signal_64.c | 21 +++++++++++++++++++--
 fs/exec.c                       |  4 ++++
 include/linux/sched.h           |  1 +
 include/linux/signal.h          |  2 ++
 kernel/signal.c                 | 41 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 6 deletions(-)

-- 
2.5.0
