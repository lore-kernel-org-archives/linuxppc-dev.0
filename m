Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CED606A33C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bXEtRLLK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZQhv4nCZz2xqh;
	Thu, 26 Nov 2026 03:52:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795625567;
	cv=none; b=Pkucnbpe3FIFQbLkiQtwyQH3RO5RxUt7GWlaNR5Ht+zdTgqZFy4EdSHmNeYZ0m3BKFbjB/me993laTkI1mwz660urCI4CgCYqXetR2iiTMMWaS890jCvv2lAlImpl/FCwahOhpUlyYy0pFHQOiQNupmMwmpN9v9cytxRKBxtZCeI25mTJZ4jevnfnMjMQeXgdsybZd3U2goyqf1xT4BpbLa6GM/04gyZr3I2r1m48IbkSgpmebINnnkUcTeq7efJ7X0169h1MxbzZI3UWlxgwdLbnBpIdxd0YMlQqrfWj8SI+CDyb06kpRMFwZV2RgEHjV1j+qPKbUzaiXUaJgRrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795625567; c=relaxed/relaxed;
	bh=FmzksWMBsSiVIlu+GaCNOdtvoguP4P/t8qvh5ZCxiSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kyoNs7zim+UK/tm9CkEOhZzreMgYTAOxhBRZvNJsjDVXxs2bR8Lwhxphn4lhl2Qc7iEAX9OObC+LAeziUnYuRKiyXBA6s8v9AAqACvTGyzXg+J/A3lIXp2NFOUQ6i5VBuXO3GQ+VMI3NsldTjfjr9+wg4Vkr+kMXDDQ4iTV4OU+mHJlso0yJbxT2wQIDwBdSOM5YjoCfQADfZSTxylCq3z0v6e4UbKJdebR6IfeBBSi0hFJoTEYdLblaJmuTGt/2PkjAFN7ijgx4K8+ehvUZ5QcX60rkFkfsDFq38lw+Jx2pk6uNwSAV6J+y7djVevY+LR9iIots+rgtuOKQLn0baA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bXEtRLLK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bXEtRLLK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQht2Ktqz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:52:45 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-385d8a00598so8917102eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 08:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795625563; x=1796230363; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FmzksWMBsSiVIlu+GaCNOdtvoguP4P/t8qvh5ZCxiSg=;
        b=bXEtRLLKinHbvgeeMH5qG1Z6Pl5KMkAmDvCcRq3Dz2z225GPA2lS4lAi/YKxIifx5Q
         si4GRjmVEx5xRriYq4nDoSQua3oW8EO5Js+wT5vmTAkLfvTX/5YZKsyeww1tI1zlgS88
         54wahDb+PyX/0g6uiyP/Alo2u05otDoyg4L8XUUqgj8gJUYnEpoA4t262B8BUACQUXTj
         iwVuASrCrPCAb/OmZvlmieDxo6/BS/fjbtBrxqsNufo1ecIHmfq7y5+yUAPg0AEI5Xbf
         /BxNqpiq1eVYdQeUTciojeV1h79LLkyR5CL5YxSU4MKWduT9a4eKXIDfDwpJyGvGIo9A
         pT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625563; x=1796230363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FmzksWMBsSiVIlu+GaCNOdtvoguP4P/t8qvh5ZCxiSg=;
        b=0yib3Rv2wIQcGhiCYoqQojrMQLsLOOo3bcV8K7sduhcQheoNZcHelsFxi1MZco9RJk
         h3bQEnzYhywhTBkv15LdZPi6mufb8X4rfsIY6whnp457+aZ4n4c1+u4byZtKwiXVP7G5
         a/FcAtMYsP+T12/im100jKc0kqG9SSKWHTRzPyB96zhJqvgnt6e0FouAl/VZR/St9gC+
         N1DCyVFqXBUL6WieLtcFscQ6QP3sr+lg5hK9nq6wBCeM1yO3nfmamPDXV3o8x7fODHuz
         qSrqlVJCs636Vcdc8X8YPWkcP2jrnvs0XaVMuTEsvpnpBmMKrf+K+vxz1W2GIhRZSR/H
         skeg==
X-Gm-Message-State: APuU4Z+FkfW9PiMnG2IvyiUmQKQAAQzzYARkF5XJO7lpT0e+hn5hpMJq
	7EDwZWeoq5DukeWFkNq+74X+zVtqftuA+vHzDNocUsuxoB7zQn4UCrtKQglMyQ==
X-Gm-Gg: AZFdTZdjHVSkWOAyHeUqO5eZWCoU7j+ks4psW2nTOUEEVrSrdeTBLPRdTEYtJbT1yAW
	l2NGq6lOTM7RtNsM8EUsgNQprDTBZlhozYhlAI4Fx5BLd3oehC9sAdR1R6SH1O3B6DcH8FupT2T
	KsXeJ/0wqNR/0sdnMSgmelhR9Bocaguj636dT0fWd55qfxgPFsHcyPBqRxIYky4zjsEJ9jYQVyq
	iZkSMJ6eJl0sXtpcsrkHr3cbBsMNfkpPABv52X2p5sgL+w1q80Oi2dcsab5T1Uo4r09dxUD8d3T
	X856BRjUvrzNuWfYcsw64UPg35WjmyV7VhDeTU73dJX+OvASTeKPwam5+YmrqPLtGDkOBTs5vUb
	1CvgGDp02SW0e5ArdW5WDWH/rMhTNTQ9uEjEWP621ts1bwqWnSTep9EyuwKy0PIK5ggR/8KyVQf
	cZF9HUDFRI2jAT8hxm/agcV1Zd+AiQLq2d1JgI2WQn1gYeMXQ3qwAYDHNSW6/ryR5fS0/5raGSU
	z1F9HCsYj7UYiOh+eHkqtLYn6BUD5OjtslBKFK7fHsUIz1d+3OReVb4eQJuGf/C+HHw54Xkosc0
	RIIC8/ThON3NpuepBHVqi4VlvpkTRpcQMEUj2wVOfr9y9K6qE3adoqw=
X-Received: by 2002:a05:693c:65cb:b0:386:b12f:c693 with SMTP id 5a478bee46e88-386b12fcaabmr9329016eec.39.1795625562455;
        Wed, 25 Nov 2026 08:52:42 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm98545358eec.3.2026.11.25.08.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:52:41 -0800 (PST)
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
Subject: [PATCHv3 0/4] powerpc: kprobes insn page fixes
Date: Wed, 25 Nov 2026 22:22:29 +0530
Message-Id: <cover.1795625038.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi All,

A few fixes that came out of looking at a W+X warning at boot with
KPROBES=y and MODULES=n.

v2 -> v3:
=========
1. Collected RB tags, addressed review comments & suggestions from Christophe
2. Removed PAGE_KERNEL_EXEC in the cleanup patch-4

v2: https://lore.kernel.org/linuxppc-dev/cover.1794572365.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (4):
  powerpc/execmem: Don't leave kprobes insn pages W+X when CONFIG_MODULES=n
  powerpc/execmem: Allocate kprobes insn pages from the modules area on book3s/32
  powerpc/ptdump: Show the exec flag of kernel mappings on e500
  powerpc/mm: Drop PAGE_KERNEL_EXEC

 arch/powerpc/include/asm/pgtable.h |  3 ---
 arch/powerpc/mm/mem.c              | 15 +++++++++++----
 arch/powerpc/mm/ptdump/shared.c    |  6 +++---
 3 files changed, 14 insertions(+), 10 deletions(-)

--
2.39.5


