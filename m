Return-Path: <mike.koss@ngc.com>
Received: from xmrm0101.northgrum.com (xmrm0101.northgrum.com
	[155.104.240.104]) by ozlabs.org (Postfix) with ESMTP id C2B7DDDF68
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 May 2008 00:31:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: arch/powerpc, Xilinx, and mainline kernel support
Date: Tue, 27 May 2008 09:31:00 -0500
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333FFA5C28@XMBIL132.northgrum.com>
In-Reply-To: <fa686aa40805230944jb6baf6fh601ec7b400a8a0eb@mail.gmail.com>
References: <EDAE140DF1B2FC42B5867C22CA0B333FFA5C0B@XMBIL132.northgrum.com>
	<fa686aa40805161526ie184ae6m29a3fc78d6676720@mail.gmail.com>
	<20080516223422.C02A26B006F@mail34-dub.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333FFA5C22@XMBIL132.northgrum.com>
	<20080523161316.7627978062@mail63-va3.bigfish.com>
	<fa686aa40805230944jb6baf6fh601ec7b400a8a0eb@mail.gmail.com>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ok, we tried your patch, Grant, against the 26-rc3 and it bombed (we
were testing w/ the
gen-mhs-devtree.git\testfiles\microblaze-temac-edk92.dts.golden)

:~/linux-2.6-torvalds-tree-2008-5-20> make simpleImage.test
fatal: cannot describe '4341086cdcd1f35f41e811288da1dd1abe52ab64'
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CALL    arch/powerpc/kernel/systbl_chk.sh
  CC      arch/powerpc/kernel/prom_init.o
  CALL    arch/powerpc/kernel/prom_init_check.sh
arch/powerpc/boot/dtc -O dtb -o arch/powerpc/boot/test.dtb -b 0
/home/####/linux-2.6-torvalds-tree-2008-5-20/arch/powerpc/boot/dts/test.
dts
DTC: dts->dtb  on file
"/home/####/linux-2.6-torvalds-tree-2008-5-20/arch/powerpc/boot/dts/test
.dts"
Warning (reg_format): "reg" property in
/plb_v46/interrupt-controller@81800000 has invalid length (8 bytes)
(#address-cells =3D=3D 2, #size-cells =3D=3D 1) Warning (reg_format): =
"reg"
property in /plb_v46/mdm@84400000 has invalid length (8 bytes)
(#address-cells =3D=3D 2, #size-cells =3D=3D 1) Warning (reg_format): =
"reg"
property in /plb_v46/memory@90000000 has invalid length (8 bytes)
(#address-cells =3D=3D 2, #size-cells =3D=3D 1) Warning (reg_format): =
"reg"
property in /plb_v46/serial@84000000 has invalid length (8 bytes)
(#address-cells =3D=3D 2, #size-cells =3D=3D 1) Warning (reg_format): =
"reg"
property in /plb_v46/xps_iic@81600000 has invalid length (8 bytes)
(#address-cells =3D=3D 2, #size-cells =3D=3D 1) Warning (reg_format): =
"reg"
property in /plb_v46/xps_ll_fifo@81a00000 has invalid length (8 bytes)
(#address-cells =3D=3D 2, #size-cells =3D=3D 1) Warning (reg_format): =
"reg"
property in /plb_v46/xps_ll_temac@81c00000 has invalid length (8 bytes)
(#address-cells =3D=3D 2, #size-cells =3D=3D 1) Warning (reg_format): =
"reg"
property in /plb_v46/xps_timer@83c00000 has invalid length (8 bytes)
(#address-cells =3D=3D 2, #size-cells =3D=3D 1) Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/plb_v46/interrupt-controller@81800000
Warning (avoid_default_addr_size): Relying on default #size-cells value
for /plb_v46/interrupt-controller@81800000
Warning (avoid_default_addr_size): Relying on default #address-cells
value for /plb_v46/mdm@84400000 Warning (avoid_default_addr_size):
Relying on default #size-cells value for /plb_v46/mdm@84400000 Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/plb_v46/memory@90000000 Warning (avoid_default_addr_size): Relying on
default #size-cells value for /plb_v46/memory@90000000 Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/plb_v46/serial@84000000 Warning (avoid_default_addr_size): Relying on
default #size-cells value for /plb_v46/serial@84000000 Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/plb_v46/xps_iic@81600000 Warning (avoid_default_addr_size): Relying on
default #size-cells value for /plb_v46/xps_iic@81600000 Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/plb_v46/xps_ll_fifo@81a00000 Warning (avoid_default_addr_size): Relying
on default #size-cells value for /plb_v46/xps_ll_fifo@81a00000 Warning
(avoid_default_addr_size): Relying on default #address-cells value for
/plb_v46/xps_ll_temac@81c00000 Warning (avoid_default_addr_size):
Relying on default #size-cells value for /plb_v46/xps_ll_temac@81c00000
Warning (avoid_default_addr_size): Relying on default #address-cells
value for /plb_v46/xps_timer@83c00000 Warning (avoid_default_addr_size):
Relying on default #size-cells value for /plb_v46/xps_timer@83c00000
  WRAP    arch/powerpc/boot/simpleImage.test
powerpc-405-linux-gnu-ld: arch/powerpc/boot/simpleboot-test.o: No such
file: No such file or directory
make[1]: *** [arch/powerpc/boot/simpleImage.test] Error 1 rm
arch/powerpc/boot/test.dtb
make: *** [simpleImage.test] Error 2
:~/linux-2.6-torvalds-tree-2008-5-20>=20

-----Original Message-----
From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
Sent: Friday, May 23, 2008 12:45 PM
To: Stephen Neuendorffer
Cc: Koss, Mike (Mission Systems); linuxppc-embedded@ozlabs.org
Subject: Re: arch/powerpc, Xilinx, and mainline kernel support

On Fri, May 23, 2008 at 10:13 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
> Grant, could you post explicit instructions about how to build the=20
> simpleImage?  I tried it too and couldn't get the makefile rules to=20
> match my dts.
>
> Mike, Supporting mpmc2 for memory access only is pretty=20
> straightforward, but supporting the temac/sdma connections is more=20
> problematic, particularly since we have no plans to update the=20
> plb_temac driver for ARCH=3Dpowerpc.

Oops; my mistake.  I've got a trivial patche in my tree that need to be
merged for the build to work.  I'll get those out ASAP.

In the mean time, add "simpleImage%" to the BOOT_TARGETS line in
arch/powerpc/Makefile.  That will allow you to do:

$ make simpleImage.virtex405-<blah>

where virtex405-<blah> corresponds with a file named
arch/powerpc/boot/dts/virtex405-<blah>.dts

Cheers,
g.

--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
