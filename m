Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A0C84DDE1A
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Dec 2007 09:10:31 +1100 (EST)
Message-ID: <4776C5EE.70004@freescale.com>
Date: Sat, 29 Dec 2007 16:10:54 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2] ucc_uart: add support for Freescale QUICCEngine UART
References: <11970458703666-git-send-email-timur@freescale.com>
	<20071226165816.GB11449@localhost.localdomain>
In-Reply-To: <20071226165816.GB11449@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

>> +		ucc@2400 {
>> +			device_type = "serial";
>> +			compatible = "ucc_uart";
>> +			model = "UCC";
> 
> model isn't used, is it needed at all?

I have no idea, but all the other UCC nodes have it, so I'm going to 
keep it.  Maybe one day we'll merge QE and CPM drivers, so this would be 
useful.

>> +	if (soft_uart) {
>> +		struct qe_firmware_info *qe_fw_info;
>> +
>> +		qe_fw_info = qe_get_firmware_info();
>> +
>> +		/* Check if the firmware has been uploaded. */
>> +		if (strstr(qe_fw_info->id, "Soft-UART")) {
> 
> qe_fw_info used w/o NULL checking.

Ok.

> [...]
>> +
>> +	qe_port->port.irq = irq_of_parse_and_map(np, 0);
>> +	if (qe_port->port.irq == NO_IRQ) {
>> +		dev_err(&ofdev->dev, "could not map IRQ for UCC%u\n",
>> +		       qe_port->ucc_num + 1);
>> +		kfree(qe_port);
>> +		return -EINVAL;
>> +	}
>> +
>> +	np = of_find_node_by_type(NULL, "qe");
> 
> Please, add "fsl,qe" compatible matching.

Ok.

>> +static struct of_platform_driver ucc_uart_of_driver = {
>> +	.owner  	= THIS_MODULE,
>> +	.name   	= "ucc_uart",
> 
> Maybe better fsl,ucc_uart?

The CPM serial driver uses "cpm_uart" and the QE ethernet driver uses 
"ucc_geth", so ucc_uart matches the pattern.
