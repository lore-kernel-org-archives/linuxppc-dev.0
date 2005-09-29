Return-Path: <Petr.Borsodi@i.cz>
Received: from ns.decros.cz (ns.decros.cz [193.85.26.2])
	by ozlabs.org (Postfix) with ESMTP id 35E176838E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 19:46:48 +1000 (EST)
Received: from gwi.cb.i.cz (gw.decros.cz [193.85.26.254])
	by ns.decros.cz (8.11.7/8.11.7) with ESMTP id j8T96dD86743
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 11:06:39 +0200 (CEST)
Received: from DCB02.cb.i.cz (dcb02.cb.i.cz [192.168.51.4])
	by gwi.cb.i.cz (8.13.1/8.13.1) with ESMTP id j8T96ZVc064809
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 11:06:35 +0200 (CEST)
	(envelope-from Petr.Borsodi@i.cz)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Thu, 29 Sep 2005 11:06:35 +0200
Message-ID: <9999CA1912E416428A03B319E6D084C807C831@DCB02.cb.i.cz>
From: "Borsodi Petr" <Petr.Borsodi@i.cz>
To: <linuxppc-embedded@ozlabs.org>
Subject: BRG setting error
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I found an error in Baud Rate Generator setting for MPC82XX processors.

The CD field of im_brgcx (x =3D 1..8) register is set to wrong value. =
This
field must be set to divisor lowered by 1, in according with doc for
MPC8272 or similar. I have searched 2.4.31 and 2.6.12 kernels.

Please check these functions:

linux-2.4.31\arch\ppc\boot\simple\m8260_tty.c: serial_init
linux-2.4.31\arch\ppc\cpm2_io\commproc.c: cpm2_setbrg
linux-2.4.31\arch\ppc\cpm2_io\commproc.c: cpm2_fastbrg

linux-2.6.12\arch\ppc\boot\simple\m8260_tty.c: serial_init
linux-2.6.12\arch\ppc\syslib\cpm2_common.c: cpm2_setbrg
linux-2.6.12\arch\ppc\syslib\cpm2_common.c: cpm2_fastbrg

This problem is shown only for small divider - for normal UART baud
rates the deviation is slight.

(I think that better approach is round the divisor to nearest value).

Best regards


Petr Borsodi, SW Development
S.ICZ a.s., J.S. Baara 40, 370 01 Ceske Budejovice, Czech Republic
