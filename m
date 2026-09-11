Return-Path: <linuxppc-dev+bounces-27139-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E4CC88E59
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 14:47:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhHSV5z2mz2ynZ;
	Sat, 12 Sep 2026 00:47:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789138026;
	cv=none; b=aNojrGFcmOvRnZaS1OTQUATQ4qSW/N4BzBOLeXyLOKl/KHn3ur+AaKOS70ajTIQNmWU9KMCJ/Nnu2myK300Peyy1xRGyxyQx1PFq101SZX4xvvmNEL95cdyyQxa0u7Z3fDw1/jQxsVbLKlUDOVRuRUyNRPrvc6Pvfvr2HF49vmh6GZYVD/Q0U2NMF6Y5UPAo27cDnX5yyeo5lRqE0rrTVJWX5e8G5S49Bu5Hawa5dTxd2clKEGY8zaXzzBUgd0kd/oc9EJ/TAse2dHtP0H5I2GQT1ABFZlsF1Kg0O3X5HXEXXy3Bjk8ocu/G0jJrmcRWy52NalKl4bbAtrX8LAldMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789138026; c=relaxed/relaxed;
	bh=6DAY0H524IPnoUin0wM315IyLKxNaVBFm7h+DvdUw5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XCf5NEpP520u3rGPTYPRg1cB4+RaoBtREL3fIijO0DIcP93xkS06pEPUcv3xkFU8sSlT+Qvwb7f35bn/uIZAuzl4u3h21Du/c+2G/R756Psp6A1TWqPnkGZzh1uCEr0SR0JvEXyuEUioKk3kgk4ys1KUKrv2jWfTgrr27VSe+sw48ezKcjXvdwnFLNWE3d/JCb7TU0THiZZcQ+cNwwrig24wGXZiGdGCVH3ElrgMM4C0yMw5EwHH4BvrMV+s4CPen+7g1rZ/o41kTuqMLSHZCmyx0h3kPWuB09pPi8c61oqIzpH2s027OmimFseTCgBN8rsfMiJCWis01uuMs6p5vA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NL9oP0nS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NL9oP0nS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhHSS3TGHz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 00:47:02 +1000 (AEST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-495437bb891so4841445e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789138018; x=1789742818; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6DAY0H524IPnoUin0wM315IyLKxNaVBFm7h+DvdUw5U=;
        b=NL9oP0nSQtr7EevaMCjrnsPWHQpNPRJJ8p5EUIaK/ykuMyWc28jKibeh8P36FvtHUV
         Z9ufLhsLagBVUvf1dYszd4/kM/nZRL6rftOWdhwBSMOh9Hp2Jza+lr3nI00LCWIOUagS
         0tNyrKBgW376deoRodVGO8lBv+O/uNm1T56F3BsfD5jg+lK6iXJOOw/8FaBiAYxAVw0A
         Wo++Vr35Raj31HjmTEJr2TSOPUytckRs7m4KkqyRVaHm4D0RkR7RFMoXYDVVyQ9TsX5z
         nBLz6Ou7XFMHqZMkPbl3bHEH59Wsu2h2w/cnBtBdl1GOCBVSEqYfB3vM+fZdjmzyfrHM
         dpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138018; x=1789742818;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6DAY0H524IPnoUin0wM315IyLKxNaVBFm7h+DvdUw5U=;
        b=S4kTthG4fCfNQreucGCCm4EoXZlPLzfTpNsRZUT71MJ52rxZdvmYnH26Xt5lkr0Tle
         lvj/6nU5DLb8+Skwvuf1namzxzrXtpPqi67IwAV7mpdGuG2RHWvzLD/9yRD5yL8qHfE4
         XAmyOH1k4z5OL0HN3CsvHx7d7s9LC1ncv9Sqvqp1ZxJkyUC8jkCwLIHCH+5Fj/RFzpVU
         s9DQJW0mr3uYDR690e10OX/RiTThGGwi3RGNtJ+PzAFnohv5aBTF/XnSSs7Z2jVO8vfc
         uIlwuAM4gbXbjcak5x+KxXNFVtfB80HLMLQEx/nx0KYERxi/fzcm4gahFEfajAUBY7iN
         XmUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzR4QN4RqLZEYsKRMEAvtVdA7mZiLfCfT3Lk9Qd3/Zk27piaAlBKjmU+czKwK0CNjjH4qLo+GNAYDSf/A0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mjQRtaL2lXXOj2xkXeba2tskj4cv4oGSAXP4sfZ+Fno2NoO0cb
	hC0bWHVgWOJ6U1uL+gnokiqwEvD+sD27bqOqlQIilMWJeZrHqozDduxW77NxC3Yjs+E=
X-Gm-Gg: AYBFou1llxckR7JbbIC50EmH8oPQS+fsEpXNGkWd9SRDkgFlXQCsOKaCKgZkIEN4KmF
	t0hK3FZR6pE5l/X2fnMLttpTu7WEzY9SBMHMyacL6GlBuwdp0UegoyKL6OvywYhU0U6hqABMfa6
	nkbPBHzOBHShQKPvnvMk3Y5IT0JjQatSo9gKhgczySQcdi5RcUyD6T5iZHKfsuXv9o3iq7qTNV+
	DxqwPPGve5bVjmHPtZPmXlWhkLr/5HjYjc0oHpW63SO8azmr0uhwMLdEOPU8gHNy0ZNMpPEcM83
	zsRzazCmoACYNtGRBmfFuHKIFoAn4vyRGkk6tYdGVNyLliCB+W9IxT2NmUajhHm8Q9+wDFtBCU+
	Eer9cX3xi/Bpjc3/TokRhL4icEKVqqsREpVVlZhPv1YpGVUre6RUhBRrIq1kyt0cNO7NzwUGD+o
	q56t9kbHC56ZCYoTFaeeCDyeXi3cjd0CLzlOPjR9qRRe8UBfszqLBQoRIxK15Qsbmzyp9HT0GNl
	hU/VQ==
X-Received: by 2002:a05:600d:8444:20b0:49d:27ee:79c9 with SMTP id 5b1f17b1804b1-49d27ee7af0mr93376655e9.8.1789138017731;
        Fri, 11 Sep 2026 07:46:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e8d1sm6328068f8f.11.2026.09.11.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:46:57 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Michal Januszewski <spock@gentoo.org>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/3] Bring includes in linux/kmod.h up to date
