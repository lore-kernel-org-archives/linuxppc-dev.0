Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA02.westchester.pa.mail.comcast.net
	(qmta02.westchester.pa.mail.comcast.net [76.96.62.24])
	by ozlabs.org (Postfix) with ESMTP id D65C0DDE09
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 13:00:43 +1000 (EST)
Message-ID: <4855D75E.1050904@gmail.com>
Date: Sun, 15 Jun 2008 23:00:46 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Peter Czanik <pczanik@fang.fa.gau.hu>
Subject: Re: Default flats for running dtc from kernel build
References: <20080606143347.B35CC247FE@gemini.denx.de>	<A005B9E2-9A1D-4190-AB00-A7C880E4DBDB@kernel.crashing.org>
	<484CFB11.1080400@fang.fa.gau.hu>
In-Reply-To: <484CFB11.1080400@fang.fa.gau.hu>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Peter Czanik wrote:
> Hello,
> 
> Kumar Gala írta:
>> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
>> index c40fb82..52db85a 100644
>> --- a/arch/powerpc/boot/Makefile
>> +++ b/arch/powerpc/boot/Makefile
>> @@ -29,6 +29,8 @@ ifdef CONFIG_DEBUG_INFO
>>  BOOTCFLAGS     += -g
>>  endif
>>
>> +DTS_FLAGS      ?= -R4 -S 0x3000
>> +
>>  ifeq ($(call cc-option-yn, -fstack-protector),y)
>>  BOOTCFLAGS     += -fno-stack-protector
>>  endif
> I have a 8610 standing next to my desk with U-Boot 1.3.0 (Mar 13 2008 - 
> 10:14:26). It came with 2.6.23. I wanted to compile a kernel from the 
> latest available kernel sources ( 2.6.26-RC5-git2 ). I compiled it using 
> mpc8610_hpcd_defconfig. I also did a make mpc8610_hpcd.dtb to have a 
> matching dtb file for the kernel. This is how far it gets:
> 
> => boot
> 
> 11032 bytes read
> 
> 1708346 bytes read
> ## Booting image at 01000000 ...
>  Image Name:   Linux-2.6.26-rc5-git2-czp7
>  Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>  Data Size:    1708282 Bytes =  1.6 MB
>  Load Address: 00000000
>  Entry Point:  00000000
>  Verifying Checksum ... OK
>  Uncompressing Kernel Image ... OK
>  Booting using the fdt at 0xc00000
>  Loading Device Tree to 007fb000, end 007fdb17 ... OK
> 
> When I use the 2.6.26 kernel, but the original dtb file from the BSP, 
> then I get two more lines on the serial console:
> 
> pci@8000 first_busno=0 last_busno=0
> pcie@9000 first_busno=0 last_busno=0
> 
> So I suspected, that this might be something with the dtb file. This is 
> when I ran into this thread. I tried all the different options for 
> DTS_FLAGS to generate a working dtb file, but I got the same result, 
> "Loading Device Tree to 007fb000, end 007fdb17 ... OK" was the last line 
> on screen. Any additional ideas, how to create a working dtb file for 
> the 8610 board for later kernels?
> 
> Bye,
> CzP

Hi Peter,

Does your .dts (dtb source) have an /aliases node with properties 
pointing to the proper serial port(s) (and enthernet port(s))? 
Somewhere around the timeframe of your current u-boot/linux versions, 
the /aliases node was added to tell the kernel which serial was ttyS0, 
ttyS1, etc. in an independent way.

I would strongly recommend a new u-boot too.  The merge window for 1.3.4 
just closed, it should work well for you.  If not, fix patches are 
welcome on the u-boot list.  ;-)

HTH,
gvb
