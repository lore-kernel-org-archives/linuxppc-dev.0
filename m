Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 43644DDD07
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 23:10:45 +1000 (EST)
Message-ID: <4656E1B9.9090308@ru.mvista.com>
Date: Fri, 25 May 2007 17:16:41 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Miroslaw Dach <miroslaw.dach@psi.ch>
Subject: Re: zImage.elf loads but does not start
References: <Pine.LNX.4.44.0705152027280.16487-100000@slslc02.psi.ch>
In-Reply-To: <Pine.LNX.4.44.0705152027280.16487-100000@slslc02.psi.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Mirek,

Miroslaw Dach wrote:
> I do not know however if the stack is properly configured since I did not 
> see any parameter in kernel which refers to the stack or heap. 
> 
> My bsp i.e xparameteres_ml403.h contains two macros:
> #define XPAR_DDR_SDRAM_1_MEM0_BASEADDR 0x00000000
> #define XPAR_DDR_SDRAM_1_MEM0_HIGHADDR 0x01FFFFFF
> 
> I have the feeling that they are ignored because I did not find anywhere 
> in the kernel source those names. 
> 
> When kernel boots it prints at the beginning:
> loaded at:     00400000 004F9138 
> board data at: 004F7120 004F7138 
> relocated to:  00404064 0040407C 
> zimage at:     00404DF1 004F6BBB 
> avail ram:     004FA000 04000000 

Have you fixed this?

For 32 MBytes of DRAM you should have
   #define XPAR_DDR_0_SIZE                 0x2000000
in your xparameters_ml403.h file.
I can't recall the whole story, but EDK 8.2 doesn't
add this #define when generating the xparameters file,
so I had to add this line by hand for EDK 8.2 generated
files. Probably earlier EDK versions did that automatically.

But your kernel (the bootwrapper to be precise) wouldn't compile
if XPAR_DDR_0_SIZE were not defined...
Do you use uboot?

Thanks,
Andrei
