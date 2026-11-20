Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E23606A332
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t8rUMRJD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW1sj1zZBz308Q;
	Fri, 20 Nov 2026 15:03:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147417;
	cv=none; b=I1GA1Lq6DYjx3cBxN7APZHkcRVzQbbXQveP4bw3Gl/TlxiO2P1WIf1eJFcZ7gCLmGzvwJiTskQLlXI//KFMhIFo9B1dNHRY8FKtgfudCOXg9pfoD5bIqy8DyZruMPdj9VTPPp6grhnXPKeEaV/OX0X7DHCAQrEt3CL8eA7p3U+EzOzoCUajZEhYnvKWsn3SzbptUfPgvgptXGQHpCoEM4W3kyGkC7mhgfRg0mvrE2Kinei/OE7CG4D3MUZnVToDZJtLRoJA0rrhZ8TOEZxcYrn2bs9rflm5f6EykdRDOi2aMDxdkgJRy4bREKCvG++SKTAgGRS6reM/TvGnW82RVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147417; c=relaxed/relaxed;
	bh=yXYdj9nyuM4v8jiGLwhF31o5qWrZcD3zaXor3EN0gEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UUiiMhSSQYwQ+iHHe8yWjGvI9peSenWTDfa+Iy2JD5VLjU1vIg37/uNQv5XbzvquXxzxjG8KJWLJwPudkJ0mkGYkNQVgBzOk5+gJyqNtUHSus6zJcvQWJiccQmiKBYJMRliyANqyXWY/YWXyAGfLfA6JGYspU308xR1lOwhrPSYioZqjRTp08Fs8nTlWGktoGrSCEfuGsmjuZtLt7wQKUaXC7kFlUMj9B25c75fQys5E+u0ZG6Ey6JhM61MfePEC2oc8YSJqCvO1Rygl2/z+bZplj+FsCMx+lAtV5dzionaQFgJ410plrjii4Rlj7V2xzwsawUGsvLUdTDiefaIESA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t8rUMRJD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t8rUMRJD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW1sh4jdyz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:03:36 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-381f65e4e4bso702679eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147414; x=1795752214; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yXYdj9nyuM4v8jiGLwhF31o5qWrZcD3zaXor3EN0gEE=;
        b=t8rUMRJDMc96IMTRGxNX7Era0V6JpAWyV/HsgqMZsnVXI0BqQ3PTFYjCA7YDjt6Kse
         JUHG4k0yv+omQd3OehfUjsE5YlfvlvC25txmPqy+oK8MmRvRWOd4jIk6Bg6GJyl2STth
         cWEZ+ldPk71E/8KVUG8hUyLUmCgt2aI3fKXqRT56mj2NkYbwNMZyzYCspdC5w0DJ7UXL
         Jb72aFCf4dAoOErRHdpcr8mftCN4UURv4e1k4HI1kZWTvZLwxYC4vI7v+Q43hve/ZDIX
         rzwdkD3Iw7UtbZyVGpmCNPw+BThtmR6ZCfsrVD/4CRnAEdK7QzYKambm8AHenK8rePKn
         wmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147414; x=1795752214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yXYdj9nyuM4v8jiGLwhF31o5qWrZcD3zaXor3EN0gEE=;
        b=LXwe179Yy/59NAk09YD3eTh833bSzaloKNRnAIRc4oQ4pTlRi+hXtB1DWYb3DuBWkZ
         Md5nhOkghfSMWgn9OiqDoXdqfdBZT/766JzDYn57POWSzEFBtI2YAZcoWqB7/0jcjbYs
         nbOe8OWc+4sLPiPrfv7XSmFP9TWckDHuCQ2dPP7YgbwHCRdFlPmUstQbqeRQK04N96mN
         +ApwtweYJpZWt3L8vebd2beiUiKqmuPAklqA0/PV2QgdrFpcbgHu/rgys+ZzOSGqp5OU
         Z2pe7Kq4uCPQRYiA6+pr9e6jSan94cj5d5VP4/AGno3FLlP28PfasTcp2Bvvh6F2PBuQ
         iYyw==
