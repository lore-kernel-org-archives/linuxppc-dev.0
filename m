Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id BFC0C2BD3C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2004 16:01:32 +1000 (EST)
Date: Wed, 15 Sep 2004 22:36:25 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: David Gardiner <daveg@sonartech.com.au>
Message-ID: <20040915223624.A25752@home.com>
References: <414916BD.9080607@sonartech.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <414916BD.9080607@sonartech.com.au>;
	from daveg@sonartech.com.au on Thu, Sep 16, 2004 at 02:29:49PM
	+1000
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linux-2.6.9-rc2 kernel build for mvme5100
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 16, 2004 at 02:29:49PM +1000, David Gardiner wrote:
> Hi all,
> 
> I've got two questions in regard to building linux-2.6.9-rc2 for a mvme5100
> 
> Target info:
> build platform: mvme5100, gcc-3.3.4, debian-testing, linuxppc_2_4_devel, 
> default mvme5100 config
> target platform: mvme5100
> 
> Questions 1:
> 
> I was getting this error when I tried to build the kernel:
> 
>   CC      arch/ppc/boot/common/bootinfo.o
>   CC      arch/ppc/boot/common/misc-common.o
>   CC      arch/ppc/boot/common/ns16550.o
> arch/ppc/boot/common/ns16550.c:14: error: conflicting types for `outb'
> include/asm/io.h:142: error: previous declaration of `outb'
> arch/ppc/boot/common/ns16550.c:15: error: conflicting types for `inb'
> include/asm/io.h:157: error: previous declaration of `inb'
> make[2]: *** [arch/ppc/boot/common/ns16550.o] Error 1
> make[1]: *** [arch/ppc/boot/common] Error 2
> make: *** [zImage] Error 2
> 
> I changed arch/ppc/boot/common/ns16550.c so that it managed to compile 
> based on what was in io.h, the patch for which is attatched, are these 
> changes okay?

You need this patch:
 http://www.ussg.iu.edu/hypermail/linux/kernel/0409.1/1192.html

-Matt
