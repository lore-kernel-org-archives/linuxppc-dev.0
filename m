Return-Path: <SRS0=j/g1=IY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB056C433C1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 14:39:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A931561A05
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 14:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A931561A05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6Pkn10P4z3c3f
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Mar 2021 01:39:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pwunMNpw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+31783f3a8021f30233dc+6424+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=pwunMNpw; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6PkH6bxGz3bnn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Mar 2021 01:39:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=Utv9ctzA6JbUf5fzkr2Iqea2KSx8G5/onxIdDRpz+iI=; b=pwunMNpwbNGiq4DpTHowZL0XLj
 +1BJOa0IXN/N1cqIhAKK24rogTUJN4Rom9Y7fL03P15FKPKmMTLNwdymKEwXlwSaHo4ketVtJRvd5
 tCVyxeVRY1gFoNUZE/5QwShA2CdnByXadWqRIZxT2LXS8zWNtqGEs3szh0d4U0T2QdxAG8oLXqSSE
 8+kLFntalg5rJONA3g5uJz9NRj3Uew0be6UCnm+87stjWJfMcvn7wJj8RY4rcOVhVnpeICXXNdDGV
 0iXJa3VCf6BeqQ7F+EQ7hQZTMCR93e2LJzQCYYWI/PgNLr1cp8AycFH488ulR7uj14QtoNWgKJzj1
 ZDLib1Pg==;
Received: from [213.208.157.35] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lPnbj-005U6L-JU; Fri, 26 Mar 2021 14:38:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Subject: cleanup compat exec handling
Date: Fri, 26 Mar 2021 15:38:27 +0100
Message-Id: <20210326143831.1550030-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Brian Gerst <brgerst@gmail.com>, x86@kernel.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi all,

this series cleans up the exec code by sharing the native vs compat
versions less awkwardly.

Diffstat:
 arch/arm64/include/asm/unistd32.h                  |    4 
 arch/mips/kernel/syscalls/syscall_n32.tbl          |    4 
 arch/mips/kernel/syscalls/syscall_o32.tbl          |    4 
 arch/parisc/kernel/syscalls/syscall.tbl            |    4 
 arch/powerpc/kernel/syscalls/syscall.tbl           |    4 
 arch/s390/kernel/syscalls/syscall.tbl              |    4 
 arch/sparc/kernel/syscalls.S                       |    4 
 arch/x86/entry/syscall_x32.c                       |    2 
 arch/x86/entry/syscalls/syscall_32.tbl             |    4 
 arch/x86/entry/syscalls/syscall_64.tbl             |    4 
 fs/exec.c                                          |  136 +++------------------
 include/linux/compat.h                             |    7 -
 include/uapi/asm-generic/unistd.h                  |    4 
 tools/include/uapi/asm-generic/unistd.h            |    4 
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |    4 
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |    4 
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |    4 
 17 files changed, 53 insertions(+), 148 deletions(-)
