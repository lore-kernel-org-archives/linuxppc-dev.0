Return-Path: <akonovalov@ru.mvista.com>
Received: from localhost.localdomain (89-178-69-49.broadband.corbina.ru
	[89.178.69.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23DABDDFBE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 08:10:06 +1000 (EST)
Message-ID: <46311FC8.9020906@ru.mvista.com>
Date: Fri, 27 Apr 2007 01:55:20 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Xilinx framebuffer device driver - 2nd version
References: <4630F018.3010200@ru.mvista.com> <200704262235.22048.arnd@arndb.de>
In-Reply-To: <200704262235.22048.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

Arnd Bergmann wrote:
>>@@ -118,6 +118,12 @@ struct xilinxfb_drvdata {
>>  #define to_xilinxfb_drvdata(_info) \
>>  	container_of(_info, struct xilinxfb_drvdata, info)
>>
>>+#define xilinx_fb_out_be32(driverdata, offset, val) \
>>+	if (driverdata->use_dcr) \
>>+		mtdcr(driverdata->regs_phys + offset, val); \
>>+	else \
>>+		out_be32(driverdata->regs + offset, val)
>>+
>>  static int
>>  xilinx_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
>>  	unsigned transp, struct fb_info *fbi)
> 
> 
> This should probably be an inline function, or use do { ... } while (0) 
> instead, to make it less error-prone, see
> http://kernelnewbies.org/FAQ/DoWhile0 for an explanation.
> 
> 	Arnd <><

xilinx_fb_out_be32 macro doesn't declare local variables, and is a single "line of code"
in terms of the web page you've referenced. IOW I can't get an example where this macro
would do wrong off the top of my head. Anyway, the do { ... } while (0) is safe and
common, so I'll regenerate the patch to use it.

Thanks a lot for reviewing that stuff!

Best regards,
Andrei
