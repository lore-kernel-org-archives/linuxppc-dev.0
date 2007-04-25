Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id AD122DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Apr 2007 04:12:11 +1000 (EST)
Message-ID: <462F9B1A.3090906@ru.mvista.com>
Date: Wed, 25 Apr 2007 22:16:58 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Xilinx framebuffer device driver
References: <462E0D5C.1090105@ru.mvista.com> <200704250035.18673.arnd@arndb.de>
	<462F98B4.2000108@ru.mvista.com>
In-Reply-To: <462F98B4.2000108@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

Grant,

Andrei Konovalov wrote:
> I could add these to platform data.
> Together with the "use DCR access" option.
> Say,
> 
> --------------------------------------------------------
> struct xilinxfb_platform_data {
>     u32 use_dcr;
>     u32 screen_height_mm;
>     u32 screen_width_mm;
> };
> 
> static struct xilinxfb_platform_data xilinxfb_pdata = {
> #if defined(XPAR_TFT_0_USE_DCR) && (XPAR_TFT_0_USE_DCR != 0)
>     .use_dcr = 1;
> #else
>     .use_dcr = 0;
> #endif

IOW I am trying to avoid conditional compilation like:

#if defined(XPAR_TFT_0_USE_DCR) && (XPAR_TFT_0_USE_DCR != 0)
#define xilinxfb_out_be32(addr, mask)     mtdcr((addr), (mask))
#else
#define xilinxfb_out_be32(addr, mask)     out_be32((addr), (mask))
#endif

- as this would make the driver to include xparameters.h which would
be an issue when moving to the OF device tree.

Or "use DCR" could be a Kconfig option for the driver.


Thanks,
Andrei
