Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-104.bluehost.com (outbound-mail-104.bluehost.com
	[69.89.22.14]) by ozlabs.org (Postfix) with SMTP id 6D66DDDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 May 2008 16:47:16 +1000 (EST)
Message-ID: <483E4FD7.3050401@dlasys.net>
Date: Thu, 29 May 2008 02:40:23 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: rodolfo <rodolfo@lesc.ufc.br>
Subject: Re: Cross toolchain for ppc405 (virtex-4)
References: <20080528193344.065CF7A8089@mail218-va3.bigfish.com>
	<635aaa73efeab32f524e372289dc2a9f@lesc.ufc.br>
In-Reply-To: <635aaa73efeab32f524e372289dc2a9f@lesc.ufc.br>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org, John Linn <John.Linn@xilinx.com>,
	Mirek23 <miroslaw.dach@psi.ch>
Reply-To: dhlii@dlasys.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am not sure if this answers your question but to build a 2.6 Linux
kernel using the buildroot uclibc ppc cross compiler you would issue the
following make command

make ARCH=ppc CROSS_COMPILE=powerpc-linux-uclibc-

If you were using the crosstools compiler rather than buildroot, the
CROSS_COMPILE value would change.
For older version of GCC it might require a full path to the crosscompiler.

If you are building a BSP in the powerpc tree use ARCH=powerpc

I am fairly certain that when you are building a Linux kernel it is
irrelevant whether you use a glibc or uclibc or ... compiler.
The kernel is not going to link against any standard C library, those
library functions the kernel uses must be coded in the kernel.

However, when you are cross compiling applications for your target it is
a good idea to stick to the same standard C library and associated cross
compiler.

rodolfo wrote:
> I'm sorry.
>
> I want build kernel linux 2.6 for ml403. 
> Did I have to change the predefined compiler flags for ppc_4xx? The default
> value is -mcpu=403.
>
> On Wed, 28 May 2008 13:32:51 -0600, "John Linn" <John.Linn@xilinx.com>
> wrote:
>   
>> I don't know, I'm not familiar with what you are doing and it's not clear
>> from the message.
>>  
>> -- John
>>     
-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
