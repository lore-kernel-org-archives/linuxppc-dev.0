Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E40EC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 21:42:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853DF20840
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 21:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XL61FXCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853DF20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Fkc541yLzDqGx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 08:41:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="XL61FXCO"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FkZB3ybRzDqD1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 08:40:18 +1100 (AEDT)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551994815;
 bh=aEF3dHxfSC+O8uFI32t0KQ8wXiO/kmMvW6eKVZyNwrU=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=XL61FXCOUQZO4h2aOX2Vfp8VSsAbM/vfKQVqZFJsW4446KSjKU6kdUxoG0gCeo3C5
 ROEKVGQGMUUsDhQ7iDQTIJn3XX0qoVD6+I8WU1BpT1mD2SiBZwc/X8dsRN1Sn2QvUr
 QGHbjPjBot+yUSZJIijGMLAhN7vZe54rpQ4jHiH8=
From: pr-tracker-bot@kernel.org
In-Reply-To: <87a7i6x1yk.fsf@concordia.ellerman.id.au>
References: <87a7i6x1yk.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a7i6x1yk.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.1-1
X-PR-Tracked-Commit-Id: 9580b71b5a7863c24a9bd18bcd2ad759b86b1eff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c3ac1134371b51c9601171af2c32153ccb11100
Message-Id: <155199481542.1630.7251693793029046147.pr-tracker-bot@kernel.org>
Date: Thu, 07 Mar 2019 21:40:15 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: mark.rutland@arm.com, sbobroff@linux.ibm.com, maddy@linux.vnet.ibm.com,
 clombard@linux.vnet.ibm.com, gustavo@embeddedor.com, aik@ozlabs.ru,
 jniethe5@gmail.com, mark.cave-ayland@ilande.co.uk, peterx@redhat.com,
 yamada.masahiro@socionext.com, oohall@gmail.com, sandipan@linux.ibm.com,
 mcroce@redhat.com, leitao@debian.org, rashmica.g@gmail.com, hch@lst.de,
 sergey.senozhatsky.work@gmail.com, joe.lawrence@redhat.com,
 sabyasachi.linux@gmail.com, aneesh.kumar@linux.ibm.com, yuehaibing@huawei.com,
 rppt@linux.ibm.com, firoz.khan@linaro.org, clabbe@baylibre.com,
 nfont@linux.vnet.ibm.com, rpjday@crashcourse.ca, joel@jms.id.au,
 igor.stoppa@gmail.com, nstange@suse.de, prasannatsmkumar@gmail.com,
 j.neuschaefer@gmx.net, npiggin@gmail.com, cai@lca.pw,
 tyreld@linux.vnet.ibm.com, natechancellor@gmail.com, arbab@linux.ibm.com,
 dvyukov@google.com, chunkeey@gmail.com, geoff@infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, malat@debian.org,
 tglx@linutronix.de, jrdr.linux@gmail.com, andrew.donnellan@au1.ibm.com,
 brajeswar.linux@gmail.com, fbarrat@linux.ibm.com, vaibhav@linux.ibm.com,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Fri, 08 Mar 2019 00:12:51 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c3ac1134371b51c9601171af2c32153ccb11100

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
