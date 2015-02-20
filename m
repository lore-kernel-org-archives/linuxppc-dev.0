Return-Path: <mohicks@gmail.com>
Received: from mail-ig0-x233.google.com (mail-ig0-x233.google.com
 [IPv6:2607:f8b0:4001:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A79D71A0F0B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 03:21:47 +1100 (AEDT)
Received: by mail-ig0-f179.google.com with SMTP id l13so4255827iga.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 08:21:45 -0800 (PST)
Sender: Martin Hicks <mohicks@gmail.com>
From: Martin Hicks <mort@bork.org>
To: Kim Phillips <kim.phillips@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/5] crypto: talitos: Add crypto async queue handling
Date: Fri, 20 Feb 2015 11:21:11 -0500
Message-Id: <1424449276-5288-1-git-send-email-mort@bork.org>
Cc: Martin Hicks <mort@bork.org>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I was testing dm-crypt performance with a Freescale P1022 board with 
a recent kernel and was getting IO errors while doing testing with LUKS.
Investigation showed that all hardware FIFO slots were filling and
the driver was returning EAGAIN to the block layer, which is not an
expected response for an async crypto implementation.

The following patch series adds a few small fixes, and reworks the
submission path to use the crypto_queue mechanism to handle the
request backlog.


Martin Hicks (5):
  crypto: talitos: Simplify per-channel initialization
  crypto: talitos: Remove MD5_BLOCK_SIZE
  crypto: talitos: Fix off-by-one and use all hardware slots
  crypto: talitos: Reorganize request submission data structures
  crypto: talitos: Add software backlog queue handling

 drivers/crypto/talitos.c |  189 ++++++++++++++++++++++++----------------------
 drivers/crypto/talitos.h |   44 +++++++++--
 2 files changed, 137 insertions(+), 96 deletions(-)

-- 
1.7.10.4
