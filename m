Return-Path: <pppeterpppan@gmail.com>
Received: from mail-qy0-f189.google.com (mail-qy0-f189.google.com
	[209.85.221.189]) by ozlabs.org (Postfix) with ESMTP id B15F2B7D11
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 16:41:32 +1000 (EST)
Received: by qyk27 with SMTP id 27so1702726qyk.23
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Apr 2010 23:41:30 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 22 Apr 2010 14:41:29 +0800
Message-ID: <q2g48abf2c21004212341oe37ed471g63c646ae12914ab3@mail.gmail.com>
Subject: How to support scc-enet on MPC8247 in Linux 2.6.32.6
From: Peter Pan <pppeterpppan@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm porting Linux 2.6.32.6 to our MPC8247 based board. We use SCC3 and
SCC4 as ethernet port. These two ports are connect with LXT905 PHY
chip.
I'm now using fs_enet driver, how should I config the scc port in dtc
file. I copied from mgcoge.dts file, and my dtc file of scc enet is
follows:

            eth2: ethernet@11a40 {
                device_type = "network";
                compatible = "fsl,mpc8247-scc-enet",
                             "fsl,cpm2-scc-enet";
                reg = <0x11a40 0x20 0x8200 0x100 0x11390 0x1>;
                local-mac-address = [ 00 00 00 00 00 00 ]; /* filled
by U-Boot */
                interrupts = <42 8>;
                interrupt-parent = <&PIC>;
                linux,network-index = <0x2>;
                fsl,cpm-command = <0x8c00000>;
                fixed-link = < 0 0 10 0 0 >;
            };
But i does not working. Linux says that PHY 0:00 is not found. I dive
into the code, and that's according to the fixed-link property.
I'm wondering how to support scc-enet in my situation.
