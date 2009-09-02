Return-Path: <bigeasy@www.tglx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0D2C7B7B7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 19:44:51 +1000 (EST)
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 449E2DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 19:44:49 +1000 (EST)
Date: Wed, 2 Sep 2009 11:44:38 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Rigby <jrigby@freescale.com>
Subject: mpc512x USB non-working after kexec
Message-ID: <20090902094438.GB15401@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi John,

on my mpc512x custom board I have non-working USB after the kexec
syscall. I've traced it down to the ehci_turn_off_all_ports() which is
called from within ehci_shutdown(). If I omit ehci_turn_off_all_ports()
it works fine. The content of the portstatus register is the same after
the setup prior the usb-stack takes over so I don't see any difference
here.
Do you see such a behaviour on your board? Unfortunately I don't have
any other "official"/FSL board where I could cross-check and say it is
the HW.

Sebastian
