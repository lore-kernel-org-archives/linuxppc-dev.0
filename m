Return-Path: <mohicks@gmail.com>
Received: from mail-ie0-x231.google.com (mail-ie0-x231.google.com
 [IPv6:2607:f8b0:4001:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C36671A0EBF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 04:00:19 +1100 (AEDT)
Received: by iecrd18 with SMTP id rd18so9285216iec.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 09:00:17 -0800 (PST)
Sender: Martin Hicks <mohicks@gmail.com>
From: Martin Hicks <mort@bork.org>
To: Kim Phillips <kim.phillips@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/2] crypto: talitos: Add AES-XTS mode
Date: Fri, 20 Feb 2015 12:00:08 -0500
Message-Id: <1424451610-5786-1-git-send-email-mort@bork.org>
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

This adds the AES-XTS mode, supported by the Freescale SEC 3.3.2.

One of the nice things about this hardware is that it knows how to deal
with encrypt/decrypt requests that are larger than sector size, but that 
also requires that that the sector size be passed into the crypto engine
as an XTS cipher context parameter.

When a request is larger than the sector size the sector number is
incremented by the talitos engine and the tweak key is re-calculated
for the new sector.

I've tested this with 256bit and 512bit keys (tweak and data keys of 128bit
and 256bit) to ensure interoperability with the software AES-XTS
implementation.  All testing was done using dm-crypt/LUKS with
aes-xts-plain64.

Is there a better solution that just hard coding the sector size to
(1<<SECTOR_SHIFT)?  Maybe dm-crypt should be modified to pass the
sector size along with the plain/plain64 IV to an XTS algorithm?

Martin Hicks (2):
  crypto: talitos: Clean ups and comment fixes for ablkcipher commands
  crypto: talitos: Add AES-XTS Support

 drivers/crypto/talitos.c |   45 +++++++++++++++++++++++++++++++++++++--------
 drivers/crypto/talitos.h |    1 +
 2 files changed, 38 insertions(+), 8 deletions(-)

-- 
1.7.10.4
