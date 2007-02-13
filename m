Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 3604BDDF47
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 05:52:01 +1100 (EST)
Message-ID: <45D208CB.9000407@freescale.com>
Date: Tue, 13 Feb 2007 12:51:55 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Check mac-address first in fsl_soc.c
References: <11710513671236-git-send-email-timur@freescale.com>
	<45CCDEFB.5050504@ru.mvista.com> <45CCDFBC.1090104@freescale.com>
	<45CCE07F.9040107@ru.mvista.com> <45D1F46C.4050901@freescale.com>
	<5B1BBAE9-00FC-454B-8855-7D362DF59850@kernel.crashing.org>
	<45D1F92B.3000000@freescale.com>
	<774F090A-27E6-4271-ABFE-FBFA7855D5AD@kernel.crashing.org>
In-Reply-To: <774F090A-27E6-4271-ABFE-FBFA7855D5AD@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

>> If you still want null_mac_addr[], you would need to do this:
>>
>>     static const u8 null_mac_addr[6] = { 0 };
> 
> Let's drop the static const part.

Ok.

Now all I need to do is fix this error, that has nothing to do with my changes:

arch/powerpc/sysdev/fsl_soc.c: In function 'gfar_of_init':
arch/powerpc/sysdev/fsl_soc.c:305: warning: ISO C90 forbids mixed declarations 
and code
arch/powerpc/sysdev/fsl_soc.c:308: error: invalid storage class for function 
'fsl_i2c_of_init'
arch/powerpc/sysdev/fsl_soc.c:361: error: initializer element is not constant
arch/powerpc/sysdev/fsl_soc.c:365: error: invalid storage class for function 
'mpc83xx_wdt_init'
arch/powerpc/sysdev/fsl_soc.c:423: error: initializer element is not constant
arch/powerpc/sysdev/fsl_soc.c:427: error: invalid storage class for function 
'determine_usb_phy'
arch/powerpc/sysdev/fsl_soc.c:443: error: invalid storage class for function 
'fsl_usb_of_init'
arch/powerpc/sysdev/fsl_soc.c:586: error: initializer element is not constant
arch/powerpc/sysdev/fsl_soc.c:586: error: syntax error at end of input
make[1]: *** [arch/powerpc/sysdev/fsl_soc.o] Error 1

Looks like someone broke arch_initcall() or something.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
