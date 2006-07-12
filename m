Return-Path: <ammubhai@gmail.com>
Received: from mailgw.cs.york.ac.uk (mailgw.cs.york.ac.uk [144.32.40.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3958867B6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 19:59:23 +1000 (EST)
Message-ID: <44B4C6C5.1040007@gmail.com>
Date: Wed, 12 Jul 2006 10:54:13 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: some problems on the SystemACE driver.
References: <BAY110-F784991A71896469EE9541B2680@phx.gbl>
In-Reply-To: <BAY110-F784991A71896469EE9541B2680@phx.gbl>
Content-Type: text/plain; charset=GB2312
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

Hi Ming,

> I heard that you have tested this driver. Have you got this problem?
> Why there are so many strange problems for me while you have tested
> without problem?

Yes, that is right! When I say... I have tested - "it really means I
have tested". So what's the problem? It works for me but not you? The
obvious difference: mine is a ML300 configuration and yours ML403.

There were some files which unknowing were made dependant on ML300
target. I have now made them compile for both targets. It should work
fine for you now (Hopefully!). Download the updated patch from the same
location.

http://www.cs.york.ac.uk/rtslab/demos/amos/xupv2pro/patches/linuxppc-2.6.17_sysace.patch

Since I don't have ML403 board, theres no way I can test this patch on
it. I rely on you in doing this... and thanks for letting me know the
issues.

WARNING: There might be more issues. :-)

Please DONOT hesitate to raise any issues with the driver. I am more
than happy to fix them.

-Ameet

Ming Liu wrote:
> Dear Ameet,
> Sorry to bother you again but I am totally confused on the systemACE 
> driver. First let me show you the problem.
> 
> 1. I downloaded the linux kernel of 2.6.17.1, also the patch for 
> SystemACE driver. Applied the patch to the kernel. Replaced the 
> xparameters_ml403.h with the generated file xparameters_ml300.h from 
> Xilinx EDK. Make menuconfig, make dep and make zImage. Then the error 
> shows like this:
> 
> drivers/block/xilinx_sysace/xsysace.c:120:6: warning: 
> "XPAR_XSYSACE_MEM_WIDTH" is not defined
> drivers/block/xilinx_sysace/xsysace.c: In function `XSysAce_LookupConfig':
> drivers/block/xilinx_sysace/xsysace.c:366: error: 
> `XPAR_XSYSACE_NUM_INSTANCES' undeclared (first use in this function)
> drivers/block/xilinx_sysace/xsysace.c:366: error: (Each undeclared 
> identifier is reported only once
> drivers/block/xilinx_sysace/xsysace.c:366: error: for each function it 
> appears in.)
> make[3]: *** [drivers/block/xilinx_sysace/xsysace.o] Error 1
> make[2]: *** [drivers/block/xilinx_sysace] Error 2
> make[1]: *** [drivers/block] Error 2
> make: *** [drivers] Error 2
> 
> I think this is because of the no inclusion of the xparameters header 
> file. So I change #include "xparameters.h" into  #include " 
> /home/mingliu/linux-2.6.17.1/arch/ppc/platforms/4xx/xparameters/xparameters.h" 
> in the files of xsysace.c and xsysace_g.c, using the full address to 
> specify the header file. In fact, this is not a serious problem and it 
> often happens. But, after the modification, another problem happened:
>  GEN     .version
>  CHK     include/linux/compile.h
>  UPD     include/linux/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>  LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x2234a): In function `XSysAce_GetCfgAddr':
> : undefined reference to `XAssertStatus'
> drivers/built-in.o(.text+0x2235e): In function `XSysAce_GetCfgAddr':
> : undefined reference to `XAssertStatus'
> drivers/built-in.o(.text+0x22364): In function `XSysAce_GetCfgAddr':
> : undefined reference to `XAssert'
> drivers/built-in.o(.text+0x22372): In function `XSysAce_GetCfgAddr':
> : undefined reference to `XAssertStatus'
> drivers/built-in.o(.text+0x2237a): In function `XSysAce_GetCfgAddr':
> : undefined reference to `XAssertStatus'
> drivers/built-in.o(.text+0x22394): In function `XSysAce_GetCfgAddr':
> : undefined reference to `XAssert'
> drivers/built-in.o(.text+0x223a2): In function `XSysAce_GetCfgAddr':
> : undefined reference to `XAssertStatus'
> drivers/built-in.o(.text+0x223aa): In function `XSysAce_GetCfgAddr':
> : undefined reference to `XAssertStatus'
> drivers/built-in.o(.text+0x22cd6): In function `XSysAce_Initialize':
> : undefined reference to `XAssertStatus'
> drivers/built-in.o(.text+0x22cdc): In function `XSysAce_Initialize':
> : undefined reference to `XAssert'
> drivers/built-in.o(.text+0x22cea): In function `XSysAce_Initialize':
> : undefined reference to `XAssertStatus'
> 
> ......( a long information to say that undefined reference to the 
> XAssert things.)
> 
> Also, I tried this in the kernel 2.6.16-rc5. (In fact I prefer this 
> version because the temac driver is for this version. ) The same problem 
> happened. I checked the source code. The problem happened in the file 
> driver/block/xilinx_sysace/adapter.c, etc. Also, the XAssert things are 
> defined in the file arch/ppc/platforms/4xx/xilinx_ocp/xbasic_types.c. 
> (In 2.6.16 kernel, it is also defined in 
> driver/xilinx_edk/xbasic_types.c. There are two copies of this file. ) I 
> think the problem is, the systemACE files cannot link together with the 
> xbasic_types.c file.
> I heard that you have tested this driver. Have you got this problem? Why 
> there are so many strange problems for me while you have tested without 
> problem? Without the CF card, I cannot try the Temac driver and my work 
> is totally blocked. So I have to ask for your suggestion. Really anxious 
> for your useful guidance. Thanks a lot!!!!!!
> 
> Regards
> Ming
> 
> _________________________________________________________________
> 与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn 
> 
