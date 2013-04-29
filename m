Return-Path: <alistair.popple@gmail.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E7A6C2C009C
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Apr 2013 13:43:17 +1000 (EST)
Received: by mail-pa0-f44.google.com with SMTP id rl6so247203pac.3
 for <linuxppc-dev@ozlabs.org>; Sun, 28 Apr 2013 20:43:15 -0700 (PDT)
Received: from localhost (ibmaus65.lnk.telstra.net. [165.228.126.9])
 by mx.google.com with ESMTPSA id lo7sm23870368pab.19.2013.04.28.20.43.13
 for <linuxppc-dev@ozlabs.org>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Sun, 28 Apr 2013 20:43:15 -0700 (PDT)
Sender: Alistair Popple <alistair.popple@gmail.com>
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] powerpc: Early debug console configuration clean up
Date: Mon, 29 Apr 2013 13:42:42 +1000
Message-Id: <1367206964-6319-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series (based on v3.9) adds a configuration option to
enable the use of BootX or OpenFirmware console for early debug
console support.

Previously the use of BootX/OpenFirmware as an early debug console was
selected by CONFIG_BOOTX. However this left the ability to select a
different early debug console under the "Early debugging" menu which
was not supported by udbg.c. Instead the actual console selected when
both CONFIG_BOOTX and another early debug console is conifigured was
based on the arbitrary order of a series of #if/#elif's in udbg.c.

This patch replaces the previously sent "[PATCH] Make CONFIG_BOOTX an
exclusive early debug option".
