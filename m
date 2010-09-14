Return-Path: <stefan.roese@gmail.com>
From: Stefan Roese <stefan.roese@gmail.com>
To: devicetree-discuss@lists.ozlabs.org
Subject: Question on of_address_to_resource() with offset != 0
Date: Tue, 14 Sep 2010 16:29:06 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201009141629.06825.stefan.roese@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm stumbling upon a problem noticed on the Ebony (440GP) eval board.
Here the first chip-select is connected to 512KiB of SRAM and 512KiB
NOR flash. The dts part look this way:

				small-flash@0,80000 {
					compatible = "jedec-flash";
					bank-width = <1>;
					reg = <0x00000000 0x00080000 0x00080000>;
					#address-cells = <1>;
					#size-cells = <1>;
					partition@0 {
						label = "OpenBIOS";
						reg = <0x00000000 0x00080000>;
						read-only;
					};
				};

Chip-select 0 has this setup:
base-addr = 0xfff00000, size = 0x100000 (phys addr 0x1fff00000 .. 0x1ffffffff)

The problem/crash happens in the physmap_of driver, when the the driver
calls do_map_probe() with the following range:
base-addr = 0xfff80000, size = 0x100000 (phys addr 0x1fff80000 .. 0x20007ffff)

My question now is, should of_address_to_resource() subtract the
offset (here 0x80000) from the size? Is this is bug here? Or should
the physmap_of driver take care of this issue somehow?

Cheers,
Stefan
