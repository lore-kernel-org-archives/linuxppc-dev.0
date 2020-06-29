Return-Path: <SRS0=PIrw=AK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56ACC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2020 08:27:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B4523359
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2020 08:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdqciQKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B4523359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49wLFM5YwdzDqQg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2020 18:27:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=viresh.kumar@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=LdqciQKk; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49wLCF1KC9zDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2020 18:25:11 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id s14so6809118plq.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2020 01:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9NfPVc9X1tGAaTQ7LTtkR4j1ayN5pMJRPHgx7xTYQLA=;
 b=LdqciQKkXx0vF40NVmUbSHqVzrdkPFKV3dLzzHZQ0CmTxL0oifFIHpiE1eOCfrV+cj
 3cVFOU1CWsgeA4WPaCLwixL8fpHf2gD4VmBWCeugFP0phu7dzgx0EP4jXAFdYovq5cJG
 mqrifK45bUERCQFkFNqN5CCv0cbp9O0w33VxEH9fSjt8seAUkgCj5NWfSlx7GXbXerH+
 3zTNgotZ4LFOJ+OuIfxb02TkTqZNjsAvm094siM8wm3CPW3Xw1zLi37XGdZb0Rf/F3fj
 b5purGoOvV/g6TdTCZgkSYAkw1VmcplH6qmVLCU/WwZMug1lxsBcwO8BPtFaLkGUy4cC
 Y6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9NfPVc9X1tGAaTQ7LTtkR4j1ayN5pMJRPHgx7xTYQLA=;
 b=O6tA+Y0sA8IfCQ6PaKvGOeX80xupwCtL28RcY1QycAZeTwUUycu8QNbx7b+W4c3jjl
 J7afhQY3h716m8pbNKlVGogkcVjEYmzEgG0eK2hRKcDWQLgdpSDRBZrJspTgta7p/4zH
 y+48zIHrZMFg6CWSUENt+5XVVGOkDrrpXdGnr4MsoE/gMMtmaAVl4XxM3yZKlwP4bnUW
 1RK1ZwizznEMwFEVPYWAcRLswUy3aWkVE48r9x9+en8wk+jDKx+DmpMXKZ1FaYTSm6UQ
 /VMEQee0YmlygFe/a2Tl/1ekDH3NINVWhOGwXZNtJ/71jQxkqT+U1wOs7LL2hbk0U5dV
 s9Rw==
X-Gm-Message-State: AOAM532K0HiA8SdJ+PgTNjrRNf/LsygPHORxSQgHD15hPkFubZKb0Yh1
 CSDiKPQhJPUzcGrEcffCfEzWZA==
X-Google-Smtp-Source: ABdhPJyR6iTPdisyGhDmgEwBMsi6ZvJ9kAEpwNBdUll/2hJsHd7ZMJ+XKDb/SY3trQjtVNUA1QgVcA==
X-Received: by 2002:a17:902:694b:: with SMTP id
 k11mr13062647plt.245.1593419108221; 
 Mon, 29 Jun 2020 01:25:08 -0700 (PDT)
Received: from localhost ([122.172.127.76])
 by smtp.gmail.com with ESMTPSA id u2sm8807092pfl.21.2020.06.29.01.25.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2020 01:25:07 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>,
 Ben Segall <bsegall@google.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 0/3] cpufreq: Allow default governor on cmdline and fix
 locking issues
Date: Mon, 29 Jun 2020 13:54:57 +0530
Message-Id: <cover.1593418662.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
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
Cc: linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 adharmap@codeaurora.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
 kernel-team@android.com, tkjos@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

I have picked Quentin's series over my patch, modified both and tested.

V3->V4:
- Do __module_get() for cpufreq_default_governor() case as well and get
  rid of an extra variable.
- Use a single character array, default_governor, instead of two of them.

V2->V3:
- default_governor is a string now and we don't set it on governor
  registration or unregistration anymore.
- Fixed locking issues in cpufreq_init_policy().

--
Viresh

Original cover letter fro Quentin:

This series enables users of prebuilt kernels (e.g. distro kernels) to
specify their CPUfreq governor of choice using the kernel command line,
instead of having to wait for the system to fully boot to userspace to
switch using the sysfs interface. This is helpful for 2 reasons:
  1. users get to choose the governor that runs during the actual boot;
  2. it simplifies the userspace boot procedure a bit (one less thing to
     worry about).

To enable this, the first patch moves all governor init calls to
core_initcall, to make sure they are registered by the time the drivers
probe. This should be relatively low impact as registering a governor
is a simple procedure (it gets added to a llist), and all governors
already load at core_initcall anyway when they're set as the default
in Kconfig. This also allows to clean-up the governors' init/exit code,
and reduces boilerplate.

The second patch introduces the new command line parameter, inspired by
its cpuidle counterpart. More details can be found in the respective
patch headers.

Changes in v2:
 - added Viresh's ack to patch 01
 - moved the assignment of 'default_governor' in patch 02 to the governor
   registration path instead of the driver registration (Viresh)

Quentin Perret (2):
  cpufreq: Register governors at core_initcall
  cpufreq: Specify default governor on command line

Viresh Kumar (1):
  cpufreq: Fix locking issues with governors

 .../admin-guide/kernel-parameters.txt         |  5 ++
 Documentation/admin-guide/pm/cpufreq.rst      |  6 +-
 .../platforms/cell/cpufreq_spudemand.c        | 26 +-----
 drivers/cpufreq/cpufreq.c                     | 87 ++++++++++++-------
 drivers/cpufreq/cpufreq_conservative.c        | 22 ++---
 drivers/cpufreq/cpufreq_ondemand.c            | 24 ++---
 drivers/cpufreq/cpufreq_performance.c         | 14 +--
 drivers/cpufreq/cpufreq_powersave.c           | 18 +---
 drivers/cpufreq/cpufreq_userspace.c           | 18 +---
 include/linux/cpufreq.h                       | 14 +++
 kernel/sched/cpufreq_schedutil.c              |  6 +-
 11 files changed, 100 insertions(+), 140 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

