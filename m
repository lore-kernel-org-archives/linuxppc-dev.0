Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64347C18E01
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:16:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAA720866
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm4P1UIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAA720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZG6S4rbBzF3XY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 00:16:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fm4P1UIG";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fm4P1UIG"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZG3X03LWzF3VD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 00:13:58 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id l17-v6so11451258pff.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=a64q9IsY9mfK+JGEdi2vqlrBaBM9lMLc6dBKgesPus8=;
 b=Fm4P1UIGZcZlSKjY/TiRr3qRMVWRSvmx3cUaLtDHArZq5cTRjdHwdh0jIwo2Tdm3DT
 sYbM/EBo61INU00lYEP70p9e3w1oLsW4SDhLk0jx9ZQBj4FxPN8+0IYDcdKTA12kPs/z
 P1cIBYYQH6itjnUgwwzV7Ki13ac69Th1OylXYonanQRV0kFPFC6FhDWjaKXnca0LMveb
 AmbLWUguC9lOH3Uk9CC43noJrRd33CuDkf6tqprJ+Fa2C9XrERR1eA8HIsuNHmqVFO0L
 AKL2RZ23ZkdJpjLKMJYfX5WeGJftOSZsg/MKMeZRjmUrrxk4MxmzAiPzFxtV6N97xPBk
 xzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=a64q9IsY9mfK+JGEdi2vqlrBaBM9lMLc6dBKgesPus8=;
 b=kE6y9ak+Ai+5BirGOa+osXwU76slQ4gGIQO0uOxKmynteWKIWeRiM+M4T3kQhK9gBj
 BTXOUn8dR0WAY+/ocjJXT7fhA+xhjOc0EbJda3R2NhT1U50N3GVAhVZnC5GgyHo+l6w4
 Tp+S3f9EgVaux+VuuOkb8Z2DtFq+QiXEb+txyFcz4QjJ9YaZa0S+8jTczxYs6JozYwme
 VBpaTkF2VhzuUCvO7Zat+leZ0jAHOwoAlSoOgXjD2Bn1HXSXFM0taF4756/Usl6EJStK
 KsqbsKzZ8IvfBRNephDLsJEv52hiZeuQeOa6ekWFW53jFcG3uukwNshsiqHBEY4LXapg
 sT8g==
X-Gm-Message-State: ABuFfogVHxayjgH6lbNglla32f0sn0UKAtn69nfU2WySrmlX6Oo1/Y8w
 3brLusqZv5+9V5yybhrJ1qI=
X-Google-Smtp-Source: ACcGV63fufuC78nwRl2J1kK16yYyt2v0azobVvGKFe3gFlVrmI37vE3DAVJ2CPDaDJTkoMmSWv/sPA==
X-Received: by 2002:a63:81c8:: with SMTP id
 t191-v6mr20202153pgd.399.1539695636307; 
 Tue, 16 Oct 2018 06:13:56 -0700 (PDT)
Received: from roar.local0.net ([60.240.252.156])
 by smtp.gmail.com with ESMTPSA id j62-v6sm16043423pgd.40.2018.10.16.06.13.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Oct 2018 06:13:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/5] mm: dirty/accessed pte optimisations
Date: Tue, 16 Oct 2018 23:13:38 +1000
Message-Id: <20181016131343.20556-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, linux-mm <linux-mm@kvack.org>,
 Ley Foon Tan <ley.foon.tan@intel.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Since v1 I fixed the hang in nios2, split the fork patch into two
as Linus asked, and added hugetlb code for the "don't bother write
protecting already writeprotected" patch.

Please consider this for more cooking in -mm.

Thanks,
Nick

Nicholas Piggin (5):
  nios2: update_mmu_cache clear the old entry from the TLB
  mm/cow: don't bother write protecting already write-protected huge
    pages
  mm/cow: optimise pte accessed bit handling in fork
  mm/cow: optimise pte dirty bit handling in fork
  mm: optimise pte dirty/accessed bit setting by demand based pte
    insertion

 arch/nios2/mm/cacheflush.c |  2 ++
 mm/huge_memory.c           | 24 ++++++++++++++++--------
 mm/hugetlb.c               |  2 +-
 mm/memory.c                | 19 +++++++++++--------
 mm/vmscan.c                |  8 ++++++++
 5 files changed, 38 insertions(+), 17 deletions(-)

-- 
2.18.0

