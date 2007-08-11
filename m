Return-Path: <blackfin.kang@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by ozlabs.org (Postfix) with ESMTP id 92423DDEFF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Aug 2007 12:09:44 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so956687fkz
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 19:09:42 -0700 (PDT)
Message-ID: <a7f827420708101909r20f0abe6m5af0c180702d109b@mail.gmail.com>
Date: Sat, 11 Aug 2007 10:09:42 +0800
From: Michael.Kang <blackfin.kang@gmail.com>
To: "mike zheng" <mail4mz@gmail.com>
Subject: Re: 2.6 system stuck with one line change in platform_init()
In-Reply-To: <5c9cd53b0708101901n62e732a4m8fba21b592f5dc95@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5c9cd53b0708101901n62e732a4m8fba21b592f5dc95@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/11/07, mike zheng <mail4mz@gmail.com> wrote:
> Hi All,
>
> In order to debug the 8548 CDS BSP of kernel 2.6, I want setup serial port
> with UART on mpc85xx as early as possible. . I add the register access code
> at the beginning of  platform_init(). However the system just hanging there
> with this line. If I comment out this
> line"WRITE8_ADDR(M85xx_EIIADDR,0)", then linux kernel runs
> well.
>
> Thanks in advance,
>
> Mike Z
>
> Here is the code of my mpc85xx_cds_common.c:
>
> #define WRITE8_ADDR(address, value) \
>     ((*((volatile u8 *)(address))) = (u8)(value))
>
> #define M85xx_EII_ADDR 0xe0004500
>
> void __init
> platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
>                    unsigned long r6, unsigned long r7)
> {
>        /* parse_bootinfo must always be called first */
>        parse_bootinfo(find_bootinfo());
>
>       /* Now we try to access register of UART */
>       WRITE8_ADDR(M85xx_EII_ADDR, 0);
         where is M85xx_EII_ADDR declearation? If the address need to
be io_remap first?
> ....
> }
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
www.skyeye.org
