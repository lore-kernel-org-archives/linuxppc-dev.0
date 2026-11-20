Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F310606A33F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t3hhIMX5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1tV3kCfz309w;
	Fri, 20 Nov 2026 15:04:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147458;
	cv=none; b=VJ4OBdAiN2yBpyW5MZC/Mn5ErmI8eU3VN1MY6cMWckUuIxm3W54uXa3ihJTUk9SwbWY6ed9iGs2g8I+MYy06GlSYdtyYhipvRLDRx3vDG/DhVvWwYOWFyqPsTOddbuRTeUmwclBHofErOoYMdr9rkX6Kis4tSoSN33z1r4ilUsyn+haK6ftEH3cuq4LFyBVsnnomIK1dUUanuPh1ylqQPVziIyDwerNRpnXjhm97wpxDW+p2LA54Ojr5XghuemYfO0E3o3PBCgynFlG1LY6rmml1kSIvhm/VNU+vyXDXuau9+ECwJkr37gxfdT3i4UA2MZDE3dgnbTWEuOGwnJVOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147458; c=relaxed/relaxed;
	bh=io+CTWk+B5zCdv2jhfadGeS4AMrXIMCEILzj93M705I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzZRbAGFIDuhZF6ftf00+p81JNc5ftEh1rMI7/HlXH5kFnPJ3i78vzIIgMYxt+zwIhpSt8Yy0fwh1hoGryiyFQVSqe50OPPYmyZyW5etyGiVdRJ3K7wTyKWrxLItcR0o84ygN8YMSFu1JS6hnAwPzoXY+MGMSZ/6sc8ObsK77ZYRwA0TeMjdAg2r3Q6CW8IG0yZtOr20mK/XMRaT/27tF4946aRQJ0uUgR3B+VC7/YqUDI8M8sAYjXA7asYTnZnaJlPr8bZZJMVRJcMBpmggT7rI4t6cW50o7NjZ0h87bgJXUrrZYA+9vmSv60/J/YniHx89aEB+FB9uWOFLV91q+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t3hhIMX5; dkim-atps=neutral; spf=pass (client-ip=74.125.82.176; helo=mail-dy1-f176.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t3hhIMX5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.176; helo=mail-dy1-f176.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1tT6ddkz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:04:17 +1100 (AEDT)
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-385c497bf94so498001eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147455; x=1795752255; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=io+CTWk+B5zCdv2jhfadGeS4AMrXIMCEILzj93M705I=;
        b=t3hhIMX53F4hN29RPJN2kzofWuQo+2JFHm7xRNtaKOa4TQN61vzP3B3/C+aGjKUIOl
         41iOIR1CXtbeZRnt1qrtuSLU4IwYpHtTNZmvCnz5ieQeaaZiUZKay/md/rba0rsaOPcE
         3iCUyafNn/dLHK7dB3KlucujJtrAHhUd/Ai8WyZGog13CPFh2E6sC8imhiPtYFujdzI/
         p1wWPuAeZOPVzYZl0/n1mjxp30I0NlHDY1KDAc+7Ga04IRJq+VqENkqk/5VbEww6DbDJ
         npj2Smwc5CCGxCeEQ5mOn8yIXrQlK0heRXXwymc0C68fa4iOGnGc+4sM3rrTWt6tVyWZ
         NJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147455; x=1795752255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=io+CTWk+B5zCdv2jhfadGeS4AMrXIMCEILzj93M705I=;
        b=e1NUU56t/SvjSwQbLrXfDuTdjouIC3+xCQOvLjKRBs4R5kTOQG/kXCQtMpunvDIcXj
         RDWJ/njavyxJO1LkPGgqbMckszNyQAojIdXgSIERi9jnOHAfwcG6SSWURU787cwv2COs
         K4SDsVAaLG3PZXt19r9Ub0jGwf93xEsXMsEmnLdSau7VMsimtqAMLVm/w3C8azs5UnbF
         KnHQjOnBLjOlpOocgjTWOkyR1V4DMop3tztiUO4738gRyZeZWp0Gve5qdP09ElWL2CB2
         1jrxv6fKftabyAH3pfuMuj37ix3HLD+NhirgKfgDgtku1pZzNsoQ1AYbvwkJHxzxQIon
         PpYg==
X-Gm-Message-State: APuU4Z+KS2vc/PZG5RdhfirnCs3DWQ67bX0pZmsw0GDSheLVbqsWm7UH
	eS+RXO7kX2bp6pw30Uks4Vi3uT1jBobhAl5vkNL+l+PWtzaBc6HAuPsgvbYK3w==
X-Gm-Gg: AZFdTZdR16gcDAJYy2xsVkP69CCGBnExxaGWt1jCvaN8xMRKZZiYGxYfuEUpEUdk7kC
	CrNw0+M/OA4e0NlouhTmFi1WIchiIjpxZUn7WIn3UL/HqPNtg0XZTd4w8ChExPAk5Px1dkgytwQ
	iv+uuG4O3w2gS+f1gOqPB2pegQOMTi1JBYrGMEXHj3o3yTcdLviezfwJw1dwtV+pt20SyAoesFB
	gIhnyqNygB0kQB0WNUK9MeZxzBfk2vwBdZgttO5QZUP4i4Es2emb299WFrwY4cGuaohM3q3rBfH
	2Fp5hZVmtkEU4RIcpejAsYQCbIcX62CBGcD1ZtIrQQrC8CXYtIkZvgWdXDYBqUMbW3PP1nZKubv
	yrCA2Y+YXoG0jlUSAhfMfKn6pRvv6a+Fku51g+U7wHJ18RELZfUv72isiZnB0n53gIQTznz+Noj
	I37+/AJVRY3OV5GnLeP88GedpMyz7DOh1RRorYZbdut3+c9gHBkSaIGCmskzoeexKrQfPRInkbw
	yb66Z90X2RfwnlCKuAG8kmIRs4FFPdoTyIb7RIPs5GCeLhhLKoeZOFzg7y3iVobJi9IulwjNFH4
	sBWNOnkjAC8AeUGWuUZZiboCrFbKcMI3sMyb3xfMmEzaezVhKcATLcI=
X-Received: by 2002:a05:7301:4718:b0:380:9c6f:ad0a with SMTP id 5a478bee46e88-3856e63b224mr1331961eec.10.1795147455454;
        Thu, 19 Nov 2026 20:04:15 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:04:14 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 11/19] powerpc/pseries: Add context annotations for the DTL worker lock
Date: Fri, 20 Nov 2026 09:33:10 +0530
Message-Id: <b358842b6682ac165275a75541123df3d6567bf9.1795147055.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795147055.git.ritesh.list@gmail.com>
References: <cover.1795147055.git.ritesh.list@gmail.com>
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


