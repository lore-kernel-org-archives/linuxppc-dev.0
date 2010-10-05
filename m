Return-Path: <john.traill@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E25F8B6F0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 00:26:03 +1100 (EST)
Message-ID: <4CAB2729.6080402@freescale.com>
Date: Tue, 5 Oct 2010 14:24:57 +0100
From: John Traill <john.traill@freescale.com>
MIME-Version: 1.0
To: Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>
Subject: Re: Serial RapidIO Maintaintance read causes lock up
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
	<AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
In-Reply-To: <AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bastiaan,

A few things to check.

1. Is the target board also set up for small common transport system size ie 256.

2. Make sure the target has "Accept All" set - in fsl_rio.c look for
>        /* Set to receive any dist ID for serial RapidIO controller. */
>         if (port->phy_type == RIO_PHY_SERIAL)
>                 out_be32((priv->regs_win + RIO_ISR_AACR), RIO_ISR_AACR_AA);

3. How do you synchronise reset between both systems ? Both need to be reset to 
insure the inbound/outbound ackid's remain in sync. If you only reset one then 
you have the potential for the ackid's to get out of sync. Also what is the 
kernel log on the agent system ?

Cheers.


On 05/10/10 09:56, Bastiaan Nijkamp wrote:
>
> Hi Alex,
>
> Thanks for your advice. We are trying to make a board-to-board
> connection without any additional hardware (eg. a switch). The boards
> use a 50-pin, right-angle MEC8-125-02-L-D-RA1 connector from SAMTEC and
> are connected trough a EEDP-016-12.00-RA1-RA2-2 cross cable from SAMTEC.
> I hope this information is sufficient since there is not much one can
> find about it on Google. In addition, you can see a picture of the board
> including the connector in the datasheet located at
> http://www.windriver.com/products/product-notes/SBC8548E-product-note.pdf.
> It is the connector on the left side of the PCI-EX slot.
>
> We have tried your suggestion but the situation does not change other
> than the lane-mode being set to single lane 0, it still locks up when
> trying to generate a maintenance transaction. I still think it is memory
> related since the lock up occurs when accessing the maintenance window.
> Although all memory related settings seems to be alright.
>
> The kernel output is as follows:
>
> Setting up RapidIO peer-to-peer network /soc8548@e0000000/rapidio@c0000
> fsl-of-rio e00c0000.rapidio: Of-device full name
> /soc8548@e0000000/rapidio@c0000
> fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]
> fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size
> 0x0000000010000000.
> fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54
> fsl-of-rio e00c0000.rapidio: DeviceID is 0x0
> fsl-of-rio e00c0000.rapidio: Configured as HOST
> fsl-of-rio e00c0000.rapidio: Overriding RIO_PORT setting to single lane 0
> fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial
> fsl-of-rio e00c0000.rapidio: Hardware port width: 4
> fsl-of-rio e00c0000.rapidio: Training connection status: Single-lane 0
> fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256
> fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO
> Maintainance Window Size 0x400000,New Main Start: 0xd1080000
> RIO: enumerate master port 0, RIO0 mport
> fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4
> fsl_rio_config_read: Passed IS_ALIGNED.
> fsl_rio_config_read: Passed 'out_be32_1'
> fsl_rio_config_read: Passed 'out_be32_2'
> fsl_rio_config_read: len is 4
> fsl_rio_config_read: triggering '__fsl_read_rio_config'
> fsl_rio_config_read: going to request to read data at d108006
>
> Regards,
> Bastiaan
>
> 2010/10/4 Bounine, Alexandre <Alexandre.Bounine@idt.com
> <mailto:Alexandre.Bounine@idt.com>>
>
>     Hi Bastiaan,
>
>     Are you trying board-to-board connection?
>     I am not familiar with WRS SBC8548 board - which type of connector they
>     use for SRIO?
>
>     Assuming that all configuration is correct,
>     I would recommend first to try setting up x1 link mode at the lowest
>     link speed.
>     The x4 mode may present challenges in some cases.
>
>     For quick test you may just add port width override into fsl_rio.c
>     like shown below (ugly but sometimes it helps ;) ):
>
>     @@ -1461,10 +1461,16 @@ int fsl_rio_setup(struct platform_device *dev)
>             rio_register_mport(port);
>
>             priv->regs_win = ioremap(regs.start, regs.end - regs.start + 1);
>             rio_regs_win = priv->regs_win;
>
>     +dev_info(&dev->dev, "Overriding RIO_PORT setting to single lane 0\n");
>     +out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) |
>     0x800000);
>     +out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) |
>     0x2000000);
>     +out_be32(priv->regs_win + 0x15C, in_be32(priv->regs_win + 0x15C) &
>     ~0x800000);
>     +msleep(100);
>     +
>             /* Probe the master port phy type */
>             ccsr = in_be32(priv->regs_win + RIO_CCSR);
>             port->phy_type = (ccsr & 1) ? RIO_PHY_SERIAL : RIO_PHY_PARALLEL;
>             dev_info(&dev->dev, "RapidIO PHY type: %s\n",
>                             (port->phy_type == RIO_PHY_PARALLEL) ?
>     "parallel" :
>
>
>     Let me know what happens.
>     Please keep me in the CC: list next time when posting RapidIO questions
>     to the linuxppc-dev or kernel mailing lists.
>
>     Regards,
>
>     Alex.
>
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
John Traill
Systems Engineer
Network and Computing Systems Group

Freescale Semiconductor UK LTD
Colvilles Road
East Kilbride
Glasgow G75 0TG, Scotland

Tel: +44 (0) 1355 355494
Fax: +44 (0) 1355 261790

E-mail: john.traill@freescale.com

Registration Number: SC262720
VAT Number: GB831329053

[ ] General Business Use
[ ] Freescale Internal Use Only
[ ] Freescale Confidential Proprietary
