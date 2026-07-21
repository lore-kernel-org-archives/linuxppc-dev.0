Return-Path: <linuxppc-dev+bounces-24599-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C89C4452F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 13:13:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4Hqj1Pg3z2ySN;
	Tue, 21 Jul 2026 23:12:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784639569;
	cv=none; b=nixt/tIVY+RSarTYvFAs4UOoYs9tT51BYRdM3ASph9TqaKdqmbS/E8yLHGHafZRW1zbTy9VlzRO/b7v/iS5OD3OULGbb0cDlHjAMQJ83YW+UzM0aWcAXOdjbiONJCZdfKP6BDIbKQwl5VMI1EgD5DPt5arQV+9S7Z/9nRqTLm/Q8sEAXlW3qyLkfbjLBESCzUtTGMXzTanE/re6Vm2w/A0485bspaFdXD9w/ybUMrUSZBE6BIaTTvMOfCisoy2oMl581J/Y1q6xjolIFpygyDt/XpYK6rkwk+oqrhMgmY1wfBQasCx2mCPdgxecfSZjh2VVLIyE4pWUqWRVwIFvxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784639569; c=relaxed/relaxed;
	bh=LZcY8JywvKXANV4b4Y/mnnGxXAY43BzjPnwULQV05KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5NuOu+DZa66kK/jhXYknjpyS2JE2GWbmM7U3C+TxPWYIv/dIkOqN1kMoxp4IIdUuQBGeEd6rZYBpd12/LBM8SaLzUtVObdMwLab9rq5+AHBl3l2NbVBftc8RHS9IZmG1NN0CV892/qjA2wTO+KDy51dNJcXAt8WDrEmLRj6zsNWAJ8C95Sey1U4ul4WALvhIpfw0D9qtMB1wk6jYdjRWpprKBAqFFgJKepin7dZqy40mhdtpnYaXjqYRefmMsZ9WIed6hF9HdEtC43TTKVgaxDsSkBt6aS4yEM1lu5ZEyvzHe8cxEVWBo3NnBB3CE7RLJkJHmBC/uQRUODzLMV6tA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=UfqWHKC5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=UfqWHKC5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4Hqh10bVz308H
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 23:12:47 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-4798bea72f9so5952099f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784639565; x=1785244365; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZcY8JywvKXANV4b4Y/mnnGxXAY43BzjPnwULQV05KI=;
        b=UfqWHKC5drh8kcUq1pYtVhG3Zyjy9qlNjDKFzUNQmEY1LW50wVz+jxIc51mKMQFw+i
         x59C0iIE5N9caPiZPEpW9PNrCeBZNrz5VJL/4MobWbvX5XqLnoJlsrMjILUUT8DRx/Hx
         VJ8paK99F9DSfAodXJjJKPc3TPaCRMyBxFaFa9UGlW5EiT1rvcif60RpSuEIwI7c3fIy
         21vz8nyLNBm+sBwIz1SzhWYIISBrJDtpnlgl+EJmSooe6W4TPT51lijykeuaYQd9I1zm
         efGiEE2VG5WI9ZlO5k5dLIQF7okIN2wOZkVKVnenJ/hufWuhA7b2GBDKA0x5vNU//Q/h
         wTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639565; x=1785244365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LZcY8JywvKXANV4b4Y/mnnGxXAY43BzjPnwULQV05KI=;
        b=X8zMhxC4v+DJf5+XYsAix0SP+IzTOAOyBeEbEMzY5K4yj8r9njw1IK8yR2Nw8AywyF
         40XQgi9cBEjzkmYb+I5Q47KUCUeXRIdqGPFnRAlqi0D0ZU5PxMP0fBQ7UdWKRoVMXmZE
         GkXwaynLgKuGo4sdz5LvLAVhgf9xdSrmOmiUddmeR17Yn4o5lDW792TThaZbPur4YzAc
         juryUeyPojD1uv8i1gs6IY6EgNvYvLKRYP0Kcfrk2gDP9V+d+zMYBKCNXhTQShVBD1SH
         fjj4zwsCKWshOTXKoLonSl2rLkKMjz4XCTBd91TnW04HEhbQ1BBWmADY3xR5pNi/pKi3
         L97Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq7SRiCB0vpcc/3cxInHCruWat0+RYz4qFyTKavTcLrezOrcijDFvQgh9qV7ZaZzpqv4gXD9TDfEnmTAVM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz1CSBJ1ckFcMMQiXAmDrXThRwDJ1xfl2V+MrLzzz9g/TqiS728
	A2N+cFTMXVS4KdZAFNBUh+/HU1Ozd2qYaNcmIgL4jw+jYeQeHDF7H2AQnKcrUtQ2iJk=
X-Gm-Gg: AR+sD11morMaNuVUgCgSNKFSQS5p0yrj7ExWI1k7pUkhwBXRZ6dBZczy899KR1t18nc
	VWTU0I6vQqI+FuukoPnc9MAmmLw6IzxrLVDPfmH1w8zBDpknFTQ9MRIl4uHWKq/0P/HLu1NUyeO
	FgrMZZLxFBmVHxkkY8MMOwQgR2p9sgN1Pk/WFfbUkelt4hDdYFenWy/8Ik8YCWwToyMIpLTenEr
	noiz0Le9yhKVirj9JA47MfmjIeandXfCkuANWi0vajfUGIYrxyO7O72GBq0uegDhmVy2aFMyaW8
	nSPtSmIgLJKJkPkuQY2eA2kcOP9BDGe+PMOZWF98xZhMwTerzR+WkcC6jPmwIelOGmcI2M87kJJ
	/MrfRXpgnqcEeu/tDJ9y17oQU1R4xtaLO9yue2ca7rXYM+ATFRO2VYHwYQ6RnluJDa7YUxC074g
	==
X-Received: by 2002:a5d:64e8:0:b0:47f:6fbd:8a17 with SMTP id ffacd0b85a97d-47f6fbd8e65mr15616435f8f.59.1784639564680;
        Tue, 21 Jul 2026 06:12:44 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm42070938f8f.36.2026.07.21.06.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:12:44 -0700 (PDT)
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
Subject: [PATCH v2 3/3] module: Bring includes in linux/kmod.h up to date
Date: Tue, 21 Jul 2026 15:11:27 +0200
Message-ID: <20260721131207.803760-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721131207.803760-1-petr.pavlu@suse.com>
References: <20260721131207.803760-1-petr.pavlu@suse.com>
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

Including linux/kmod.h alone results in 1.5 MB of preprocessed output, even
though it provides only a few functions and macros.

The header currently depends on:

* __printf() -> linux/compiler_attributes.h,
* ENOSYS -> linux/errno.h,
* bool -> linux/types.h.

Include only these files, reducing the preprocessed output to 10 kB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/linux/kmod.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/kmod.h b/include/linux/kmod.h
index 9a07c3215389..b9474a62a568 100644
--- a/include/linux/kmod.h
+++ b/include/linux/kmod.h
@@ -2,17 +2,9 @@
 #ifndef __LINUX_KMOD_H__
 #define __LINUX_KMOD_H__
 
-/*
- *	include/linux/kmod.h
- */
-
-#include <linux/umh.h>
-#include <linux/gfp.h>
-#include <linux/stddef.h>
+#include <linux/compiler_attributes.h>
 #include <linux/errno.h>
-#include <linux/compiler.h>
-#include <linux/workqueue.h>
-#include <linux/sysctl.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_MODULES
 /* modprobe exit status on success, -ve on error.  Return value
-- 
2.54.0


