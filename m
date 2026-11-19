Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551860A2623
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iFlWIHMc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPNd5Q9qz2xyh;
	Thu, 19 Nov 2026 14:39:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059585;
	cv=none; b=TKB/cAkfQ9m8GhsWPdL8CIE9ecJiiXwqVTWEPbUmMCzwwKL5hJlMy3fSPPE7ENEGG0soMgyyFFgh/PgyVwbHuODBcn6c5YEdKEk0mrEzSLtgPlsSeMm6b98qDxxiTM76KPgCwCWUQnLT2R11Xjtphk3fJ0RUsQBm0IvOrLnP/lZglDJXNPfh6x91bcEtvAW+PoINjNxffbJ/GZXVsYotVKV89H04IXC8epZHex9AQQn8havulTVBXE7XqJovqm5NlAxQcWbqUE5+ihL+ET3PuRpxAxPZaZW6ZvkGupeHOtKwKFvtx9+R6PTlCMIWkVDm9qhkK8pBIEoJRNKHwRRXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059585; c=relaxed/relaxed;
	bh=zePSK3NYQ9Uq2qwAbmJwQ8LjQR2v+Q7ZVPo8eNiOxkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a50XG7AbfFekBANrZ0sCoPLXApIkefOItAwLbvmIf97Yl9EmtZRofYXc2ell3uePdmx50MO21Kzia7q8Jt8ppnbJGbUiHmp168D8UzPbvjKyVP0C3ZZ4cTqFnVWsS8lGlt4+fVC53WNY6KKdNQ++27amJPvgHkAaSR10TJ29+T4SyZEppMzzcvsF/vI9QaOSvdxwRef9MnQGqzvr08eGqWZFLBP0E2N5ROAA3JGkCLUYH5vHUmjDNijYOn2qrSLZxlGWHKAJYv5ArAPB1q3LgETIgO2tYgDPb/1yCbFJH+5hWGdm9ECiE1e+D8zKQumB2pE29UdOY0Jxh0CRTbpn4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iFlWIHMc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iFlWIHMc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPNd0SsLz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:39:45 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-381d542bc29so3309743eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059583; x=1795664383; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zePSK3NYQ9Uq2qwAbmJwQ8LjQR2v+Q7ZVPo8eNiOxkM=;
        b=iFlWIHMc7lGYBZuX2HpVEbedVvNg+roiT8rw75htf0/pNqcB+TqITsn98io8y286fl
         ItxaD9+iDkbcqFyYM/M4BQzCPq7NdYwPwjuM9iC2uw1cLfnAaqZEtbsFvkP8kAho4Xdg
         zPyLc+y5T5jbhSpbD8CSuHCfDFh1B9mmOm0Ps8hee8wlhNgMUCWUdpXlhgZ2JJLNu4h+
         aXabBGSVAUZGwejBgGDHI8ArhIw/9+jzVaFQ8zsxgRIXirYyrmcgAPei2nzGDBoI9iKv
         FcIZUGmJazUEPUb5Qif1tWGveROtSvDl+LflGy9+IVVNd8akX4n8wwMcHAZMFdtUDFKZ
         qrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059583; x=1795664383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zePSK3NYQ9Uq2qwAbmJwQ8LjQR2v+Q7ZVPo8eNiOxkM=;
        b=bfi+8Lp/iY2hxhf0w9+ho7rj9CmS4vnFB6sJIB7AxoVxcwrtXwMAtPNzzub+LyLCCh
         OSdRsSmXWLvdbCCFAkKBR7UYdlfyqZHN4o8/9qJ7klrnGTBzci1cUdptj0IPdrpM/k6Q
         TBLCoPp93tt6xAsIfSVQA1uP5m/AqzuotAS6l43AI58AcSJUPEX3zUiliqdVru/gKh4t
         dWBVXXMiTfkmJKoSlMDQga3LhIWOYjnBfB5It75g1hW85SUSF6QHDED+sYmwtfx3f01N
         inyZ4CgAcCqWWqOUL7eV3FlKyW/CbW7MC7oaJEHtox2rW4OUSv4VCP8Kl4BfsrdvFqnv
         +K6Q==
X-Gm-Message-State: APuU4Z/9QA0v+cEixB0t/eczCBclRoNlXUOVonQMN020hlpBie2Jf3Al
	xuXluDSXEZ7JVYTM5lIIBUbqvTPAUUKByInGRYKwn+Xe4NXH3fCdphp5hwZHjg==
X-Gm-Gg: AZFdTZdvL2Zup+UDOXTIBFa9te4Oy7AHGo+m/BQBli/fGhASCBIz0LVV4XjCVgLpUkP
	BFl5wK0GfOq/YC59sFLRnDyTZDY/u7IJH9yUbeFT63zzIZTV2eovsBN7ORyWWUczvhorNZcMXsg
	Btfk9xhK6k03pDaMqt0eSArglcO3VcgWmxWcngPqM/u69ptfOKpnJa/9f1dZfJiRGWJXOuaakht
	vtwsnoCp8Ze+xkaPRMyGig6djurzCZB0upeiq7Yz2AtdLoovUsTg+Zef5eZJoL1GKdnwyLbb74C
	qUNP8jqWgU0BI1qeLvwiYKXohoAsZetR67Ei0FkpQBmZgebfibSdVxAXsX8424yUMhozgdA84su
	+811XMOXuJIyoiCB4k179Atr9FBWW3tZTnBfABn3p3KcEAZZNZZJ2fDwvAnMbWL/PQHCEQKbR5N
	ICmGqKWPgTzV8RcFftrL1espCR6G5aScUDYLJErOkGLvrYOGiDkSps5i7XHXOgl7n0tp9kNc+8t
	q7kqrmbsC7LojLv9E4qIyMVGoo8/WhP9oxdxWOpIFLhIXId2WLyE09vQ+Pfd6wE/cu43Vc+joSF
	XAp7x8FBflLRmoz/WyV2RQ7YkTbusvhzvA==
X-Received: by 2002:a05:7300:dc05:b0:36e:c07a:426f with SMTP id 5a478bee46e88-38281cf6a2bmr5272970eec.39.1795059582944;
        Wed, 18 Nov 2026 19:39:42 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:39:42 -0800 (PST)
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
Subject: [PATCHv2 04/18] powerpc/mm/book3s64: Annotate the subpage-protection PTE lock
Date: Thu, 19 Nov 2026 09:08:59 +0530
Message-Id: <7ae38230aaf14a87724f02ab955a9196acd27ebf.1795058683.git.ritesh.list@gmail.com>
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

Clang's context analysis reports:
  subpage_prot.c:83:2: error: releasing spinlock 'ptl' that was not held [-Werror,-Wthread-safety-analysis]

pte_offset_map_lock() holds ptl when it returns a PTE and
pte_unmap_unlock() drops it. However since the lock is taken inside the
helper, which is not annotated, so the unlock in hpte_flush_range()
looks unheld.

This patch fixes it in hpte_flush_range() by adding the needed
annotation here. IMO, should ideally be added to pte_offset_map_lock(),
once that happens (since it might need larger enablement), we can remove
it from here.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/subpage_prot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
index 37d47282c368..d641c35c408d 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -73,6 +73,8 @@ static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
 		return;
+	/* pte_offset_map_lock on success returns with ptl lock held */
+	__acquire(ptl);
 	lazy_mmu_mode_enable();
 	for (; npages > 0; --npages) {
 		pte_update(mm, addr, pte, 0, 0, 0);
-- 
2.39.5


