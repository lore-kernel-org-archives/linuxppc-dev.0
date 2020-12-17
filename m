Return-Path: <SRS0=l6JL=FV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5E2C4361B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Dec 2020 13:49:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAEE72360D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Dec 2020 13:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEE72360D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CxYJH1WqvzDqXb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Dec 2020 00:49:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031;
 helo=mail-pj1-x1031.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=hrf6ZR11; dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CxYGQ26PNzDqSG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2020 00:47:41 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id hk16so4142559pjb.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2020 05:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hevA3bYuwXFK8kmkpY1UT/6gQlduGHRWbKtrX42914E=;
 b=hrf6ZR114Cc7F1F5fvSpX03MAGEK5vGY0M/7WQftHmaDceFMNrF/LPTJjdp/nFumEd
 vfObmM4R0BsF267Xf6nsc32XRXXmrz07SOi7vtiO0Ecbw/UHh9ZIESbP2yiPGwUnSKUM
 qsnT1A8Bgl8uQymDmONpSILkY8rqN159nh57/iQNOb3HTzGDzljZjezQ/PwUS+aKM7j8
 huwKpJgh82O8VhF4PAgYQlWsWbn0IGxlH6mzHcyVIzJmYHS+EHAQDh1RcbbT2FN4/w4h
 yfaJ6EdipXNJeYkIgpJlrNgQ/x1OCN2nLonCn2fWni78rwzV2/MySZxdQzleJJys32Bw
 U/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hevA3bYuwXFK8kmkpY1UT/6gQlduGHRWbKtrX42914E=;
 b=EL7niKCNjsZcwuphVvIHO9L5lWZkJahEKGYMvUfWUs7RORlkkGa6r/VvhOdfJ26BsY
 KuoStgtDu+wnWpvipwjKzaoUqpyyYXOwuQMF1rlZUo4kzZiie3Nn+4SppodwfKWjXr+f
 9//J6BRuEEUwE3m2TOXfY8qu5V9+wlDurU4vWp3s7W+xMdXnxOeijrSqFQIt0JAlAZO+
 pE8FkYqiOs0XRkRG1WCi1cJElKwu7qUh3zEhPGbZ11zy+DWlcyIEBFRWfZLdAF+1aLoO
 9LK2EQGENyPueTsKKmtCpKK8IqtC1T7g054/m4uEHy9fOuGz07W1Az6kPVpFppnfqWCs
 Zkwg==
X-Gm-Message-State: AOAM530m6Foa/ibGwGPjfChFQRLdhwGeYbwHuebnjsWIYG9SNCLHCKo2
 cYPiU6JziqkQYnNQegY3BkPFAkpyGqO+/A==
X-Google-Smtp-Source: ABdhPJzFsxgH1FTcA0Qu+DmWVue8xfrXUHPXFQdxg6abgTFYSQgFkZmlpCDqKMmvSqizgQNWoMjTog==
X-Received: by 2002:a17:902:e9d4:b029:da:a2fd:476 with SMTP id
 20-20020a170902e9d4b02900daa2fd0476mr36186147plk.73.1608212858281; 
 Thu, 17 Dec 2020 05:47:38 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (193-116-97-30.tpgi.com.au. [193.116.97.30])
 by smtp.gmail.com with ESMTPSA id bf3sm5486112pjb.45.2020.12.17.05.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Dec 2020 05:47:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/7] powerpc/64s: TLB flushing improvements
Date: Thu, 17 Dec 2020 23:47:24 +1000
Message-Id: <20201217134731.488135-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Another round of reducing TLB flushing (mostly on radix).

Thanks,
Nick

Nicholas Piggin (7):
  powerpc/64s/radix: add warning and comments in mm_cpumask trim
  powerpc/64s/radix: refactor TLB flush type selection
  powerpc/64s/radix: Check for no TLB flush required
  powerpc/64s/radix: Allow mm_cpumask trimming from external sources
  powerpc/64s/radix: occasionally attempt to trim mm_cpumask
  powerpc/64s/radix: serialize_against_pte_lookup IPIs trim mm_cpumask
  powerpc/64s: Implement ptep_clear_flush_young that does not flush TLBs

 arch/powerpc/include/asm/book3s/64/pgtable.h |  23 +-
 arch/powerpc/mm/book3s64/pgtable.c           |  13 +-
 arch/powerpc/mm/book3s64/radix_tlb.c         | 297 ++++++++++++-------
 3 files changed, 225 insertions(+), 108 deletions(-)

-- 
2.23.0

