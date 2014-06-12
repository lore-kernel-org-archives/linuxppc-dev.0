Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3368F1A0559
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 07:21:40 +1000 (EST)
Message-ID: <1402608088.6603.549.camel@snotra.buserror.net>
Subject: Re: Device Tree Binding for DSA on P1023RDB
From: Scott Wood <scottwood@freescale.com>
To: Pannirselvam Kanagaratnam <pannir@xsmail.com>
Date: Thu, 12 Jun 2014 16:21:28 -0500
In-Reply-To: <5399C8F2.8060108@xsmail.com>
References: <5399C8F2.8060108@xsmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-06-12 at 23:36 +0800, Pannirselvam Kanagaratnam wrote:
> The QORIQ P1023RDB has an option to populate the Marvell 88E6165
> Ethernet switch. We populated this device and was able to initialize
> it as a basic switch in U-Boot. However, the switch driver was not
> loaded upon kernel bootup. DSA kernel config was enabled for the
> 88E6165. The following patch was applied:
> 
> 
> http://patchwork.ozlabs.org/patch/230257/
> 
> 
> The switch is attached to phy address 0x3 via dtsec2. My dts file is
> as below. Would appreciate any feedback on whether the DSA is
> correctly structured in the dts.

If you have a dtsec driver you're not working with an upstream kernel
(or you've ported a lot of SDK code to it)...  What tree are you working
with?  Are there prerequisites to the above patch that you might be
missing?

The above patch is a platform driver and you put the node in the
toplevel device tree node.  Have you added marvell,dsa to the list of
compatible strings that get probed (of_device_ids in corenet_generic.c
or an equivalent list in your SDK kernel)?
> 
>     dsa@0 {
>             compatible = "marvell,dsa";
>             #address-cells = <2>;
>             #size-cells = <0>;
> 
>             interrupts = <3>;

This interrupts property needs to be four cells rather than one, if MPIC
is the parent -- assuming you have #interrupt-cells = <4> and not some
old device tree with #interrupt-cells = <2>, but in any case you need
more than one cell.

-Scott
