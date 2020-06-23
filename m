Return-Path: <SRS0=X5Ay=AE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACE7C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 14:25:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904122072E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 14:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="V94+StGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904122072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49rpT66Kq7zDqMM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2020 00:24:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--qperret.bounces.google.com
 (client-ip=2607:f8b0:4864:20::849; helo=mail-qt1-x849.google.com;
 envelope-from=38w_yxgckdngkj8ll8naiiaf8.6igfchorjj6-78pfcmnm.itf45m.ila@flex--qperret.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=V94+StGW; dkim-atps=neutral
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49rpPW2YHgzDqLF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2020 00:21:43 +1000 (AEST)
Received: by mail-qt1-x849.google.com with SMTP id c26so5212518qtq.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2020 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=u1DDKlY4raUnYKBkmaNYPdbNtcYQKCadD73iqEHJ/Ig=;
 b=V94+StGWnc22eutcWvOiDbMPO3aIFCF/x/97/cKQYwcL/WynS+RlBLbo/0jwE0o2VA
 nvcw+BSjvTbunQrZHWvIddiZGzLt+QE7fYwP2NJT85uIfNyhClMJ0GenQppRmjarze6z
 2hnxUwvjgKD1htigvr+jaLAzk5YWbRZazVdI5VsbCUZcBW5zbKBLmcIYmXECYtvgsdFh
 TeOvh+Mk+8ghcMYmeyMi+EaoYPyYRwGQ6dgf4tTU5PfGW12EanP3QAbZCAItTuSvaN1/
 Pl5gtcWsGbr8nibe1a6JsDp9rUVV3xzkqErQBK1KEXyWT79IpUnkrtRyqmMJM8VDJumM
 FZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=u1DDKlY4raUnYKBkmaNYPdbNtcYQKCadD73iqEHJ/Ig=;
 b=hjz2HLdK2K9AShbY/SewrMsN+DKTfst3SSGRF4dP5TaecGsh916542L6fZ/dMIHecC
 zQCsgtFB84e1MDSpV9/56UA/wMYc/6J6QQ54raYSOHcK8bq4mZqHvl8p1nrZTSKRASmw
 KIwJGmAYP/vqe/6h/LzRk8oASM2/P4nrSKdMo1x1sWBvLrcI6XtkBZrpCLQkmq+V1ETy
 3sxE84fUPPtOhiCRtoBTJq+vkfZ6JVumqwHqBIuArZFLGdnWJNoOfKjv7CYD8o1aOpI7
 AvRmH2GDRgLS5KEkPDCYf3jboVOnAfIIhO8HXtKOtA2Djva/7x2zQqKEpJCKISweWLhn
 +bNw==
X-Gm-Message-State: AOAM530vJ4+ZI82nMS1o48b/xClM4UOTeioI2UceEouFiWHi9A3TIwV2
 rxCKuJ1UFMR+E3bc/2C+kApQVg+wWA3e
X-Google-Smtp-Source: ABdhPJw/yysC+TJ6IjitCFw5yaXajcA+uMBI+rTC2wq1jjbjHR0l6X9AqIpGAMm6egmgBJibg/HvOHK7IZay
X-Received: by 2002:ad4:56ac:: with SMTP id
 bd12mr26923271qvb.139.1592922099906; 
 Tue, 23 Jun 2020 07:21:39 -0700 (PDT)
Date: Tue, 23 Jun 2020 15:21:36 +0100
Message-Id: <20200623142138.209513-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 0/2] cpufreq: Specify the default governor on command line
From: Quentin Perret <qperret@google.com>
To: rjw@rjwysocki.net, rafael@kernel.org, viresh.kumar@linaro.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: juri.lelli@redhat.com, kernel-team@android.com, vincent.guittot@linaro.org,
 arnd@arndb.de, linux-pm@vger.kernel.org, peterz@infradead.org,
 adharmap@codeaurora.org, qperret@google.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 tkjos@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

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

Thanks,
Quentin

Quentin Perret (2):
  cpufreq: Register governors at core_initcall
  cpufreq: Specify default governor on command line

 .../admin-guide/kernel-parameters.txt         |  5 ++++
 Documentation/admin-guide/pm/cpufreq.rst      |  6 ++---
 .../platforms/cell/cpufreq_spudemand.c        | 26 ++-----------------
 drivers/cpufreq/cpufreq.c                     | 23 ++++++++++++----
 drivers/cpufreq/cpufreq_conservative.c        | 22 ++++------------
 drivers/cpufreq/cpufreq_ondemand.c            | 24 +++++------------
 drivers/cpufreq/cpufreq_performance.c         | 14 ++--------
 drivers/cpufreq/cpufreq_powersave.c           | 18 +++----------
 drivers/cpufreq/cpufreq_userspace.c           | 18 +++----------
 include/linux/cpufreq.h                       | 14 ++++++++++
 kernel/sched/cpufreq_schedutil.c              |  6 +----
 11 files changed, 62 insertions(+), 114 deletions(-)

-- 
2.27.0.111.gc72c7da667-goog

