Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D851C60A5BDC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Feh5hAVl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPP708nzz2yQl;
	Thu, 19 Nov 2026 14:40:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059610;
	cv=none; b=efQEY77ZfUPOs5qBgNBd0+PxE6QmYWnTQJ7mc8CCBnITzvo3RtjiuYCV1zLeRp8tMDoheY2jwnzgkWfOy12vu9sDFz18udOpsDXlw9EfnpAUVgh6PfClkz8myB9ueCLoNfvuSHRqLN1DQ6DkYTWdrDcrrmGSNFGeGtcuMinEXrbJKNYnSNhbxs8goBadWKsD+ac1e6f9T4OMrKc1vfk2thLIGEQrtfFw+mb9yGW71okR7SIG8apyoV3bf1RB1n7jE6Sb2EN8ZWHueGGE0hgNGN8JYc3zszWewHocIw1uvRByi0nqbDm9f1PlPCFHYAn7JY2q7p1+/Lqi4ZGgk1XVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059610; c=relaxed/relaxed;
	bh=io+CTWk+B5zCdv2jhfadGeS4AMrXIMCEILzj93M705I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/tS/rlWpU+C6BwmCHcwlJikZWwY/CIRPj3Y65qzAKFWYvFp6pBtKks7OD9GapNOkX6bUZ3oZt8eDIQ4aGK6AjNeoUKqATGpTyeKb2IXGX3RbW3KKkw7cRIl5RH5a0ZIF082cDf7kiRgVKpFcG1Xx6qT7vKGiFb1aXrTEZAcO7MLo8i7GOJt24+/QF4J3B3D3Avwb5icG5KWwm7wSy3Q7IvthirXWnTNJCEddRu2G8f/YQuGTaMqf4p6+8+ZeIGZDnluC+jrbSOxhTKgoveVz7QJ+mvoRt5OXvnItw8Y4j0AWEsq5ni3aSDqzyGDTR9itiIcKnQjou3HeN2+5BOEvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Feh5hAVl; dkim-atps=neutral; spf=pass (client-ip=74.125.82.176; helo=mail-dy1-f176.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Feh5hAVl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.176; helo=mail-dy1-f176.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPP62yzLz3bVW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:40:10 +1100 (AEDT)
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36f8cdd30beso2254949eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059608; x=1795664408; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=io+CTWk+B5zCdv2jhfadGeS4AMrXIMCEILzj93M705I=;
        b=Feh5hAVlcN5g2UfETEepYiODouABc5V16iQEieYAqgjS9Rau821TfSOGCcd6O9MRH4
         8Z+0dwy3TXcWihjqYhSi9inrEDlwJ7IE815AZ6upCRvEYjEOH72Fqt4l5KLytEM7GW4a
         hqtW9IJrpqUmfu9GXyCVaLt7saBh/n7FYPaXtxYJUSTPzbE7wd+7RKZSS085PvlY+ySu
         hIWGiOPvcVQ3WmZN/S9yKrhSbDTnDs54grl9Rar5NpDFALs0JZp8J5dKC1n+3fTwGpR8
         RLrFWLHpL/tp3tci5PlJcUtxqeTMCe8pA/S64fqcS1BKbGSyQbLI7IQYsHSnW+lMnmh7
         vypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059608; x=1795664408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=io+CTWk+B5zCdv2jhfadGeS4AMrXIMCEILzj93M705I=;
        b=RsyHEtt5o5aixiC5lB6IB3AdEyoVn2hKqWTt1eSkx1kHFdWjrgIsNT35kNW4jxOxol
         rxXM+P3Pz/+ogSpLDgy+7qGgx+r6YnO6ezZCDztaKTlNSAfuUw88cbC4tvr2zvbVuehP
         VRAFFtqaY71gJVB0psv5/5bnn92541xcIlvhbmJjwwUTQ6F0qg4o0ouFWpTPOOhrHpmr
         GL3F9O04Dsa9bfwI7RrQrmFAhjnoBtjE48DxX5LT4trs0lCNNvC9SJHU1yaGmT2rLBwH
         rU4LwEUibKgEMrgbvH0O9yvYCaPMyk9Y8+lCQI53hzhpa6fMHHrrX95nm2prJneI+xut
         wH8w==
X-Gm-Message-State: APuU4Z+HRro7h709M+pLpAHCiTGdpw9GLqTblpUS4TFnD8N7nb9gpPvx
	LGx40zs1TwVO/iK5rQJZyj+lZuvQ/0ndpGT1G7qBmbAZp9BWp6LsmSkv2LvUYQ==
X-Gm-Gg: AZFdTZesqgrgmyqeTNQwfIgfg6rptG10c56G+aM6s5ay4KgQR1FIbG8DKx6f9I2y6AT
	N28ukYOc7MNobfWlm7pZ367yprDJhvmdIBFqbyIUqTPvAJmGMgogWry8CKaOfJwYvcWqAWramEp
	iCR01wrBH7osDlnRNAW5k4uF4rCM6xNi+xubah/l6bjLLDTL98CaifOC6NOOh9uKqV5Y2FeBfDg
	oSkbZ3kiwW7SJvoAKuwOJ1I6Br4GL4jhjak5iUh+nyw8IGL1mmNZrp8Dn7b/11RozAJSC4bRJpm
	KioyhsH7R2Md0+ASI4jb/+1RT1CeCBLDiX/4TI2nIYJJi5ia1vnxVitI8vFs413fP3qmB/z3DYN
	ci9c3ooa5VWOKvVFxB/PFLb0u8gaqkcAme/KlEJ3+IT7QB3DYDGHhkjlIdykedJ2GDEIZ4aJK/9
	t2b80RZFM58LhjZ+PSpbNqxZZrFyOeIhGiiyCpgchEQGDIAdIR/8ozvA/mA+hvuVneIFgJhrb+G
	s4SFffyeDWSbNQN4TlIvV5hIKipyjiY3gOE0EIEYn02EtlbPO3G1Nl0nxPq1WMqxVISufkqsdzq
	CSFGI5Md1vsKNU+Oo2N4X0K+0zOUg9GT1iXRQulf2povLuje+EYBdhQ=
X-Received: by 2002:a05:7300:e9cb:10b0:374:ea35:9069 with SMTP id 5a478bee46e88-38281fe7a00mr4592092eec.39.1795059607772;
        Wed, 18 Nov 2026 19:40:07 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:40:07 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 10/18] powerpc/pseries: Add context annotations for the DTL worker lock
