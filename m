Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 62B9DDDE03
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 01:40:26 +1100 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id BA6A520D512
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 15:41:26 +0100 (CET)
Received: from localhost (unknown [192.168.1.157])
	by mail.m-online.net (Postfix) with ESMTP id CB220903D8
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 15:40:23 +0100 (CET)
Received: from localhost ([192.168.3.149])
	by localhost (scanner1.m-online.net [192.168.1.157]) (amavisd-new,
	port 10024) with ESMTP id 6CeUkz80ZW7E for <linuxppc-dev@ozlabs.org>;
	Sat,  1 Dec 2007 15:40:22 +0100 (CET)
Received: from ibook.aepfle.de (DSL01.83.171.165.156.ip-pool.NEFkom.net
	[83.171.165.156]) by mail.mnet-online.de (Postfix) with ESMTP
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 15:40:22 +0100 (CET)
Date: Sat, 1 Dec 2007 15:40:21 +0100
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: serial console autodetection not working on powermac
Message-ID: <20071201144021.GA13898@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


How is the serial console autodetection supposed to work with current
kernels? arch/powerpc/kernel/legacy_serial.c is not compiled unless
CONFIG_PPC_UDBG_16550 is selected.
Even if I force this config option, legacy_serial_console remains -1 and
the ch-a/ch-b check in check_legacy_serial_console() does not trigger.
Can the ch-a/ch-b check in check_legacy_serial_console() trigger anyway?

The autodetection used to work in earlier kernels.

A compiletime check for CONFIG_SERIAL_PMACZILOG_TTYS is also required,
to switch between ttyS and ttyPZ. Currently ttyS is hardcoded.
