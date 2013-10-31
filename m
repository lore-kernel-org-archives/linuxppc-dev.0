Return-Path: <tommusta@gmail.com>
Received: from mail-ob0-x22e.google.com (mail-ob0-x22e.google.com
 [IPv6:2607:f8b0:4003:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6222B2C0185
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 05:39:35 +1100 (EST)
Received: by mail-ob0-f174.google.com with SMTP id vb8so3449693obc.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 11:39:30 -0700 (PDT)
From: Tom <tommusta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [V2 PATCH 0/3] powerpc: Fix Little Endian Bugs in Single Step Code
Date: Thu, 31 Oct 2013 13:38:55 -0500
Message-Id: <1383244738-5986-1-git-send-email-tommusta@gmail.com>
Cc: Tom Musta <tommusta@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tom Musta <tommusta@gmail.com>

This patch series addresses bugs in the PowerPC single-step emulation
code (arch/powerpc/lib/sstep.c) pertaining to Little Endian.

The existing code has a chicken switch for little endian.  The first
patch softens the restriction so that only cross-endian modes are not
supported.

There is a general problem with unaligned little endian loads and stores.
This is addressed by the second patch.

Finally, there is a problem with unaligned single precision floating point
loads and stores which is addressed by the third patch.

V2: fixed bug in MSR[LE] check identified by Andreas Schwab and
Geert Uytterhoeven.

Tom Musta (3):
  powerpc: Enable emulate_step In Little Endian Mode
  powerpc: Fix Unaligned Fixed Point Loads and Stores
  powerpc: Fix Unaligned LE Floating Point Loads and Stores

 arch/powerpc/lib/sstep.c |  109 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 94 insertions(+), 15 deletions(-)
