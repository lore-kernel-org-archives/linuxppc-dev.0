Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A19606A33B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=asFl9vqf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTXCf1tGTz2xl0;
	Wed, 18 Nov 2026 04:43:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794937438;
	cv=none; b=dUqyQnMT6L+/zNPygQfDJ7FAQxY7vHfJKgOx4ul2KEILSGRgeVDxTbi7NwR+hHSCXpi7siimq2+PuwGppEiu3XROechVMYoMiPToJAqIYs3rw9n5VUgaP+ZifBDJo3qhyTBiHmTrvgx0laau+o0ZPJto1ZuWhcZfoY5gn1IXCLx6DOBGIatITqP/s8C+sSivvp6xlaQOjQvELT9b3+FVnRJJQ+1TgQbbedFUSoN6UY4oAuz0CIGXm5FqUaeS99cY/AU7CJxfiWdpcqrJt05Hy9YSjSkk3PpIEyPGxw7tsgXedOsIbpARp6oMrWWy+VfyLBXpDOJo27oviM7SmVZz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794937438; c=relaxed/relaxed;
	bh=ZM3n+wUd1iTorLkN+/w9/MJC1KrDVHt16lgqYCBSzqI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SnQX93iiinnKuZqHvLerzljzbfNeO7Ut5tZA9ixqWJa0ts7HwZuH71yiWw9f+jT8WUZaKLeu7YwIGKgCCLCt40cxGyaL8/FD+Byo4UD7lNy81zk8yPLoe+Jq3JYAJSAEFTkStF1kmr/kiXGTjPeVBpoEHG/bXOT3vwseUda0SLqfMCNPL+5jNzX80qK/JjBQKv+IZNqoUt36xHZnLSqM49qYlNLOV5dMzTWiPrU71kuFr/q40vFLHdNldeIqZj6MO8Ei/ZK7m8dxLtbQXq+g47bp+9Ta8N3/K1RhTFgM1n7a81aKpw3m1rHe6oOCiD68tKPSjz3pb6k9R6XQu2teFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=asFl9vqf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=asFl9vqf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTXCd2t1dz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:43:57 +1100 (AEDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-8b3402105b9so38609987b3.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937435; x=1795542235; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZM3n+wUd1iTorLkN+/w9/MJC1KrDVHt16lgqYCBSzqI=;
        b=asFl9vqfA+a/9gpPegiGPCP6VJyI0tvYUAIfrzwGBejKWLmgXkQGIY3mXTkXClCcFP
         DfDpbkb/3nx7Jd4Ztd2ppUVZrRSCs5+PIx3LR8S/KV194FMMFhhY6/Lleteyv7hzoAJ2
         W/bpdmYPVt/rdHxKRfQo7Uh1Nuz0qwGOOPLsNtx/VUzu1rfe3kob+c8IWraidlxLKAhn
         9R61/YokEyecp+jVsXMQ8ts1E1U9Bvc67JJjWQ+psKdlnrcXWAgPEoNRpOZtpZ7xFU0Z
         J0kk3aUvMlutQ2KinX4LqcGb/1GAS+QceAHs2FsaKoJnATOOz7779WMLnEn5hQZ/BL6t
         M+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937435; x=1795542235;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZM3n+wUd1iTorLkN+/w9/MJC1KrDVHt16lgqYCBSzqI=;
        b=ePdUAsGEvH94DY11wlsaQIk34k1WkTFOp5hUpIn0ho4k+x039WVk4nONZhmksmp9uu
         5zPE8KuDSVXuuM0IcLCCmw4bXjEn6jmic7zw/Dx1NMquYQtG9SrhAItmUez4SCehaHLZ
         YcRfJQn1g8Ufw4gQscCjIlxsZnWrZYO0ULcEbLlq6ZUiUgii8pMIYW6FktLyWHPIsWYy
         qAVWn+3KSsJA4vhbuaL2ZWk/AuJ2zSh2XIT4fekAL49KNlpoYipT93YFpGRkE7Y0XXzx
         BPH/FUkLwaJwzNsvkQrUmpI8CkeMzHVZ9GReIeSlxBLLzLjqMz6MHYugmyh+/2Wkynur
         8LLg==
X-Gm-Message-State: APuU4Z9vzNuMiTVKCOCMfKI091C+kzWSLSqeb+se3U7pwIIaLVcrIpsY
	TI/ivnSCs+Dxa9pdmToQwpVHViiwE6m4Uqgj7ZRm0KS5XipOqYHBoaG4
X-Gm-Gg: AZFdTZdTJDAwqUKgMGbYcsZyotgAjUQ3A/bBDDw3oZgEUIq2mCu9cLawwNMDj0DDodu
	2c4Ng+6qrZAo8AZJ4XmN2TB6sPWcmIWBuuLWYWpasPWxAFpEEkgpbKDGTzwOhGlAhswtMFW4E9Y
	+wJbopUr+Jo6uGyPkKCE6YK4qXuD4+LyzKRmuoV6GxdUhTZoJVdGA1FLeUS4HTzWOxFUqwWH5CD
	S9p0P2AN79UhB5YWcL3UhuIBucaXnXcfngAgG/iEbz2K0E2AO0FQkrM1Dl4YWU1JNBSMt96vVY4
	GVxc4RhawvJfoRlmCR93Ue4XGpY2inoBFgntnjsiEqEVtOJSSVWH/q7pIM8GLjyCzOIPxT1rgRG
	bjIiwREkDstdC2x4ZxJeBJiS8408elV0nK8Ou+sKmpfmX83cfR9Ndw32BTrrsC63JXI3tn9ifKn
	RQRDZkE0CODswPqstXiNp/5uVe3JkFuH/tvtMP1vQD0dKPAfmxGTA5t+QffGIx3EC1vXbadba6i
	O+OzFz4peRiRAyPdXHC/px4+AIsMjcGt/hVmdvaWREHGuAHPeKwvBlwfvpa9H2DU8YuPu8Rr+ES
	fGg179yEKz1C7YHeYdAfT34XepXVelU0FlJEqmBO4Zg1mZxlo5oLncJEFOWXnsbv4t2F3AsfNQW
	7gT1hwZl63vYB+A1c95rpljnC89zjlO6yUWj4u/hlmEHwqXKozFWHCbZQMNS7BhEpyklnA9TYQw
	CqvJ/r57+6K+aRHW5UJg==
X-Received: by 2002:a05:690c:f85:b0:8b3:45b:a4f3 with SMTP id 00721157ae682-8b4aa350595mr75502137b3.83.1794937434610;
        Tue, 17 Nov 2026 09:43:54 -0800 (PST)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe030a65sm2194157b3.15.2026.11.17.09.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:43:53 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 0/8] powerpc/perf: mpc7450: Event fixes, SIAR sampling
 and sysfs event names
