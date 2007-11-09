Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out2.tiscali.nl (smtp-out2.tiscali.nl [195.241.79.177])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E017DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 23:32:27 +1100 (EST)
Message-ID: <47345350.6090400@tiscali.nl>
Date: Fri, 09 Nov 2007 13:32:16 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] balance ioremap/iounmap in {sycamore, walnut}_setup_arch()
References: <47333A69.3030606@tiscali.nl> <47333EDA.4080907@ru.mvista.com>
In-Reply-To: <47333EDA.4080907@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak wrote:
> Roel Kluin wrote:
>> I guess it should be done after the last usage of kb_data or fpga_status?
> 
> I think no iounmap(kb_data) needed. Looks like the pointer kn_cs (kb_cs
> = kb_data + 1) is used by the serio driver
> (drivers/input/serio/i8042-ppcio.h).
> Please note that we just ioremap and assign pointers here, not actually
> reading the registers.
> Also, looks like you unmap the fpga registers too early.
> Thanks,
> Valentine.

Thanks for your pointers. I'm new, so I'm not sure how this should be done. I
have removed the iounmap(kb_data), and moved the iounmap(fpga_status) lower.
possibly the latter could be done before the sycamore_rtc_base assignment?
--
Balance ioremap/iounmap

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/ppc/platforms/4xx/sycamore.c b/arch/ppc/platforms/4xx/sycamore.c
index 8689f3e..6ce4815 100644
--- a/arch/ppc/platforms/4xx/sycamore.c
+++ b/arch/ppc/platforms/4xx/sycamore.c
@@ -132,6 +132,7 @@ sycamore_setup_arch(void)
 	sycamore_rtc_base = (void *) SYCAMORE_RTC_VADDR;
 	TODC_INIT(TODC_TYPE_DS1743, sycamore_rtc_base, sycamore_rtc_base,
 		  sycamore_rtc_base, 8);
+	iounmap(fpga_status);
 
 	/* Identify the system */
 	printk(KERN_INFO "IBM Sycamore (IBM405GPr) Platform\n");
