Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.206])
	by ozlabs.org (Postfix) with ESMTP id D62BD67B1C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 04:37:36 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so1275960wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 11:37:35 -0700 (PDT)
Message-ID: <528646bc050411113074ad93b5@mail.gmail.com>
Date: Mon, 11 Apr 2005 12:30:54 -0600
From: Grant Likely <glikely@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Eliminating RTC from MPC5200
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm working on a design using the MPC5200.  The hardware engineer I'm
working has asked if he could omit the crystal for the RTC.  I've
searched through the Linux source (2.6.11) and it seems that the on
the lite5200 the RTC is being used to measure both the system clock
and the decrementer speed for the serial port.  It does not look like
the RTC is used otherwise.

Is this true?  Can I eliminate the need for the RTC If I modify
mpc52xx_calibrate_decr() in arch/ppc/syslib/mpc52xx_setup.c and
mpc52xx_ipbfreq() in arch/ppc/boot/simple/mpc52xx_tty.c?  I'm assuming
that I can hard code the system clock speeds for my specific hardware.

Thanks,
g.
