Return-Path: <linuxppc-dev+bounces-23832-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71132C43602
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 15:46:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwMrc5Rsqz3090;
	Thu, 09 Jul 2026 01:46:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783525568;
	cv=none; b=PgVntFuL42vt8KLrBzHIwJXIqIhUyQTQmHGVhapQnbo3+Aabm0lkGNYlG/IrewnVhG3b1oed0RsS7rOW9FB71JN1kfsdmUypzX7w+j5HgVisEYjnJgYl5m9ZLzW8ZizO9E55CFO1J/n/UrKHsPG0LolRKIj+OQIPuTvdtJ2afVef/r/CB2pyPK3u7HOlXaBoeNC9nZ6fGNVt7Ms3JBDHhd8hFsllC/avOUVEWwqrkzmeQsUeVEtAtpTj4fxCuXso/3ATJwFKFdw7GplhiUig/+RX65vnXhhIDSSfLItZ1Lx58k+5nUwPma0S0zwqlbcedE7MKzpb/RnGHwBXNW15wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783525568; c=relaxed/relaxed;
	bh=ELc0xKTk0Kykl5od6ahABvgXKhkxN3989aWHpftFOnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eE6UfGgwaW14oJ5rQDDx8N1A8klzUDEggk4W+RmHB0ZBpSc0I3u142Rjy9f09mh9SkxC8nrCafFysVLQDwYF71HeocRhUoaBvXbtGjt+hY9he8lB0kjrmzG4gigV0UJrbdt0hlTIH/FjjFIT/afv7dOkV9nT7qTof0JOwDo4ux91rhIJtVBzUHgW6mTPr8ym2m0+thzuxxZp/YJqFKyWRWUp+2rhvE8w7vlTXIV2bVStXg0LMjU+dwT+Rh9jSmAl/XSzr4WDA46nQjFuZDoPMYpP/G70xMBNNhqpw65zqB5WjDtof3yCHGD36I0eBvdqFe+bYcycMnBURYYWOo2zYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=eDbt9Xvf; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=eDbt9Xvf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwMrZ6q7Hz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 01:46:06 +1000 (AEST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-4759b4f0897so539963f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783525564; x=1784130364; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELc0xKTk0Kykl5od6ahABvgXKhkxN3989aWHpftFOnw=;
        b=eDbt9XvfaAAqhnKcF/i6c+VqDb+gPSnVRTrSEtFlZJhI0W7SL3xtm8CyBgc/CC2Sci
         YQUh0ZNQGPUVnm3J6qKosnTTwiOjPzF3zRaOzpE/2za1W2Eu4/N9sN/QKQ2BOmXV1BlI
         Qx4f6F0nYkFWN0nNoeUlbVdCK7rHHZk5GK2THQCNY/hz5wbtQ+CMK7dd09OWeeHnT8L9
         qWmcK6tCWDdFDEd4jFoc08g7KSNug/1WiYiY6E2GLEGkKvPb55Py4n7GkwJ5Dsiv8tdJ
         RUjKWdO9oNXlsyw/WuGJW9ZjTfD1+EAuVDbMt7s0Ck/LYBya6jjXf+GIQ88lDc9BCvYo
         YiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525564; x=1784130364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ELc0xKTk0Kykl5od6ahABvgXKhkxN3989aWHpftFOnw=;
        b=StSD2WUGNQMhQH6YvATHf8wqU7TVeY114ofKHthsxjtKzZqRjw0VCLZvvr1Dsxr/29
         /iICMIQ70tQ3mzZYJZqB+zfYhOiv4+x2TZwQcBnGYeCmoqPhjqrJJcN/mT3F/ldYSQit
         LBGcyZHR9c/EEpuuKYJSxXQdWMiSKb/TvpPMrlCJEkcCnTkBRjcllBRWy2vmZBgvcPFP
         b3oZxUqFeiEXMdWu7yTDqBegqHuTsD3B/4TcmkKJaHLB950BkFJ5Wp/Dz66jxFrU7qfg
         ym6UYbDiZYBdFOcnNCge5EBWuI1XFe0ZhCV7lyYqVbgHhWhum+sLNiLWIHj8uP9Nag3q
         hvhw==
X-Forwarded-Encrypted: i=1; AHgh+Rrnx2z33cnK09Xc5yPOhrxrbCMJsnWuJSEwoDlNi2PXorrn3tATLJ/hnlQQYA5KeX5zpCfkPoJ6iDpkGiw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzDYU35jP2ljHxjSNYXQxD4GTYG5UIUwUMap0sk2Xjh0CLQk4pD
	DhuPOdxrknJeK56SS74ZJOBRRnITCDGQYhv9Azk9Q7Kiwtm0hLrIOjUtAKZ9Y8QVhPQ=
X-Gm-Gg: AfdE7cmTmF9r2f/NOeiJwikbr9xBPb0qL320Pp1bb1qF/HF2C6Ja4HolzOE9xDMkRDn
	x1Pdr9FTDE9lvVj9LDCDneDbeJBZMl5K03jOCTQL/S0UIgZaUm+KyT5OBT0J543xiG0PCai4MUv
	7u3pai8PGJlfXc8Ix7XOsP/h77lFR4DzzdW/9jmdSQtqjFXwX5ury+ocVkZnHwnUMLm4kfg70A9
	s+j8RkWadjBN9/GslJpblgic73kv3rWLpXofrIeaRJ6hEnQhX4hBy+SKja5Ew83lSuHjugNcdae
	3P7pDxjAMgdoacka+FEJpfkI6MYVFG/bU+sO0MdSLW+cmnXFI1FMedvDLLgL5v4C93+Zmevi6TD
	Y6odU4gg7IHhJ/y+L1A3fN+jQR1VnhTUvdS0YZ1iZFJ0BGB/Y65qxPzqd+JFkI334JgSdHVH4SU
	p49S4vqEgLpRgNYwrziFl6vdZID4Qi7w==
X-Received: by 2002:a05:6000:703:b0:45e:64b3:af44 with SMTP id ffacd0b85a97d-47df07f1aa7mr3243977f8f.36.1783525563754;
        Wed, 08 Jul 2026 08:46:03 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm44806847f8f.11.2026.07.08.08.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:46:03 -0700 (PDT)
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
Subject: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where needed
Date: Wed,  8 Jul 2026 17:44:29 +0200
Message-ID: <20260708154510.6794-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708154510.6794-1-petr.pavlu@suse.com>
References: <20260708154510.6794-1-petr.pavlu@suse.com>
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

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 2 +-
 drivers/block/drbd/drbd_nl.c         | 1 +
 drivers/greybus/svc_watchdog.c       | 1 +
 drivers/macintosh/windfarm_core.c    | 1 +
 drivers/pnp/pnpbios/core.c           | 2 +-
 drivers/video/fbdev/uvesafb.c        | 1 +
 fs/coredump.c                        | 2 +-
 fs/nfs/cache_lib.c                   | 2 +-
 fs/nfsd/nfs4layouts.c                | 2 +-
 fs/nfsd/nfs4recover.c                | 1 +
 fs/ocfs2/stackglue.c                 | 1 +
 kernel/cgroup/cgroup-v1.c            | 1 +
 kernel/module/kmod.c                 | 1 +
 kernel/power/process.c               | 2 +-
 kernel/reboot.c                      | 2 +-
 kernel/umh.c                         | 2 +-
 lib/kobject_uevent.c                 | 2 +-
 net/bridge/br_stp_if.c               | 2 +-
 security/keys/request_key.c          | 2 +-
 security/tomoyo/common.h             | 2 +-
 20 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 053555206d81..af4e76babe7a 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -11,7 +11,7 @@
 
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/poll.h>
 
 #include "internal.h"
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index f9ffcd67607b..de90cf4a0789 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/umh.h>
 #include <linux/drbd.h>
 #include <linux/in.h>
 #include <linux/fs.h>
diff --git a/drivers/greybus/svc_watchdog.c b/drivers/greybus/svc_watchdog.c
index 16e6de5e9eff..b318eb34bcca 100644
--- a/drivers/greybus/svc_watchdog.c
+++ b/drivers/greybus/svc_watchdog.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/suspend.h>
+#include <linux/umh.h>
 #include <linux/workqueue.h>
 #include <linux/greybus.h>
 
diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
index 5307b1e34261..e66de11c69a3 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/freezer.h>
+#include <linux/umh.h>
 
 #include "windfarm.h"
 
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index f7e86ae9f72f..46af1f549337 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -47,7 +47,7 @@
 #include <linux/delay.h>
 #include <linux/acpi.h>
 #include <linux/freezer.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/kthread.h>
 
 #include <asm/page.h>
diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 9d82326c744f..6c503e6914d6 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/umh.h>
 #include <video/edid.h>
 #include <video/uvesafb.h>
 #ifdef CONFIG_X86
diff --git a/fs/coredump.c b/fs/coredump.c
index e68a76ff92a3..4908b44f6fdc 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -32,7 +32,7 @@
 #include <linux/tsacct_kern.h>
 #include <linux/cn_proc.h>
 #include <linux/audit.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/fsnotify.h>
 #include <linux/fs_struct.h>
 #include <linux/pipe_fs_i.h>
diff --git a/fs/nfs/cache_lib.c b/fs/nfs/cache_lib.c
index 9738a1ae92ca..ca4e81d4e315 100644
--- a/fs/nfs/cache_lib.c
+++ b/fs/nfs/cache_lib.c
@@ -6,7 +6,7 @@
  *
  * Copyright (c) 2009 Trond Myklebust <Trond.Myklebust@netapp.com>
  */
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mount.h>
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index f34320e4c2f4..008f0f088c3a 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2014 Christoph Hellwig.
  */
 #include <linux/exportfs_block.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/file.h>
 #include <linux/jhash.h>
 #include <linux/sched.h>
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 6ea25a52d2f4..20b98e43f668 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -41,6 +41,7 @@
 #include <linux/fs.h>
 #include <linux/hex.h>
 #include <linux/module.h>
+#include <linux/umh.h>
 #include <net/net_namespace.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
 #include <linux/sunrpc/clnt.h>
diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
index 741d6191d871..0ccaab29426d 100644
--- a/fs/ocfs2/stackglue.c
+++ b/fs/ocfs2/stackglue.c
@@ -18,6 +18,7 @@
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 #include <linux/sysctl.h>
+#include <linux/umh.h>
 
 #include "ocfs2_fs.h"
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index a4337c9b5287..60eb994c32ae 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -16,6 +16,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/cgroupstats.h>
 #include <linux/fs_parser.h>
+#include <linux/umh.h>
 
 #include <trace/events/cgroup.h>
 
diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
index a25dccdf7aa7..dcaad5d65275 100644
--- a/kernel/module/kmod.c
+++ b/kernel/module/kmod.c
@@ -28,6 +28,7 @@
 #include <linux/ptrace.h>
 #include <linux/async.h>
 #include <linux/uaccess.h>
+#include <linux/umh.h>
 
 #include <trace/events/module.h>
 #include "internal.h"
diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22..295904ec9a82 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -16,7 +16,7 @@
 #include <linux/freezer.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <trace/events/power.h>
 #include <linux/cpuset.h>
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 695c33e75efd..3d4a262973e7 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -11,13 +11,13 @@
 #include <linux/ctype.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
-#include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/syscore_ops.h>
 #include <linux/uaccess.h>
+#include <linux/umh.h>
 
 /*
  * this indicates whether you can reboot with ctrl-alt-del: the default is yes
diff --git a/kernel/umh.c b/kernel/umh.c
index 48117c569e1a..72b2d9a878aa 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -8,7 +8,7 @@
 #include <linux/binfmts.h>
 #include <linux/syscalls.h>
 #include <linux/unistd.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/cred.h>
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index ddbc4d7482d2..a67129e452a3 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -17,7 +17,7 @@
 #include <linux/string.h>
 #include <linux/kobject.h>
 #include <linux/export.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/slab.h>
 #include <linux/socket.h>
 #include <linux/skbuff.h>
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index a7e5422eb5d1..89bc161a4b47 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/etherdevice.h>
 #include <linux/rtnetlink.h>
 #include <net/switchdev.h>
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index fa2bb9f2f538..e6ba2d054399 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -9,7 +9,7 @@
 
 #include <linux/export.h>
 #include <linux/sched.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/err.h>
 #include <linux/keyctl.h>
 #include <linux/slab.h>
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index d098cf8aae61..d26034000913 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -16,7 +16,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/file.h>
-#include <linux/kmod.h>
+#include <linux/umh.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/namei.h>
-- 
2.54.0


