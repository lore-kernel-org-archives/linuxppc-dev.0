Return-Path: <mohicks@gmail.com>
Received: from mail-ie0-x22b.google.com (mail-ie0-x22b.google.com
 [IPv6:2607:f8b0:4001:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 963751A0214
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 00:21:51 +1100 (AEDT)
Received: by iecrd18 with SMTP id rd18so57740706iec.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2015 05:21:48 -0800 (PST)
Sender: Martin Hicks <mohicks@gmail.com>
From: Martin Hicks <mort@bork.org>
To: Kim Phillips <kim.phillips@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 0/5] crypto: talitos: Add crypto async queue handling
Date: Tue,  3 Mar 2015 08:21:32 -0500
Message-Id: <1425388897-5434-1-git-send-email-mort@bork.org>
Cc: Martin Hicks <mort@bork.org>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org,
 =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@freescale.com>
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

Changes since v1:

- Ran checkpatch.pl
- Split the path for submitting new requests vs. issuing backlogged
  requests.
- Avoid enqueuing a submitted request to the crypto queue unnecessarily.
- Fix return paths where CRYPTO_TFM_REQ_MAY_BACKLOG is not set.


Martin Hicks (5):
  crypto: talitos: Simplify per-channel initialization
  crypto: talitos: Remove MD5_BLOCK_SIZE
  crypto: talitos: Fix off-by-one and use all hardware slots
  crypto: talitos: Reorganize request submission data structures
  crypto: talitos: Add software backlog queue handling

 drivers/crypto/talitos.c |  240 +++++++++++++++++++++++++++-------------------
 drivers/crypto/talitos.h |   44 +++++++--
 2 files changed, 177 insertions(+), 107 deletions(-)

-- 
1.7.10.4
