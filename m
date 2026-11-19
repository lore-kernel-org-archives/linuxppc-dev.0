Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F5606A331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b4e1mIsb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVLyC5XD4z2xN4;
	Thu, 19 Nov 2026 12:50:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795053011;
	cv=none; b=hKPa1lceOTqdpGRr/HmUnLJSxdT2O1yHV9M0kyh/MuE+ABEtjNwvPJohdGNIboFZWZzdMyxSoIqH1sCqK5cNPmy2+RHXsqdWBEMO8dyrU80QPMyzTO/xu2uAu1Pil1pUe8Xd+LnDdjSTB0D/wfm1AFl8lKaMhVq5LnmNggqtx4DvZFe+UUuROyVt2e9K/8oFM7yELD3k4P8TZF+qE93UIbdyqKLNgJEq7IP71r6ovzVJ9pppO6+y2WRolhEYVimzamQWEqKqgaLonIVpv9Fxw+8HLDq4F/CXVxohTIM4jc7PUtBSpGiM0Ah2lnVGjjJk3h8P3zSF1kL3GPHvjCURyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795053011; c=relaxed/relaxed;
	bh=zMbXDwiwhPzho9zRreMRs+AlQUufycAfiHIq9zZ6xHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byOvvshgBADEtncMQ+jUvOfM2oIlvkEu6oZZhUt20LxnAho7pLAhbePbcF3vYsVbLX1H0ohI/UWIV1c4PhTYU1qua3pKYX1JycXFUJQh7xVxfAFdJjJ8GgVup0hReTodBl3nR2isl1RKoAYI9wdf0qs4QfFEEgxkTuhV8vkofDwNVP0KHPr0G+kjTqP+8YiIch5bRVkj/3dnb61paZVMUGrnns69Z+93CgCwL26+8wh40h5ucvxLNaAwuUZswnsYeV0xvMBOdgIbvLDlN5IAH6P+PMEqKKue/iVSk1UDeCYleGTxNJRDzeWkYbOtwv4N0c8LKnMz1+XzoWuR/JQnkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b4e1mIsb; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b4e1mIsb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVLy54cccz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 12:50:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zMbXDwiwhPzho9zRreMRs+AlQUufycAfiHIq9zZ6xHk=; b=b4e1mIsbpOlMv01At+Wp4iM+m4
	7ug4tTWIl67Uod42CUrTQ+eNtWySwkn2aafL0L0ndamWEM5WzCAUvRj0gxxzm42xVMT0wLJWUu6K/
	qcfkMY+NpoN12zTZZkMRZPMcmk0hhL3qa/CnwfKLW3SkXstSHEQKT2a8NX1SX9VIO4Ve/hnIME4D7
	Krn5vaj4swtGFHPj9w9qynVzICfvXWruvXq2VCF8B2JzZMs7Xg8OYOM0Ym+km+VfUBGqwfMyDSjta
	DQHL+JhfQ5CKkui029SdBP5FzZqULOXPpwuXuCJ/+YtYIJLY7gPXrNI17SsMVPL53s+AkTgF3hz7E
	FbpdMb/A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTrHj-0000000AebB-3FLL;
	Thu, 19 Nov 2026 01:49:59 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] docs: kernel-parameters: correct a typo
Date: Wed, 18 Nov 2026 17:49:57 -0800
Message-ID: <20261119014957.213349-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.1
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark a kernel parameter as EARLY instead of ENABLE.

I saw this "ENABLE" and didn't make any sense of it, unless
it's just a typo for "EARLY".

Fixes: 600716592a3a ("doc: Add EARLY flag to early-parsed kernel boot parameters")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org

 Documentation/admin-guide/kernel-parameters.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20261118.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20261118/Documentation/admin-guide/kernel-parameters.txt
@@ -5556,7 +5556,7 @@ Kernel parameters
 			execution priority.
 
 	ppc_strict_facility_enable
-			[PPC,ENABLE] This option catches any kernel floating point,
+			[PPC,EARLY] This option catches any kernel floating point,
 			Altivec, VSX and SPE outside of regions specifically
 			allowed (eg kernel_enable_fpu()/kernel_disable_fpu()).
 			There is some performance impact when enabling this.

