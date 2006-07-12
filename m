Return-Path: <ammubhai@gmail.com>
Received: from mailgw.cs.york.ac.uk (mailgw.cs.york.ac.uk [144.32.40.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A810679FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jul 2006 04:24:38 +1000 (EST)
Message-ID: <44B53DD0.5020006@gmail.com>
Date: Wed, 12 Jul 2006 19:22:08 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: some problems on the SystemACE driver.
References: <BAY110-F290517A86325ADABA1B020B2690@phx.gbl>
In-Reply-To: <BAY110-F290517A86325ADABA1B020B2690@phx.gbl>
Content-Type: text/plain; charset=GB2312
Cc: akonovalov@ru.mvista.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ming,
   Thanks for testing the driver patch! The errors you get when
compiling both - SysAce and TEMAC are reasonable. My ignorance or call
it me being lazy. I recollect now... I was also working on the Xilinx
Ethernet driver and forgot to cleanup that code before creating the
patch for the SysAce driver. Thus, it so happens that code for the
ethernet driver in my patch also gets compiled along with the TEMAC. I
have deleted the unnecessary code files and updated the patch (name
changed). Find the new one here:
https://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17.1-sysace-1.1.patch

Let me know if it works for you now?

-Ameet

Ming Liu wrote:
> Dear Ameet (and Andrei),
> I have tested the new patch for SystemACE driver. With respect to the 
> single SystemACE driver, it works well. I can boot my linux in ML403 
> board. (I tried both 2.6.16-rc5 and 2.6.17.1 versions) So first 
> congratulations and thanks for your hard work!
> 
> However, when I tried to implemented Temac (with and without SystemACE. 
> TWO conditions.), some errors happened. Here is the compilation 
> information:
> 
>  CC      init/do_mounts.o
>  LD      init/mounts.o
>  CC      init/initramfs.o
>  LD      init/built-in.o
>  LD      .tmp_vmlinux1
> drivers/built-in.o(.sdata+0x2c): multiple definition of `XWaitInAssert'
> arch/ppc/platforms/4xx/built-in.o(.sdata+0x0): first defined here
> drivers/built-in.o(.text+0x3e480): In function `XPacketFifoV200a_WriteDre':
> : multiple definition of `XPacketFifoV200a_WriteDre'
> arch/ppc/platforms/4xx/built-in.o(.text+0x1b14): first defined here
> drivers/built-in.o(.text+0x3e158): In function `XPacketFifoV200a_SelfTest':
> : multiple definition of `XPacketFifoV200a_SelfTest'
> arch/ppc/platforms/4xx/built-in.o(.text+0x17ec): first defined here
> drivers/built-in.o(.sbss+0x18c): multiple definition of `XAssertStatus'
> arch/ppc/platforms/4xx/built-in.o(.sbss+0x8): first defined here
> drivers/built-in.o(.text+0x3e798): In function `XPacketFifoV200a_L0Write':
> : multiple definition of `XPacketFifoV200a_L0Write'
> arch/ppc/platforms/4xx/built-in.o(.text+0x1e2c): first defined here
> drivers/built-in.o(.text+0x3e280): In function `XPacketFifoV200a_Read':
> : multiple definition of `XPacketFifoV200a_Read'
> arch/ppc/platforms/4xx/built-in.o(.text+0x1914): first defined here
> drivers/built-in.o(.text+0x3e55c): In function `XPacketFifoV200a_L0Read':
> : multiple definition of `XPacketFifoV200a_L0Read'
> arch/ppc/platforms/4xx/built-in.o(.text+0x1bf0): first defined here
> drivers/built-in.o(.text+0x3e380): In function `XPacketFifoV200a_Write':
> : multiple definition of `XPacketFifoV200a_Write'
> arch/ppc/platforms/4xx/built-in.o(.text+0x1a14): first defined here
> drivers/built-in.o(.text+0x3e0cc): In function `XAssertSetCallback':
> : multiple definition of `XAssertSetCallback'
> arch/ppc/platforms/4xx/built-in.o(.text+0x44): first defined here
> drivers/built-in.o(.text+0x3e9fc): In function 
> `XPacketFifoV200a_L0WriteDre':
> : multiple definition of `XPacketFifoV200a_L0WriteDre'
> arch/ppc/platforms/4xx/built-in.o(.text+0x2090): first defined here
> drivers/built-in.o(.text+0x3e0dc): In function 
> `XPacketFifoV200a_Initialize':
> : multiple definition of `XPacketFifoV200a_Initialize'
> arch/ppc/platforms/4xx/built-in.o(.text+0x1770): first defined here
> drivers/built-in.o(.text+0x3e088): In function `XAssert':
> : multiple definition of `XAssert'
> arch/ppc/platforms/4xx/built-in.o(.text+0x0): first defined here
> drivers/built-in.o(.text+0x3e0d8): In function `XNullHandler':
> : multiple definition of `XNullHandler'
> arch/ppc/platforms/4xx/built-in.o(.text+0x50): first defined here
> make: *** [.tmp_vmlinux1] Error 1
> 
> It looks like that your patch affect some symbols which are used by 
> Temac. (When I use the old patch for SystemACE, there is no problem like 
> this if I only choose Temac. ) So let's find out the problem together. 
> Also, I don't know if this is a problem from SystemACE or Temac , I 
> would like to invite Andrei to look at this altogether. If any 
> suggestion, please feel free to announce. Thanks for both your help.
> Regards
> Ming
> 
> 
> 
>> From: Ameet Patil <ammubhai@gmail.com>
>> To: Ming Liu <eemingliu@hotmail.com>
>> CC: linuxppc-embedded@ozlabs.org
>> Subject: Re: some problems on the SystemACE driver.
>> Date: Wed, 12 Jul 2006 10:54:13 +0100
>>
>> Hi Ming,
>>
>> > I heard that you have tested this driver. Have you got this problem?
>> > Why there are so many strange problems for me while you have tested
>> > without problem?
>>
>> Yes, that is right! When I say... I have tested - "it really means I
>> have tested". So what's the problem? It works for me but not you? The
>> obvious difference: mine is a ML300 configuration and yours ML403.
>>
>> There were some files which unknowing were made dependant on ML300
>> target. I have now made them compile for both targets. It should work
>> fine for you now (Hopefully!). Download the updated patch from the same
>> location.
>>
>> http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17_sysace.patch 
>>
> 
>>
>> Since I don't have ML403 board, theres no way I can test this patch on
>> it. I rely on you in doing this... and thanks for letting me know the
>> issues.
>>
>> WARNING: There might be more issues. :-)
>>
>> Please DONOT hesitate to raise any issues with the driver. I am more
>> than happy to fix them.
>>
>> -Ameet
>>
>> Ming Liu wrote:
>> > Dear Ameet,
>> > Sorry to bother you again but I am totally confused on the systemACE
>> > driver. First let me show you the problem.
>> >
>> > 1. I downloaded the linux kernel of 2.6.17.1, also the patch for
>> > SystemACE driver. Applied the patch to the kernel. Replaced the
>> > xparameters_ml403.h with the generated file xparameters_ml300.h from
>> > Xilinx EDK. Make menuconfig, make dep and make zImage. Then the error
>> > shows like this:
>> >
>> > drivers/block/xilinx_sysace/xsysace.c:120:6: warning:
>> > "XPAR_XSYSACE_MEM_WIDTH" is not defined
>> > drivers/block/xilinx_sysace/xsysace.c: In function 
> `XSysAce_LookupConfig':
>> > drivers/block/xilinx_sysace/xsysace.c:366: error:
>> > `XPAR_XSYSACE_NUM_INSTANCES' undeclared (first use in this function)
>> > drivers/block/xilinx_sysace/xsysace.c:366: error: (Each undeclared
>> > identifier is reported only once
>> > drivers/block/xilinx_sysace/xsysace.c:366: error: for each function it
>> > appears in.)
>> > make[3]: *** [drivers/block/xilinx_sysace/xsysace.o] Error 1
>> > make[2]: *** [drivers/block/xilinx_sysace] Error 2
>> > make[1]: *** [drivers/block] Error 2
>> > make: *** [drivers] Error 2
>> >
>> > I think this is because of the no inclusion of the xparameters header
>> > file. So I change #include "xparameters.h" into  #include "
>> > 
> /home/mingliu/linux-2.6.17.1/arch/ppc/platforms/4xx/xparameters/xparameters.h" 
> 
> 
>> > in the files of xsysace.c and xsysace_g.c, using the full address to
>> > specify the header file. In fact, this is not a serious problem and it
>> > often happens. But, after the modification, another problem happened:
>> >  GEN     .version
>> >  CHK     include/linux/compile.h
>> >  UPD     include/linux/compile.h
>> >  CC      init/version.o
>> >  LD      init/built-in.o
>> >  LD      .tmp_vmlinux1
>> > drivers/built-in.o(.text+0x2234a): In function `XSysAce_GetCfgAddr':
>> > : undefined reference to `XAssertStatus'
>> > drivers/built-in.o(.text+0x2235e): In function `XSysAce_GetCfgAddr':
>> > : undefined reference to `XAssertStatus'
>> > drivers/built-in.o(.text+0x22364): In function `XSysAce_GetCfgAddr':
>> > : undefined reference to `XAssert'
>> > drivers/built-in.o(.text+0x22372): In function `XSysAce_GetCfgAddr':
>> > : undefined reference to `XAssertStatus'
>> > drivers/built-in.o(.text+0x2237a): In function `XSysAce_GetCfgAddr':
>> > : undefined reference to `XAssertStatus'
>> > drivers/built-in.o(.text+0x22394): In function `XSysAce_GetCfgAddr':
>> > : undefined reference to `XAssert'
>> > drivers/built-in.o(.text+0x223a2): In function `XSysAce_GetCfgAddr':
>> > : undefined reference to `XAssertStatus'
>> > drivers/built-in.o(.text+0x223aa): In function `XSysAce_GetCfgAddr':
>> > : undefined reference to `XAssertStatus'
>> > drivers/built-in.o(.text+0x22cd6): In function `XSysAce_Initialize':
>> > : undefined reference to `XAssertStatus'
>> > drivers/built-in.o(.text+0x22cdc): In function `XSysAce_Initialize':
>> > : undefined reference to `XAssert'
>> > drivers/built-in.o(.text+0x22cea): In function `XSysAce_Initialize':
>> > : undefined reference to `XAssertStatus'
>> >
>> > ......( a long information to say that undefined reference to the
>> > XAssert things.)
>> >
>> > Also, I tried this in the kernel 2.6.16-rc5. (In fact I prefer this
>> > version because the temac driver is for this version. ) The same 
> problem
>> > happened. I checked the source code. The problem happened in the file
>> > driver/block/xilinx_sysace/adapter.c, etc. Also, the XAssert things are
>> > defined in the file arch/ppc/platforms/4xx/xilinx_ocp/xbasic_types.c.
>> > (In 2.6.16 kernel, it is also defined in
>> > driver/xilinx_edk/xbasic_types.c. There are two copies of this file. ) 
> I
>> > think the problem is, the systemACE files cannot link together with the
>> > xbasic_types.c file.
>> > I heard that you have tested this driver. Have you got this problem? 
> Why
>> > there are so many strange problems for me while you have tested without
>> > problem? Without the CF card, I cannot try the Temac driver and my work
>> > is totally blocked. So I have to ask for your suggestion. Really 
> anxious
>> > for your useful guidance. Thanks a lot!!!!!!
>> >
>> > Regards
>> > Ming
>> >
>> > _________________________________________________________________
>> > 与联机的朋友进行交流，请使用 MSN Messenger:  
> http://messenger.msn.com/cn
>> >
> 
> _________________________________________________________________
> 免费下载 MSN Explorer:   http://explorer.msn.com/lccn/ 
> 
