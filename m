Return-Path: <SRS0=lnSH=6X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02B6C28CBC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 19:24:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85088206B8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 19:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xUz/f9vJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85088206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49KHF92GWNzDrBJ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2020 05:24:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49KGh40nm9zDr5l
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2020 04:58:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Date:Cc:To:Subject:From:Message-Id:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=hHP539olhChIDgjKWq092Tv+Ub+GtJssx5xvKfZ2AJo=; b=xUz/f9vJeR5RO1KpAoykk9QnIG
 CU+7EGPcDchaWR+GTmXYHkFPeoey2ASxtUqCHjf6l5F7S+bsxQMywelmLN/iM9KTQ918VoTN4QJRH
 G7m1cm0jc1smNX15S/+3SqtNUnR742jb1wyj0XmiWYfCXMUOPa7pJDEyKmkTxR9PAD7fgQcYWNiPV
 1AiYRJOKB1pSsznJXIZrHHP6q1FGIsntQ9/wAN9Z2pF6w/U3SZrhWifGt89jin2lNTKst2b5bAMIB
 VtQf0CqY5a9SasAcvxvZnq6u0jRPIo/QDWV9DudRxiQkKpI9swJKvDA/oPc1LjrYczq6676nF1WvH
 OBy1kxhw==;
Received: from geoff by merlin.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jXUgB-0003Db-Hw; Sat, 09 May 2020 18:58:31 +0000
Message-Id: <cover.1589049250.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Sat, 9 May 2020 11:34:10 -0700
Subject: [PATCH v2 0/9] powerpc + ps3 patches
To: Michael Ellerman <mpe@ellerman.id.au>,
 David S. Miller <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>
Date: Sat, 09 May 2020 18:58:31 +0000
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
Cc: linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Markus Elfring <elfring@users.sourceforge.net>,
 Emmanuel Nicolet <emmanuel.nicolet@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

This is a combined V2 of the two patch sets I sent out on March 27th,
'PS3 patches for v5.7' and 'powerpc: Minor updates to improve build debugging'.

I've dropped these two patches that were in my 'PS3 patches for v5.7' set:

      powerpc/ps3: Add lv1_panic
      powerpc/ps3: Add udbg_panic

and replaced them with a new patch:

      powerpc/ps3: Fix kexec shutdown hang

There is new patch I've added in this set:

      hvc_console: Allow backends to set I/O buffer size

which I've been using in my debugging.  There is nothing using this feature in
the upstream kernel, and I don't plan to submit anything that would use it, so
use your discretion as to merge it.

-Geoff

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-merge-powerpc-v2

for you to fetch changes up to 6f6294df663a53f47bb28abcbb1ef756c6a59922:

  hvc_console: Allow backends to set I/O buffer size (2020-05-09 11:24:42 -0700)

----------------------------------------------------------------
Emmanuel Nicolet (1):
      ps3disk: use the default segment boundary

Geoff Levand (6):
      powerpc/head_check: Automatic verbosity
      powerpc/wrapper: Output linker map file
      powerpc/head_check: Avoid broken pipe
      powerpc/ps3: Add check for otheros image size
      powerpc/ps3: Fix kexec shutdown hang
      hvc_console: Allow backends to set I/O buffer size

Markus Elfring (2):
      drivers/ps3: Remove duplicate error messages
      net/ps3_gelic_net: Remove duplicate error message

 arch/powerpc/boot/wrapper                    | 20 +++++++++++++++++---
 arch/powerpc/platforms/ps3/mm.c              | 22 ++++++++++++----------
 arch/powerpc/tools/head_check.sh             |  8 +++++---
 drivers/block/ps3disk.c                      |  1 -
 drivers/net/ethernet/toshiba/ps3_gelic_net.c |  2 --
 drivers/ps3/ps3-lpm.c                        |  2 --
 drivers/ps3/ps3-vuart.c                      |  1 -
 drivers/tty/hvc/hvc_console.c                | 19 +++++++++++--------
 8 files changed, 45 insertions(+), 30 deletions(-)

-- 
2.20.1

