Return-Path: <linuxppc-dev+bounces-27140-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE06C88E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 14:47:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhHSW3GLTz2yqq;
	Sat, 12 Sep 2026 00:47:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789138027;
	cv=none; b=AQY+JeBkvLXsVKIytij0/JtMt+rcwfq78zlEeCvejpfwXXRorJ4x4YXnNfB/OE7TQvqdptdTM/3eXB3tCNIcxfB063Ov3uug0nVOBDZqlsWcaXBTrwrjR4qV0GqjtiUDxTGxYgNxs0UdyvMazAc/emvgLpXE4Oovz6fAS8mMWWgBu95pQ1zNoSDcZdVigwbCOFFoqkZj1Ooxs3zB7umj1GKWLK+BXtHeOR+htCJASLX07gcxDPlCWTjL1tPz6R9ilA6orKDQZl6iM08X390pQnwD3HoAsmUZ1gDXGTGv6KFXh4SMEQAnQtJZ6cza5H9dFgUFt0jYOIgEEKj5zs5now==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789138027; c=relaxed/relaxed;
	bh=QuYE5JBWhvW9oHs2kdysh3HB71WxLYQMcei9gKN4bpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mj4Erck8kPPy8Seuodd0L8qrxl1CC243YUbEIYUl+bpFiqfBr40Bbi/LOZjkid6BLkDHR+st6TZ5ljjuJmKf1GQ1QMgH7UKHyKazOyox1nUPZhKNzs21y8QCL2VPR/3ycyDakR+HdOGn417r+vlO2goEvfVqeuUVhuGjv5+ON72RsxKHeDyOs+1qstMvKQyJBW+msdhFsq+9z4+SJ0QhENstQjMAfHeS04FIalUV50OnOAmGZqONFa49KPuYEF2hLJLCdHiYXkDGCOPw5Txx7GJh8HT/asNoUtVmMBQ3A1dA77UTgSCpEUtKwz7phobn6clHfw/gC3tGMSagzpxtJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NxO2dtLL; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NxO2dtLL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhHSV2H7vz2ygK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 00:47:06 +1000 (AEST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-485850cbac3so535225f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789138023; x=1789742823; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QuYE5JBWhvW9oHs2kdysh3HB71WxLYQMcei9gKN4bpc=;
        b=NxO2dtLLFAEoGTH/q+oFNtGW+ZMULpbI2IFJzKUjCiirn8jhiun5ybn0CvDXwmsUwN
         0/heqUqxoVSLJxj+C9+ocamklcvsrq6F1vj+WBOy15wfADj36bMTPN+/Adqhu9J+NopA
         0s5qdZac3kOstqKzKqckfEn1PN8u8jPX+yEkZ09n77/uKNDI9PqVLSKrGDHEghJOHdFo
         NraXaiG2/6b8phc1GEJWxpRq9h9yAXJv0mSkehTQuS+9AJ4FH40ZpFrL8ZbC8eLBp5Rc
         2B8XM0Rk6SxQHK3PEDg7kCQHZz8cCR4C/toFHLBnmt/wbW/w7eXBb01CDp9dJNhUNJUd
         OKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138023; x=1789742823;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QuYE5JBWhvW9oHs2kdysh3HB71WxLYQMcei9gKN4bpc=;
        b=CSZ39wFvxjDF87yOGREyFGTVpB4pzWMeYzM+j9uajZo/d79ZN4A+1Wo1nljEnf26QA
         Gul0CRTsRDGbjusjNWNItSjKwsquUfG4u14U4bjjhOZGYicjGoXJ05htqn4QbuTGvmMI
         9QAvndNadbJOIBiziHOufSR9uZbsimbzC3YmNWI32Wj8IO/j5h0evYC4MKPAp7QWQ6g9
         cRVkeuaPDgqxCb0opdzXc7odLpwmOO3X4e/TGEywJ19TKWd5dgyHXv3sozTAopq82cz6
         m7tvbRc3/Wzr2ZJmbRJN8JdYmkAtQ/9r5h76RBIGIXtxPCFtH0rCkd9pnA3s+752TvhY
         cwUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDCnV2a4D0+IIByJdlFQUBW7qhkZjk6TuTFT2dh+Yc+SXsca36N8Jplp0ZAUvKoSLk+AKLbzoGza7abDY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k9LWwZSS4W5zykeMy2WeY4Z3IeDl36/G77lV1nnwj76qRjL0Kl
	xaR6r7TDEG/h3OFrEHWm8QHUVOduq+ZHyj0eVsNf//W/BijF4cW5dkDLI7kren+vc0E=
X-Gm-Gg: AYBFou0lDq29v/YzwFMEqrGdUgvgPvyV3qh6bbJ84TR8khxREZybcVQ7zy8FD3QA0bZ
	1YlwQYnB+VL1NOCw4vabXHpqJuT5mYTSnVsvmpS+maEVHSmQZB1v3PvQzcEvUgSFMnba3QQsL8c
	h1Xk2qNSb5nIscufbTf83N20o4WjnGVsakgvFRF/yx6Jqu/jmafQyLvkRBBLac7TFc6Rs5V2ph9
	EUPj0tbrP06xl8nJMLucaVgoLUGW1LmVd6ATqepH9wEMNsUZZx/5dh0dUAJOwJOw2fIE5Jp+Njh
	9KvPfO5Ta3Yepptm5IwVOo1IO3F9LWZBunj4QpZWEMFDKhepOTaORD+0kvbVO6By2miK+eRBWbh
	+jlVkWeYhEAotzwBio6hFD/vxzKkH2iZtYRzR38haAKm3fYyVd9PVOCNJ/oNafAnezd0C5syquj
	zkYrwi20FjyDGd28f84GHxvyER4kj8tlmrRbH9Q7HicZp1OlvI5eA6Yajzgj/juLhmG/6lgFdTA
	/MiNA==
X-Received: by 2002:a5d:5e08:0:b0:486:e81b:842a with SMTP id ffacd0b85a97d-486eb358ab6mr5259626f8f.48.1789138022582;
        Fri, 11 Sep 2026 07:47:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e8d1sm6328068f8f.11.2026.09.11.07.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:47:02 -0700 (PDT)
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
Subject: [PATCH v3 2/3] time/jiffies: Include linux/sysctl.h for proc_int_u2k_conv_uop(), ...
Date: Fri, 11 Sep 2026 14:46:15 +0000
Message-ID: <20260911-module-include-kmod-v3-2-6ebccc3e0731@suse.com>
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

jiffies.c uses proc_int_u2k_conv_uop(), proc_int_k2u_conv_kop(),
proc_int_conv(), proc_dointvec_conv() and proc_doulongvec_minmax_conv(),
which are declared in linux/sysctl.h. It currently gets that header
indirectly through linux/module.h -> linux/kmod.h, but the latter no longer
needs to include linux/sysctl.h.

Include linux/sysctl.h directly in jiffies.c ahead of removing the
unnecessary include from linux/kmod.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Acked-by: Thomas Gleixner <tglx@kernel.org>
---
 kernel/time/jiffies.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 213ae1d6a014..9231fea557ce 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -8,6 +8,7 @@
 #include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sysctl.h>
 
 #include "timekeeping.h"
 #include "tick-internal.h"

-- 
2.55.0

