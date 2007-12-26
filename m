Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EE6EADDEC4
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 03:56:54 +1100 (EST)
Date: Wed, 26 Dec 2007 19:58:16 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] ucc_uart: add support for Freescale QUICCEngine UART
Message-ID: <20071226165816.GB11449@localhost.localdomain>
References: <11970458703666-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <11970458703666-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 07, 2007 at 10:44:30AM -0600, Timur Tabi wrote:
> Add support for UART serial ports using a Freescale QUICC Engine
> (found on some MPC83xx and MPC85xx SOCs).
> 
> Updated booting-without-of.txt to define new properties for a QE UART node,
> and a new node definition that describes uploaded QE firmware.
> 
> Because of a silicon bug in some QE-enabled SOCs (e.g. 8323 and 8360), a new
> microcode is required. This microcode implements UART via a work-around,
> hence it's called "Soft-UART".  This driver can use the QE firmware upload
> feature to upload the correct microcode to the QE.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

> @@ -250,6 +279,26 @@
>  			pio-handle = < &pio4 >;
>  		};
>  
> +		ucc@2400 {
> +			device_type = "serial";
> +			compatible = "ucc_uart";
> +			model = "UCC";

model isn't used, is it needed at all?

> +			device-id = <5>;	/* The UCC number, 1-7*/
> +			port-number = <0>;	/* Which ttyQEx device */
> +			soft-uart;		/* We need Soft-UART */
> +			reg = <2400 200>;
> +			interrupts = <28>;	/* From Table 18-12 */
> +			interrupt-parent = < &qeic >;
> +			/*
> +			 * For Soft-UART, we need to set TX to 1X, which
> +			 * means specifying separate clock sources.
> +			 */
> +			rx-clock-name = "brg5";
> +			tx-clock-name = "brg6";
> +			pio-handle = < &pio5 >;
[...]
> +	if (soft_uart) {
> +		struct qe_firmware_info *qe_fw_info;
> +
> +		qe_fw_info = qe_get_firmware_info();
> +
> +		/* Check if the firmware has been uploaded. */
> +		if (strstr(qe_fw_info->id, "Soft-UART")) {

qe_fw_info used w/o NULL checking.

> +			firmware_loaded = 1;
> +		} else {
> +			char filename[32];
> +			unsigned int soc;
> +			unsigned int rev_h;
> +			unsigned int rev_l;
> +
> +			soc = soc_info(&rev_h, &rev_l);
> +			if (!soc) {
> +				dev_err(&ofdev->dev, "unknown CPU model\n");
> +				return -ENXIO;
> +			}
> +			sprintf(filename, "fsl_qe_ucode_uart_%u_%u%u.bin",
> +				soc, rev_h, rev_l);
> +
> +			dev_info(&ofdev->dev, "waiting for firmware %s\n",
> +				filename);
> +
> +			/*
> +			 * We call request_firmware_nowait instead of
> +			 * request_firmware so that the driver can load and
> +			 * initialize the ports without holding up the rest of
> +			 * the kernel.  If hotplug support is enabled in the
[...]
> +
> +	qe_port->port.irq = irq_of_parse_and_map(np, 0);
> +	if (qe_port->port.irq == NO_IRQ) {
> +		dev_err(&ofdev->dev, "could not map IRQ for UCC%u\n",
> +		       qe_port->ucc_num + 1);
> +		kfree(qe_port);
> +		return -EINVAL;
> +	}
> +
> +	np = of_find_node_by_type(NULL, "qe");

Please, add "fsl,qe" compatible matching.

> +	if (!np) {
> +		dev_err(&ofdev->dev, "could not find parent 'qe' node\n");
> +		kfree(qe_port);
> +		return -EINVAL;
> +	}
> +
[...]
> +static struct of_platform_driver ucc_uart_of_driver = {
> +	.owner  	= THIS_MODULE,
> +	.name   	= "ucc_uart",

Maybe better fsl,ucc_uart?


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
