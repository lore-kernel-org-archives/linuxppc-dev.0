Return-Path: <SRS0=2k7A=4J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7181CC35647
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Feb 2020 11:43:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D440C222C4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Feb 2020 11:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MgvZsxBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D440C222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48P8k12vF3zDqp5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Feb 2020 22:43:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48P8hD4zNtzDqbm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2020 22:42:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=MgvZsxBS; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48P8hD20VMz9sRk;
 Fri, 21 Feb 2020 22:42:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1582285340;
 bh=NiF+bAhi1skEMdJThTrM5/fv2rDtBJ34wkpPNzl4/Es=;
 h=From:To:Cc:Subject:Date:From;
 b=MgvZsxBSUc/fzQWExGRyxW6ivm9Ea4SxJJoljMGwOkhsvbS68717+YuDDjuikChA0
 L/Ayp+X7FGl1GMApgDX2jP29Yo6C4txm0GWoKON/Btkm9XqWfEQWSv8FSr5hVVEGXK
 JK6bePekDkoRqBbx3KKJ3SIWuEHqAFosIf9DeR32TJ9L0h1Er/r11Muy60uTPMnhIA
 z1mtmOnnJqaBjjEVQaVIGnpKQO08hQ0OV5FT8PwbI9AawzUUwziKkGf77WWxA32WMI
 bF4Gt+UZWKqkhnyshiXrpBKAphvtcGa7xdM50ZVuab7jS4xbRBq7bFIUlPG+XeZrwP
 63rYJDx9fRFHQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.6-3 tag
Date: Fri, 21 Feb 2020 22:42:15 +1100
Message-ID: <87lfowdv54.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: mikey@neuling.org, gustavold@linux.ibm.com, sbobroff@linux.ibm.com,
 linux-kernel@vger.kernel.org, oohall@gmail.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.6. This is two weeks worth as I was
out sick last week.

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.6-3

for you to fetch changes up to 9eb425b2e04e0e3006adffea5bf5f227a896f128:

  powerpc/entry: Fix an #if which should be an #ifdef in entry_32.S (2020-02-19 10:35:22 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.6 #3

 - Three fixes for the recently added VMAP_STACK on 32-bit.

 - Three fixes related to hugepages on 8xx (32-bit).

 - A fix for a bug in our transactional memory handling that could lead to a
   kernel crash if we saw a page fault during signal delivery.

 - A fix for a deadlock in our PCI EEH (Enhanced Error Handling) code.

 - A couple of other minor fixes.

Thanks to:
  Christophe Leroy, Erhard F, Frederic Barrat, Gustavo Luiz Duarte, Larry
  Finger, Leonardo Bras, Oliver O'Halloran, Sam Bobroff.

- ------------------------------------------------------------------
Christophe Leroy (7):
      powerpc/hugetlb: Fix 512k hugepages on 8xx with 16k page size
      powerpc/hugetlb: Fix 8M hugepages on 8xx
      powerpc/8xx: Fix clearing of bits 20-23 in ITLB miss
      powerpc/32s: Fix DSI and ISI exceptions for CONFIG_VMAP_STACK
      powerpc/chrp: Fix enter_rtas() with CONFIG_VMAP_STACK
      powerpc/6xx: Fix power_save_ppc32_restore() with CONFIG_VMAP_STACK
      powerpc/entry: Fix an #if which should be an #ifdef in entry_32.S

Gustavo Luiz Duarte (1):
      powerpc/tm: Fix clearing MSR[TS] in current when reclaiming on signal delivery

Oliver O'Halloran (1):
      powerpc/xmon: Fix whitespace handling in getstring()

Sam Bobroff (1):
      powerpc/eeh: Fix deadlock handling dead PHB


 arch/powerpc/include/asm/page.h       |   5 +
 arch/powerpc/include/asm/processor.h  |   4 +
 arch/powerpc/kernel/asm-offsets.c     |  12 ++
 arch/powerpc/kernel/eeh_driver.c      |  21 +--
 arch/powerpc/kernel/entry_32.S        |  13 +-
 arch/powerpc/kernel/head_32.S         | 155 +++++++++++++++++++-
 arch/powerpc/kernel/head_32.h         |  21 ++-
 arch/powerpc/kernel/head_8xx.S        |   2 +-
 arch/powerpc/kernel/idle_6xx.S        |   8 +
 arch/powerpc/kernel/signal.c          |  17 ++-
 arch/powerpc/kernel/signal_32.c       |  28 ++--
 arch/powerpc/kernel/signal_64.c       |  22 ++-
 arch/powerpc/mm/book3s32/hash_low.S   |  52 +++----
 arch/powerpc/mm/book3s32/mmu.c        |  10 +-
 arch/powerpc/mm/hugetlbpage.c         |  29 ++--
 arch/powerpc/mm/kasan/kasan_init_32.c |   3 +-
 arch/powerpc/xmon/xmon.c              |   5 +
 17 files changed, 308 insertions(+), 99 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl5PwfYACgkQUevqPMjh
pYBuFg//b2i/1wn5+CQiqCM4B7Z0fbNvAWH0CFrseR1f72OnO0c9h92vTMjNDIVf
SItrgl4bBstVq/1YjHnZn00WpJPihIFcXPveQbiH+9yb89Mkcwjj3jLrV/DYIpRW
gtHxCJImc4/A4tLOUhRA2armXL4AoFlolF/Pbe2m/2lGeH1+tfY4Xd50FJF8c9Zc
zLdIN4B5Y+IkROQO23LFKiYV0tarvc4q5z6VOY5WlaGd/dpK4OQmheymeDMTYiNN
CH81u4b6jiiq9uwAWRXao2RTotac3m3Q4XnEswf3obDNGF2mDkAWvpqIgKxRxPNu
7vtmlamHxhpuqtZpRPPYIaH57j0pGZH63gvCThjJ+V9SL7J856cml9mv4UJOcmI3
Fkyk8S/QbiP5Rt9KV+CELHGcWaVt+uCuKPwlFrkoEMw1HZ6GErhpKzBNHyoNA1mG
xLMR4joCHZig62WBEHlZXgLzPVsetO7ZpY+j7tYEWrllfmOeL0F8HzNQ2e6ukF1R
gyF7eEThKajDhCwgz8pGnE2te+mz56oLHv9lcqU/wEgxHadyzeMjkiRUfxgiQ+K1
sOWzQjYEt7dhocavOAJb3qtfNMhwSfvSk75P6x8PQNFhQ+KhbNi6JpkOYSTmESBP
T8po1xh7Hm7IiIROT0hvcdnNb2fIIBNrKaheUlmvOOObEfWaa2Q=
=rC3U
-----END PGP SIGNATURE-----
