Return-Path: <pozzi.fabio@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41FB1B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2012 03:14:16 +1100 (EST)
Received: by obbun3 with SMTP id un3so1573622obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 09:14:12 -0700 (PDT)
MIME-Version: 1.0
From: Fabio <pozzi.fabio@gmail.com>
Date: Wed, 28 Mar 2012 18:13:42 +0200
Message-ID: <CAP-cLV5pF-j_izadBSVD7p4hQte96O_g2udCxi=9tkaPwxEsaw@mail.gmail.com>
Subject: Help initialize phy-less ethernet in 2.6.38
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,
I am a newbie trying to get the FCC1 ethernet interface to work on a
custom board.
The hardware used is based on mpc8270 which is connected via FCC1 to a
phy-less interface linked to another microcontroller.
FCC1 should be recognized as eth0 by the linux kernel and it should
receive data when set up in promiscuous mode.
Currently during the boot it seems that the device initialization goes
ok but I can't understand why I can't receive data when I put the
interface in promiscuous mode.
Going into details I can see that the fs_enet probe function gets called.
I customized it to setup the fs_platform_info structure using the
values taken from the old kernel driver for now.
The only fields I cannot setup are the bus_id,phy_irq,phy_addr because
they are not part of the fs_platform_info data structure anymore.
I can't see any errors during the initialization, but I can't receive
data on the interface.

I think the problem can be in an interrupt misconfiguration but I
haven't figured out how to configure the ethernet dts part in the
right way or how to handle the phy-less situation correctly.


--- dts snippet ---
			eth0: ethernet@11300 {
				device_type = "network";
				compatible =  "fsl,cpm2-fcc-enet";
				reg = <0x11300 0x20 0x8400 0x100 0x11390 0x1>;
				local-mac-address = [ 00 01 02 03 04 05 ];
				interrupts = <32 8>;
				interrupt-parent = <&PIC>;
				linux,network-index = <0>;
				fsl,cpm-command = <0x12000300>;
			};
---

Thanks in advance,



-- 
Fabio Pozzi
