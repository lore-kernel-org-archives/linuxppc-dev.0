Return-Path: <fredrik.roubert@barco.com>
Received: from df.lth.se (mail.df.lth.se [194.47.250.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DC8767BC6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 03:25:06 +1000 (EST)
Received: from igloo.df.lth.se (localhost [127.0.0.1])
	by df.lth.se (8.13.1/8.13.1) with ESMTP id k9NGfH8p006759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Oct 2006 18:41:17 +0200 (CEST)
Received: (from roubert@localhost)
	by igloo.df.lth.se (8.13.1/8.13.1/Submit) id k9NGfGiY006758
	for linuxppc-embedded@ozlabs.org; Mon, 23 Oct 2006 18:41:16 +0200 (CEST)
Date: Mon, 23 Oct 2006 18:41:16 +0200
From: Fredrik Roubert <fredrik.roubert@barco.com>
To: linuxppc-embedded@ozlabs.org
Subject: ARCH=powerpc: IRQ numbers change mysteriously
Message-ID: <20061023164116.GC15953@igloo.df.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

On my MPC8439 based board, running Linux 2.6.18 with ARCH=powerpc, the
IRQ's for the I2C behave in a for me mysterious way.

In my DTS file, I have the following:


i2c@3000 {
	device_type = "i2c";
	compatible = "fsl-i2c";
	reg = <3000 100>;
	interrupts = <e 8>;
	interrupt-parent = <&/soc8349@ff400000/pic@700>;
	dfsrr;
};

i2c@3100 {
	device_type = "i2c";
	compatible = "fsl-i2c";
	reg = <3000 100>;
	interrupts = <f 8>;
	interrupt-parent = <&/soc8349@ff400000/pic@700>;
	dfsrr;
};


But when I boot the system and cat /proc/interrupts, the output says:


18:         61   IPIC   Level     i2c-mpc
19:          0   IPIC   Level     i2c-mpc


This doesn't make sense to me. Why are the IRQ numbers changed? They are
still adjacent, so it seems to be some logic to the change. Does anyone
know what this is?

Cheers // Fredrik Roubert

-- 
Barco Medical Imaging          |  +32 56 233549
http://www.barco.com/medical/  |  fredrik.roubert@barco.com
