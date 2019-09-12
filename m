Return-Path: <SRS0=nVWd=XH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FD8C4CEC6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Sep 2019 13:55:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C21020856
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Sep 2019 13:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PpkVSY9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C21020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46TgK61S4JzF39g
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Sep 2019 23:55:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="PpkVSY9G"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46TgB05KpTzF3Nx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2019 23:49:44 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 46Tg9v0znqz9tyn4;
 Thu, 12 Sep 2019 15:49:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=PpkVSY9G; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Wf5kk3MVvHvj; Thu, 12 Sep 2019 15:49:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 46Tg9t71PYz9tyn0;
 Thu, 12 Sep 2019 15:49:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1568296179; bh=d2QKZgIsoKBN+peITw+555bks/d8W8e+DijVX+dp8BY=;
 h=From:Subject:To:Cc:Date:From;
 b=PpkVSY9Gqb+knPHWbIUSQD/D+v2EuU1ilWPUrwsA+RereHq+2h/jUGl30Iy9zmRT4
 ppHWVyM4vJ4rew4cLuCqRz9v4MUL537VXiPBCd74DegYXJqC0rJmI03VgEE/u/0N5F
 pW8LIAgMlAA0JP4k5ML0pTaonfnUW3WkZaGz3oSg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 872498B93B;
 Thu, 12 Sep 2019 15:49:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 4UtH4FD05xBO; Thu, 12 Sep 2019 15:49:40 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 525488B933;
 Thu, 12 Sep 2019 15:49:40 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 31A5D6B736; Thu, 12 Sep 2019 13:49:40 +0000 (UTC)
Message-Id: <cover.1568295907.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 0/4] powerpc: Add support for GENERIC_EARLY_IOREMAP
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 npiggin@gmail.com, hch@infradead.org
Date: Thu, 12 Sep 2019 13:49:40 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series adds support for GENERIC_EARLY_IOREMAP on powerpc.

It also adds a warning in the standard ioremap() when it's called
before vmalloc is available in order to help locate those users.

Next step will be to incrementaly migrate all early users of
ioremap() to using early_ioremap() or other method.

Once they are all converted we can drop all the logic
behind ioremap_bot.

Christophe Leroy (4):
  powerpc/fixmap: don't clear fixmap area in paging_init()
  powerpc/fixmap: Use __fix_to_virt() instead of fix_to_virt()
  powerpc: Add support for GENERIC_EARLY_IOREMAP
  powerpc/ioremap: warn on early use of ioremap()

 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/include/asm/Kbuild   |  1 +
 arch/powerpc/include/asm/fixmap.h | 19 ++++++++++++++++++-
 arch/powerpc/kernel/setup_32.c    |  3 +++
 arch/powerpc/kernel/setup_64.c    |  3 +++
 arch/powerpc/mm/ioremap_32.c      |  1 +
 arch/powerpc/mm/ioremap_64.c      |  2 ++
 arch/powerpc/mm/mem.c             |  8 --------
 8 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.13.3

