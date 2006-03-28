Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de [83.120.0.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2D7E3679FF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 11:29:23 +1100 (EST)
Received: from server.idefix.loc (ppp-82-135-78-215.mnet-online.de
	[82.135.78.215]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.4/8.13.4) with ESMTP id k2S072f5002370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 02:07:02 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.loc with local (Exim 4.60 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1FO1jj-000P6g-8B
	for linuxppc-embedded@ozlabs.org; Tue, 28 Mar 2006 02:07:03 +0200
Date: Tue, 28 Mar 2006 02:07:03 +0200
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Kernel for MPC Lite 5200 will not compile
Message-ID: <20060328000703.GA95672@server.idefix.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Matthias Fechner <idefix@fechner.net>
Reply-To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I installed today ELDK 4.0 for the LITE5200 board (icecube).
./install -d /usr/local/eldk ppc_6xx

After compiling u-boot and playing a little bit with it, i tried to
compile the kernel 2.6.

For this I used the git repository.
I copied the file arch/ppc/configs/lite5200_defconfig to .config, and
tried the following one:
make ARCH=ppc CROSS_COMPILE=ppc_6xx- uImage

But i got a failure with the following error message:
  CC      arch/ppc/syslib/bestcomm/bestcomm.o arch/ppc/syslib/bestcomm/bestcomm.c: In function 'mpc52xx_sdma_probe':
arch/ppc/syslib/bestcomm/bestcomm.c:269: warning: implicit declaration of function 'to_platform_device' 
arch/ppc/syslib/bestcomm/bestcomm.c:269: warning: initialization makes pointer from integer without a cast
arch/ppc/syslib/bestcomm/bestcomm.c:278: warning: implicit declaration of function 'platform_get_resource'
arch/ppc/syslib/bestcomm/bestcomm.c:278: warning: assignment makes pointer from integer without a cast
arch/ppc/syslib/bestcomm/bestcomm.c:279: warning: assignment makes pointer from integer without a cast
arch/ppc/syslib/bestcomm/bestcomm.c: At top level:
arch/ppc/syslib/bestcomm/bestcomm.c:367: error: 'platform_bus_type' undeclared here (not in a function)
make[2]: *** [arch/ppc/syslib/bestcomm/bestcomm.o] Fehler 1
make[1]: *** [arch/ppc/syslib/bestcomm] Fehler 2
make: *** [arch/ppc/syslib] Fehler 2

What is wrong here, I think i did an error on any step...

Thx for help!

Best regards,
Matthias