X-Gm-Message-State: APuU4Z8iAYwm52f020Ox0BBruj6maiQyvYpHz+4hBWTDnpm74rIqfpbM
	LZuC6QTGU57sTWd0I6ootNSmcG6PezhKgMc/fgXqhqxGOXsvi/4e48ZmWvYCWg==
X-Gm-Gg: AZFdTZfIY21dhjuUj5LKCATYV0sD4b2orQ5rXV0M7JwATrRl9mMii2J79PuMu/7xUCF
	Pyf0ucovPUYbpKXCo9r7YGZl32FTub/RSENI2DbqfoWxiuTaUqkrjmjpUtrhqU3yUHgJROp8fGp
	NywTG4g9lsWyFhstOlMAjtZLHRoRiWkwQBsMm+76ehwJzPzLYXlryd6VwieQpTw00tz5o9RhsJ9
	Tn4O4xbCxXLGd7KDZUk0iVwW0eQBHCQtM4SHBB6TYLVG0xSKPLyNCjcNy2JZJFMSQPVIoQa6w5E
	D46PNejWYeuaU4OfopT+0tEY1IAAz1I/JHiOPu5+HQcYwyIONB8GrzEcrmLm3J9/TkBgE8nWlnz
	54vdaOhbc+vWStrcd+p0YRcoVtrlAGjSnXq5q4Sui4M5wWKQnfqDeju398q7ZB7JyfeEjkAxzUF
	xEGiNj5XD8m3n7QEtDHhmkOjCuKGc1Gp6kXYih498VFUeUlE8mPtfNpOsErkzTL+80ef/lCo9/w
	4cqAg0ALzLqjqUrjZc8cz4lHte4oYJRzkWl3BfT1EWj3PqoUv8nYIXY7NETCbRyiUi2A1BT5EFw
	a9LUlAJxzWVlXDsa6WIYAZDaLtMXEUs+4w==
X-Received: by 2002:a05:7300:10e:b0:385:4fef:bb1e with SMTP id 5a478bee46e88-38570c361e8mr1625006eec.36.1795147414494;
        Thu, 19 Nov 2026 20:03:34 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm3246104eec.6.2026.11.19.20.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:03:33 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv3 01/19] powerpc/mm/book3s64: unlock RCU before returning from mm_iommu_is_devmem()
Date: Fri, 20 Nov 2026 09:33:00 +0530
Message-Id: <c6cce4c4ad2b177cacfb7bfbb7bfd4a26fcd4612.1795147055.git.ritesh.list@gmail.com>
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

Clang's context analysis reports:
  iommu_api.c:380:1: error: __ctx_lock_RCU 'RCU' is not held on every path through here [-Werror,-Wthread-safety-analysis]

mm_iommu_is_devmem() takes the RCU read lock to walk the preregistered
device-memory list. On a match it returned true from inside the loop and
skipped rcu_read_unlock(). Hence fix it.

Fixes: b5952f8125ae ("powerpc/mm/book3s64/iommu: fix some RCU-list locks")
Cc: stable@vger.kernel.org
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/iommu_api.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/iommu_api.c b/arch/powerpc/mm/book3s64/iommu_api.c
index 60d00c9e7f19..56d9aa6cc8e2 100644
--- a/arch/powerpc/mm/book3s64/iommu_api.c
+++ b/arch/powerpc/mm/book3s64/iommu_api.c
@@ -356,6 +356,7 @@ bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
 {
 	struct mm_iommu_table_group_mem_t *mem;
 	unsigned long end;
+	bool ret = false;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
@@ -371,12 +372,13 @@ bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
 			 * and the caller needs to distinguish this situation.
 			 */
 			*size = min(1UL << pageshift, end - hpa);
-			return true;
+			ret = true;
+			break;
 		}
 	}
 	rcu_read_unlock();
 
-	return false;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mm_iommu_is_devmem);
 
-- 
2.39.5


