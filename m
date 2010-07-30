Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id B5731B6EE8
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 16:40:22 +1000 (EST)
Received: by iwn36 with SMTP id 36so1134100iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 23:40:21 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 29 Jul 2010 23:40:21 -0700
Message-ID: <AANLkTimBP98EwRuvU_dj-RM2kaXZ-FSZ=GQxdod9VQeU@mail.gmail.com>
Subject: Which microcode patch for MPC870?
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Which microcode patch should be selected for MPC870? In the old 2.4
kernel, the CONFIG_UCODE_PATCH was selected. What's the corresponding
config: CONFIG_USB_SOF_UCODE_PATCH or CONFIG_I2C_SPI_UCODE_PATCH or
CONFIG_I2C_SPI_SMC1_UCODE_PATCH? Since my board doesn't have USB, I
believe USB microcode is irrelevant here. So it comes down the other
two choices. Of course do I really need the patch? My board has I2C
and SMC1, but no SPI.

I chose CONFIG_I2C_SPI_UCODE_PATCH as an experiment but got the
following compilation error:
  CC      arch/powerpc/sysdev/micropatch.o
arch/powerpc/sysdev/micropatch.c: In function 'cpm_load_patch':
arch/powerpc/sysdev/micropatch.c:629: error: expected '=', ',', ';',
'asm' or '__attribute__' before '*' token
arch/powerpc/sysdev/micropatch.c:629: error: 'spp' undeclared (first
use in this function)
arch/powerpc/sysdev/micropatch.c:629: error: (Each undeclared
identifier is reported only once
arch/powerpc/sysdev/micropatch.c:629: error: for each function it appears in.)
cc1: warnings being treated as errors
arch/powerpc/sysdev/micropatch.c:630: warning: ISO C90 forbids mixed
declarations and code
arch/powerpc/sysdev/micropatch.c:671: error: 'spi_t' undeclared (first
use in this function)
arch/powerpc/sysdev/micropatch.c:671: error: expected expression
before ')' token
arch/powerpc/sysdev/micropatch.c:630: warning: unused variable 'smp'
make[1]: *** [arch/powerpc/sysdev/micropatch.o] Error 1

Obviously there is no spi_t declaration in 2.6.33.5. So where is this
spi_t declared?

Thanks a lot,
-Shawn.
