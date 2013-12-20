Return-Path: <jjhiblot@gmail.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 055EE2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 02:15:52 +1100 (EST)
Received: by mail-wi0-f174.google.com with SMTP id z2so8520395wiv.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 07:15:47 -0800 (PST)
From: jean-jacques hiblot <jjhiblot@traphandler.com>
To: wsa@the-dreams.de
Subject: [PATCH v3 REPOST 0/4] i2c : i2c-ibm-iic : use interrupts to perform
 the data transfer
Date: Fri, 20 Dec 2013 16:12:52 +0100
Message-Id: <1387552376-12986-1-git-send-email-jjhiblot@traphandler.com>
Cc: gregory.clement@free-electrons.com,
 jean-jacques hiblot <jjhiblot@traphandler.com>, linuxppc-dev@lists.ozlabs.org,
 linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfram,

I'm reposting this patch set with the linux-ppc list in cc as the ibm I2c
controller is primarily (only?) available on ppc platforms.


This patch set aims to improve the performance of the driver for the IBM iic
controller by implementing the data transfer in the interrupt handler.
Using interrupts to trigger the data transfer reduces and make more
deterministic the latencies between indivdual bytes, and consequently reduces
the total transfer time,

In our test environement with multiple masters, this significantly reduces the
rate of i2c errors.

Changes since v2:
 - cosmectics change (comments style, removed a hard-coded value)
 - moved some parts from one patch to another 
 
Changes since v1:
 - split the patch in 4 individual patches. The code has been refactored a bit
   to make the diff easier to read.
 - changed some dev_dbg in dev_err or dev_warn when more appropriate
 
jean-jacques hiblot (4):
  i2c: i2c-ibm-iic: cleanup.
  i2c: i2c-ibm-iic: perform the transfer in the interrupt handler
  i2c: i2c-ibm-iic: Implements transfer abortion
  i2c: i2c-ibm-iic: Implements a polling mode

 drivers/i2c/busses/i2c-ibm_iic.c | 490 +++++++++++++++++++++++----------------
 drivers/i2c/busses/i2c-ibm_iic.h |  20 +-
 2 files changed, 309 insertions(+), 201 deletions(-)

-- 
1.8.4.2
