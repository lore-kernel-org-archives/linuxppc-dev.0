Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F8E5DDDED
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 21:45:56 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0GAjoBu016508
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 19:45:50 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l0GAjpSN021186
	for linuxppc-dev@ozlabs.org; Tue, 16 Jan 2007 19:45:51 +0900 (JST)
Received: from mx11.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0GAjoHT018573
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 19:45:50 +0900 (JST)
Message-Id: <200701161045.l0GAjnWH009513@toshiba.co.jp>
MIME-Version: 1.0
Date: Tue, 16 Jan 2007 19:45:58 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH 0/4] drivers/ata: add another IRQ calls
Cc: jeff@garzik.org, arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear everyone.

This is the patchset (based on 2.6.20-rc4) for PATA controller
of Celleb. Now, I add two IRQ calls (irq_on, irq_ack) in
ata_port_operations. If these calls are not defined, ata_irq_on()
and ata_irq_ack() are used. Using them, the size of pata_scc.c
is reduced considerably.

I think the abstraction level of these calls are more acceptable
as libata I/F than low-level taskfile accessors.
Please give me any comments.

Best regards,
Akira Iguchi
