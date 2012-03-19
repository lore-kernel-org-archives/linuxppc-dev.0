Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C3D6B6FE9
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2012 05:43:42 +1100 (EST)
Message-ID: <4F677E51.8030905@freescale.com>
Date: Mon, 19 Mar 2012 13:43:29 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/85xx: don't call of_platform_bus_probe() twice
References: <1322669957-8259-1-git-send-email-timur@freescale.com>
 <F8C3451C-1B14-4C30-A194-B15B6C10B0A7@kernel.crashing.org>
 <4F63A7A4.4000205@freescale.com> <20120319160452.B57D13E05A5@localhost>
In-Reply-To: <20120319160452.B57D13E05A5@localhost>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Scott Wood <scottwood@freescale.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> The problem is that you want to create devices for grandchildren
> nodes when the bus ids passed in don't match any of the child nodes so
> the of_platform_bus_probe() doesn't iterate down to that level.  This
> is correct and expected behaviour.

Well, I'm not still not 100% sure on what I'm supposed to do, so I tried this:

static struct of_device_id __initdata p1022_ds_ids[] = {
	/* The audio driver probes the SSI DMA channels individually */
	{ .compatible = "fsl,ssi-dma-channel", },
	{},
};

static int __init p1022_ds_publish_devices(void)
{
	struct device_node *np;
	int ret;

	mpc85xx_common_publish_devices();

	for_each_compatible_node(np, NULL, "fsl,eloplus-dma") {
		ret = of_platform_bus_probe(np, p1022_ds_ids, NULL);
		if (ret)
			return ret;
	}

	return 0;
}

It works, but it looks clunky.

For the record, this is what the DMA controller node looks like.  It's a
child of the SOC node.  The SSI driver probes on the "fsl,ssi-dma-channel"
nodes directly.

dma@c300 {
        cell-index = <0x1>;
        ranges = <0x0 0xc100 0x200>;
        reg = <0xc300 0x4>;
        compatible = "fsl,eloplus-dma";
        #size-cells = <0x1>;
        #address-cells = <0x1>;

        dma-channel@180 {
                interrupts = <0x4f 0x2 0x0 0x0>;
                cell-index = <0x3>;
                reg = <0x180 0x80>;
                compatible = "fsl,eloplus-dma-channel";
        };

        dma-channel@100 {
                interrupts = <0x4e 0x2 0x0 0x0>;
                cell-index = <0x2>;
                reg = <0x100 0x80>;
                compatible = "fsl,eloplus-dma-channel";
        };

        dma-channel@80 {
                phandle = <0x4>;
                linux,phandle = <0x4>;
                interrupts = <0x4d 0x2 0x0 0x0>;
                cell-index = <0x1>;
                reg = <0x80 0x80>;
                compatible = "fsl,ssi-dma-channel";
        };

        dma-channel@0 {
                phandle = <0x3>;
                linux,phandle = <0x3>;
                interrupts = <0x4c 0x2 0x0 0x0>;
                cell-index = <0x0>;
                reg = <0x0 0x80>;
                compatible = "fsl,ssi-dma-channel";
        };
};

-- 
Timur Tabi
Linux kernel developer at Freescale
