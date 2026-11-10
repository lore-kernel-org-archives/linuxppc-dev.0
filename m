Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B466606A332
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EPHBzt7N
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNqJr20Wyz2yCr;
	Tue, 10 Nov 2026 12:47:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b131"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794275228;
	cv=none; b=YaW9WyUpRot/uVNvsWkxYj+jNO4Uvghrjn3zz70porWrecubIg09hIBHBCmMsSuhK4iY6PaYpVKI4CDbpvumBK67GtpCM6LrF27c77gXa0nXUOibB5mC/ob7l6O/VnWpwVkU63vJGuo84gDuMxts7TmassMhvYiB6qjH9d50zop8zGZEm3FPYWwhppKvMDfYsZbcL8ez0/2tcJdayRjfXqKV8/b2H4haQ/CG9k+90uF59j/5Ny4KJhfY14Fj+2LwiKwRXCC61/7w4lRJ9DQ7xVhYgMljppZZnX1oAkcZ9/OTwe1IbkznAEnFa4+NCqzAgR0Rw9B8gUnPenbCyblc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794275228; c=relaxed/relaxed;
	bh=vr6olQf0uNc0/a4nGcpEjf8EuC1NH5KXo4yVBRGMbwM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y0u3isc4u0YOeU5kuonU70Gzywxybry62E6unl8Tb7DbbeqZYcymtAvNABN3Mh238AYI9wCloKoEdqUK+LPVcZOQVHU2bD4/mU3jYYjrAxFLR2W6ZeL32aylqh/utwrRi4YvEPujUhhpahYc17MPh6VAl/JBJW0quN2XNYBkOeL3T12v0h128/RtlH5jQokplyEnyEIebob/h9ne/RiJudRVvwxj4LXYNsYYS5J16/NlPmfuzQPZ0WvWcWAsvvfMxyBnDkuYe5vnKPP2pnsJ6HVhijkF89vdNqEItVD7xATUjRGGdLGrxLqPMTYNLcfit9UmA+1QZtNbwYY7GftZ8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EPHBzt7N; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EPHBzt7N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com [IPv6:2607:f8b0:4864:20::b131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNqJp4kdSz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 12:47:05 +1100 (AEDT)
Received: by mail-yx1-xb131.google.com with SMTP id 956f58d0204a3-67c24619b19so1483168d50.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 17:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275222; x=1794880022; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vr6olQf0uNc0/a4nGcpEjf8EuC1NH5KXo4yVBRGMbwM=;
        b=EPHBzt7NIXFJuProY2Ul4a0eoKKSmiaguq27qE2MqrkZ2eA/2uEslSUnX2S/bclP37
         QpTeXAit8SCljzsKIc/U6QuDRrN9yHYzPC0I2VoKVSqeIJ/CAlcnQ2u6rXP8Aa+jcBhG
         Nu5liWIo66bING8n3c1swDmIdBLlkHToRBKqyG2pNMeufDnpLazcrjh3RvniiT+hSI6k
         JnSinCY1/206phpFlnERh7t/1sKTnOd7JFg+wpKUpfV4R7aNNKl0bj+tyfAGOrdsZS0H
         uTHFEPym05pvsw3sgh77VSCMJFdKmLh31f9JVgLWyb903Qq2HxCs4YuGs3yZZY9AYhi0
         mwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275222; x=1794880022;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vr6olQf0uNc0/a4nGcpEjf8EuC1NH5KXo4yVBRGMbwM=;
        b=r6ZufFBG7LPDBP2s+6NzfY6595Uivn5yIIUmxrCsqiWbep30HTCFNM7BEFybvbFNcT
         r2u8M1R4wD7oWJOGD5fLPD8vNP0+jm5zY61KP5LlCFqj6SdJiDbRQauqHs2ML8tBqtOB
         Q4tCYR+9K82yG3H6O4z+8b1u+WRHcpFaxmk8eT7yGzAV7l37QolL2tbyk352jdSygy56
         HOOQsyW5eSj1C5qcErR2GkjZ+qwdrSKb2IWcbnoo5HUre6NZhSnSZ+pVhAHWeL2KZ1ym
         qZb8AgLhEthig9hccTYKLFda6MbMSVADsQ5TSadp5HVqHr3IrswWl6dj0IPEA1OD69nS
         BN3g==
X-Gm-Message-State: APuU4Z+EVtf0bzGMy5PP6MVw1w/fpBR03Dbn8G4Z0J4DfIJgo2ohsiJi
	w7eSHdIlJSpBAhED8RC4wtdRjLM3L9iET81X1c1v65BustvMK3j0hAistadjKBeJ
X-Gm-Gg: AYBFou0kkVvu1fmefL7GjStZwtqhq/O6ZS4vZIhkWzTienfavbMDmj9aw3OSsAc4uY3
	S/pasg9BV1XY2RHBVN3k9OuQZhSPeddCnR4v21W8GUiOYB91ZbbZ3k+OGcWaB7iAmprt+3+EBht
	8giWdZR59OMr4+U3dhI3a/JDfiThU5FreS/uKJzHTIuXE3ngSs0Ha3ODaWrWdpK7HA3AF/6i6TP
	Y2OOxCIM/gETRZl2NQFfqeq4yYZg0g7Ktol2oT34+2Utpo5ZMr462iEfhPJROk04YQ5Ux07gAEg
	W3ZG0SHQIlpDGSuqvBSKDtY7+oW91EZVsRXP3AXLyGIzG+EbJHuYLgY5Um29kT5Ug7kCMETxh7U
	YKBKd706JjG3t05k9Js7SANjEr3IsULEaZG1LEMTKS7Mc1/Mhfyt6ZOJX+xrm6OVjYbwQaK6nH2
	6bkhZrQ585bkAysE4BM5odMj2dUHE740KGKe5fWPKbfC5ILVRYtPMwo3dd6mT316ZPI66jGQZdr
	lv+mBcpSo6NvwX9TRo8Z4ZsdwL6yKJf2egmzhy7hrmW7X/l0zGkXEDgAh+aAO3+SSU8vKYZWi5V
	uma+4WHk+n4uyPi6jXqGhiHI6DFC68tqnO0NTW4m0AQHceEZaGSngAorIttDPJJA5KlztjFewPI
	iNbzlzoR0Gg==
X-Received: by 2002:a05:690e:408d:b0:679:ab08:5285 with SMTP id 956f58d0204a3-67c568c72e6mr963184d50.82.1794275221980;
        Mon, 09 Nov 2026 17:47:01 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589c6f24sm692080d50.12.2026.11.09.17.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:47:01 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/8] powerpc/perf: mpc7450: Event fixes, SIAR sampling and
 sysfs event names
