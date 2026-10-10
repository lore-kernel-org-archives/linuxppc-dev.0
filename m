Return-Path: <linuxppc-dev+bounces-29177-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F29CA9EBE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Oct 2026 12:21:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j22sc648Kz2yqx;
	Sat, 10 Oct 2026 23:21:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791634916;
	cv=none; b=FJZ073B5XwQAEehynZqWcNX0Dq0B+WkyrOOB72q4ShysgZanASbwNmAQf4mEjj8f0y8VsuiOLBnWBNjzABmzhjYL3c4ifwmIhjb27t41X05mz5GjM8Jn2DPThi6h707OLRkX6uN7g8N5y6TUbiK4SRWuTRMjDzuajhHus09s5vM1qWybai1GitkDJyUByajH/4E90CXGqqvE5GHQXyflWlLRMmUT7jGOjB1cxqBFNuivU0ZLGFuz05Z6obvYgnycm8InbnxL6VF+SZ78CLLXH3c19ab1B4bilLYVfGHRRYE9s5G8L+gG+oQhhVAEIH+YjWSpRGtjo8MdUv0nqL6rRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791634916; c=relaxed/relaxed;
	bh=5KEImB+rJ+HNxPnu7ZXYsFF7K4BEwIE7Yr1L57wfEvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I9H8RworzbXHVOjFnIAXN0FZk8Tsh+MMcX3x/PJLssqv/Ocpkf47apk2R8v6dR6q6uCC9auoL3UqiAgNBbWNn6PgDo8p4SjKntsDND8A7xkx7CvLRyTz0FuKIq/u+R54Dq4l5R7QkIPZLSxTps85T+pAHX2ttQJGiKXjFWzDxb9dpFIXGa8MdG2DyelhM8AC1iFcORHnEjEkvCGcuTPTtX46mKxh0u58hDG/rzOd4lhQ0cHlY3wccuXQPWlvKly2HhnZlQ/fOEIpUYAynpItUAvtsTIESvF9TNmV3mK/uhFisM3Rs8BiD6wi5nFILneoACMnbgE84vrwRWqC7wefeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ra2n0uNR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ra2n0uNR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j22sb0hgdz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 23:21:53 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-3514b90bb89so880608eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791634911; x=1792239711; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5KEImB+rJ+HNxPnu7ZXYsFF7K4BEwIE7Yr1L57wfEvk=;
        b=ra2n0uNRgdzOVbNedDNxhDQPCTWR9W/gLMMnzffyp3rshbfVx3BUgDVLrs6UyPNcs0
         asmp2FUyQuzMzYW7KXc3Wp3Y8+AIx0yUTjoN4yUpJcQD4iUrprsx5eaZCzxegolw9iSo
         K1fUbIBZgn2dQM6ztVgYy6y8lB914axDQ6WmkVds45vE+zwaSVWjF04Z5V12al8QltDD
         4BYDSCd9PiniGa7HlF5qPrXsgeJG0cIV640jcFyxD0femfVdj5ICdkcf6ppN5fcpwP83
         i2vApB0KDDEXTWr8YFhpzSxIL0k0HpesqwqeZjb1fsKjA7nK/qRoHr1u7UCH4ozHVUMe
         rEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791634911; x=1792239711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5KEImB+rJ+HNxPnu7ZXYsFF7K4BEwIE7Yr1L57wfEvk=;
        b=aUoRFuPkgVlNKegn8x30ikedUinh/KpGLysm28TDwen6zXRNPhSgM6am31yc6vdnPe
         dnsfQNWTlkSRIDv17JfF3Hh4RofZbXSQDyaBRh3dzpZZO1AVBiGrFqs2GgyuQ3IZEXFd
         nY7X+vYRJGyJxxzGMsgLjpRGpfBsU5MqhZ8U0VCmVKv1CmPRZo0DX26AVMzKKx+evi0e
         Lwce0t1O2umD/1K0DcsZOHLJVKKGC7F9HPk+YEdN5ggijFz0AlNFaLsVA9y4eLVbcq6+
         yFcA1qAY9OlgEy49l1dLWDxfek/+5y5/YlCkudWYqO8wLBI5u6NrKvFyyg7lO5HnCdXn
         nzfg==
