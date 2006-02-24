Return-Path: <heiko.schocher@invitel.hu>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id F0AAF67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Feb 2006 22:18:42 +1100 (EST)
Received: from mail.invitel.hu (mail.vnet.hu [213.163.59.4])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	EFE93110222 for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Feb 2006 11:47:35 +0100 (CET)
Received: from embluxa7e0291e ([213.163.18.53])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0IV600AF8TX3AG20@invitel.hu> for
	linuxppc-embedded@ozlabs.org; Fri, 24 Feb 2006 11:46:16 +0100 (CET)
Date: Fri, 24 Feb 2006 11:47:27 +0100
From: Heiko Schocher <heiko.schocher@invitel.hu>
Subject: PQ2FADS_ZU: u-boot-1.1.4, eldk.3.1.1, linux-2.4.25 boots problem
To: "Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Message-id: <AHEILKONAKAEJPHNMOPNEEIECFAA.heiko.schocher@invitel.hu>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Reply-To: heiko.schocher@invitel.hu
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I think your Environmentsettings are bogus:

your Environmentsettings:
> setconsole=setenv bootargs $console
[...]
> nfsboot=tftp $loadaddr $bootfile; run setconsole nfsargs addip; echo $bootargs; bootm
> console=console=ttyS0,115200n8 console=tty0

try this Environmentsettings:

addcons=setenv bootargs $(bootargs) console=ttyS0,115200
nfsboot=tftp $loadaddr $bootfile; run nfsargs addip addcons; echo $bootargs; bootm

> I have tried console=ttyCPM0,115200n8 console=tty0 and it makes no difference.

try console=ttyS0,115200

> BTW, which one should be used for serial console in 2.4.x kernel
> for this PowerQUICC II 8280 platform? ttySx or ttyCPMx?

If you have a 2.4.x Kernel, you must use ttySx, on a 2.6.x Kernel
it is ttyCPMx

Is there anything in the log_buf? Try a

http://www.denx.de/wiki/view/DULG/LinuxPostMortemAnalysis

Best regards

Heiko
