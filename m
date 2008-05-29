Return-Path: <temerkhanov@yandex.ru>
Received: from smtp7.yandex.ru (smtp7.yandex.ru [213.180.200.45])
	by ozlabs.org (Postfix) with ESMTP id E80FFDE124
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 17:10:04 +1000 (EST)
Received: from ppp91-78-89-159.pppoe.mtu-net.ru ([91.78.89.159]:16218 "EHLO
	[10.0.0.10]" smtp-auth: "temerkhanov" TLS-CIPHER: <none> TLS-PEER-CN1:
	<none>) by mail.yandex.ru with ESMTP id S738636AbYE2HD5 (ORCPT
	<rfc822;linuxppc-dev@ozlabs.org>); Thu, 29 May 2008 11:03:57 +0400
Message-ID: <483E555C.9050703@yandex.ru>
Date: Thu, 29 May 2008 11:03:56 +0400
From: Sergey Temerkhanov <temerkhanov@yandex.ru>
MIME-Version: 1.0
To: vencent2006 <vencent2006@163.com>
Subject: Re: May I ask some questions?
References: <12692943.1528961211977480208.JavaMail.coremail@bj163app110.163.com>
In-Reply-To: <12692943.1528961211977480208.JavaMail.coremail@bj163app110.163.com>
Content-Type: text/plain; charset=x-gbk; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

vencent2006 wrote:
> I am Michael from China.A few days ago, I was supposed to debug 
> executable.elf with xmd while some problems happened.It said like that:
> xmd% dow executable.elf
> Failed to download ELF file
> ERROR(1053):UNABLE TO READ ELF FILE.THE ELF FILE
> MAYBE CORRUPTED
> :executable.elf
You need to install updates for EDK. xmd 9.1 without updates is known to 
have broken ELF loader

> I wanna ask u to point out what causes this problem.
> There is another question about "xparameters.h" and
> "xparameters_ml300.h". When I have generated BSP, there are two 
> "xparameters.h" files in project which
> have the same name while different size(eg: one is 22k ,the other is 
> 4k). Which one is the proper?
> And when I add "xparameters.h" and "xparameters_ml300.h" to the 
> kernel, some compiling
> error occurs.
> eg:
> arch/ppc/syslib/virtex_devices.c:116: error: 
> 'XPAR_UARTNS550_0_CLOCK_FREQ_HZ' undeclared here (not in a function)
> arch/ppc/syslib/virtex_devices.c:119: error: 
> 'XPAR_UARTNS550_1_CLOCK_FREQ_HZ' undeclared here (not in a function)
> I don't understand where to define them and whether i need them or not.
> my eldk is:eldk/4.2/ppc-linux-x86
> using Xilinx EDK/ISE 9.1
> Linux 2.6.24
These macros must be defined in xparameters_ml300.h. You need them as 
they define base frequency for UARTNS550 and proper configuration of 
baud rates depends on it

>
> --
>
>
> ------------------------------------------------------------------------
> 眼睛干涩？润洁一下！清凉配方，多重营养，缓解眼疲劳 
> <http://popme.163.com/link/004304_0515_8953.html>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
