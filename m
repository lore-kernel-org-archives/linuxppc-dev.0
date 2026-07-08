Return-Path: <linuxppc-dev+bounces-23831-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F789C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 15:46:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwMrb39YLz2y7r;
	Thu, 09 Jul 2026 01:46:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783525567;
	cv=none; b=Mi9G2G8cUX0uPpdih7135CEnhwReffOiiCAysBBGfMQ6c8EriWWUWE3QpUcN73QfIaphLqTHd3/Zp1usp7F3HBYe1kKLCD0zijRMcUI0/uz3GyW0odOFrbiXGUTIk7su3j1G4F3u3jkW/RuV01A4XVmeTZF1ERI8G9TsPhbmWDtnYWV1/3Uj5npDw7GwK8hZ6xUkn94Za1tPSj9KPao27id4sx0NCHUUsbmXIWRbJrsz9XJ2ly8Ck/+BeaJ55j8yEvGc5jEKGgR6uruKDws7NhZaQ83CNtwRlucTdC3wcDCUFAUXKe6KWy2fCmOr19qGZGrU+D7oR6JfJ6sH8S1Qkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783525567; c=relaxed/relaxed;
	bh=f/mdlbu7kxNAYQt2PwbA0grJPU5KW1EejarCbBPlRO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/iwN09Ku6A3zT/dRciZWCd53FCqjNGCkQjLfOCsxFomMTPiROy8QdlhlwJwlX3bwtNtTg2+GEyOH9SQA0Rr92yW1/Qr+nHOm9wZb54N5nTGlb8ThX4yw3q2+76MwFUe7MiGFS3gu3vyEfbpV4tCaMeNa+ckXaoP7H9YNl4hAMMQutrwQdKBV8UBUuUJ6Rfh0Y6eoTdQKWemBaaN4u9kORMrMocdyZ4ehLjePX1sYOBUomShhSR4/vHQz/fJUVSp+oUl0tOlLHzKUiz0ADBywsNmJGisz2303LbkFlRNNI6joaztkdev6ccVozzmlCiaPelGXLrgNNHyOHxLUxLzCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=g9O0k/xH; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=g9O0k/xH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwMrY3vgnz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 01:46:04 +1000 (AEST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-47dedd17e12so75412f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783525561; x=1784130361; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f/mdlbu7kxNAYQt2PwbA0grJPU5KW1EejarCbBPlRO8=;
        b=g9O0k/xHditGfell4XPLiP/QsA61TMkXPA7G4GhWG/AVTDxFLrq6CL3kilD2hR6RxG
         IR/myII0C13LDkkDn4nGOd+MOuYUGe9aSeqrnNVx2fKZhdV5JLzu2CiwuvnbM/QH5kcO
         YbmSCt9QQB00BMukRtaUyrrPgl+OGVLdqlR/WwBBLSktGC8CpuWNKu29Nn0BDdlzes9W
         O7vw6EZQSX8HHQevBiIl7ZmVCw0rogev3NabTsWBeZrp2y5DCy5wx7YHOY+gV+4/JSbI
         U4kLLKuDLL0lsw1NgzxHbrrHDK+QDHJGyHKSqsS8LPA3hdyLR+Ai1rkApcPbGGfKNht3
         auXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525561; x=1784130361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f/mdlbu7kxNAYQt2PwbA0grJPU5KW1EejarCbBPlRO8=;
        b=O2+zoTzGHSSgxdWGBV4hjQ2KywzqoduAMTxi1X1WypYQwYU1La/TdpFhI0enaP2iWt
         CnU/hJCNVccSLh3tB1NJFKDuHR0vZDHpgYTqOyfXbZN5TP6I9uGgIAVcFuC+6nPueNzw
         1W1Xfgm2Uasq8qSkVbgMqv3mZbDKy29+3xix3YN877z4vICb/qapkHXekpWS3ALjkx5k
         FHpTDpmNEgyKk8uNEVDNrsXw52F1mBMu6iM2AU+O3slMUZcT0hkOnA3+FzhAyUccekaq
         rqgtwdvz22q6ZUHISJpeAeWltSlov+MBA/cRpFnulS2YTzcrsRdAyuyNQjXfFEhTxBio
         vnwA==
X-Forwarded-Encrypted: i=1; AHgh+RpkEFFhdXfLrEVLyaQVMhvDNm2Vny/8QLQDMDN2zpE4/2yxw1JbLYCOYQqk/1LQkPNw/WhhC1g6hgMPefI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyrVlDAeyTHOyK2t9apqE/s9vieMVcvyPzTbYgBGXpffPPJlL4g
	wMnSv4pUcV8LszgkenKNfpg+sEN/waeUd/xcq0Hc6JyDyR2fFDpbif3RCRaTr5je76Q=
X-Gm-Gg: AfdE7clrn75dlnipQd6xnWDBMDRh0vwk/QvXDsUb3FOxiu/n/48M3zH+0df4m5wj2Zv
	h99Qi0jKh1yP9YfyURalc6cokd0CXKGEEiDGADZxyTRfTOKu3tK+OUc1utZIpsv30HWxYS9UhHN
	lxsH6BLhX6oFTAN+knxhcEl2tNrQ5lba8oawFt25adhVVyyGSUCAkr5ZES4TcSziO5t+tqUlA79
	AElN5kYkaG+vadFf+y5ohNMT6HFDG26n5LNhmoUR6kwhm3VMv3W3fcKpOH9qlu0zYA071Kv/z/h
	udac1BkdOIC0Xy8dSF0WThE74evnw3hb7fq7RF5cywW/UUz8C3DP01cvJJ4Am8zLM9mnh65LevN
	Ed1tl+eTxOKBWOEf5SS2Qy+YJH5PP4X0vlhAUikCF657AihZSMbf/C6g3wQze4Sq7oJDrWAQzka
	OTo5GrTS042WExrYs7SxItYZ4vJtWrlB1Z0swPSDoZ
X-Received: by 2002:a05:6000:4304:b0:46d:55a5:8ec5 with SMTP id ffacd0b85a97d-47df078bbffmr3378920f8f.33.1783525561596;
        Wed, 08 Jul 2026 08:46:01 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm44806847f8f.11.2026.07.08.08.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:46:01 -0700 (PDT)
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
Subject: [PATCH 0/2] Bring includes in linux/kmod.h up to date
Date: Wed,  8 Jul 2026 17:44:28 +0200
Message-ID: <20260708154510.6794-1-petr.pavlu@suse.com>
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

Then clean up linux/kmod.h so that it includes only the headers that it
actually requires, importantly removing the compat linux/umh.h include.

Apologies for the wide distribution.

This cleanup is motivated by trying to reduce the preprocessed size of
linux/module.h, which includes linux/kmod.h. The linux/module.h header is
included by every *.mod.c file to provide `struct module` and other related
definitions, so it should avoid pulling in unnecessary dependencies. Note
that this series doesn't immediately improve the situation, since most of
the files included by linux/kmod.h are, for now, also included by
linux/module.h through other paths.

Petr Pavlu (2):
  umh, treewide: Explicitly include linux/umh.h where needed
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
 kernel/cgroup/cgroup-v1.c            |  1 +
 kernel/module/kmod.c                 |  1 +
 kernel/power/process.c               |  2 +-
 kernel/reboot.c                      |  2 +-
 kernel/umh.c                         |  2 +-
 lib/kobject_uevent.c                 |  2 +-
 net/bridge/br_stp_if.c               |  2 +-
 security/keys/request_key.c          |  2 +-
 security/tomoyo/common.h             |  2 +-
 21 files changed, 22 insertions(+), 22 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0