X-Gm-Message-State: AFq9FYIr3C3rW7JjvUYGd8No1Boz4iIPEoSNKD2qVDzwtxwL9T45CKm0
	EBNvWA12GNWiBEztVTjs/9sv1rDvbIKXhzVTss8LdtJX18lUpgQML+iPQ7NpegfE
X-Gm-Gg: AYBFou032czY10Uzy/KfvJ7iOjzDiTdyv+iKHkrJckHa/P+Idv62nfLxthY01CfJk0m
	IbDFxXOycPuU/fqjQVknCDr0ZUsHfyXNVVKDo/2//v83EfIkPwyBhTiX//XTiOXVa/XNO6Nrp5E
	fAo4D9HgC16xAqGbRcEIjQVmY65W3S6psLodLldOBUxv3xlaw2PbqeNhbzmfm+sni1m0t0jen55
	Jjxwj8LihZ9enceVMr1+euNYIGI+WPV+Hqt0U+NgB2XeRvGiDz5Emm4pCkuNTWgBQhzzlyYJ554
	DD0sBrRfqZ6ajpIiAieu3FBNtlaK7U29CBNAMn5clOmRdmnpVuPCAe3++ZChAlnpMmg8rGCxJ8Z
	dk0hOyjcoivHZKFz55QqmhMCWIDSr1CQK8D6argWBkp3n4+YMlsq4xfLS1hCRGDJqdlH6MzVllj
	6TzPQjUiIiGwz53yA29MHbk4xzV71YQuidexnwlNDt31ulOP6kM2dImkFizySFnOTRA4ikd1loR
	P/WiQ77j2nkWcQpinJWJu6qAtY0xSFQ73kGIlfPzU0lvF8SDBo8zJOEaTtd
X-Received: by 2002:a05:7022:f503:b0:16a:f5cd:365 with SMTP id a92af1059eb24-16af5cd03a3mr5524830c88.5.1791634910994;
        Sat, 10 Oct 2026 05:21:50 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becf08sm15401816c88.5.2026.10.10.05.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 05:21:49 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 0/4] powerpc/book3s64/radix: Add support for memfd_secret
Date: Sat, 10 Oct 2026 17:51:08 +0530
Message-Id: <cover.1791608423.git.ritesh.list@gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memfd_secret() gives a process a place to keep a secret that the kernel itself
should not be able to read. The page is still mapped in that process but it is
removed from the kernel linear map, so a kernel read or a speculative walk of
that map cannot see it.

On PowerPC book3s64, if the same address is translated by two pages of different
sizes at once, the TLB access can raise a machine check for a parity error or
a multi-hit. So that means breaking a 2M or a 1G mapping of kernel linear map is
not possible.

The way around that is to build the linear map out of base pages in the first
place and only then allow a single page to be dropped and put back. So, that is
what this series does by adding a linear_map_use_base_page cmdline option.

This is based out of mm-new branch for now (since few dependent function
definitions have been modified there). Once v7.4 is merge window closes - I will
rebase this to latest upstream powerpc tree.

Ritesh Harjani (IBM) (4):
  powerpc/64s: Add linear_map_use_base_page command line option
  powerpc/64s/radix: Implement ARCH_HAS_SET_DIRECT_MAP
  powerpc: Wire memfd_secret syscall
  selftests: mm: Enable memfd_secret for powerpc

 .../admin-guide/kernel-parameters.txt         | 10 ++
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/include/asm/book3s/64/mmu.h      |  2 +
 arch/powerpc/include/asm/set_memory.h         |  9 ++
 arch/powerpc/kernel/syscalls/syscall.tbl      |  2 +-
 arch/powerpc/mm/book3s64/pgtable.c            | 22 +++++
 arch/powerpc/mm/book3s64/radix_pgtable.c      |  2 +-
 arch/powerpc/mm/pageattr.c                    | 96 +++++++++++++++++++
 tools/testing/selftests/mm/Makefile           |  2 +-
 9 files changed, 143 insertions(+), 3 deletions(-)

--
2.39.5


