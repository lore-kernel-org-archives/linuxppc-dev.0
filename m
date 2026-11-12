Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183C606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgxklbZi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQM8p4fw2z2y8F;
	Fri, 13 Nov 2026 00:45:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794491130;
	cv=none; b=OtdXfJFKW4ADQfChA8MpqJzTNQ6OSsqWkAm7aG4axSzOQJNCxDs8rzeK2xxOA8gmbvY4W0GGgeuMUHPhy6W/iseVPVVhLG+UKDwugrtjulNDSOAVwGMcu4Kh5Rg9rdDGKTz8jTlkOXJLFT+myyHcy6oKtyEMwJbW5Vloq77rfIHLk6ESFM7xSeHVLPWbMzCsUG6oMiq3gYpgxNXaUIW5wOYOlq1B7OE2wUjDQHzbxJuqjcRslc4aCbD6wL/GetGxh/A8MoG6I4FVaARVSWJtpP+6v5y6XOzhVRG6nNjrqvtfVgaXImSQNetCvPRor5FcV15/Ip0HTYb3Mhbbk0GuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794491130; c=relaxed/relaxed;
	bh=muUv3N6Cj44u4/A9nUxipF92QTXzboxZXiYL59wGe5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BviD9I3dz1qZZom4CDLEyGg4gfkKUaRSlRenO5QOzYxJXr2apAMFYpMZDFLWeti6oRoGOaB1qY4mQLZTRw8G2kz6lduiGcIgyAE2l3gHCa8yyEkE5+aUUW8ig+PmbgxOxGDI8v5spLD8SThdHouZ6F8iN1UEkBwPBh3KkhYEb2iY4aZCc1HSPtadKuNMUjTtGrrdq6gDInM/X14A5maFUCPEUHachaYx9ztSZG8gPgyZRIrQLeWoAm4fi0RJbSYVZMUU8OsnBE0CN5Y+OX7usTLNhJuwqTI98Xvhr8qoQWDsHk5xdae01MaXUWhbh3xm+S0nsyLB+YJNJEC7J0/vHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgxklbZi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com; envelope-from=mdshahid03@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgxklbZi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com; envelope-from=mdshahid03@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQM8m5B29z2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 00:45:27 +1100 (AEDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-91ea0c05c92so44365176d6.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 05:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794491125; x=1795095925; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=muUv3N6Cj44u4/A9nUxipF92QTXzboxZXiYL59wGe5c=;
        b=hgxklbZiWNg0qqzmH31E99l7B8lvDfSSMHockFkdLw6ydaKnMnTdPHj9RxJLJjhOhk
         ikSdDcEYkUaOa8fTRWUWD1c9lwYqyRimzlfLMCZw5xQZ0ijtTPeJzSqoAqDs57PZ+yd4
         0pnu6IaN7BeaNSMl1arm92i3HoeSrkUEqQiDPoTUJIzETY4gdpYKHHEX0fzKPrJ8LFuc
         5IpElvQ4WzdCOO+Jl7ZBEVab6LP/dLp4IyTupn9EypEqWhVj7zFLIU1fQ/qkylVAQGyc
         NemFwpE7bMbSvvxVnG0vAEw7yYVY/Gn+H5HIRff08fH8Qj6x03tGNYJAh8TPJsAlQf5U
         OAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491125; x=1795095925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=muUv3N6Cj44u4/A9nUxipF92QTXzboxZXiYL59wGe5c=;
        b=g8V26Ufi2/DRoYstUWWFB47h3zdeAho9BadQ/e0vCeXd2IUZxpat8lSseXn9raYeBN
         prbXz5JU1oLYi9IwHCpp6stY/bjoR1uf7nmGyAOHjDj3xGYuaK9uyoYuyJSwKVJd6Kzv
         N17hfwhl/Qw4RZ1l1730c//kUzNywBa4t8HJxdNOtj+UHbZvELmo3fZfK+jb5QkgiZEf
         6ihygKhRB48lUd9B82g4i+oXn1lDSd17FtjOAHOgFWJxiQzCOxJoky6kGSgOtpVb8o2P
         DdQyUCw/2VXlPM6hW662zKE2Yd97/3PbjBC2kFQs00YKGoi7djpXllCELiaU02eI2taO
         DoHg==
X-Forwarded-Encrypted: i=1; AL+hErE43Dp6uXp9DRmodHULckKEufIZJBjiuXu+lS55T8qcJQyxnehZxos4XAb+Vsz6l592Um1xmA0ilwID/uc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9r5mlvMwOiN8HCRzmgFRYEiYqaqwPHWVKPRhpHUxMMkctRIYia
	48Sx2Um94pn5SqGAmld56+dDhwWX3xg3jmrty52kQYcGY8Oln8UkomEi
X-Gm-Gg: AYBFou2PhixfjjxohLdQzT0Zu0ia/lNUJ+iKVqc12Eiyp9Q79mRwdcFmP5gOxk85MR2
	d/3v20n1+KO/fTvB4g1+eapHBhzxS4hg3R7PQpESXG2GaCo5YHzOEGw4o5H0Bc2rl+kN4iY2rdc
	V76B3yJe4/1g04huTwOf3ZRGrlogeHP+HSP5zMi6MdfkSoKuyYBVtgNGjbusqoyRfatEhBOSLiD
	O4Q4p2jkfNDV9jnCC46k3dDJ+fQ6d7ZHq9BF622JHregQVlWvdZtVr9yOaf3Zxuo9YdKgb7EVKx
	o3wDmgXYdVrggn3vzvuTBLbRN8K2r8zZ8/xt2zPScn8airEHwfllOs6/V2nru7mRT7mLErmW5Vm
	g/6FUaWQse4cRQ9ZQIfkhFc1dfp7OMiwoDC+TGlSh9BKybOXdrKeKfdsKQ1Y6PMLbUiRYuWw9fR
	yiy4RKI44a8qW+HkzMQnd30lKnBMdSWmWg77v81RbsT27ZcpU2i1+6jJRXsDvS/SWTm7xwOxvSx
	J9q1Sn1c2YWh09adTpVaOv5IT5ytwVY9j+s0+EQbKckUg2ijaWE9M/c0DunNWtfbxzYwE2IEHDX
	91BI41TWGv5QMe5xjqRzYoedg02VKaG0VU1zbXa1ubjf4kvwBQ==
X-Received: by 2002:a05:622a:1f99:b0:51c:fc4:a144 with SMTP id d75a77b69052e-556bdfd1fa8mr89199291cf.4.1794491124502;
        Thu, 12 Nov 2026 05:45:24 -0800 (PST)
Received: from ubuntu.. ([2405:201:8026:213e:cd0c:f17e:7390:7542])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b9438dbsm75155071cf.19.2026.11.12.05.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:45:24 -0800 (PST)
From: mdshahid03@gmail.com
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] powerpc/perf: vpa-dtl: fix resource leak on allocation failure
Date: Thu, 12 Nov 2026 19:14:55 +0530
Message-ID: <20261112134455.6880-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Mohammad Shahid <mdshahid03@gmail.com>

vpa_dtl_event_init acquires dtl_access_lock when initializing the
first vpa_dtl PMU event.

If vpa_dtl_mem_alloc() fails,the function returns -ENOMEM without
releasing the semaphore.

Release the semaphore when buffer allocation fails and no other
PMU events are active.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 arch/powerpc/perf/vpa-dtl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/perf/vpa-dtl.c b/arch/powerpc/perf/vpa-dtl.c
index 3e3d65b6c796..20eafeaffa6b 100644
--- a/arch/powerpc/perf/vpa-dtl.c
+++ b/arch/powerpc/perf/vpa-dtl.c
@@ -396,6 +396,8 @@ static int vpa_dtl_event_init(struct perf_event *event)
 
 	/* Allocate dtl buffer memory */
 	if (vpa_dtl_mem_alloc(event->cpu)) {
+		if (dtl_global_refc == 0)
+			up_write(&dtl_access_lock);
 		spin_unlock(&dtl_global_lock);
 		return -ENOMEM;
 	}
-- 
2.43.0