Date: Mon, 09 Nov 2026 20:46:59 -0500
Message-Id: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgMmioNXEYfapppFQwoiiHe3O
 L7h/weKuEqBqXnA5dKi51FBbQNxD8cmqKkauOORqBvRLPaMJp5xzYF6DjRwWqEG5pL1/mfz8r4
 fI+XZ9FwAAAA=
X-Change-ID: 20261106-ppc32-perf-bfa132a142db
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=+7BXvgmmUAJktVVUTJnPsJZ3PxH3Hy9JzygYzXxr5Gs=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI+lU/2/FN3Z1FD/i6VJ15HRA/MWhaswvJpz8Wd2az/L
 Fknr5rv3PGRhUGMi2GmmCJL3HpFllltO5b6nJb+BTOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkbxEDk9Bo3M4uLS1CLdtIIih7z8ksSSzPy8Yr38gtS8gvQCvbTMtJKMjPyi4lSgEXp5qSW
 mro5uRoYGJpaOFmZOFo6mJs7OToZObo6Ozq5ORpbmJgbOlo4mrpbmDFycAjDXzLjE8E+l8fUT64
 syu28nLq8Qmb3l6V+LqX8KlDZNeuWkc1OtyoeH4X/0mgm9vXd8v555yX/29fy5/hbb9umZJ5WG+
 QUIeFVf2scLAA==
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
manual (MPC7450UM Rev. 5, chapter 11).  The worst is patch 3: an
alternatives row joins three different events, so perf can report the
count of a different event.  In one test it was 374 times the real
count.

Patch 4 fills in the L1 data cache events, patch 5 adds the PMC6 copies
of five L3 events to the alternatives table, and patch 6 adds a format/
directory.

Patch 7 takes sample addresses from SIAR on 32-bit.  When a counter
overflows with interrupts disabled, the interrupted PC is where they
are re-enabled; SIAR is not.

Patch 8 names the events in sysfs.

Tested on an iMac G4 (MPC7448).  The 7448 has no L3, so patch 5 and the
L3 half of patch 8 are untested.

Signed-off-by: Matt Turner <mattst88@gmail.com>
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

 arch/powerpc/perf/core-book3s.c         |  55 ++++---
 arch/powerpc/perf/mpc7450-events-list.h | 250 ++++++++++++++++++++++++++++++++
 arch/powerpc/perf/mpc7450-pmu.c         | 118 +++++++++++++--
 3 files changed, 388 insertions(+), 35 deletions(-)
---
base-commit: d68ce4e71248e1ff5af9654b407541d9260b3ba5
change-id: 20261106-ppc32-perf-bfa132a142db

Best regards,
--  
Matt Turner <mattst88@gmail.com>


