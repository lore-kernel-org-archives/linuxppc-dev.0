Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3793EB6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2012 05:35:41 +1100 (EST)
Message-ID: <4F74AB70.7070209@freescale.com>
Date: Thu, 29 Mar 2012 13:35:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Fabio <pozzi.fabio@gmail.com>
Subject: Re: Help initialize phy-less ethernet in 2.6.38
References: <CAP-cLV5pF-j_izadBSVD7p4hQte96O_g2udCxi=9tkaPwxEsaw@mail.gmail.com>
In-Reply-To: <CAP-cLV5pF-j_izadBSVD7p4hQte96O_g2udCxi=9tkaPwxEsaw@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Cc: Andy Fleming <afleming@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/28/2012 11:13 AM, Fabio wrote:
> Hi all,
> I am a newbie trying to get the FCC1 ethernet interface to work on a
> custom board.
> The hardware used is based on mpc8270 which is connected via FCC1 to a
> phy-less interface linked to another microcontroller.
> FCC1 should be recognized as eth0 by the linux kernel and it should
> receive data when set up in promiscuous mode.
> Currently during the boot it seems that the device initialization goes
> ok but I can't understand why I can't receive data when I put the
> interface in promiscuous mode.

Is the problem only with promiscuous mode, or do you have problems with
normal operation as well (receiving broadcast packets and packets
addressed to you, sending pakcets, etc)?

> Going into details I can see that the fs_enet probe function gets called.
> I customized it to setup the fs_platform_info structure using the
> values taken from the old kernel driver for now.

Which old kernel driver?  Why do you need to mess with fs_platform_info?

> The only fields I cannot setup are the bus_id,phy_irq,phy_addr because
> they are not part of the fs_platform_info data structure anymore.

All this stuff comes from the device tree.

> I can't see any errors during the initialization, but I can't receive
> data on the interface.
> 
> I think the problem can be in an interrupt misconfiguration but I
> haven't figured out how to configure the ethernet dts part in the
> right way or how to handle the phy-less situation correctly.

Why do you think the interrupt is misconfigured?

For phy-less you should have a fixed-link property.  For some reason
this property is documented only in
Documentation/devicetree/bindings/net/fsl-tsec-phy.txt, but it is
applicable here as well.

Looking at the code, though, I'm not sure if this stuff still works --
e.g. I don't see where any fields of fixed-link but the ID are used, or
what's supposed to happen when of_phy_connect_fixed_link() calls
phy_connect().

> --- dts snippet ---
> 			eth0: ethernet@11300 {
> 				device_type = "network";
> 				compatible =  "fsl,cpm2-fcc-enet";
> 				reg = <0x11300 0x20 0x8400 0x100 0x11390 0x1>;
> 				local-mac-address = [ 00 01 02 03 04 05 ];
> 				interrupts = <32 8>;
> 				interrupt-parent = <&PIC>;
> 				linux,network-index = <0>;
> 				fsl,cpm-command = <0x12000300>;
> 			};

Some of this stuff shouldn't be needed anymore (device-type,
linux,network-index), and you should use a real MAC address, but
otherwise this looks right.

-Scott
