Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 29F36DDF21
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 02:37:42 +1000 (EST)
Date: Mon, 7 Apr 2008 11:38:02 -0500
From: Scott Wood <scottwood@freescale.com>
To: =?utf-8?B?5petIOe9lw==?= <luoxu_gun@yahoo.com.cn>
Subject: Re: a question about use dtb to bootting linux kernel on MPC83xx
	platform
Message-ID: <20080407163802.GC2688@loki.buserror.net>
References: <959437.18740.qm@web15907.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <959437.18740.qm@web15907.mail.cnb.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 07, 2008 at 09:35:17AM +0800, 旭 罗 wrote:
>     I am Linux software engineer. These days I was debugging a MPC8313 system. In  the debugging process, some source code in the kernel makes me puzzled. So I  have find your email address in the source code. I think you can give me some  advises to solve the problem.
>   
>         My version is  linux-2.6.23.9 and I use the device tree(dtb) to  booting the kernel. In my bootloader I use the following code to jump to the  kernel.
>  (*image)((bd_t *)dtb_entry,  (unsigned int)image, 0, 0, 0); 
>   
>  The dtb_entry is the address of dtb  file which in the SDRAM, the image
> is the kernel entry point. I flashed some LEDs in my board. So I can make
> sure the program run to the machine_init() which is defined in the
> /arch/powerpc/kernel/setup_32.c In order to trace the problem I search the
> source code. I can find that these information is printed by the start
> function which is defined in the /arch/powerpc/boot/main.c.
>  Fourth more I have found that the  kernel call the platform_init which is
>  defined in the /arch/powerpc/boot/cuboot-83xx.c. looking the file head I
>  have known you are the author for this file. Could you told me how the
>  kernel call the platform_init function and I hope you can show me the
>  booting process of the MPC83xx linux or you could give me some document
>  about it.

As I said when you e-mailed me privately a few days ago, cuImage is for
older u-boots that pass in a bd_t, not a device tree. You should be booting
uImage instead.

-Scott