Date: Thu, 19 Nov 2026 09:09:05 +0530
Message-Id: <eda42f05405e0d43b9fc19c8c7f4cc589c30921f.1795058683.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795058683.git.ritesh.list@gmail.com>
References: <cover.1795058683.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dtl_worker_{enable,disable}() needs annotations since they acquire and
release locks. So this adds conditional annotation based on return value.

Let's also disable context analysis for vcpudispatch_stats_write(),
since based on received input, it can leave the lock held until a later
write of 0 unlocks it. So we need to mark it with __context_unsafe().

Otherwise we get following error on enabling CONTEXT_ANALYSIS on this
file:
  lpar.c:490:9: error: rw_semaphore 'dtl_access_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
  lpar.c:498:2: error: releasing rw_semaphore 'dtl_access_lock' that was not held [-Werror,-Wthread-safety-analysis]

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 5dbf447d3a83..9965ead1e93c 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -461,6 +461,7 @@ static void reset_global_dtl_mask(void)
 }
 
 static int dtl_worker_enable(unsigned long *time_limit)
+		__cond_acquires(0, &dtl_access_lock)
 {
 	int rc = 0, state;
 
@@ -491,6 +492,7 @@ static int dtl_worker_enable(unsigned long *time_limit)
 }
 
 static void dtl_worker_disable(unsigned long *time_limit)
+		__releases(&dtl_access_lock)
 {
 	cpuhp_remove_state(dtl_worker_state);
 	free_dtl_buffers(time_limit);
@@ -500,6 +502,7 @@ static void dtl_worker_disable(unsigned long *time_limit)
 
 static ssize_t vcpudispatch_stats_write(struct file *file, const char __user *p,
 		size_t count, loff_t *ppos)
+		__context_unsafe(/* dtl_access_lock is held from enable write until disable write */)
 {
 	unsigned long time_limit = jiffies + HZ;
 	struct vcpu_dispatch_data *disp;
-- 
2.39.5


