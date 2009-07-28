Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net
	[151.189.21.56])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9ECD5B7B70
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 22:50:59 +1000 (EST)
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net
	[151.189.8.33]) by mx.arcor.de (Postfix) with ESMTP id A5B3D257116
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 14:50:51 +0200 (CEST)
Received: from mail-in-17.arcor-online.net (mail-in-17.arcor-online.net
	[151.189.21.57])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 91AD32543ED
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 14:50:51 +0200 (CEST)
Received: from webmail10.arcor-online.net (webmail10.arcor-online.net
	[151.189.8.93])
	by mail-in-17.arcor-online.net (Postfix) with ESMTP id 79C753B23F3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 14:50:51 +0200 (CEST)
Message-ID: <24979490.1248785451446.JavaMail.ngmail@webmail10.arcor-online.net>
Date: Tue, 28 Jul 2009 14:50:51 +0200 (CEST)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [5200] ATA and (BAD) interrupts question
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I run linux 2.6.29.1 from kernel.org on a custom Freescale MPC5200B based b=
oard, which has a CF card attached to the 5200's ATA.  The CF seems to run =
nicely, but I am somewhat confused by the interrupts reproted by the kernel=
.

Immediately after the boot, /proc/interrupts reports (inter alia)

135:          8  MPC52xx Peripherals Edge      mpc52xx_ata
194:          0  MPC52xx SDMA Edge      ATA task
BAD:         44

Then I say 'mount -t vfat -o noatime /dev/sda1 /mnt/cf0', and I get

135:         41  MPC52xx Peripherals Edge      mpc52xx_ata
194:          0  MPC52xx SDMA Edge      ATA task
BAD:         44

Then, I recursively copy a folder to the CF card:

135:     125111  MPC52xx Peripherals Edge      mpc52xx_ata
194:          0  MPC52xx SDMA Edge      ATA task
BAD:     121863

Is it correct that the "ATA task" interrupts are still 0, and that I get su=
ch a high number of BAD ones?  Is there a way to detect which source actual=
ly triggered the BAD interrupts?

Thanks in advance,
Albrecht.

Der E-Mail-Dienst PIA basic belegt im Test der Stiftung Warentest unter den=
 kostenfreien Angeboten mit dem Qualit=E4tsurteil 3,0  den zweiten Platz!
(Testheft Juli 2009, Artikel "E-Mail-Dienste - Besser gratis")
JETZT TESTEN: www.arcor.de/rd/pia_sw
