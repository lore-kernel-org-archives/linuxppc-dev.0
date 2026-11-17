Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A1606A323
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEtQzxW8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTRqD0DRqz2xqL;
	Wed, 18 Nov 2026 01:26:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794925559;
	cv=none; b=j4YIasUgBM7KDd4BY4F52/xTBS2HUOzwYtb5KGwGTj32GT69hL++QkhLkxzMzX98kS68RxMTlsDwt/S2T49+Sv+VFd7/j9JSqXJtwEAfiCdEXyLUj+Iy42pPLJVCOj2q0BGgT930ZSyIrFYepBWKpn8xnYgZ8tIAhkC8Y4Fugf1gBFu5PucWocdxS79NBQtOXlY9Kb9fX/PNkWVGek65gA9WHGC/Vfb9SM2E+psuUN751DaIu19tQni7tXEGtdZKHkluOqlmXpZv3FVtavYPTSPphwBEmvO44ZW4G9bGRdCvcFlnuVOiBaJhYfM90I9IFirDS8brR2b1Tns1ysoUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794925559; c=relaxed/relaxed;
	bh=qTTU/HttU3fjnx/LLkySkKgelZHAjJmF566oK0Z4Ap4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mHbcRboa1SnBjcS/9dW5bPROZOmLW2DUbaYTJjvGsITf2K2Hy/0PVc6SbPASgRxj75hsgrfNzkUX1dTXH9QSGsF1DSqr2EXwcFtShfdYxlH1Q+oQZTN+ecsffAh24ZsFjDDX07fylfpZUVhcQDTda+lZQM6AvTIkNb1j2Jwj3bfKRpS33ftOZMR44UT3/kwLL68MoQ7XmeksuWxZJE5GPfu9tkgdNFulTIzzeWrMftAl9b0GfkpYjEzVIL4cx+gEkGJRKpEpuep4UbpcAfiFkS86iQraMiL/c6UxItMkJeuT4wsC7UosRZtJCaKmPnx/uaPZo1pCAg+XLIPXKG9FeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEtQzxW8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEtQzxW8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTRqC2KCxz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 01:25:59 +1100 (AEDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-70b875f6f1fso4819285eaf.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 06:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925557; x=1795530357; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qTTU/HttU3fjnx/LLkySkKgelZHAjJmF566oK0Z4Ap4=;
        b=uEtQzxW89GeCVukfjrEbnidTn4dvd8VksOuYGgUAMIc4pSdktYKl9EOeCgNXmyzJfi
         zQy4Ww67tM9wOwazha23ApjCEcoJ08tBbFvAXmmaCXtnvEtET3YIP8qyeBCMIHNL9OFs
         dEVGLxCPbysJ5R8YP5TT/p8OrwGi3YMrN1uu7h4UhgJWmmJPHTmnnu11NXw1gxEyK53n
         Izz5Jlc3InK6yql1kI9CIATTgPNZLdIcCY6/6Z0tmie8Lwb4y5Q+huHyW50Lxo8WvPPR
         NSQuCd+z50JWpvK5u720ennSUQveL3mG6Vr6oBmDfy33Qbp3aZqL2eIksk+ElI+QoooU
         BWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925557; x=1795530357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTTU/HttU3fjnx/LLkySkKgelZHAjJmF566oK0Z4Ap4=;
        b=OTDGpfL9Ae7fPykuuNgLp5FnEJ/PM9TxnUO8Ds/OzrK4bLVZKr9OZN/97mpmZqGXVw
         0d3F7797o7LPJDj7CgIGFBDG1ezJ4e67D8yeWCmOXGkLqCPoPfMMbHRaTdIa/tcsLu8D
         3jE2oBCjZn5rCIWVcy1lvUqjae0Yv2AyIqmRJncFi6T7Jv1WxJFnZG2LSi5hfz7goJDF
         oy6aM0wy8DdPAyX/ZSfFWpknaDZ71Ur6iWIt1tr0mCYl6ONAHdya0aDL0PGCaHq+IW/u
         cawnmBxa8Wsb9Kf0b1JYzwEsuv9dvuxsi00wLF//lEjLQqBD/AENqgymAOYcpR6JslvT
         G9uA==
X-Gm-Message-State: APuU4Z/sX0fVQ5lrsex2tw1CWHS5H15DgoxM4RPHvJdMnKCTaC3ZgJEm
	/W3wiLucSytVH5deljspOsgYg0Mol1m5NwNWiZ3d3jzASnEgABlUSWDwfqWoGc2A
X-Gm-Gg: AYBFou059gHpCikSEGP6n9mATRE6lLXOfoKOflrB4ySUiUkP9hd/MS96vN4DPEMjpKd
	c1vmxGKrSIYV5WQdihdm3J069vvUR9Umy922DLrZtwl580iFc6JARNbKAvK4fJrCft7cvNdJDvM
	nz0GkwJK5TEJEgUsnZtHQd9iaxPu2b2jLzZUa565j+yZzLtYVzpVFp9HsnGLDhAH8GX1Kb9rX0o
	ixYQeY1MU7cg+eCP7+cloEdaAgrAEBuY6u2xJch8MSAwOtOlUAqPwNY4NDi0Ps440BQ0+Hr/CiZ
	te/TCnInzLZPtoRontII1oMW8qjZYoEQk7jcMfspaJSpRCIIzxkFWZWQHpD/r5dHNcWr3ZaunJh
	FEhwDgIXGAQsZYYnryGrliPN5NqX0hhsLgfYetFvol9GXX5GwOvULURQgrmj2jCN8cesDRY1c7B
	TbPkE4kQzX9msiWFu1A1pZrhfPLw3VNxpdzq/emrT6y3o8laQACnwlqnBRTPCl4sAk5Hi8c+mYv
	6GfpKjH5qcCuUHy/ed3JSIRuhLgOJA14SPVEmPh+dIKW6jxmOVMt/G3fWQfg1RswLjEIAfl5Cj0
	qKe8S55BzjXbBfhXocaJuowmVgTwnZ3zxIE=
X-Received: by 2002:a05:6820:1353:b0:719:1ad8:a34a with SMTP id 006d021491bc7-71ab51ad506mr8840255eaf.67.1794925555161;
        Tue, 17 Nov 2026 06:25:55 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71af0a8a18csm5313709eaf.4.2026.11.17.06.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:25:54 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv2 4/4] powerpc/kvm-hv-pmu: Free hostwide stats buffers if perf_pmu_register() fails
Date: Tue, 17 Nov 2026 19:55:20 +0530
Message-Id: <f26a80d822ddfceb926aa732deb96e81c40dd2f9.1794924821.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794924821.git.ritesh.list@gmail.com>
References: <cover.1794924821.git.ritesh.list@gmail.com>
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

kvmppc_register_pmu() calls kvmppc_init_hostwide(), which allocates
gsm_l0_stats and gsb_l0_stats. It then registers the pmu. If
perf_pmu_register() fails we return without freeing them.

Call kvmppc_cleanup_hostwide() on that error path.

Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
Cc: stable@vger.kernel.org
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/perf/kvm-hv-pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
index a58634f656e9..ec05b4855736 100644
--- a/arch/powerpc/perf/kvm-hv-pmu.c
+++ b/arch/powerpc/perf/kvm-hv-pmu.c
@@ -402,8 +402,10 @@ static int __init kvmppc_register_pmu(void)

 		/* Register the pmu */
 		rc = perf_pmu_register(&kvmppc_pmu, kvmppc_pmu.name, -1);
-		if (rc)
+		if (rc) {
+			kvmppc_cleanup_hostwide();
 			goto out;
+		}

 		pr_info("Registered kvm-hv pmu");
 	}
--
2.39.5


