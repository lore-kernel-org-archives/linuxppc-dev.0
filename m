Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E60F0DDEB9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 May 2007 01:24:01 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Hrbe1-0000Ej-6a
	for linuxppc-embedded@ozlabs.org; Fri, 25 May 2007 08:23:57 -0700
Message-ID: <10805157.post@talk.nabble.com>
Date: Fri, 25 May 2007 08:23:57 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: zImage.elf loads but does not start
In-Reply-To: <4656E1B9.9090308@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10079346.post@talk.nabble.com> <10142161.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C0159BAAE@ehost011-3.exch011.intermedia.net>
	<10165159.post@talk.nabble.com> <10323147.post@talk.nabble.com>
	<463B5422.6030105@ru.mvista.com> <10372619.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C017019FD@ehost011-3.exch011.intermedia.net>
	<4640F08E.5040608@nec.com.au>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C06A207@MERCURY.inside.istor.com>
	<10409434.post@talk.nabble.com>
	<D1AFFAE2CC4BD54CA4C1543CFF4A4FCC2F391B@exchangemb3.bnl.gov>
	<10429898.post@talk.nabble.com> <10621564.post@talk.nabble.com>
	<4649A7AC.1050503@ru.mvista.com>
	<Pine.LNX.4.44.0705151430120.7758-100000@slslc02.psi.ch>
	<4649F6FF.7060003@ru.mvista.com>
	<Pine.LNX.4.44.0705152027280.16487-100000@slslc02.psi.ch>
	<4656E1B9.9090308@ru.mvista.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Andrei,

     Thank you very much for your suggestion. 
I am very grateful for all of your hints. They were always very valuable to
me.

I have set as you mentioned:
#define XPAR_DDR_0_SIZE                 0x2000000

And now all works fine!!!!

The root file system is mounted and I can execute whatever I like from the
rootfile system.
It was just my mistake that I did not noticed the memory size was wrong :(

After all of that I would like to use the GPIO driver to talk to the FPGA
part of the board.
Do you have some experience with that. 

in my xparameters_ml403.h I have two devices defined: LEDs and SWITCHES as
listed below

/* Definitions for peripheral LEDS_8BIT */
#define XPAR_LEDS_8BIT_BASEADDR 0x40000000
#define XPAR_LEDS_8BIT_HIGHADDR 0x4000FFFF
#define XPAR_LEDS_8BIT_DEVICE_ID 0
#define XPAR_LEDS_8BIT_INTERRUPT_PRESENT 0
#define XPAR_LEDS_8BIT_IS_DUAL 0


/* Definitions for peripheral DIP_SWITCHES_8BIT */
#define XPAR_DIP_SWITCHES_8BIT_BASEADDR 0x40020000
#define XPAR_DIP_SWITCHES_8BIT_HIGHADDR 0x4002FFFF
#define XPAR_DIP_SWITCHES_8BIT_DEVICE_ID 1
#define XPAR_DIP_SWITCHES_8BIT_INTERRUPT_PRESENT 0
#define XPAR_DIP_SWITCHES_8BIT_IS_DUAL 0

#define XPAR_GPIO_0_BASEADDR XPAR_LEDS_8BIT_BASEADDR
#define XPAR_GPIO_0_HIGHADDR XPAR_LEDS_8BIT_HIGHADDR
#define XPAR_GPIO_0_IS_DUAL XPAR_LEDS_8BIT_IS_DUAL
#define XPAR_GPIO_0_DEVICE_ID XPAR_LEDS_8BIT_DEVICE_ID
#define XPAR_GPIO_1_BASEADDR XPAR_DIP_SWITCHES_8BIT_BASEADDR
#define XPAR_GPIO_1_HIGHADDR XPAR_DIP_SWITCHES_8BIT_HIGHADDR
#define XPAR_GPIO_1_IS_DUAL XPAR_DIP_SWITCHES_8BIT_IS_DUAL
#define XPAR_GPIO_1_DEVICE_ID XPAR_DIP_SWITCHES_8BIT_DEVICE_ID

but I do not know how exactly to talk to them by means of the xgpio driver.



Best Regards and many many thanks for your support

Mirek




Andrei Konovalov wrote:
> 
> Mirek,
> 
> Miroslaw Dach wrote:
>> I do not know however if the stack is properly configured since I did not 
>> see any parameter in kernel which refers to the stack or heap. 
>> 
>> My bsp i.e xparameteres_ml403.h contains two macros:
>> #define XPAR_DDR_SDRAM_1_MEM0_BASEADDR 0x00000000
>> #define XPAR_DDR_SDRAM_1_MEM0_HIGHADDR 0x01FFFFFF
>> 
>> I have the feeling that they are ignored because I did not find anywhere 
>> in the kernel source those names. 
>> 
>> When kernel boots it prints at the beginning:
>> loaded at:     00400000 004F9138 
>> board data at: 004F7120 004F7138 
>> relocated to:  00404064 0040407C 
>> zimage at:     00404DF1 004F6BBB 
>> avail ram:     004FA000 04000000 
> 
> Have you fixed this?
> 
> For 32 MBytes of DRAM you should have
>    #define XPAR_DDR_0_SIZE                 0x2000000
> in your xparameters_ml403.h file.
> I can't recall the whole story, but EDK 8.2 doesn't
> add this #define when generating the xparameters file,
> so I had to add this line by hand for EDK 8.2 generated
> files. Probably earlier EDK versions did that automatically.
> 
> But your kernel (the bootwrapper to be precise) wouldn't compile
> if XPAR_DDR_0_SIZE were not defined...
> Do you use uboot?
> 
> Thanks,
> Andrei
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10805157
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
