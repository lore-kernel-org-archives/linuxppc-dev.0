Return-Path: <linuxppc-dev+bounces-23833-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCB1C43602
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 15:46:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwMrf1zzkz2xpn;
	Thu, 09 Jul 2026 01:46:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783525570;
	cv=none; b=Vol776rqUtZtseuEpV9W/Ye28GCMZVojWYrzi7g+DPAPXQxWuXu6OUP/6TnB1IId8Vi915IBAsAHD4fvdv92c6tOwiL3Du0iDZ3PpJxOZWJBeEFyNfzbnW2zVDSp2U7HQM8epx0QIaTUzqSgA96lOtnrSvQaYrFca9NY3ehW5DKfqxhIPeMAqB7CjKf/uOZQYNPys5k6VFBnoHf8w7LY+Om3z5PkgStRBUswHoQUkj9wiYX1oRjqq56alwv0RNiJEeRlseWtgUgd582kqonCOUxSAHmaiUeUcz+BZAPvAiKbB6OyrYdWCLqMN9X5wBQJB0FZDOeJ6JRAIbXANQPgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783525570; c=relaxed/relaxed;
	bh=DFzX8ayLrWD5LLPflyw5iQn6+h660qomUnmCAVS4si0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLlfitrTwS36eR8e+gzQt51avFzvygHsSgX9AHTef6tXHf+/oU0DSKJ94eaVkowL5PikSMTbTO1s0pd6LJUsi6NsUUZ23cx1iywqs/qM2Xl6zvcNX3EF2HuRzdsME8F+jRmYrHshq06r6lOaMOcYZv6aQ2hvp+Hy8yOnFpdw4GRjgTdKH7F7p9elEkQDTT6a9+4o8Rm1Z7+BTa1f4/RDD430jr1XY8vhFBNmjUx8owg0L+ZWZIUV4tapeEtrgcgaVwdV485N1RojEt5+APqV/f1+nGkqxlu47OQYJRMkHULiO2Wyqrd4TFFUUuF7gw2xwxyKY0NZKlI90Lmi+f1EXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Qx8sAeqo; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Qx8sAeqo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwMrd1M3pz30BH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 01:46:08 +1000 (AEST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-474560436c3so804050f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783525566; x=1784130366; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFzX8ayLrWD5LLPflyw5iQn6+h660qomUnmCAVS4si0=;
        b=Qx8sAeqoqHku9yeKhfkMSSe9ykHh1Z86PSpo1VfElptt2rvl3Fpe41GfuDtCCAZjNF
         4z9qZzJHLY2LHK4p0U4F2lTt092hAjZLdxo5px5lQxQd1TzTAwfTdnk9Knew2dTbDN5U
         co8Cc5hFoQTWzXIsLcx05h+VQEwr8Ned6Syu077cllMpkSmv6EHvsN5APL0nxz9Vo9DJ
         M9lpY9TSzfXdKwnmvbzAK8rze8A3ETeQP2M0utX5Jjp+VpCod2ay0OoVA8wWf+kejBeu
         tNYzRZMhXqVSorMaCkzxaMpLGUs83y+w7odBYYowa2GzYIEVNWuzD2AjQkZAr3fbKtFS
         bOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525566; x=1784130366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFzX8ayLrWD5LLPflyw5iQn6+h660qomUnmCAVS4si0=;
        b=dL5nAQEF0r6oqqBtwzDKlgJf1DgZDXVKh3JKe16L0J6eu6nFeTAdDqW1YdEW2u32CV
         9Y6C0l78WlGZOXjgMj4ARl3puyBcXXJYtsphcJtLnozLzNs+r+GmaSgzQFwo8uVYH1P1
         kBHTFaCNYtbzts12MRP0zAfNJbpW2DQlkLhDCcarAo4X4BgCXuPCtPV0haRp4WGWsOiY
         SBHjF1JrPF9EKnOECw6GasR9bZrfxlnvrJLviwwOQFg3CgMqRSG7IKYfis2epnLFXUHH
         ZFPr/tLv2jJN/igCE1JJzISu4m2xUc9Sz8T75Hsr0KIzayYZGO3/HiqXs1U4T/9gv07Y
         pueA==
X-Forwarded-Encrypted: i=1; AHgh+RqKKED0NnAEnYr0yZC+J+/L03diis/aUJoEKxgpLtQzYLJwCD+XsnloNb/zE0uV9mFSHWHT5zRAIPL96yI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyvE00YjbxqYxVeY6y6UoL2gVLG7MlkWUVmYrEc8E4OUIgMMkMZ
	qY8iwfx43kZDCQ3P6QNqx9EaeRy1sHIRI/6q8VTgVrWTQJ6uozpW28j/wo3r686MwBA=
X-Gm-Gg: AfdE7clGFSNCiWDF7lyxcAuGJ8gQFzOS1WW1hlbmNWPBu244S7KU+9N/5wPz17xZ7QF
	Eik6R9w4REGg5Z31J2vyiEMMvvtyBiQzCqpFN/DaWNZP0CsGv49djoLp2fbmzsbPX2JTupkPiw/
	8z/lOBBt2JJGx3ExIJp0jrvn7cjyo3rWAzi+fB9qY05Kcl9yDJDqv1d/CHKGWSAwSzs4CgXcwEj
	EUU762rrJQNw5Wp8NCyl5O/Fpg0d+KFwpT9dd5XuqED2uMDhe84lbjHJ6C973hf4i3SHl/mCLSB
	JoC3e3k4hVfhHqIbjEvZf6C758ptnwzxHCTOBxc4ZGk7GNFl+dIYhzt6XYzoho43DbZaY+78PrW
	+np/Mi+EGaGU0PZHd80eBlaXfDwEcLvQHNpfFEe1GIWt60i489lqkPC18ycBnEEcLl5Qyv8xFUK
	CyaGT1GeGn5Z9a6oWZcNMF1HnF01mTIg==
X-Received: by 2002:a05:6000:26d0:b0:473:673e:3836 with SMTP id ffacd0b85a97d-47df078bb73mr3861713f8f.28.1783525565920;
        Wed, 08 Jul 2026 08:46:05 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm44806847f8f.11.2026.07.08.08.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:46:05 -0700 (PDT)
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
Subject: [PATCH 2/2] module: Bring includes in linux/kmod.h up to date
Date: Wed,  8 Jul 2026 17:44:30 +0200
Message-ID: <20260708154510.6794-3-petr.pavlu@suse.com>
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

Including linux/kmod.h alone results in 1.5 MB of preprocessed output, even
though it provides only a few functions and macros.

The header currently depends on:

* __printf() -> linux/compiler_attributes.h,
* ENOSYS -> linux/errno.h,
* bool -> linux/types.h.

Include only these files, reducing the preprocessed output to 10 kB.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
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


