Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hnFd5sFpzF29t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 07:59:49 +1000 (AEST)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mathieu Malaterre <malat@debian.org>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/2] powerpc: Wii IRQ fixes
Date: Thu, 10 May 2018 23:59:17 +0200
Message-Id: <20180510215919.27808-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series makes it possible to use the SD card on the Wii. The WLAN
now also works on the SDIO level, but fails to connect to a network for
some reason.

Patch 1 seems quite obvious, although I don't know why the code was
broken in this particular way.

Patch 2 might not be the right solution for the problem at hand, but it
works and should only cause problems when both processors in the system
(PPC and ARM) try to use the same interrupt, if at all.

Jonathan Neuschäfer (2):
  powerpc: flipper-pic: Don't match all IRQ domains
  powerpc: hlwd-pic: Prevent interrupts from being handled by Starlet

 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 8 --------
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    | 5 +++++
 2 files changed, 5 insertions(+), 8 deletions(-)

-- 
2.17.0
