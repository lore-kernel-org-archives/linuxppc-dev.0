Return-Path: <tommusta@gmail.com>
Received: from mail-oa0-x236.google.com (mail-oa0-x236.google.com
 [IPv6:2607:f8b0:4003:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8328F2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 06:38:52 +1100 (EST)
Received: by mail-oa0-f54.google.com with SMTP id o20so439394oag.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 12:38:48 -0700 (PDT)
Message-ID: <1382125125.2206.22.camel@tmusta-sc.rchland.ibm.com>
Subject: [PATCH 0/3] powerpc: Fix Little Endian Bugs in Single Step Code
From: Tom Musta <tommusta@gmail.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 18 Oct 2013 14:38:45 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tmusta@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series addresses bugs in the PowerPC single-step emulation
code (arch/powerpc/lib/sstep.c) pertaining to Little Endian.

The existing code has a chicken switch for little endian.  The first
patch softens the restriction so that only cross-endian modes are not
supported.

There is a general problem with unaligned little endian loads and stores.
This is addressed by the second patch.

Finally, there is a problem with unaligned single precision floating point
loads and stores which is addressed by the third patch.

Tom Musta (3):
  powerpc: Enable emulate_step In Little Endian Mode
  powerpc: Fix Unaligned Fixed Point Loads and Stores
  powerpc: Fix Unaligned LE Floating Point Loads and Stores

 arch/powerpc/lib/sstep.c |  109 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 94 insertions(+), 15 deletions(-)
