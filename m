Return-Path: <koti.kelam@gmail.com>
Received: from mail-pw0-f43.google.com (mail-pw0-f43.google.com
	[209.85.160.43]) by ozlabs.org (Postfix) with ESMTP id 7CDA3B7BEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Jan 2010 17:42:16 +1100 (EST)
Received: by pwj11 with SMTP id 11so13669903pwj.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 07 Jan 2010 22:42:14 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 8 Jan 2010 12:12:14 +0530
Message-ID: <e4855a1001072242o718c2dbap4990cc5c0140fb8b@mail.gmail.com>
Subject: Any patch for MTD_FSL_UPM_NAND with OF_GPIO
From: Koteswar <koti.kelam@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=00504502cd68f450a1047ca17cb5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00504502cd68f450a1047ca17cb5
Content-Type: text/plain; charset=ISO-8859-1

Hi
I am using linux-2.6.26.8 kernel. In drivers/mtd/nand/Kconfig,
MTD_NAND_FSL_UPM depends on MTD_NAND && OF_GPIO && (PPC_83xx || PPC_85xx).
But I didnt find any way to select OF_GPIO option in "make menuconfig". So I
removed it from Kconfig file and got MTD_NAND_FSL_UPM in menuconfig. I
selected it and did "make uImage". This is giving few errors:

include/asm-generic/gpio.h: In function 'gpio_get_value_cansleep':
include/asm-generic/gpio.h:135: error: implicit declaration of function
'gpio_get_value'
include/asm-generic/gpio.h: In function 'gpio_set_value_cansleep':
include/asm-generic/gpio.h:141: error: implicit declaration of function
'gpio_set_value'
In file included from drivers/mtd/nand/fsl_upm.c:21:
include/linux/of_gpio.h: At top level:
include/linux/of_gpio.h:26: error: field 'gc' has incomplete type
include/linux/of_gpio.h: In function 'to_of_gpio_chip':
include/linux/of_gpio.h:34: warning: type defaults to 'int' in declaration
of '__mptr'
include/linux/of_gpio.h:34: warning: initialization from incompatible
pointer type
drivers/mtd/nand/fsl_upm.c: In function 'fun_probe':
drivers/mtd/nand/fsl_upm.c:203: error: implicit declaration of function
'gpio_request'
drivers/mtd/nand/fsl_upm.c:208: error: implicit declaration of function
'gpio_direction_input'
drivers/mtd/nand/fsl_upm.c:242: error: implicit declaration of function
'gpio_free'
make[3]: *** [drivers/mtd/nand/fsl_upm.o] Error 1
make[2]: *** [drivers/mtd/nand] Error 2
make[1]: *** [drivers/mtd] Error 2
make: *** [drivers] Error 2

I am suspection that some gpio lib is missing. So any patch is there to this
problem??
Regards
Koteswar

--00504502cd68f450a1047ca17cb5
Content-Type: text/html; charset=ISO-8859-1

Hi<br>
I am using linux-2.6.26.8 kernel. In drivers/mtd/nand/Kconfig,
MTD_NAND_FSL_UPM depends on MTD_NAND &amp;&amp; OF_GPIO &amp;&amp;
(PPC_83xx || PPC_85xx). But I didnt find any way to select OF_GPIO
option in &quot;make menuconfig&quot;. So I removed it from Kconfig file and got
MTD_NAND_FSL_UPM in menuconfig. I selected it and did &quot;make uImage&quot;.
This is giving few errors:<br>
<br>
include/asm-generic/gpio.h: In function &#39;gpio_get_value_cansleep&#39;:<br>
include/asm-generic/gpio.h:135: error: implicit declaration of function &#39;gpio_get_value&#39;<br>
include/asm-generic/gpio.h: In function &#39;gpio_set_value_cansleep&#39;:<br>
include/asm-generic/gpio.h:141: error: implicit declaration of function &#39;gpio_set_value&#39;<br>
In file included from drivers/mtd/nand/fsl_upm.c:21:<br>
include/linux/of_gpio.h: At top level:<br>
include/linux/of_gpio.h:26: error: field &#39;gc&#39; has incomplete type<br>
include/linux/of_gpio.h: In function &#39;to_of_gpio_chip&#39;:<br>
include/linux/of_gpio.h:34: warning: type defaults to &#39;int&#39; in declaration of &#39;__mptr&#39;<br>
include/linux/of_gpio.h:34: warning: initialization from incompatible pointer type<br>
drivers/mtd/nand/fsl_upm.c: In function &#39;fun_probe&#39;:<br>
drivers/mtd/nand/fsl_upm.c:203: error: implicit declaration of function &#39;gpio_request&#39;<br>
drivers/mtd/nand/fsl_upm.c:208: error: implicit declaration of function &#39;gpio_direction_input&#39;<br>
drivers/mtd/nand/fsl_upm.c:242: error: implicit declaration of function &#39;gpio_free&#39;<br>
make[3]: *** [drivers/mtd/nand/fsl_upm.o] Error 1<br>
make[2]: *** [drivers/mtd/nand] Error 2<br>
make[1]: *** [drivers/mtd] Error 2<br>
make: *** [drivers] Error 2<br>
<br>
I am suspection that some gpio lib is missing. So any patch is there to this problem??<br>
Regards<br>
Koteswar<br>
<br>

--00504502cd68f450a1047ca17cb5--
