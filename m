Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2ABC0DDEE2
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 23:32:28 +1000 (EST)
Message-Id: <E55D097A-13D0-45BF-9AE8-E9741A0A869D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: jwboyer@linux.vnet.ibm.com
In-Reply-To: <1209730435.2946.160.camel@vader.jdub.homelinux.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
Date: Fri, 2 May 2008 08:32:12 -0500
References: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
	<1209730435.2946.160.camel@vader.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2008, at 7:13 AM, Josh Boyer wrote:

> On Fri, 2008-05-02 at 03:11 -0500, Kumar Gala wrote:
>> GCC 4.4.x looks to be adding support for generating out-of-line  
>> register
>> saves/restores based on:
>>
>> http://gcc.gnu.org/ml/gcc-patches/2008-04/msg01678.html
>>
>> This breaks the bootwrapper as we'd need to link with libgcc to get  
>> the
>> implementation of the register save/restores.
>
> We don't link with libgcc anywhere in the kernel.  Is this going to  
> have
> similar impacts for building the vmlinux itself?

Not by default.  The issue only shows up with -Os.  Not sure if we can  
build the kernel that way.

> What are they actually error messages you see with that version of  
> GCC,
> out of curiosity?


   CC      fs/qnx4/qnx4.mod.o
arch/powerpc/boot/cuboot-85xx.o: In function `setprop':
/home/galak/git/linux-2.6/arch/powerpc/boot/ops.h:114: undefined  
reference to `_restgpr_30_x'
arch/powerpc/boot/cuboot-85xx.o: In function `platform_init':
/home/galak/git/linux-2.6/arch/powerpc/boot/cuboot-85xx.c:60:  
undefined reference to `_restgpr_25_x'
arch/powerpc/boot/cuboot-85xx.o: In function `find_node_by_devtype':
/home/galak/git/linux-2.6/arch/powerpc/boot/ops.h:163: undefined  
reference to `_restgpr_29_x'
arch/powerpc/boot/cuboot-85xx.o: In function `platform_fixups':
/home/galak/git/linux-2.6/arch/powerpc/boot/cuboot-85xx.c:51:  
undefined reference to `_restgpr_25_x'
   CC      fs/sysv/sysv.mod.o
arch/powerpc/boot/wrapper.a(main.o): In function `setprop':
/home/galak/git/linux-2.6/arch/powerpc/boot/ops.h:114: undefined  
reference to `_restgpr_30_x'
arch/powerpc/boot/wrapper.a(main.o): In function `start':
/home/galak/git/linux-2.6/arch/powerpc/boot/main.c:207: undefined  
reference to `_restgpr_24_x'
arch/powerpc/boot/wrapper.a(libfdt-wrapper.o): In function `fdt_init':
/home/galak/git/linux-2.6/arch/powerpc/boot/libfdt-wrapper.c:193:  
undefined reference to `_restgpr_30_x'

...

/home/galak/git/linux-2.6/arch/powerpc/boot/libfdt/fdt_wip.c:132:  
undefined reference to `_restgpr_26_x'
arch/powerpc/boot/wrapper.a(fdt_wip.o): In function `fdt_nop_node':
/home/galak/git/linux-2.6/arch/powerpc/boot/libfdt/fdt_wip.c:144:  
undefined reference to `_restgpr_28_x'
arch/powerpc/boot/wrapper.a(fdt_wip.o): In function  
`fdt_setprop_inplace':
/home/galak/git/linux-2.6/arch/powerpc/boot/libfdt/fdt_wip.c:73:  
undefined reference to `_restgpr_29_x'
make[1]: *** [arch/powerpc/boot/cuImage.mpc8560ads] Error 1
   CC      lib/libcrc32c.mod.o
   CC      net/key/af_key.mod.o

- k
