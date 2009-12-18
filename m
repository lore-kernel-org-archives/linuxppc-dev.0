Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A9D1B6F12
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Dec 2009 01:04:03 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBIDvHWu029237
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 08:57:17 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBIE3ttl1573030
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 09:03:56 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBIE3tiP014176
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 12:03:55 -0200
Date: Fri, 18 Dec 2009 09:03:47 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: tmarri@amcc.com
Subject: Re: [PATCH] Adding PCI-E support for 460SX based redwood board.
Message-ID: <20091218140347.GG8458@zod.rchland.ibm.com>
References: <1259621903-9666-1-git-send-email-tmarri@amcc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1259621903-9666-1-git-send-email-tmarri@amcc.com>
Cc: writetomarri@yahoo.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 30, 2009 at 02:58:23PM -0800, tmarri@amcc.com wrote:
>+			PCIE0: pciex@d00000000 {
>+				device_type = "pci";
>+				#interrupt-cells = <1>;
>+				#size-cells = <2>;
>+				#address-cells = <3>;
>+				compatible = "ibm,plb-pciex-460sx", "ibm,plb-pciex";
>+				primary;
>+				port = <0x0>; /* port number */
>+				reg = <0x0000000d 0x00000000 0x20000000	/* Config space access */
>+				       0x0000000c 0x10000000 0x00001000>;	/* Registers */
>+				dcr-reg = <0x100 0x020>;
>+				sdr-base = <0x300>;
>+
>+				/* Outbound ranges, one memory and one IO,
>+				 * later cannot be changed
>+				 */
>+				ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x00000000 0x00000000 0x80000000
>+					  0x01000000 0x00000000 0x00000000 0x0000000f 0x80000000 0x00000000 0x00010000>;
>+

DTC complains about this:

jwboyer@zod:~/src/linux-2.6> make ARCH=powerpc CROSS_COMPILE=ppcnf-unknown- -j2 redwood.dtb
/home/jwboyer/src/linux-2.6/scripts/dtc/dtc -O dtb -o arch/powerpc/boot/redwood.dtb -b 0 -p 1024 /home/jwboyer/src/linux-2.6/arch/powerpc/boot/dts/redwood.dts
DTC: dts->dtb  on file "/home/jwboyer/src/linux-2.6/arch/powerpc/boot/dts/redwood.dts"
Warning (ranges_format): "ranges" property in /plb/opb/pciex@d00000000 has invalid length (56 bytes) (parent #address-cells == 1, child #address-cells == 3, #size-cells == 2)
Warning (ranges_format): "ranges" property in /plb/opb/pciex@d20000000 has invalid length (56 bytes) (parent #address-cells == 1, child #address-cells == 3, #size-cells == 2)
Warning (ranges_format): "ranges" property in /plb/opb/pciex@d40000000 has invalid length (56 bytes) (parent #address-cells == 1, child #address-cells == 3, #size-cells == 2)
jwboyer@zod:~/src/linux-2.6> 

My guess is that you meant to have this under the PLB bus node, and not the OPB
bus?

josh
