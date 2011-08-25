Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F912B6F8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 05:24:26 +1000 (EST)
Message-ID: <4E56A15D.8070406@freescale.com>
Date: Thu, 25 Aug 2011 14:24:13 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnaud Lacombe <lacombar@gmail.com>
Subject: Re: [PATCH] xics/icp_natives: add __init to marker icp_native_init()
References: <1314288433-26322-1-git-send-email-lacombar@gmail.com>
In-Reply-To: <1314288433-26322-1-git-send-email-lacombar@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnaud Lacombe wrote:
> This should fix the following warning:
> 
>  LD      arch/powerpc/sysdev/xics/built-in.o
> WARNING: arch/powerpc/sysdev/xics/built-in.o(.text+0x1310): Section mismatch in
> reference from the function .icp_native_init() to the function
> .init.text:.icp_native_init_one_node()
> The function .icp_native_init() references
> the function __init .icp_native_init_one_node().
> This is often because .icp_native_init lacks a __init
> annotation or the annotation of .icp_native_init_one_node is wrong.
> 
> icp_native_init() is only referenced in `arch/powerpc/sysdev/xics/xics-common.c'
> by xics_init() which is itself marked with __init.
> 
> = not built-tested =
> 
> Reported-by: Timur Tabi <timur@freescale.com>
> Signed-off-by: Arnaud Lacombe <lacombar@gmail.com>

Acked-by: Timur Tabi <timur@freescale.com>

This warning still appears, though:

WARNING: arch/powerpc/sysdev/built-in.o(.text+0xf6b8): Section mismatch in
reference from the function .ics_rtas_init() to the function
.init.text:.xics_register_ics()
The function .ics_rtas_init() references
the function __init .xics_register_ics().
This is often because .ics_rtas_init lacks a __init
annotation or the annotation of .xics_register_ics is wrong.

To fix this warning, you'll also need:

diff --git a/arch/powerpc/sysdev/xics/ics-rtas.c b/arch/powerpc/sysdev/xics/ics-
index c782f85..a125721 100644
--- a/arch/powerpc/sysdev/xics/ics-rtas.c
+++ b/arch/powerpc/sysdev/xics/ics-rtas.c
@@ -213,7 +213,7 @@ static int ics_rtas_host_match(struct ics *ics, struct devic
        return !of_device_is_compatible(node, "chrp,iic");
 }

-int ics_rtas_init(void)
+int __init ics_rtas_init(void)
 {
        ibm_get_xive = rtas_token("ibm,get-xive");
        ibm_set_xive = rtas_token("ibm,set-xive");


However, now we get another similar warning:

WARNING: drivers/built-in.o(.text+0x259c484): Section mismatch in reference from
the function .tc3589x_keypad_open() to the function
.devinit.text:.tc3589x_keypad_init_key_hardware()
The function .tc3589x_keypad_open() references
the function __devinit .tc3589x_keypad_init_key_hardware().
This is often because .tc3589x_keypad_open lacks a __devinit
annotation or the annotation of .tc3589x_keypad_init_key_hardware is wrong.

I'm not sure what to do at this point, because I have a suspicion that adding
__devinit to tc3589x_keypad_open() is wrong.

-- 
Timur Tabi
Linux kernel developer at Freescale