Date: Fri, 11 Sep 2026 14:46:13 +0000
Message-ID: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
X-Mailer: git-send-email 2.55.0
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
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260816-module-include-kmod-14d1a0e19462
Content-Transfer-Encoding: 8bit

The usermode helper declarations were previously provided by linux/kmod.h
but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
moved them to linux/umh.h in 2017. Add explicit includes of linux/umh.h to
files that use usermode helpers and remove linux/kmod.h where it is no
longer needed.

Also add a missing include of linux/sysctl.h to kernel/time/jiffies.c.

Finally, clean up linux/kmod.h so that it includes only the headers that it
actually requires, importantly removing the compat linux/umh.h include.

This cleanup is motivated by trying to reduce the preprocessed size of
linux/module.h, which includes linux/kmod.h. linux/module.h appears in
roughly 15k #include directives across the kernel. This makes it a "hot"
header, so it should avoid pulling in unnecessary definitions. Note that
this series doesn't immediately improve the situation, since most of the
files included by linux/kmod.h are, for now, also included by
linux/module.h through other paths.

Apologies for the wide distribution. Acked-bys are appreciated.

---
Changes in v3:
- Rebase on top of v7.3-rc2.
- Clean up commit descriptions.
- Link to v2: https://patch.msgid.link/20260721131207.803760-1-petr.pavlu@suse.com

Changes in v2:
- Remove the linux/kmod.h include from kernel/cgroup/cgroup-v1.c.
- Add a missing include of linux/sysctl.h to kernel/time/jiffies.c.
- Link to v1: https://patch.msgid.link/20260708154510.6794-1-petr.pavlu@suse.com

---
Petr Pavlu (3):
      umh, treewide: Explicitly include linux/umh.h where needed
      time/jiffies: Include linux/sysctl.h for proc_int_u2k_conv_uop(), ...
      module: Bring includes in linux/kmod.h up to date

 arch/x86/kernel/cpu/mce/dev-mcelog.c |  2 +-
 drivers/block/drbd/drbd_nl.c         |  1 +
 drivers/greybus/svc_watchdog.c       |  1 +
 drivers/macintosh/windfarm_core.c    |  1 +
 drivers/pnp/pnpbios/core.c           |  2 +-
 drivers/video/fbdev/uvesafb.c        |  1 +
 fs/coredump.c                        |  2 +-
 fs/nfs/cache_lib.c                   |  2 +-
 fs/nfsd/nfs4layouts.c                |  2 +-
 fs/nfsd/nfs4recover.c                |  1 +
 fs/ocfs2/stackglue.c                 |  1 +
 include/linux/kmod.h                 | 12 ++----------
 kernel/cgroup/cgroup-v1.c            |  2 +-
 kernel/module/kmod.c                 |  1 +
 kernel/power/process.c               |  2 +-
 kernel/reboot.c                      |  2 +-
 kernel/time/jiffies.c                |  1 +
 kernel/umh.c                         |  2 +-
 lib/kobject_uevent.c                 |  2 +-
 net/bridge/br_stp_if.c               |  2 +-
 security/keys/request_key.c          |  2 +-
 security/tomoyo/common.h             |  2 +-
 22 files changed, 23 insertions(+), 23 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260816-module-include-kmod-14d1a0e19462

