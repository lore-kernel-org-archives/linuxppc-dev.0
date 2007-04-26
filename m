Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id A66A9DDF56
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 06:35:41 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: [PATCH] Xilinx framebuffer device driver - 2nd version
Date: Thu, 26 Apr 2007 22:35:21 +0200
References: <4630F018.3010200@ru.mvista.com>
In-Reply-To: <4630F018.3010200@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200704262235.22048.arnd@arndb.de>
Cc: rick.moleres@xilinx.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> @@ -118,6 +118,12 @@ struct xilinxfb_drvdata {
>   #define to_xilinxfb_drvdata(_info) \
>   	container_of(_info, struct xilinxfb_drvdata, info)
> 
> +#define xilinx_fb_out_be32(driverdata, offset, val) \
> +	if (driverdata->use_dcr) \
> +		mtdcr(driverdata->regs_phys + offset, val); \
> +	else \
> +		out_be32(driverdata->regs + offset, val)
> +
>   static int
>   xilinx_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
>   	unsigned transp, struct fb_info *fbi)

This should probably be an inline function, or use do { ... } while (0) 
instead, to make it less error-prone, see
http://kernelnewbies.org/FAQ/DoWhile0 for an explanation.

	Arnd <><