Date: Tue, 17 Nov 2026 12:43:51 -0500
Message-Id: <20261117-ppc32-perf-v2-0-2072e9b90009@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03MQQrDIBCF4auEWdeiJpG0q96jZKFmTAaaKFqkJ
 Xj32kChy//B+3ZIGAkTXJsdImZK5Lca8tSAXfQ2I6OpNkgulRBcsRBsK1nA6JhxWrRSi05OBuo
 hRHT0OrD7WHuh9PTxfdhZfNcfc/lnsmCcaYWD7nvTmm64zaumx9n6FcZSygcqb/fepAAAAA==
X-Change-ID: 20261106-ppc32-perf-bfa132a142db
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>, Tanushree Shah <tshah@linux.ibm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2225; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=+wsNCo/yl0EPm7ERyMT6IkB2BuBys15yaHR/GHDCMrE=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+TIp4lqli+f371tAnv8/JdrkbbFDhqpxw46fMZuGta
 +9Wad992PGRhUGMi2GmmCJL3HpFllltO5b6nJb+BTOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkbxEDk9Bo3M4uLS1CLdtIIih7z8ksSSzPy8Yr38gtS8gvQCvbTMtJKMjPyi4lSgEXp5qSW
 mro5uRoYGJpaOFmZOFo6mJs7OToZObo6Ozq5ORpbmJgbOlo4mrpbmDFycAjDXLOVl+B/Tx8LR/c
 25riDj5YLP/Nzff3Fyli3ZK+jLVajakrHb9TEjwytO/5f91099jE40faTBEVKzqMzubOvkwu13H
 k9ZJcbFxg4A
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Patches 1-3 fix the MPC7450 perf driver's event tables against the
manual (MPC7450UM Rev. 5, chapter 11). The worst is patch 3: an
alternatives row joins three different events, so perf can report the
count of a different event. In one test it was 374 times the real
count.

Patch 4 fills in the L1 data cache events, patch 5 adds the PMC6 copies
of five L3 events to the alternatives table, and patch 6 adds a format/
directory.

Patch 7 takes sample addresses from SIAR on 32-bit. When a counter
overflows with interrupts disabled, the interrupted PC is where they
are re-enabled; SIAR is not. It falls back to the interrupted PC when
SIAR is on the other side of a user/kernel transition.

Patch 8 names the events in sysfs.

Tested on an iMac G4 (MPC7448). The 7448 has no L3, so patch 5 and the
L3 half of patch 8 are untested.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v2:
- Patch 7: Use SIAR only when it is in the same mode (user or kernel) as
  the interrupted context, and take the user/kernel flags from regs
  again. This keeps the callchain consistent with its first entry.
- Collected Reviewed-by tags.
- Link to v1: https://patch.msgid.link/20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com

---
Matt Turner (8):
      powerpc/perf: mpc7450: Event 0x30d does not use the threshold
      powerpc/perf: mpc7450: Event 0x634 counts L2 prefetches, not L1I
      powerpc/perf: mpc7450: Remove the snoop retry alternatives
      powerpc/perf: mpc7450: Fill in the L1 data cache events
      powerpc/perf: mpc7450: Add the PMC6 L3 events to the alternatives table
      powerpc/perf: mpc7450: Export the event format in sysfs
      powerpc/perf: Use SIAR for sample addresses on 32-bit
      powerpc/perf: mpc7450: Export event names in sysfs

 arch/powerpc/perf/core-book3s.c         |  18 ++-
 arch/powerpc/perf/mpc7450-events-list.h | 250 ++++++++++++++++++++++++++++++++
 arch/powerpc/perf/mpc7450-pmu.c         | 118 +++++++++++++--
 3 files changed, 369 insertions(+), 17 deletions(-)
---
base-commit: d68ce4e71248e1ff5af9654b407541d9260b3ba5
change-id: 20261106-ppc32-perf-bfa132a142db

Best regards,
--  
Matt Turner <mattst88@gmail.com>


