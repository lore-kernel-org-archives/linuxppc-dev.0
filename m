Return-Path: <linuxppc-dev+bounces-24598-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F70C4452F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 13:12:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4Hqg3Ykkz2yxB;
	Tue, 21 Jul 2026 23:12:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784639567;
	cv=none; b=X+6GHoFT4zjf7OrSQ8Y8EHMHlFkMjnguk5ezDGQUBJWw6/IZzlCuLDacvAk+S8pkraKxKwRJAEMdyJ92Z/3V1TiyCxdoCR1sfcXYsYD0xTH4OXTPyK0GuzIcf8RHsyhYgNtUEAoq5vvyp7KNHeAQqrwn1KG78oLyRrrkzdvRbxYYpWmRYbnBaa7cUpIxivWLzcEJ6CT+AgZXiXXFMMFCyxMQaQBu/ZHfWN2B4Fd6dfbRfTf/zwpIsAySg8BlJHxQvXyzfTA0t2UIMGK6DDmLd8orDW8Qb55vpwo11tU/OebED3jYaVPpdHKOTE9CUEggp3HLC6KBW7zHb/I1zkKWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784639567; c=relaxed/relaxed;
	bh=uFYQPc/AUmoponr7iNZhaXGCIgX0+Ls311ZPwQA2S6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYAcZM5otoLYjZW8d3+rd0IL4z5DUD+Nr6LlEME8566aoRlhZIGFqxUajvroOPJPxLjd6zxfrg+R4frz0IkCejcbGAorRYRjPiaB4KksyVX1QboZJ4/MCqPa0boYQERJN9LLIqZHoz5STd4CJsnbEhx1S5JKV54llrCzK1xl46u51L7112rWCLJN4zeLfVfO1FD8C7NuAcfAyiQlb6wXEP33jbh6tvR15IojdYQd4voKzZIa1XaA79rz8I4n2rdYORUi9TzCcyraKEYF2r9oCV6j6RkLMlHSqrhYHtKxj9oljsRw4ORfVlisAp7NdhOx20aIY0ltFabuF63gnm+08A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gVl0uKuq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gVl0uKuq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=petr.pavlu@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4Hqf2hmFz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 23:12:45 +1000 (AEST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso7409358f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784639563; x=1785244363; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uFYQPc/AUmoponr7iNZhaXGCIgX0+Ls311ZPwQA2S6I=;
        b=gVl0uKuqJZA3WwVeOlG4E5w1GkbD1Y2dM+xLaSl3WispIsX+wDl82WGeYHsd/dB+BN
         rMYTThTn2M70WJMauR53/ki3DUu3jo5KiRIPbJ9gwLXAG/22SxT7wc7EzS3A9PNALRCG
         M+gB7UgeNwb56ixf0F50tZjkDGbqTG7eHndGqeixl/itTUUGx92Q+0o64nX6lYEK2xtJ
         RbWu3K2vtGXZEQ2m0siZdC0FKukFFNfH6w3OvIKFsQfiqJWQFxSrfgyA6dCEqQ4159lu
         3LMKZxzx5xumThgMzAOHnapjfAv+qO7c+8MtWQOBkEl+k1NH0PN2BL+VWODHWEE7QpLL
         OMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639563; x=1785244363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uFYQPc/AUmoponr7iNZhaXGCIgX0+Ls311ZPwQA2S6I=;
        b=hnP3AWGiG/CxuPL72hTXIgNnRxaLomuJvHphqMKyernvrTCk0597NzEM7GZyTT34He
         uBqaLI/jnflhUD8SJ8JEJp4sZ3iNBKmerzZpEyX1CxTHRex9RrzFyT7LdSH6iebukZGM
         gUOMsYbRNbxbvpEAB3boLKqEmb6oLkW5UgLJxaj2mHuA0dZnGYkiRLrh8w9wO7c1sYBV
         qyNC0CP8r7TF3yX037YIkQfV5gx2glYKfWV+rupbJTgWX+wyzN3A5U1xZeDKtzHiu2Ie
         G+jyYn0UXgU1jlk6h/0rB66YzEptn7O/O9DmLgS3CxMY89MOdm849pYCtRBWVvyqiSBY
         u/rQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOUBH5r8nCQeLCPSNFuBfvaCa9fRUOW4FMbAXnXZmZiGmhIZdLfUMenEyPi0Mec+KaOozTjsRol4OySgg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz8JvtnYNUfmOwiR0JKYot+5rOgGB8ungANFvPYxq/HTzXf2QCK
	6WF5pyVcOhZqhFvhNhMJ7u7I5q3djcIOBLtrd9t0QSoWB5wOaRwVZ4n6aj6vA/7D2XQ=
X-Gm-Gg: AR+sD10kJADF2pWBbHHLRcW61uQAs+RJQ78cbYeFUGbzXAa+fSnME4qfLckD9z0iQSA
	1kiRDsBJzZaOHuPBJqD6VVs9rsH3S+ByMhWQRcwApavYQQlzYduRN/tnsHrVJdd/+gEz6tM7UZQ
	cMMs39kYjTPlEoiBxY/Xb8V2FI4HKRG+KXzuo5YBE1C1KXtbEgnxQnu6jJVTOxLO/QhnZGX6BKX
	UgKaF2PJhCQSar879J8FptrT6IMX+QwFaCMEadzUz1dmKfG4S6SjEQW8eWvT4KdNTQ1knCqO14M
	izvPHrqaAEE3vpspAlJP834I0GkWsPY/pEcmCS5HndeoNJUOyJihRkMkiKctI+fvohjE5viZZav
	7Vrr5JCj7wyMVlc8u2c5gsQmypvJPJP1Be56858N8d8825DGUMJ7fZO2Wj3uYIttiTyVgqyMSoQ
	==
X-Received: by 2002:a05:6000:4023:b0:47f:81fe:12fb with SMTP id ffacd0b85a97d-47f81fe1712mr2452175f8f.47.1784639562827;
        Tue, 21 Jul 2026 06:12:42 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm42070938f8f.36.2026.07.21.06.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:12:42 -0700 (PDT)
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
Subject: [PATCH v2 2/3] time/jiffies: Include linux/sysctl.h for proc_int_u2k_conv_uop(), ...
Date: Tue, 21 Jul 2026 15:11:26 +0200
Message-ID: <20260721131207.803760-3-petr.pavlu@suse.com>
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

The kernel/time/jiffies.c file uses proc_int_u2k_conv_uop(),
proc_int_k2u_conv_kop(), proc_int_conv(), proc_dointvec_conv() and
proc_doulongvec_minmax_conv(), which are declared in linux/sysctl.h. It
currently relies on this header being included indirectly through
linux/module.h -> linux/kmod.h. Add the missing include in preparation for
removing the linux/sysctl.h include from linux/kmod.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/time/jiffies.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index d51428867a33..17cdb5ef8893 100644
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
2.54.0


