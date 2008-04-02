Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C92B7DDFA9
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 01:13:57 +1100 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m32EDpEH001444
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 16:13:52 +0200
Message-ID: <0cf501c894cb$c73dfee0$f52f9e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: ARCH=ppc vs powerpc
Date: Wed, 2 Apr 2008 16:13:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anyone care to comment on that:

$ make ARCH=ppc linux26-menuconfig
[ -f 
/home/guinevere/buildroot/project_build_ppc/genepy/linux-2.6.24/.config ] |
| cp local/genepy/linux-2.6.24.config 
/home/guinevere/buildroot/project_build_pp
c/genepy/linux-2.6.24/.config
/usr/bin/make -j1 HOSTCC="/usr/bin/gcc" HOSTCFLAGS="" ARCH=powerpc
[...]

Why does ARCH change ?!?

[...]
.config:132:warning: trying to assign nonexistent symbol XILINX_ML405
[...]

$ find -name Kconfig -exec grep -H XILINX_ML405 {} \;
./toolchain_build_powerpc/linux-2.6.24/arch/ppc/platforms/4xx/Kconfig:config 
XILINX_ML405
./project_build_ppc/genepy/linux-2.6.24/arch/ppc/platforms/4xx/Kconfig:config 
XILINX_ML405
./toolchain_build_ppc/linux-2.6.24/arch/ppc/platforms/4xx/Kconfig:config 
XILINX_ML405

Well, it's no surprise that it won't find them if it looks in the powerpc 
branch...
The question is why ?
-- 
Guillaume Dargaud
http://www.gdargaud.net/
