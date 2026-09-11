Return-Path: <linuxppc-dev+bounces-27141-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8B8C88E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 14:47:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhHSY6Bn3z2ygK;
	Sat, 12 Sep 2026 00:47:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789138029;
	cv=none; b=NsJojfnMwLuYlROW0jSsRF5XWFYFQe6uzv3BUTdBGi9WPmKRLdLZOO7E5DX6wkp48CO+JN2N9LnbCypvRDxPqEPnR1y/B8AK2tjIuVhChpXkZuUYASANK3d5C29a9X86yD7WV63ZtcubCMeDbd6Q0FicEOxNXIK4LRTadLogtMOTLL+0vjcADtSdOQEmJrPVevwI0PX7WtSDCBeLXp7AFEImOnvF1iPr2zwueYr7lHC6cFshVARMp18GIRT8vDacHdQbk893N3tsEY/V3IpQJL9paX5HAwhlCvZMc/GIn3xsNYg1BKkToJimdQcYaonTs7HIC8N50ivQ72btveGPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789138029; c=relaxed/relaxed;
	bh=sAWK/0nRwHnvVvMYnd/Ub3wFPGnd0x9DJjP7YOulvgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdEjoUuNtCv/xZwItFWXTMDhKRbDUYdoLqn3UY2tgrguzFaThxGGMF2vVpWC2isT4OvUh7QFYqkpgDszrBRZn7s8p7PFk0U33PP+iucm5fE4hviPgjRHxnHy9aA7Z18Omop3gAkSz655Zg1aEDkzWI5dYj8VJcJGAcNNuIgeKxqukskuVoKzPEEw1iw313xxMjPZo4dDi3vgiWOAW5/p/gglB5i85pZYbVZWC2XLNK+gpMMEG00d5XYJw8Z4SswgLUOxEiAag+xW+fJJeED3t0tZnwSvOm/T2Rxj6+ZQLz12VPa5K3iJFK667wXjqgK3I/IMdSX+WA5Ka+AwI1IMrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=LSGT1eRT; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=LSGT1eRT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com [IPv6:2a00:1450:4864:30::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhHSX5ZQVz2ytv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 00:47:08 +1000 (AEST)
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-48434392b02so769627f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789138025; x=1789742825; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sAWK/0nRwHnvVvMYnd/Ub3wFPGnd0x9DJjP7YOulvgY=;
        b=LSGT1eRTxWMBI23MV1Ad9f2OXRkE93MJ69xUL+vHG9pD7oyOsDW2Jtyfbmf9MvGP7v
         XjHFzdPrdeJ5hXeBU41H2zQ4LShoHR2uRlFDmvWZ9+S9THqDQp7Mnj4HlyivojJI9Of2
         871x0H9pPldGntmRPmZJXbldyefPeXWhK4lJ9rB4OoiU8R3tTgqRT/n7aCUlNgk+4Yic
         aGHmQZ2+dwph1m2SvExbeCdkookpb9Fna4fXbZGZaWv4vj3tJd930hZy1/HdGA7Kz/Sn
         empY3gfILJZcNgKOOUZwOx7gP0bwp4pU8xLsS925xZk3/QHZSImkYJcp1nK0kyyXBTR7
         TmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138025; x=1789742825;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAWK/0nRwHnvVvMYnd/Ub3wFPGnd0x9DJjP7YOulvgY=;
        b=hvEfKcsLdo3NYs3DcdZ/aoP/vzBgNBRUy0Ig8dwkMzuGFuPOKlWlJMBLZlIbIzodTq
         qAcmCPt/kXFtn0GRfwI2gnxszl0OEz8MQxducFc/5HGxUWZfSFbdfBlf4XEIxP+z4T8R
         Ga6w4hsCV1y5G/cOTP78mtAViVYCABdhqI41xRkdndwvqP9rW4BzueflUwThLKivftkn
         e4HpgDbSwHLvzcus+I8ML6OloEtw9T8OXEG3XQjpXjNar3BToNj3LII2CyzECWugzN5x
         zPMy5ubjNt2UpF/d5U7IhQ8MvrGfWJ2w8xDDtiN5pEOwfci9brKO7zF+74b6W4XMq8d5
         R16w==
X-Forwarded-Encrypted: i=1; AKwUvByVOSp1QnEr7AZXZjSHL3EJ8ZR+0kT/x0qIYxdrRoAQ9op1a9t+fbgBC7RAP2TCBz8uKZLSSBJsL4/tJnw=@lists.ozlabs.org
X-Gm-Message-State: AFuF++noFPwAnTSA5nFQv30vulGygOgWIyn0I2z6U8lvFl20iAPl6q1W
	zLSQNeCWC9J9g/oO43gy3K82KMFzAF1+LYaPWEnPXtzozDcX/h1j40YtxHFbfYMhM6c=
X-Gm-Gg: AYBFou2remqpfNrO/ZWqWRSScDK09DJycK2nntJ7D/VNVjy7E/OFXHldKrAU1AtPMJt
	jWwuRZA1I8tF1SFDWVDexY8Zuuah0uZISWp15Dr8KLqgV9Ol3tVncD3H1F4MhV+Clu9kJORB6wm
	2yk59ueaWyacQMCgrtzDs91/tF9i1bu9Q+GF4eumdvm4fy9d6YjTzIovcFAbG9wUpyK9/D5w72y
	NHyVXLNF4BCUH74CJxD/a0lEJlXHECOZQCv/jHM2/Kp3FWRcQRubmUjElXczUjoz9E7/nexn+MH
	cJcB2RBCewDnh1x0badC6KcXxSWaWgDrPOuyIQ8GuKp4rHNB5U9J4Is1bR1ow+/5QsWKOnh8sWO
	vx/DZh+QGdmZCaLsmPJbdFWrQ+WafSLtwba9e4JWd8NutZhecqxaIkgv5rdM8/3+4HzG2mBQaAg
	vgoG2bB9BCYi8ADadAfgsZf6cZu2LzcyVrlodoN1NOF4MF+EAJ3ov5oeq2WL61d1RpEJl5sjsCm
	Hk9tg==
X-Received: by 2002:a05:6000:26cf:b0:482:f61c:7cdd with SMTP id ffacd0b85a97d-486eb1d8541mr10746731f8f.4.1789138025130;
        Fri, 11 Sep 2026 07:47:05 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e8d1sm6328068f8f.11.2026.09.11.07.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:47:04 -0700 (PDT)
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
Subject: [PATCH v3 3/3] module: Bring includes in linux/kmod.h up to date
Date: Fri, 11 Sep 2026 14:46:16 +0000
Message-ID: <20260911-module-include-kmod-v3-3-6ebccc3e0731@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
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
2.55.0

