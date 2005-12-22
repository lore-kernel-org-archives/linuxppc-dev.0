Return-Path: <Bukhari@fzi.de>
Received: from francis.fzi.de (francis.fzi.de [141.21.7.5])
	by ozlabs.org (Postfix) with ESMTP id 2AA4C6890D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Dec 2005 02:56:58 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 22 Dec 2005 16:39:48 +0100
Message-ID: <EE3E34EBE104B24DA5DF5DBC1EA998D5287FEF@loretta.fzi.de>
From: "Amir Bukhari" <Bukhari@fzi.de>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC5200 Cache issue with Bestcomm
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sorry this question is not related to linux kernel, but I can't find any
sources which I can find any tipps for the issue I encoured.
I write a standalone application with TCP stack (I use lwip stack). I am
want to enable the cache to increase performance of my application.

------------------------
Here is my configuration of various registers:

#define CORE_HID0_INIT                    0x8010C000
#define CORE_HID2_INIT                    0x00000000
#define CORE_IBAT0U_INIT                  0x000007FF
#define CORE_IBAT0L_INIT                  0x00000001

#define CORE_DBAT0U_INIT                  0x000007FF
#define CORE_DBAT0L_INIT                  0x00000052
#define CORE_DBAT1U_INIT                  0xF000000F  // for MBAR
#define CORE_DBAT1L_INIT                  0xF000002A  // for MBAR
#define CORE_DBAT2U_INIT                  0x40001FFF
#define CORE_DBAT2L_INIT                  0x40000022  // for PCI
#define CORE_DBAT3U_INIT                  0x50001FFF  //
#define CORE_DBAT3L_INIT                  0x50000022  //

XLARB configuration is :
#define XLARB_CONFIG_INIT                 0x8000A006 // snoop window is
enabled
#define XLARB_PRIORITY_ENABLE_INIT        0x0000000F
#define XLARB_PRIORITY_INIT               0x11111010
#define XLARB_SNOOP_WINDOW_INIT           0x00000019 // base address is =
0
and 64Mbytes length

----------------

Now as soon as I enable cache the Bestcomm doesn't stop firing me a =
ethernet
packet receive. It doesn't stop this and this let my system hangs up. =
When
running the system without cache every thing work well.

I will be happy if someone can give me a tipp if I may missed something!

-Amir
