Return-Path: <glikely@secretlab.ca>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.189])
	by ozlabs.org (Postfix) with ESMTP id 2E765DDF21
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 02:50:47 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so1447180tib.13
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 09:50:46 -0700 (PDT)
Message-ID: <fa686aa40805260950w7af43ddevca9ba530249edec5@mail.gmail.com>
Date: Mon, 26 May 2008 10:50:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: biswa.nayak@wipro.com
Subject: Re: Icecube/lite5200 board does not boot in linux-2.6.25.x
In-Reply-To: <4F36B0A4CDAD6F46A61B2B32C33DC69C062BEA16@BLR-EC-MBX03.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4F36B0A4CDAD6F46A61B2B32C33DC69C062BEA16@BLR-EC-MBX03.wipro.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 26, 2008 at 9:58 AM,  <biswa.nayak@wipro.com> wrote:
> Hi
> I am trying to boot Freescale Icecube/Lite5200 board using
> Linux-2.6.25.x,
> but nothing gets printed on to the serial console after the
> uncompressing kernel and ramdisk messages.
>
> The same board boots up cleanly with Linux-2.6.24.7.
> But anything after linux-2.6.25 does not work at all.
> I am using ELDK-4.1 as my toolchain.
>
> Using BDI2000 device I dumped the '__log_buf' section
> to find out whether there is any activity that goes behind the scene
> and found out that the system crashes with below log messages.

There is a known bug in 2.6.25 which has been fixed in the stable tree
(2.6.25.3).  It might be your problem.

Try making this change:

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index d93b357..7a3625f 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -1221,8 +1221,8 @@ static struct of_device_id mpc52xx_uart_of_match[] = {
 #endif
 #ifdef CONFIG_PPC_MPC512x
        { .compatible = "fsl,mpc5121-psc-uart", .data = &mpc512x_psc_ops, },
-       {},
 #endif
+       {},
 };

 static int __devinit
