Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7F606A32D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OrjqbeLp;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6InlJuWn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRQx54wbxz2xL1;
	Sat, 14 Nov 2026 18:39:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794641945;
	cv=none; b=hAMQz1Y48KmRuIwQ+J2pDM5GhXqTtLq7fZ/9tPnhKvC6krTbyIg2P4FbGa1ipyogQQKwMk76Ppm09h/aK8ePJ+xdpxFgJ2BIOmLayBO81rwLuh0QbKbPB47K2bk9WS5EdkQVOa8DkGZDMEYjfMMOOpO8j+kORsMRJoERXGortnhHJENVdcbGWhFde7+iO6dyZBB+5TGJHqC4pv3lSjXRzy0A6ec5m0qbaGa3Run8ZSRgT4XMhrTFpcoqQj7eQ4t05mA+kQNa76TyqgLaRGnI0Buk7162v5/9somaM1w61KH3pUFT/rSrY/Z/IsMJYfvv7jpjqWa95l/6t5cOued49w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794641945; c=relaxed/relaxed;
	bh=MdHGsjPh/MNPsqhqozEDhkuZaojExdx2lHXEaEZxsDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JVPX5mWU/Vm2RV1sX4+7Oif3e3lV6dFd7gW0XHiPmv8bU9ePGxwi3lUN7Cv6Leb7tN3I1aRsoR/9/2umAvrk0ORCSjd58YU4PSBOiSmAfT9VKqZNzYEny1Lu9T+54MCWNQIPGsC4OYf9HyW01y6dnD2z06yqsJj1GmazettG1qTHM+RAZPDAlOK3o/8Sv7Jpeo2Er+1UcwTQZsI7c/OequY4Y2IHNfPb9L+5Kd2X3Ob2+DhpsWXB4NtBratDGwu/4Sy3+/T6/SBTkaW06H2tKYinkJFpeoa190ky5kyNj/z/oKCTg68Z6NuxTHXRMl7exk3Gj02qTsQCies3/bFLLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OrjqbeLp; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6InlJuWn; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OrjqbeLp;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=6InlJuWn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRQx41RBwz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 18:39:04 +1100 (AEDT)
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794641937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MdHGsjPh/MNPsqhqozEDhkuZaojExdx2lHXEaEZxsDI=;
	b=OrjqbeLpeWxhXuXdBGINwOME3+iamaq7qBVZBUm4VKn4yjOKDloXj4qD/UN9tIvYyXSNh8
	tL1meXnT/m40MG1pZE9gS5b8uB5Ow10352+7BD4OWIbEXKneTCOmzT0TDzuX8K0CDaRyg4
	KN1EbIpmMPOlxLhdeOLP57tXK3bPScSreYX4f8pkIKBAqLsSf09FCE98eHejrWJziQxinU
	AfGZAntxGDHmdUgLfeaSytpnUS1f2x7A8P+f046m73lmZ5srL/0Gj52HY5QrKOFbHiIoTy
	5edKWxRGQ6WjnbsAE/BsOJ4nwAs9UAIygw7aRJKq91qdAM4rsDWNtXYsaUFLzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794641937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MdHGsjPh/MNPsqhqozEDhkuZaojExdx2lHXEaEZxsDI=;
	b=6InlJuWn/1TnJKdafzyMF2gKfpijYBQhpWJ/AHYjd2+eNquZ3ik837kK+6VBKjrD1+azNi
	JElvy1v+j0iDhNAQ==
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
    Nicholas Piggin <npiggin@gmail.com>,
    "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
    "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
    Shrikanth Hegde <sshegde@linux.ibm.com>,
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
    linuxppc-dev@lists.ozlabs.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/smp: parse_thread_groups() return error on missing
 property
Date: Sat, 14 Nov 2026 08:44:57 +0106
Message-ID: <87mrrbrhf2.fsf@jogness.linutronix.de>
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
Content-Type: text/plain
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

parse_thread_groups() is supposed to return -EINVAL if the property
does not exist and -ENODATA if property does not have a value.
However, it is currently assuming it exists and blindly calling
kzalloc_objs() with whatever of_property_count_u32_elems() returns.

Since of_property_count_u32_elems() returns exactly these same error
values in those cases, simply return with the returned error value.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/powerpc/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 7a25eaa59e626..58824f5f4c800 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -824,6 +824,8 @@ static int parse_thread_groups(struct device_node *dn,
 	int i = 0;
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
+	if (count < 0)
+		return count;
 	thread_group_array = kzalloc_objs(u32, count);
 	if (!thread_group_array)
 		return -ENOMEM;
-- 
2.47.3

