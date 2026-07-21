Return-Path: <linuxppc-dev+bounces-24596-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BFDC4451C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 13:12:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4Hqf17dwz2y8p;
	Tue, 21 Jul 2026 23:12:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784639566;
	cv=none; b=UpOXbPvodO9nxw4F2LmznLYqe0+qT52kltr0e8MpWv41hg5wWjkLY9ktsEXaerGcqn2AQBOIop85FR1PKMVn8AyM9/RvExP9AHTDcJoMvBuCwuHD5AGb4DBYK7ATaYOlcQwillxDve6s39ENdCTn/R8zuppczvefGwhGgyb3FxJpgjS1eh7uTI6Up6ZBGTP8EQqcdZ6bTfPQf0bWpYzACTg1+scLQOlf+NbSeELspYatkhT6wqsx2wyoLJVEy2uA/ePQK5cO3fBoufh3ppKRczgr3/1tdWDxz+5TwhChO9eySmPBU8mLR+KxCfRdWfYoxGjqdtlpo4spebGMre7MGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784639566; c=relaxed/relaxed;
	bh=vXH/AcaDYaWjD1D7W7UeWMormFqpNiZzAjn7k+W0SEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RfjTjELdNly0E/augU1GfXqFQ8M+WfOrhmPkN1QEfm0YCOers9bc+52PqToiHhdxbYc1iEZdnueQfDfaPkupOd5ALHmCQQSmbNr6JFAr8sjy2T2SXbm9cGvZe8N/sSugOBYcXSLmYXjokjjyXfQ3x7aDruOESe/audue4V8btneD5jtSAzuSIwm84nxM9cx2vGKmeocDtNSAwmE+fAEeqqSk5iMQaVHHYFrQcZ1auXkWlMaYrCILMYHXXdaGM5LvyCCor25TN7cJKTlrhlRqOf2hs08s1a7FV9EjMlzRlkPUgp1ViOc+ks+TvZf8GYkchmRs3pRA+NCFHQ/AbQimQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=UqBERIap; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=UqBERIap;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4Hqc2Qqsz2xyl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 23:12:43 +1000 (AEST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-47362928f65so10253880f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784639559; x=1785244359; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vXH/AcaDYaWjD1D7W7UeWMormFqpNiZzAjn7k+W0SEQ=;
        b=UqBERIapqSONVQyvQvXDVnFLumMyS7lgPYiz/kEaQrKeUqjxC2G9CC5ZvOgrKRKUVD
         MPay/UNVJeTjpPnqv1s6u5Da1XyeM1dhLRMaGh2Cb6XvUrH9SEhrQnkHQ00ipO2azVkV
         ctrME3+im7ci0HD1b1kgbT2PjAClvHbQB3th3ssLdee4ChIsYrs8+5KShvo9Nh4RgUEs
         DLNVcfBzAUAQBkGxKlWqZ56fe8HWiU+Bh81zn+ECJEn4Sk4cfCIWMhkD6SKq5lMcz83g
         ZNwW8pv4epXMdkrnv+O0TwSKyLBTGnCpQdvCKJWfJOO4Or4bGjyCl3QwY6svSsy075Xx
         hFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639559; x=1785244359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vXH/AcaDYaWjD1D7W7UeWMormFqpNiZzAjn7k+W0SEQ=;
        b=lIdqptcft9bdk+ECizcrki+MXFobzoYjDdiGOB33FFQeaw9K1EE/Ooi+eKA0L2HUMO
         Zo8ci2v5OM0dxpiJmZ3hLZc2Wsplj4JcLUYJ8LMKPQMKzaz00/2roQcaPEl0C8G7gmMe
         ckoIVDppBYPsbWRm0x+TilLT0Bp4MC7O0MrpJ4dXMpBXVRwkGydm6wILKvhIizLoyTDb
         MwluIvcyQTdNp5pGRD4z4YSFL7kekVmzjhA9bJftwEtGm6jPaYxRCo6KSFa2Z/ILwABZ
         zUDbsqyRdMLy1TUNA+Dk5RFCR4bP/POhi3bSnG0C1ErWUwJ1Urah8KShO8F4D+jGHZ+i
         2e9g==
X-Forwarded-Encrypted: i=1; AHgh+Ro/gQ2VSJ862Dn9yolU5co5aEbUFS0KdWggaUuxmumcl7K8BRlg9QEgNog6ZLIhqr8oBLfYaFNSA1o2nRo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzllMInFki+Yz6WAXb46F0mFm0mACBqeqw7Fdb5+F7LoWokgJ2O
	jCWevl19NsMRHzu/TnBXrPgjfYJwHlq/F2VvzlLo4qjDMrEgbUXY4QM1tJp6wFdjvic=
X-Gm-Gg: AR+sD13RlLvKQN1i6b4xKelLQvPn/c1ZHbNfjBv8m1ledjthnC3m3BC7CCzbkTB3QF2
	bkhX6vmmfyD7ioicY9XtaLVGZxlDuCAkEMe+0XufLIsEDNpjdSgyu8431OESjjEyhaTgzgGDaUU
	6v8qpPh9s64YJhEGP3L88mOU55poNgWTZmxRzVoCcZPJMtoCp+q3twhw+JKuT2xMVftKXC2oN3K
	2qVR4OEBNRLVU9gQfsVgFKfNkLb70hjY6KAaaKi1N3gVg1D6bZNNyfn8Q6DUtAkD4CIGriuGmPJ
	mHrENh15Yb0cAjS9IiH1UyzJilUarn3Ob/RO7qMZj5NAiaPETeWcRmU1EfFIJJ7dVm+m/0xB1Mv
	ba9Lf+wFWEI8u8AB+4l0lJP3QSoloHCGjK6rEI2i46o6wFEbiStzJKJcZ1w39WHIpRNwjnLwrfg
	==
X-Received: by 2002:a05:6000:2084:b0:47e:81aa:3832 with SMTP id ffacd0b85a97d-47f6230e614mr22543209f8f.16.1784639559042;
        Tue, 21 Jul 2026 06:12:39 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm42070938f8f.36.2026.07.21.06.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:12:38 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Bring includes in linux/kmod.h up to date
Date: Tue, 21 Jul 2026 15:11:24 +0200
Message-ID: <20260721131207.803760-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
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

The usermode helper declarations were previously provided by linux/kmod.h
but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
moved them to linux/umh.h in 2017. Add explicit includes of linux/umh.h to
files that use usermode helpers and remove linux/kmod.h where it is no
longer needed.

Also add a missing include of linux/sysctl.h to kernel/time/jiffies.c.

Finally, clean up linux/kmod.h so that it includes only the headers that it
actually requires, importantly removing the compat linux/umh.h include.

This cleanup is motivated by trying to reduce the preprocessed size of
linux/module.h, which includes linux/kmod.h. The linux/module.h header is
included by every *.mod.c file to provide `struct module` and other related
definitions, so it should avoid pulling in unnecessary dependencies. Note
that this series doesn't immediately improve the situation, since most of
the files included by linux/kmod.h are, for now, also included by
linux/module.h through other paths.

Apologies for the wide distribution. Acked-bys are appreciated.

Changes in v2:
- Remove the linux/kmod.h include from kernel/cgroup/cgroup-v1.c.
- Add a missing include of linux/sysctl.h to kernel/time/jiffies.c.
- Link to v1: https://lore.kernel.org/linux-modules/20260708154510.6794-1-petr.pavlu@suse.com/

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

-- 
2.54.0


