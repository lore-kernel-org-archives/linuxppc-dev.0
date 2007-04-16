Return-Path: <gshan@alcatel-lucent.com>
Received: from ihemail4.lucent.com (ihemail4.lucent.com [135.245.0.39])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ihemail4.lucent.com",
	Issuer "Lucent Technologies Certificate Services 1" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5FAF4DDEAB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 15:35:23 +1000 (EST)
Received: from mailgate.qd.lucent.com (h135-252-40-221.lucent.com
	[135.252.40.221])
	by ihemail4.lucent.com (8.13.8/IER-o) with ESMTP id l3G5SsUH020393
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 00:28:55 -0500 (CDT)
Message-ID: <46230995.4060003@alcatel-lucent.com>
Date: Mon, 16 Apr 2007 13:28:53 +0800
From: gshan <gshan@alcatel-lucent.com>
MIME-Version: 1.0
To: "Wang, Baojun" <wangbj@lzu.edu.cn>
Subject: Re: PROBLEM: kernel 2.6.20.6 build failed for ppc board chestnut(ibm
	ppc 750GX/FX)
References: <376700739.05606@lzu.edu.cn>
In-Reply-To: <376700739.05606@lzu.edu.cn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm using eldk4, there are no problems.

Wang, Baojun wrote:
> PROBLEM: linux kernel 2.6.20.6 build failed for ppc board chestnut(ibm ppc 
> 750GX/FX)
>
> STEPS I followed:
> 1) make ARCH=ppc CROSS_COMPILE=ppc_4xx- chestnut_defconfig # toolchain from 
> eldk 4.1
>
> 2) make ARCH=ppc CROSS_COMPILE=ppc_4xx- V=1
>
> ...
>
> make -f scripts/Makefile.build obj=arch/ppc/platforms
>   
> ppc_4xx-gcc -m32 -Wp,-MD,arch/ppc/platforms/.chestnut.o.d  -nostdinc -isystem /opt/eldk/usr/bin/../lib/gcc/powerpc-linux/4.0.0/include -D__KERNEL__ -Iinclude  -include 
> include/linux/autoconf.h -Iarch/ppc -Iarch/ppc/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -Iarch/ppc -msoft-float -pipe -ffixed-r2 -mmultiple  -mno-altivec -mstring -Wa,-maltivec -fomit-frame-pointer  -Wdeclaration-after-statement -Wno-pointer-sign    -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(chestnut)"  -D"KBUILD_MODNAME=KBUILD_STR(chestnut)" -c -o 
> arch/ppc/platforms/chestnut.o arch/ppc/platforms/chestnut.c
> arch/ppc/platforms/chestnut.c: In function 'chestnut_setup_mtd':
> arch/ppc/platforms/chestnut.c:435: error: 'physmap_map' undeclared (first use 
> in this function)
> arch/ppc/platforms/chestnut.c:435: error: (Each undeclared identifier is 
> reported only once
> arch/ppc/platforms/chestnut.c:435: error: for each function it appears in.)
> make[1]: *** [arch/ppc/platforms/chestnut.o] Error 1
> make: *** [arch/ppc/platforms] Error 2
>
>
> This PROBLEM should also affect these boards:
> find -name '*.[chS]' -exec grep physmap_map {} \; -print
>         physmap_map.size = CHESTNUT_32BIT_SIZE;
> ./arch/ppc/platforms/chestnut.c
>         physmap_map.size = size;
> ./arch/ppc/platforms/ev64360.c
>         physmap_map.size = size;
> ./arch/ppc/platforms/katana.c
>
> I've veryfied 2.6.15, 2.6.19.2 2.6.20.1 2.6.20.6
>
> ONLY 2.6.15 can build successfully. sounds like the problem is caused by the 
> interface change of mtd.
>
>
> this brute force patch sould solve the problem:
>
> diff -Nru /tmp/linux-2.6.20.6/arch/ppc/platforms/chestnut.c \  
> linux-2.6.20.6/arch/ppc/platforms/chestnut.c
>
> --- /tmp/linux-2.6.20.6/arch/ppc/platforms/chestnut.c   2007-04-07 
> 04:02:48.000000000 +0800
> +++ linux-2.6.20.6/arch/ppc/platforms/chestnut.c        2007-04-13 
> 17:09:03.000000000 +0800
> @@ -432,7 +432,9 @@
>         ptbl.name = "User FS";
>         ptbl.size = CHESTNUT_32BIT_SIZE;
>
> -       physmap_map.size = CHESTNUT_32BIT_SIZE;
> +       // physmap_map.size = CHESTNUT_32BIT_SIZE;
> +       physmap_configure(CHESTNUT_32BIT_BASE, CHESTNUT_32BIT_SIZE, 
> CONFIG_MTD_PHYSMAP_BANKWIDTH, NULL);
> +
>         physmap_set_partitions(&ptbl, 1);
>         return 0;
>  }
>
>   
