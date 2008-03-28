Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81ECADDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 21:40:15 +1100 (EST)
Message-ID: <066b01c890c0$17d9a800$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
References: <052801c88f37$3b51f7e0$ad289e86@LPSC0173W>
	<fa686aa40803260601j6e7f507fpe4d31c7c462fce5e@mail.gmail.com>
Subject: Re: Patch: FW:Xilinx: BSP: Updated ML405 to match hardware used
	fortesting
Date: Fri, 28 Mar 2008 11:40:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>  I'm trying to get things up and running on a Xilinx Virtex-4 ml405 
>> board,
>>  and as such I've been trying to figure out the following recent message 
>> to
>>  the list:
>>  http://patchwork.ozlabs.org/linuxppc/patch?person=1226&id=17037
>>
>>  I don't understand what this patch applies to: it references files such 
>> as
>>  ml405_defconfig which are not part of the normal kernel tree and which I
>>  cannot find anywhere. Is there some other kind of patch that needs to 
>> apply
>>  first in order to get for instance CONFIG_XILINX_DRIVERS,
>>  CONFIG_XILINX_EMAC, etc...

> It applies to Xilinx's git tree of the Linux kernel.

Fair enough.

OK, I managed to install git, download the Xilinx kernel source tree, 
integrate it into root and compile it successfully...

Now I'd like to understand this ml405_defconfig file. I cannot replace my 
.config with it because it gives me:

$ make ARCH=ppc linux26-menuconfig
[ -f 
/home/guinevere/buildroot/project_build_ppc/genepy/linux-2.6.24/.config ] |
| cp local/genepy/linux-2.6.24.config 
/home/guinevere/buildroot/project_build_pp
c/genepy/linux-2.6.24/.config
/usr/bin/make -j1 HOSTCC="/usr/bin/gcc" HOSTCFLAGS="" ARCH=powerpc 
CFLAGS_KERNEL
="-Os -I/home/guinevere/buildroot/build_ppc/staging_dir/usr/include -I/home/guin
evere/buildroot/build_ppc/staging_dir/include --sysroot=/home/guinevere/buildroo
t/build_ppc/staging_dir/ -isysroot 
/home/guinevere/buildroot/build_ppc/staging_d
ir -mtune=405" 
INSTALL_MOD_PATH=/home/guinevere/buildroot/project_build_ppc/gene
py/root 
CROSS_COMPILE=/home/guinevere/buildroot/build_ppc/staging_dir/usr/bin/pp
c-linux-uclibc- 
LDFLAGS="-L/home/guinevere/buildroot/build_ppc/staging_dir/lib -
L/home/guinevere/buildroot/build_ppc/staging_dir/usr/lib --sysroot=/home/guineve
re/buildroot/build_ppc/staging_dir/" 
LZMA="/home/guinevere/buildroot/toolchain_b
uild_ppc/bin/lzma"  -C 
/home/guinevere/buildroot/project_build_ppc/genepy/linux-
2.6.24 menuconfig
make[1]: Entering directory 
`/home/guinevere/buildroot/project_build_ppc/genepy/
linux-2.6.24'
scripts/kconfig/mconf arch/powerpc/Kconfig
.config:117:warning: trying to assign nonexistent symbol WANT_EARLY_SERIAL
.config:122:warning: trying to assign nonexistent symbol BUBINGA
.config:123:warning: trying to assign nonexistent symbol CPCI405
.config:124:warning: trying to assign nonexistent symbol EP405
.config:127:warning: trying to assign nonexistent symbol SYCAMORE
.config:129:warning: trying to assign nonexistent symbol XILINX_ML300
.config:130:warning: trying to assign nonexistent symbol XILINX_XUPV2P
.config:131:warning: trying to assign nonexistent symbol XILINX_ML403
.config:132:warning: trying to assign nonexistent symbol XILINX_ML405
.config:133:warning: trying to assign nonexistent symbol XILINX_ML41x
.config:138:warning: trying to assign nonexistent symbol XILINX_EMBED_CONFIG
.config:139:warning: trying to assign nonexistent symbol EMBEDDEDBOOT
.config:140:warning: trying to assign nonexistent symbol PPC4xx_DMA
.config:142:warning: trying to assign nonexistent symbol UART0_TTYS0
.config:143:warning: trying to assign nonexistent symbol UART0_TTYS1
.config:149:warning: trying to assign nonexistent symbol PC_KEYBOARD
.config:759:warning: trying to assign nonexistent symbol SERIAL_TEXT_DEBUG

So my question is that even with a full (?) Xilinx kernel, there seems to be 
missing drivers. Does this have to do with the BSP ?

Thanks
-- 
Guillaume Dargaud
http://www.gdargaud.net/
